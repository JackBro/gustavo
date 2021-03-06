#include "contingdrawing.h"
#include "continggroup.h"
#include "contingutil.h"
#include "contingxml.h"
#include "contingserializable.h"

#include "contingline.h"

#include <string.h>
#include <assert.h>
#include <math.h>

static gint move_signal_id = 0;
static gint delete_signal_id = 0;


static gint event_motion_id = 0;
static gint event_button_id = 0;
static gint event_key_id = 0;
static gint event_notify_id = 0;

static GType event_param_types[1];

static guint next_id = 0;

enum {
    CONTING_DRAWING_PROP_0,
    CONTING_DRAWING_PROP_ONE_LINE,
    CONTING_DRAWING_PROP_GROUP,
    CONTING_DRAWING_PROP_ID
};

#define CONTING_DRAWING_GET_PRIVATE(o)  (G_TYPE_INSTANCE_GET_PRIVATE((o), \
            CONTING_TYPE_DRAWING, ContingDrawingPrivate))

typedef struct ContingDrawingPrivate_ ContingDrawingPrivate;
struct ContingDrawingPrivate_ {
    ContingOneLine *oneline;
    ContingGroup *group;

    guint id;

    gdouble affine[6];

    gboolean selected;
};

static void
g_cclosure_marshal_VOID__EVENT(GClosure *closure,
		GValue *return_value,
		guint n_param_values,
		const GValue *param_values,
		gpointer invocation_hint,
		gpointer marshal_data)
{
	typedef void (*GMarshalFunc_VOID__EVENT)(gpointer data1,
			ContingDrawingEvent *arg_1, gpointer data2);
	register GMarshalFunc_VOID__EVENT callback;
	register GCClosure *cc = (GCClosure *) closure;
	register gpointer data1, data2;

	g_return_if_fail(n_param_values == 2);

	data1 = g_value_peek_pointer(param_values + 0);
	data2 = closure->data;

	callback = (GMarshalFunc_VOID__EVENT)
		(marshal_data ? marshal_data : cc->callback);

	callback(data1, g_value_get_boxed(param_values + 1),
			data2);
}

void
conting_drawing_get_center(ContingDrawing *self,
                           ArtPoint *pw_dst, const ArtPoint *pw_src)
{
	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->get_center(self, pw_dst, pw_src);
}

static void
conting_drawing_get_center_impl(ContingDrawing *self,
                                ArtPoint *pw_dst, const ArtPoint *pw_src)
{
	ArtDRect bounds;

	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	conting_drawing_get_bounds(self, &bounds);

	pw_dst->x = bounds.x0 + fabs(bounds.x0 - bounds.x1) / 2;
	pw_dst->y = bounds.y0 + fabs(bounds.y0 - bounds.y1) / 2;
}

#define TOLERANCE CONTING_DRAWING_TOLERANCE
static void
conting_drawing_draw_box(ContingDrawing *self,
		gdouble x, gdouble y)
{
	cairo_t *cr = conting_drawing_get_cairo(self);

	cairo_move_to(cr, x - TOLERANCE, y - TOLERANCE);
	cairo_line_to(cr, x - TOLERANCE, y + TOLERANCE);
	cairo_line_to(cr, x + TOLERANCE, y + TOLERANCE);
	cairo_line_to(cr, x + TOLERANCE, y - TOLERANCE);
	cairo_line_to(cr, x - TOLERANCE, y - TOLERANCE);

	cairo_set_source_rgb(cr, 0, 0, 0);
	cairo_fill(cr);
	cairo_stroke(cr);

	cairo_destroy(cr);
}

GList *
conting_drawing_get_links(ContingDrawing *self)
{
	g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), NULL);

	return CONTING_DRAWING_GET_CLASS(self)->get_links(self);
}

void
conting_drawing_draw(ContingDrawing *self, cairo_t *cr)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->draw(self, cr);

	if (conting_drawing_is_selected(self)) {
		if (CONTING_DRAWING_GET_CLASS(self)->draw_selection)
			CONTING_DRAWING_GET_CLASS(self)->draw_selection(self,
					conting_drawing_draw_box);
	}
}

ContingOneLine *
conting_drawing_get_one_line(ContingDrawing *self)
{
    ContingOneLine *oneline;

    g_object_get(G_OBJECT(self),
            "one-line", &oneline,
            NULL);

    return oneline;
}

ContingGroup *
conting_drawing_get_group(ContingDrawing *self)
{
    ContingGroup *group;

    g_object_get(G_OBJECT(self),
            "group", &group,
            NULL);

    return group;
}

void
conting_drawing_affine(ContingDrawing *self,
                       const gdouble affine[6])
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    art_affine_multiply(priv->affine, priv->affine, affine);
}
void
conting_drawing_affine_absolute(ContingDrawing *self,
                       const gdouble affine[6])
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    memcpy(priv->affine, affine, 6 * sizeof(double));
}

void
conting_drawing_i2w(ContingDrawing *self, ArtPoint *dst, ArtPoint *src) {
    gdouble affine[6];

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    conting_drawing_get_i2w_affine(self, affine);
    art_affine_point(dst, src, affine);
}

void
conting_drawing_w2i(ContingDrawing *self, ArtPoint *dst, ArtPoint *src) {
    gdouble affine[6];

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    conting_drawing_get_w2i_affine(self, affine);
    art_affine_point(dst, src, affine);
}

static void
conting_drawing_get_i2w_affine_impl(ContingDrawing *self,
                           gdouble affine[6])
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    memcpy(affine, priv->affine, 6 * sizeof(gdouble));
}

static void
conting_drawing_get_w2i_affine_impl(ContingDrawing *self,
                                    gdouble affine[6])
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    art_affine_invert(affine, priv->affine);
}

void
conting_drawing_get_i2w_affine_absolute(ContingDrawing *self,
		gdouble affine[6])
{
	conting_drawing_get_i2w_affine_impl(self, affine);
}

void
conting_drawing_get_i2w_affine(ContingDrawing *self,
                                gdouble affine[6])
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->get_i2w_affine(self, affine);
}

void
conting_drawing_get_w2i_affine(ContingDrawing *self,
                                gdouble affine[6])
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->get_w2i_affine(self, affine);
}


void
conting_drawing_get_update_bounds(ContingDrawing *self, ArtDRect *bounds)
{
	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->get_update_bounds(self, bounds);
}


void
conting_drawing_get_bounds(ContingDrawing *self,
                           ArtDRect *rect)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->get_bounds(self, rect);
}
void
conting_drawing_place(ContingDrawing *self)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->place(self);
}

gboolean
conting_drawing_is_placed(ContingDrawing *self)
{
    g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

    return CONTING_DRAWING_GET_CLASS(self)->is_placed(self);
}
gboolean
conting_drawing_answer(ContingDrawing *self,
                       gdouble world_x, gdouble world_y)
{
    g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

    return CONTING_DRAWING_GET_CLASS(self)->answer(self, world_x, world_y);
}
gboolean
conting_drawing_event(ContingDrawing *self,
                      GdkEvent *event)
{
    g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

    if (CONTING_DRAWING_GET_CLASS(self)->event)
        return CONTING_DRAWING_GET_CLASS(self)->event(self, event);

    return FALSE;
}

void
conting_drawing_motion(ContingDrawing *self, ArtPoint *pi)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->motion(self, pi);
}
void
conting_drawing_motion_place(ContingDrawing *self, ArtPoint *pi)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->motion_place(self, pi);
}

void
conting_drawing_accept(ContingDrawing *self, ContingVisitor *visitor)
{
	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->accept(self, visitor);
}

void
conting_drawing_grab(ContingDrawing *self, ArtPoint *pi)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->grab(self, pi);
}

static void
conting_drawing_grab_impl(ContingDrawing *self, ArtPoint *pi)
{
	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    conting_one_line_grab(conting_drawing_get_one_line(self), self);
}

void
conting_drawing_ungrab(ContingDrawing *self)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));
	
	CONTING_DRAWING_GET_CLASS(self)->ungrab(self);
}

static void
conting_drawing_ungrab_impl(ContingDrawing *self)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    conting_one_line_ungrab(conting_drawing_get_one_line(self), self);
}

void
conting_drawing_update(ContingDrawing *self)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    conting_one_line_update_drawing(conting_drawing_get_one_line(self), self);
}
void
conting_drawing_set_selected(ContingDrawing *self,
                             gboolean selected)
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    if (priv->selected != selected) {
        priv->selected = selected;
        conting_drawing_update(self);
    }
}
gboolean
conting_drawing_is_selected(ContingDrawing *self)
{
    ContingDrawingPrivate *priv;

    g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    return priv->selected;
}

void
conting_drawing_delete(ContingDrawing *self)
{
    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    CONTING_DRAWING_GET_CLASS(self)->delete(self);
}


/* TODO: improve it.
 * Create a new widget class, which contains an area to place a label, and
 * an hbox to place items. See termometer_test.c for an example */
/** TOOLTIP LIKE WINDOW */
/*
static gboolean
window_exposed(GtkWidget *widget, GdkEventExpose *event,
		gpointer user_data)
{
	gdk_draw_rectangle(widget->window, widget->style->black_gc, FALSE, 0, 0,
			widget->allocation.width - 1, widget->allocation.height -1);

	return FALSE;
}

GtkWidget *
conting_drawing_create_window(ContingDrawing *self)
{
	GtkWidget *window, *label;
	GdkColor color;
	char buff[256];
	gint x, y;

	gdk_color_parse("beige", &color);

	window = gtk_window_new(GTK_WINDOW_POPUP);
	gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
	gtk_widget_modify_bg(window, GTK_STATE_NORMAL, &color);
	gtk_container_set_border_width(GTK_CONTAINER(window), 5);
	g_signal_connect_after(G_OBJECT(window), "expose-event",
			G_CALLBACK(window_exposed), NULL);

	sprintf(buff, "%s, (%p)", g_type_name(G_OBJECT_TYPE(self)), self);
	
	label = gtk_label_new(buff);
	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);

	gtk_container_add(GTK_CONTAINER(window), label);

	gdk_display_get_pointer(gdk_display_get_default(), NULL, &x, &y, NULL);
	gtk_window_move(GTK_WINDOW(window), x, y);

	return window;
}

static gboolean
show_hint(gpointer user_data)
{
	gpointer *params;
	ContingDrawing *self;
	ContingDrawingPrivate *priv;
	guint tick;

	params = user_data;
	self = params[0];
	tick = (guint) params[1];

	** An "evil" hack? Detects if the drawing was deleted *
	if (params[0] == NULL)
		goto show_hint_end;

	g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

	priv = CONTING_DRAWING_GET_PRIVATE(self);

	if (tick == priv->show_tick) {
		priv->window = conting_drawing_create_window(self);
		gtk_widget_show_all(priv->window);
	}

show_hint_end:
	g_free(params);

	return FALSE;
}

static void
conting_drawing_setup_hint(ContingDrawing *self)
{
	ContingDrawingPrivate *priv;
	gpointer *params;

	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	priv = CONTING_DRAWING_GET_PRIVATE(self);

	priv->show_tick++;

	* Each call must have each own params, such that
	 * we can't use a static array *

	if (priv->params)
		return;
	
	priv->params = params = g_new(gpointer, 2);
	params[0] = self; params[1] = (gpointer) priv->show_tick;
	g_timeout_add_full(G_PRIORITY_DEFAULT, 1000, show_hint, params, NULL);
}

static void
conting_drawing_cancel_hint(ContingDrawing *self)
{
	ContingDrawingPrivate *priv;

	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	priv = CONTING_DRAWING_GET_PRIVATE(self);

	priv->show_tick++;
	if (priv->window) {
		gtk_widget_destroy(priv->window);
		priv->window = NULL;
	}

	if (priv->params) {
		priv->params[0] = NULL;
		priv->params = NULL;
	}
}
*/

static void
conting_drawing_notify_signal(ContingDrawing *self,
		ContingDrawingEventType type, ArtPoint *pi) {
	ContingDrawingEvent event;

	event.type = type;
	event.notify.x = pi->x;
	event.notify.y = pi->y;
	
	g_signal_emit_by_name(self, "notify-event",
			g_boxed_copy(CONTING_TYPE_DRAWING_EVENT, &event));
}

static void
conting_drawing_button_signal(ContingDrawing *self,
		ContingDrawingEventType type, ArtPoint *pi,
		guint state, guint button)
{
	ContingDrawingEvent event;

	event.type = type;
	event.button.x = pi->x;
	event.button.y = pi->y;
	event.button.state = state;
	event.button.button = button;

	g_signal_emit_by_name(self, "button-event",
			g_boxed_copy(CONTING_TYPE_DRAWING_EVENT, &event));

	g_print("signal emitting button-event\n");
}

static void
conting_drawing_key_signal(ContingDrawing *self,
		ContingDrawingEventType type, guint state, guint keyval)
{
	ContingDrawingEvent event;

	event.type = type;
	event.key.state = state;
	event.key.keyval = keyval;

	g_signal_emit_by_name(self, "key-event",
			g_boxed_copy(CONTING_TYPE_DRAWING_EVENT, &event));
}

static void
conting_drawing_motion_signal(ContingDrawing *self,
		ContingDrawingEventType type, ArtPoint *pi, guint state)
{
	ContingDrawingEvent event;

	event.type = type;
	event.motion.x = pi->x;
	event.motion.y = pi->y;
	event.motion.state = state;
	
	g_signal_emit_by_name(self, "motion-event",
			g_boxed_copy(CONTING_TYPE_DRAWING_EVENT, &event));
}

#include <gdk/gdkkeysyms.h>
static gboolean
conting_drawing_event_impl(ContingDrawing *self, GdkEvent *event)
{
	ContingDrawingPrivate *priv;
	ArtPoint pi;

	g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), FALSE);

	priv = CONTING_DRAWING_GET_PRIVATE(self);

	conting_one_line_window_to_world(conting_drawing_get_one_line(self),
			event->button.x, event->button.y, &pi.x, &pi.y);
	conting_drawing_w2i(self, &pi, &pi);

	switch (event->type) {
		case GDK_ENTER_NOTIFY:
			conting_drawing_notify_signal(self, CONTING_DRAWING_ENTER, &pi);
			return TRUE;
			break;

		case GDK_LEAVE_NOTIFY:
			conting_drawing_notify_signal(self, CONTING_DRAWING_LEAVE, &pi);
			return TRUE;
			break;

		case GDK_BUTTON_PRESS:
			conting_drawing_button_signal(self, CONTING_DRAWING_BUTTON_PRESS,
					&pi, event->button.state, event->button.button);
			return TRUE;
			break;
			
		case GDK_BUTTON_RELEASE:
			conting_drawing_button_signal(self, CONTING_DRAWING_BUTTON_RELEASE,
					&pi, event->button.state, event->button.button);
			return TRUE;
			break;

		case GDK_2BUTTON_PRESS:
			g_print("2 BUTTON PRESS\n");
			conting_drawing_button_signal(self, CONTING_DRAWING_2BUTTON_PRESS,
					&pi, event->button.state, event->button.button);
			return FALSE;
			break;

		case GDK_KEY_PRESS:
			conting_drawing_key_signal(self, CONTING_DRAWING_KEY_PRESS,
					event->key.state, event->key.keyval);
			return TRUE;
			break;

		case GDK_MOTION_NOTIFY:
			conting_drawing_motion_signal(self, CONTING_DRAWING_MOTION_NOTIFY,
					&pi, event->motion.state);
			return TRUE;
			break;

		default:
			break;
	}

	return FALSE;
}

void
conting_drawing_find_link(ContingDrawing *self, ContingDrawingPredicate pred,
		gpointer user_data)
{
	g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

	CONTING_DRAWING_GET_CLASS(self)->find_link(self, pred, user_data);
}

static void
conting_drawing_place_xml(ContingSerializable *self, xmlNodePtr drawing_node,
                          GHashTable *id_drawing)
{
    ContingDrawingPrivate *priv;
    xmlNodePtr class_node;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

	/*
	priv->id = strtoul(id, NULL, 10);
	next_id = MAX(priv->id, next_id);
	*/

    for (class_node = drawing_node->children; class_node;
            class_node = class_node->next) {
        xmlChar *class_name;

        if (!xmlStrEqual(class_node->name, BAD_CAST "class"))
            continue;

        class_name = xmlGetProp(class_node, BAD_CAST "name");
        if (class_name && xmlStrEqual(class_name, "ContingDrawing")) {
            xmlNodePtr attr;
            xmlFree(class_name);

            for (attr = class_node->children; attr; attr = attr->next) {
                xmlChar *name, *type;
                if (!xmlStrEqual(attr->name, BAD_CAST "attribute"))
                    continue;

                name = xmlGetProp(attr, BAD_CAST "name");
                type = xmlGetProp(attr, BAD_CAST "type");

				g_print("<attribute name=\"%s\" type=\"%s\">\n",
						name, type);

                if (xmlStrEqual(type, BAD_CAST "affine")
                        && xmlStrEqual(name, BAD_CAST "affine")) {
                    conting_util_load_affine(attr, priv->affine);
                }
            }
            break;
        }

    }

	printf("%s(%p) = (%lf %lf %lf %lf %lf %lf)\n",
			g_type_name(G_OBJECT_TYPE(self)), self,
			priv->affine[0], priv->affine[1], priv->affine[2],
			priv->affine[3], priv->affine[4], priv->affine[5]);
    
}

static void
conting_drawing_xml_node(ContingSerializable *self, xmlNodePtr drawing_node,
    	 				 xmlNodePtr *result)
{
    ContingDrawingPrivate *priv;
    xmlNodePtr class_node;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    class_node = xmlNewNode(NULL, BAD_CAST "class");
    xmlNewProp(class_node, BAD_CAST "name",
            BAD_CAST g_type_name(CONTING_TYPE_DRAWING));
    xmlAddChild(class_node, conting_util_affine_node("affine", priv->affine));

    xmlAddChild(drawing_node, class_node);
}

static void
conting_drawing_delete_impl(ContingDrawing *self)
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    conting_one_line_delete_drawing(conting_drawing_get_one_line(self),
            self);
}

static void
conting_drawing_get_property(GObject *self,
                             guint prop_id,
                             GValue *value,
                             GParamSpec *pspec)
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    switch (prop_id) {
        case CONTING_DRAWING_PROP_ONE_LINE:
            g_value_set_object(value, priv->oneline);
            break;
        case CONTING_DRAWING_PROP_GROUP:
            g_value_set_object(value, priv->group);
            break;
        case CONTING_DRAWING_PROP_ID:
            g_value_set_uint(value, priv->id);
            break;
        default:
            G_OBJECT_WARN_INVALID_PROPERTY_ID(self, prop_id, pspec);
            break;
    }
}

static void
conting_drawing_set_property(GObject *self,
                             guint prop_id,
                             const GValue *value,
                             GParamSpec *pspec)
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    switch (prop_id) {
        case CONTING_DRAWING_PROP_ONE_LINE:
            priv->oneline = g_value_get_object(value);
            break;
        case CONTING_DRAWING_PROP_GROUP:
            priv->group = g_value_get_object(value);
            break;
        case CONTING_DRAWING_PROP_ID:
            priv->id = g_value_get_uint(value);
            break;
        default:
            G_OBJECT_WARN_INVALID_PROPERTY_ID(self, prop_id, pspec);
            break;
    }
}


static guint
conting_drawing_get_id(void)
{
    return ++next_id;
}

guint
conting_drawing_id(ContingDrawing *self)
{
	ContingDrawingPrivate *priv;

	g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), 0);

	priv = CONTING_DRAWING_GET_PRIVATE(self);

	return priv->id;
}

static void
conting_drawing_instance_init(GTypeInstance *self,
                              gpointer g_class)
{
    ContingDrawingPrivate *priv;

    g_return_if_fail(self != NULL && CONTING_IS_DRAWING(self));

    priv = CONTING_DRAWING_GET_PRIVATE(self);

    art_affine_identity(priv->affine);

    priv->selected = FALSE;

    priv->oneline = NULL;
    priv->group = NULL;

    priv->id = conting_drawing_get_id();
}

static void
conting_drawing_class_init(gpointer g_class,
                           gpointer class_data)
{
    GObjectClass *gobject_class;
    ContingDrawingClass *drawing_class;

    gobject_class = G_OBJECT_CLASS(g_class);
    gobject_class->set_property = conting_drawing_set_property;
    gobject_class->get_property = conting_drawing_get_property;

    g_object_class_install_property(G_OBJECT_CLASS(g_class),
            CONTING_DRAWING_PROP_ONE_LINE,
            g_param_spec_object("one-line",
                                "OneLine container",
                                "The one-line diagram of this item",
                                CONTING_TYPE_ONE_LINE,
                                G_PARAM_READABLE | G_PARAM_CONSTRUCT_ONLY
                                | G_PARAM_WRITABLE));

    g_object_class_install_property(G_OBJECT_CLASS(g_class),
            CONTING_DRAWING_PROP_GROUP,
            g_param_spec_object("group",
                                "Group",
                                "Group in which the item is contained",
                                CONTING_TYPE_GROUP,
                                G_PARAM_READABLE | G_PARAM_WRITABLE));

    g_object_class_install_property(G_OBJECT_CLASS(g_class),
            CONTING_DRAWING_PROP_ID,
            g_param_spec_uint("id",
                             "ID",
                             "Drawing unique identifier",
                             0, G_MAXUINT, 0,
                             G_PARAM_READABLE));

    drawing_class = CONTING_DRAWING_CLASS(g_class);
    drawing_class->draw = NULL;
	drawing_class->draw_selection = NULL;
    drawing_class->get_bounds = NULL;
    drawing_class->get_update_bounds = NULL;
    drawing_class->place = NULL;
    drawing_class->is_placed = NULL;
    drawing_class->answer = NULL;
    drawing_class->event = conting_drawing_event_impl;
    drawing_class->delete = conting_drawing_delete_impl;

    drawing_class->get_i2w_affine = conting_drawing_get_i2w_affine_impl;
    drawing_class->get_w2i_affine = conting_drawing_get_w2i_affine_impl;

	drawing_class->get_center = conting_drawing_get_center_impl;

	drawing_class->grab = conting_drawing_grab_impl;
	drawing_class->ungrab = conting_drawing_ungrab_impl;
	drawing_class->motion = NULL;
	drawing_class->motion_place = NULL;

	drawing_class->accept = NULL;

	drawing_class->get_links = NULL;

    move_signal_id = g_signal_newv(
            "move",
            G_TYPE_FROM_CLASS(g_class),
            G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
            NULL, /* class closure */
            NULL, /* accumulator */
            NULL, /* accu_data */
            g_cclosure_marshal_VOID__VOID,
            G_TYPE_NONE, /* return_type */
            0,
            NULL);

    delete_signal_id = g_signal_newv(
            "delete",
            G_TYPE_FROM_CLASS(g_class),
            G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
            NULL,
            NULL,
            NULL,
            g_cclosure_marshal_VOID__VOID,
            G_TYPE_NONE,
            0,
            NULL);

	event_param_types[0] = CONTING_TYPE_DRAWING_EVENT;
	event_motion_id = g_signal_newv(
			"motion-event",
			G_TYPE_FROM_CLASS(g_class),
			G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
			NULL,
			NULL,
			NULL,
			g_cclosure_marshal_VOID__EVENT,
			G_TYPE_NONE,
			1,
			event_param_types);
	event_button_id = g_signal_newv(
			"button-event",
			G_TYPE_FROM_CLASS(g_class),
			G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
			NULL,
			NULL,
			NULL,
			g_cclosure_marshal_VOID__EVENT,
			G_TYPE_NONE,
			1,
			event_param_types);
	event_key_id = g_signal_newv(
			"key-event",
			G_TYPE_FROM_CLASS(g_class),
			G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
			NULL,
			NULL,
			NULL,
			g_cclosure_marshal_VOID__EVENT,
			G_TYPE_NONE,
			1,
			event_param_types);
	event_notify_id = g_signal_newv(
			"notify-event",
			G_TYPE_FROM_CLASS(g_class),
			G_SIGNAL_RUN_FIRST | G_SIGNAL_NO_RECURSE | G_SIGNAL_NO_HOOKS,
			NULL,
			NULL,
			NULL,
			g_cclosure_marshal_VOID__EVENT,
			G_TYPE_NONE,
			1,
			event_param_types);

    g_type_class_add_private(g_class, sizeof(ContingDrawingPrivate));
}

static void
conting_drawing_serializable_init(gpointer g_iface, gpointer iface_data)
{
	ContingSerializableClass *serial_class;

	serial_class = g_iface;
	serial_class->read = conting_drawing_place_xml;
	serial_class->write = conting_drawing_xml_node;
	
	g_print("serial_class = %p\n", serial_class);
	g_print("serial_class->read = %p\n", serial_class->read);
	g_print("serial_class->write = %p\n", serial_class->write);
}

GType
conting_drawing_get_type(void)
{
    static GType type = 0;

    if (type == 0) {
        static GTypeInfo type_info = {
            sizeof(ContingDrawingClass),
            NULL,
            NULL,
            conting_drawing_class_init,
            NULL,
            NULL,
            sizeof(ContingDrawing),
            0,
            conting_drawing_instance_init,
            NULL
        };

		static const GInterfaceInfo serial_info = {
			conting_drawing_serializable_init,
			NULL,
			NULL	
		};

        type = g_type_register_static(G_TYPE_OBJECT,
				"ContingDrawing",
                &type_info, 0);

		g_type_add_interface_static(type,
				CONTING_TYPE_SERIALIZABLE,
				&serial_info);
    }

    return type;
}

gpointer
conting_drawing_get_attr(ContingDrawing *self, const gchar *attr)
{
	ContingItemData *item_data;
	gpointer result;

	g_return_val_if_fail(self != NULL && CONTING_IS_DRAWING(self), NULL);

	item_data = conting_drawing_get_item_data(self);

	if (item_data == NULL)
		return NULL;
	
	result = NULL;
	conting_item_data_get_attr(item_data,
			attr, &result,
			NULL);

	return result;
}
static gpointer
conting_drawing_event_copy(gpointer boxed)
{
	ContingDrawingEvent *result = g_new(ContingDrawingEvent, 1);

	*result = *((ContingDrawingEvent *) boxed);
	
	return result;
}

GType
conting_drawing_event_get_type(void)
{
	static GType type = 0;

	if (type == 0) {
		type = g_boxed_type_register_static("ContingDrawingEvent",
			conting_drawing_event_copy, g_free);
	}

	return type;
}
