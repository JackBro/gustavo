#include <gtk/gtk.h>
#include "contingdrawing.h"
#include "contingcomponent.h"
#include "contingconnection.h"
#include "contingbus.h"
#include "contingtrans2.h"

static GSList *drawings = NULL;

static ContingDrawing *current_drawing = NULL;
static GdkPoint current_drawing_position = { -1, -1 };
static gboolean current_drawing_start = TRUE;


typedef struct DrawingToDraw_ DrawingToDraw;
struct DrawingToDraw_ {
	ContingDrawing *drawing;
	GdkPoint position;
};

static DrawingToDraw *selected_dd = NULL;
static gboolean is_moving = FALSE;
static ContingResizeOrientation is_resizing = 0;

static void darea_realize(GtkWidget *widget, gpointer user_data) {
	gtk_widget_add_events(widget, GDK_EXPOSURE_MASK
			| GDK_BUTTON_PRESS_MASK | GDK_BUTTON_RELEASE_MASK
			| GDK_POINTER_MOTION_MASK | GDK_KEY_PRESS_MASK
			| GDK_KEY_RELEASE_MASK);
}

static gboolean darea_expose_event(GtkWidget *widget, GdkEventExpose *event,
		gpointer user_data) {
	gint w, h;
	GSList *n;
	static GdkGC *gc = NULL;


	gdk_drawable_get_size(widget->window, &w, &h);
	gdk_draw_rectangle(widget->window, widget->style->white_gc, TRUE,
			0, 0, w, h);

	if (gc == NULL) {
		gc = gdk_gc_new(widget->window);
	}

	for (n = drawings; n != NULL; n = g_slist_next(n)) {
		DrawingToDraw *dd = n->data;

		conting_drawing_draw(dd->drawing,
				widget->window, gc,
				&dd->position, NULL);
	}

	if (selected_dd != NULL) {
		conting_drawing_draw_selected(selected_dd->drawing,
				widget->window, gc,
				&selected_dd->position);
	}

	if (current_drawing != NULL) {
		GdkPoint pos;

		gtk_widget_get_pointer(widget, &pos.x, &pos.y);
		
		if (!current_drawing_start) {
			pos.x -= current_drawing_position.x;
			pos.y -= current_drawing_position.y;
		}

		conting_drawing_draw(current_drawing,
				widget->window, gc,
				&current_drawing_position, &pos);
	}

	g_print("expose_event\n");
	return TRUE;
}

static DrawingToDraw *answer_move(gint x, gint y) {
	GSList *n;

	for (n = drawings; n != NULL; n = g_slist_next(n)) {
		DrawingToDraw *dd = n->data;

	if (conting_drawing_answer_move(dd->drawing,
					x - dd->position.x, y - dd->position.y)) {
			return dd;
		}
	}

	return NULL;
}

static DrawingToDraw *answer(gint x, gint y) {
	GSList *n;

	for (n = drawings; n != NULL; n = g_slist_next(n)) {
		DrawingToDraw *dd = n->data;

		if (conting_drawing_answer(dd->drawing,
					x - dd->position.x, y - dd->position.y)) {
			return dd;
		}
	}

	return NULL;
}

static gboolean darea_button_release_event(GtkWidget *widget,
		GdkEventButton *event, gpointer user_data) {
	is_moving = FALSE;
	is_resizing = 0;
	return TRUE;
}

static gboolean darea_button_press_event(GtkWidget *widget,
		GdkEventButton *event, gpointer user_data) {
	if (current_drawing != NULL) {
		DrawingToDraw *dd;

		if (event->button != 1) {
			g_object_unref(current_drawing);
			current_drawing = NULL;
			gtk_widget_queue_draw(widget);
			return TRUE;
		}

		if (current_drawing_start) {
			conting_drawing_start_place(current_drawing);
			current_drawing_start = FALSE;
			current_drawing_position.x = event->x;
			current_drawing_position.y = event->y;
		}

		dd = answer(event->x, event->y);


		g_print("VIOLATES ? %s\n", dd ? "YES" : " NO");

		conting_drawing_place(current_drawing,
				event->x - current_drawing_position.x,
				event->y - current_drawing_position.y,
				(dd == NULL ? NULL : dd->drawing),
				(dd == NULL ? -1 : event->x - dd->position.x),
				(dd == NULL ? -1 : event->y - dd->position.y));

		g_print("IS PLACED ? %s\n",
				conting_drawing_is_placed(current_drawing) ? "YES" : " NO");
		if (conting_drawing_is_placed(current_drawing)) {
			DrawingToDraw *dd = g_new(DrawingToDraw, 1);

			dd->drawing = current_drawing;
			dd->position = current_drawing_position;

			drawings = g_slist_append(drawings, dd);

			current_drawing = NULL;
			current_drawing_start = TRUE;
		}

	} else { /* current_drawing == NULL */
		if (selected_dd != NULL
				&& CONTING_IS_COMPONENT(selected_dd->drawing)) {
			ContingResizeOrientation orient;
			if (conting_component_answer_resize(
						CONTING_COMPONENT(selected_dd->drawing),
						event->x - selected_dd->position.x,
						event->y - selected_dd->position.y,
						&orient)) {
				is_resizing = orient;

				return TRUE;
			}
		}
		selected_dd = answer_move(event->x, event->y);

		if (selected_dd == NULL) {
			selected_dd = answer(event->x, event->y);
			is_moving = FALSE;
		} else {
			is_moving = TRUE;
		}
	}

	gtk_widget_queue_draw(widget);

	g_print("RETURNED");
	return TRUE;
}
#include <gdk/gdkkeysyms.h>
#include <math.h>
static gboolean darea_key_press_event(GtkWidget *widget, GdkEventKey *event,
		gpointer user_data) {
	if (event->type == GDK_KEY_PRESS) {
		if ((event->keyval == GDK_R || event->keyval == GDK_r)) {
			if (selected_dd != NULL
					&& CONTING_IS_COMPONENT(selected_dd->drawing)) {
				g_print("darea_key_press_event()\n");
				conting_component_rotate(
						CONTING_COMPONENT(selected_dd->drawing), M_PI / 2);
			}

			gtk_widget_queue_draw(GTK_WIDGET(user_data));
		}

		if (event->keyval == GDK_Delete && selected_dd != NULL) {
			drawings = g_slist_remove(drawings, selected_dd);

			g_object_unref(selected_dd->drawing);
			g_free(selected_dd);
			selected_dd = NULL;

			gtk_widget_queue_draw(GTK_WIDGET(user_data));
		}

	}
	return TRUE;
}

//static gboolean darea_button_press_event(GtkWidget *widget,
//		GdkEventButton *event, gpointer user_data) {
//	GSList *n;
//	ContingDrawing *violated_drawing = NULL;
//	GdkPoint violated_position = { -1, -1 };
//
//
//	if (current_drawing == NULL) {
//		for (n = drawings; n != NULL; n = g_slist_next(n)) {
//			DrawingToDraw *dd = n->data;
//
//			if (conting_drawing_answer(dd->drawing,
//						event->x - dd->position.x,
//						event->y - dd->position.y)) {
//				select(dd, widget);
//				break;
//			}
//		}
//
//		/* dd selected */
//	} else {
//		for (n = drawings; n != NULL; n = g_slist_next(n)) {
//			DrawingToDraw *dd = n->data;
//
//			if (conting_drawing_answer(dd->drawing,
//						event->x - dd->position.x,
//						event->y - dd->position.y)) {
//				violated_drawing = dd->drawing;
//				violated_position = dd->position;
//				break;
//			}
//		}
//
//		if (violated_drawing != NULL) {
//			if (conting_drawing_can_link(violated_drawing, current_drawing,
//						event->x - violated_position.x,
//						event->y - violated_position.y)) {
//				if (current_drawing_start) {
//					current_drawing_position.x = event->x;
//					current_drawing_position.y = event->y;
//				}
//				current_drawing_start = conting_drawing_place_linked(
//						current_drawing,
//						event->x - current_drawing_position.x,
//						event->y - current_drawing_position.y,
//						violated_drawing,
//						event->x - violated_position.x,
//						event->y - violated_position.y);
//				/* returns TRUE if the link is finished */
//			} else {
//				/* can't draw, there's another drawing already in the space
//				 * and the drawing doesn't accept links from current_drawing*/
//			}
//		} else { /* violeted_drawing == NULL */
//			conting_drawing_place(current_drawing);
//			DrawingToDraw *dd = g_new(DrawingToDraw, 1);
//			dd->drawing = current_drawing;
//
//			dd->position.x = event->x;
//			dd->position.y = event->y;
//
//			drawings = g_slist_append(drawings, dd);
//
//			current_drawing = NULL;
//			current_drawing_start = TRUE;
//		}
//	}
//
//	g_print("button_press_event\n");
//	return TRUE;
//}

static gboolean darea_motion_notify_event(GtkWidget *widget,
		GdkEventMotion *event, gpointer user_data) {
	gdk_window_set_cursor(widget->window, NULL);
	if ((event->state & GDK_BUTTON1_MASK) && selected_dd) {
		if (is_moving) {
			conting_drawing_move(selected_dd->drawing,
					event->x - selected_dd->position.x,
					event->y - selected_dd->position.y);
			if (CONTING_IS_COMPONENT(selected_dd->drawing)) {
				selected_dd->position.x = event->x;
				selected_dd->position.y = event->y;
			}
		} else if (is_resizing != 0) {
			conting_component_resize(
					CONTING_COMPONENT(selected_dd->drawing),
					event->x - selected_dd->position.x,
					event->y - selected_dd->position.y,
					is_resizing);
		}

		gtk_widget_queue_draw(widget);
	} else if (current_drawing != NULL) {
		gtk_widget_queue_draw(widget);
	} else if (selected_dd != NULL
			&& CONTING_IS_COMPONENT(selected_dd->drawing)) {
		static GdkCursor *h_cursor = NULL;
		static GdkCursor *v_cursor = NULL;
		ContingResizeOrientation orientation;
		
		if (h_cursor == NULL) {
			h_cursor = gdk_cursor_new(GDK_SB_H_DOUBLE_ARROW);
			v_cursor = gdk_cursor_new(GDK_SB_V_DOUBLE_ARROW);
		}
		
		if (conting_component_answer_resize(
					CONTING_COMPONENT(selected_dd->drawing),
					event->x - selected_dd->position.x,
					event->y - selected_dd->position.y,
					&orientation)) {
			switch (orientation) {
				case CONTING_RESIZE_HORIZONTAL:
					gdk_window_set_cursor(widget->window, h_cursor);
					break;
				case CONTING_RESIZE_VERTICAL:
					gdk_window_set_cursor(widget->window, v_cursor);
			}
		}
	}

	return TRUE;
}


static void bus_button_clicked(GtkButton *button, gpointer user_data) {
	g_print("bus_button_clicked()\n");
	if (selected_dd != NULL) {
		selected_dd = NULL;
		gtk_widget_queue_draw(GTK_WIDGET(user_data));
	}

	if (current_drawing != NULL && !current_drawing_start) {
		return;
	}

	current_drawing = conting_bus_new();
	current_drawing_start = TRUE;
}

static void line_button_clicked(GtkButton *button, gpointer user_data) {
	g_print("line_button_clicked()\n");
	if (selected_dd != NULL) {
		selected_dd = NULL;
		gtk_widget_queue_draw(GTK_WIDGET(user_data));
	}

	if (current_drawing != NULL && !current_drawing_start) {
		return;
	}
	current_drawing = conting_connection_new();
	current_drawing_start = TRUE;
}

static void trans2_button_clicked(GtkButton *button, gpointer user_data) {
	g_print("trans2_button_clicked()\n");
	if (selected_dd != NULL) {
		selected_dd = NULL;
		gtk_widget_queue_draw(GTK_WIDGET(user_data));
	}

	if (current_drawing != NULL && !current_drawing_start) {
		return;
	}
	current_drawing = conting_trans2_new();
	current_drawing_start = TRUE;
}

int main(int argc, char *argv[]) {
    GtkWidget *window, *darea, *swindow;
	GtkWidget *bus_button, *line_button, *trans2_button;
	GtkWidget *vbox, *hbox;

    gtk_init(&argc, &argv);

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_widget_set_size_request(GTK_WIDGET(window), 400, 400);

	vbox = gtk_vbox_new(FALSE, 0);
	gtk_container_add(GTK_CONTAINER(window), vbox);
	gtk_widget_show(vbox);

	swindow = gtk_scrolled_window_new(NULL, NULL);
	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(swindow),
			GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);

	gtk_box_pack_start(GTK_BOX(vbox), swindow, TRUE, TRUE, 0);
	gtk_widget_show(swindow);

    darea = gtk_drawing_area_new();
	gtk_widget_set_size_request(GTK_WIDGET(darea), 800, 800);
	g_signal_connect(G_OBJECT(darea), "realize",
			G_CALLBACK(darea_realize), NULL);
	g_signal_connect(G_OBJECT(darea), "expose_event",
			G_CALLBACK(darea_expose_event), NULL);
	g_signal_connect(G_OBJECT(darea), "button-press-event",
			G_CALLBACK(darea_button_press_event), NULL);
	g_signal_connect(G_OBJECT(darea), "button-release-event",
			G_CALLBACK(darea_button_release_event), NULL);
	g_signal_connect(G_OBJECT(window), "key-press-event",
			G_CALLBACK(darea_key_press_event), darea);
	g_signal_connect(G_OBJECT(darea), "motion_notify_event",
			G_CALLBACK(darea_motion_notify_event), NULL);

	gtk_scrolled_window_add_with_viewport(GTK_SCROLLED_WINDOW(swindow), darea);
	gtk_widget_show(darea);

	hbox = gtk_hbox_new(FALSE, 0);
	gtk_box_pack_start(GTK_BOX(vbox), hbox, FALSE, TRUE, 0);
	gtk_widget_show(hbox);

	line_button = gtk_button_new_with_label("LINE");
	g_signal_connect(G_OBJECT(line_button), "clicked",
			G_CALLBACK(line_button_clicked), darea);
	gtk_box_pack_start_defaults(GTK_BOX(hbox), line_button);
	gtk_widget_show(line_button);

	bus_button = gtk_button_new_with_label("BUS");
	g_signal_connect(G_OBJECT(bus_button), "clicked",
			G_CALLBACK(bus_button_clicked), darea);
	gtk_box_pack_start_defaults(GTK_BOX(hbox), bus_button);
	gtk_widget_show(bus_button);
	
	trans2_button = gtk_button_new_with_label("TRANS2");
	g_signal_connect(G_OBJECT(trans2_button), "clicked",
			G_CALLBACK(trans2_button_clicked), darea);
	gtk_box_pack_start_defaults(GTK_BOX(hbox), trans2_button);
	gtk_widget_show(trans2_button);
	
	
	gtk_widget_show(window);

    gtk_main();

    return 0;
}
