#include "contingdrawing.h"
#include "contingce.h"
#include "contingutil.h"
#include "contingxml.h"
#include <string.h>
#include <math.h>

static gpointer parent_class = NULL;

static void
conting_ce_draw(ContingDrawing *self, cairo_t *cr)
{
	ContingSymbol *symb;
	ContingComponent *comp;
	GdkColor *color;
	ArtPoint pw0, pw1;
	gdouble affine[6];

	g_return_if_fail(self != NULL && CONTING_IS_CE(self));

	symb = CONTING_SYMBOL(self);
	comp = CONTING_COMPONENT(self);

	g_object_get(self, "color", &color, NULL);

	pw0 = comp->p0;
	pw1 = comp->p1;

	cairo_set_antialias(cr, CAIRO_ANTIALIAS_DEFAULT);


	cairo_move_to(cr, pw0.x, pw0.y);
	cairo_line_to(cr, pw0.x, pw1.y);
	cairo_line_to(cr, pw1.x, pw1.y);
	cairo_line_to(cr, pw1.x, pw0.y);
	cairo_line_to(cr, pw0.x, pw0.y);
	cairo_line_to(cr, pw0.x, pw1.y);
	cairo_set_source_rgb(cr,
			(gdouble) color->red / (gdouble) G_MAXUINT16,
			(gdouble) color->green / (gdouble) G_MAXUINT16,
			(gdouble) color->blue / (gdouble) G_MAXUINT16);
	cairo_stroke(cr);


	cr = conting_drawing_get_cairo_absolute(self);
	conting_drawing_get_i2w_affine_absolute(self, affine);
	cairo_transform(cr, (cairo_matrix_t *) affine);
	cairo_set_antialias(cr, CAIRO_ANTIALIAS_DEFAULT);
	
	cairo_set_source_rgb(cr,
			(gdouble) color->red / (gdouble) G_MAXUINT16,
			(gdouble) color->green / (gdouble) G_MAXUINT16,
			(gdouble) color->blue / (gdouble) G_MAXUINT16);
	{
		PangoLayout *layout;
		PangoFontDescription *font;

		layout = pango_cairo_create_layout(cr);

		font = pango_font_description_new();
		pango_font_description_set_size(font, 4 * PANGO_SCALE);
		/*  g_print("size = %d\n", pango_font_description_get_size(font)); */
		pango_font_description_set_family_static(font, "Arial");
		pango_font_description_set_style(font, PANGO_STYLE_NORMAL);

		pango_layout_set_font_description(layout, font);
		pango_layout_set_text(layout, "CE", 2);

		cairo_move_to(cr, pw0.x + 1, pw0.y + 2);
		pango_cairo_update_layout(cr, layout);
		pango_cairo_show_layout(cr, layout);

		g_object_unref(layout);
	}
	cairo_stroke(cr);

	cairo_destroy(cr);

	CONTING_DRAWING_CLASS(parent_class)->draw(self, cr);
}

static void
conting_ce_accept(ContingDrawing *self, ContingVisitor *visitor)
{
	g_return_if_fail(self != NULL && CONTING_IS_CE(self));
		conting_visitor_visit_ce(visitor, CONTING_CE(self));
}

static void
conting_ce_instance_init(GTypeInstance *self,
                           gpointer g_class)
{
    ContingSymbol *symb;
    ContingComponent *comp;

    g_return_if_fail(self != NULL && CONTING_IS_CE(self));

    symb = CONTING_SYMBOL(self);
    comp = CONTING_COMPONENT(self);

    comp->p0.x = -5;
    comp->p0.y = -5;
    comp->p1.x = 5;
    comp->p1.y = 5;

    symb->link0 = NULL;
}

static void
conting_ce_class_init(gpointer g_class, gpointer class_data)
{
    ContingDrawingClass *drawing_class;

    drawing_class = CONTING_DRAWING_CLASS(g_class);
    drawing_class->draw = conting_ce_draw;
	
	drawing_class->accept = conting_ce_accept;

    parent_class = g_type_class_peek_parent(g_class);
}

GType conting_ce_get_type(void) {
    static GType type = 0;

    if (type == 0) {
        static GTypeInfo type_info = {
            sizeof(ContingCEClass),
            NULL,
            NULL,
            conting_ce_class_init,
            NULL,
            NULL,
            sizeof(ContingCE),
            0,
            conting_ce_instance_init,
            NULL
        };

        type = g_type_register_static(CONTING_TYPE_SYMBOL,
                "ContingCE",
                &type_info, 0);
    }

    return type;
}
