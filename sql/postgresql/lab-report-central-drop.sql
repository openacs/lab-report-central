-- $Id$

--
-- Drop hierarchy of privileges.
--
select acs_privilege__remove_child('lab_report_central_admin','lab_report_central_admin_create');
select acs_privilege__remove_child('lab_report_central_admin','lab_report_central_admin_modify');
select acs_privilege__remove_child('lab_report_central_admin','lab_report_central_admin_delete');
select acs_privilege__remove_child('admin','lab_report_central_admin');
select acs_privilege__remove_child('read','lab_report_central_read');
select acs_privilege__remove_child('write','lab_report_central_write');

--
-- Drop privileges.
--
select acs_privilege__drop_privilege('lab_report_central_admin');
select acs_privilege__drop_privilege('lab_report_central_admin_create');
select acs_privilege__drop_privilege('lab_report_central_admin_modify');
select acs_privilege__drop_privilege('lab_report_central_admin_delete');
select acs_privilege__drop_privilege('lab_report_central_write');
select acs_privilege__drop_privilege('lab_report_central_read');

--
-- Drop functions
--
drop function lrc_feedback_criteria__name (integer);
drop function lrc_feedback_criteria__del (integer);
drop function lrc_feedback_criteria__new (
	integer,
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lrc_resource__name (integer);
drop function lrc_resource__del (integer);
drop function lrc_resource__new (
	integer,
	integer,
	varchar,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lrc_section__name (integer);
drop function lrc_section__del (integer);
drop function lrc_section__new (
	integer,
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lrc_template__name (integer);
drop function lrc_template__del (integer);
drop function lrc_template__new (
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop function lrc_lab__name (integer);
drop function lrc_lab__del (integer);
drop function lrc_lab__new (
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	timestamptz,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

--
-- Drop tables
--
drop table lrc_lab;
drop table lrc_resource;
drop table lrc_feedback_criteria;
drop table lrc_section;
drop table lrc_template;
drop table lrc_groups;
drop table lrc_lab_template_map;
drop table lrc_lab_student_map;

delete from acs_objects where object_type='lrc_lab';
delete from acs_objects where object_type='lrc_template';
delete from acs_objects where object_type='lrc_section';
delete from acs_objects where object_type='lrc_resource';
delete from acs_objects where object_type='lrc_feedback_criteria';

--
-- Drop object types.
--
select acs_object_type__drop_type ('lrc_lab', 'f');
select acs_object_type__drop_type ('lrc_template', 'f');
select acs_object_type__drop_type ('lrc_section', 'f');
select acs_object_type__drop_type ('lrc_resource', 'f');
select acs_object_type__drop_type ('lrc_feedback_criteria', 'f');
