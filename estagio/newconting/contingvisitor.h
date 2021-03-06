#ifndef CONTING_VISITOR_H
#define CONTING_VISITOR_H

#include <glib.h>
#include <glib-object.h>

#define CONTING_TYPE_VISITOR			(conting_visitor_get_type())
#define CONTING_VISITOR(o)				(G_TYPE_CHECK_INSTANCE_CAST ((o), \
			CONTING_TYPE_VISITOR, ContingVisitor))
#define CONTING_VISITOR_CLASS(k)		(G_TYPE_CHECK_CLASS_CAST ((k), \
			CONTING_TYPE_VISITOR, ContingVisitorClass))
#define CONTING_IS_VISITOR(o)			(G_TYPE_CHECK_INSTANCE_TYPE ((o), \
			CONTING_TYPE_VISITOR))
#define CONTING_IS_VISITOR_CLASS(k)	(G_TYPE_CHECK_CLASS_TYPE ((k), \
			CONTING_TYPE_VISITOR))
#define CONTING_VISITOR_GET_CLASS(o)	(G_TYPE_INSTANCE_GET_INTERFACE ((o), \
			CONTING_TYPE_VISITOR, ContingVisitorClass))


typedef struct ContingVisitor_ ContingVisitor;
typedef struct ContingVisitorClass_ ContingVisitorClass;

#include "contingdrawing.h"
#include "contingline.h"
#include "contingbus.h"
#include "contingtrans2.h"
#include "contingtrans3.h"
#include "contingload.h"
#include "continggen.h"
#include "contingce.h"
#include "contingcs.h"
#include "contingground.h"
#include "contingcshunt.h"
#include "contingrshunt.h"

struct ContingVisitorClass_ {
	GTypeInterface parent;

	void (*visit_line)(ContingVisitor *self, ContingLine *line);
	void (*visit_bus)(ContingVisitor *self, ContingBus *bus);
	void (*visit_trans2)(ContingVisitor *self, ContingTrans2 *trans2);
	void (*visit_trans3)(ContingVisitor *self, ContingTrans3 *trans3);
	void (*visit_load)(ContingVisitor *self, ContingLoad *load);
	void (*visit_gen)(ContingVisitor *self, ContingGen *gen);
	void (*visit_ce)(ContingVisitor *self, ContingCE *gen);
	void (*visit_cs)(ContingVisitor *self, ContingCS *gen);
	void (*visit_ground)(ContingVisitor *self, ContingGround *gen);
	void (*visit_c_shunt)(ContingVisitor *self, ContingCShunt *cs);
	void (*visit_r_shunt)(ContingVisitor *self, ContingRShunt *cs);
};

GType
conting_visitor_get_type(void);

void conting_visitor_visit_line(ContingVisitor *self, ContingLine *line);
void conting_visitor_visit_bus(ContingVisitor *self, ContingBus *bus);
void conting_visitor_visit_trans2(ContingVisitor *self, ContingTrans2 *trans2);
void conting_visitor_visit_trans3(ContingVisitor *self, ContingTrans3 *trans3);
void conting_visitor_visit_load(ContingVisitor *self, ContingLoad *load);
void conting_visitor_visit_gen(ContingVisitor *self, ContingGen *gen);
void conting_visitor_visit_ce(ContingVisitor *self, ContingCE *gen);
void conting_visitor_visit_cs(ContingVisitor *self, ContingCS *gen);
void conting_visitor_visit_ground(ContingVisitor *self, ContingGround *gen);
void conting_visitor_visit_c_shunt(ContingVisitor *self, ContingCShunt *cs);
void conting_visitor_visit_r_shunt(ContingVisitor *self, ContingRShunt *cs);

#include "contingvisitorcolor.h"


#endif /* CONTING_VISITOR_H */
