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

--
-- Drop tables
--
drop table lrc_lab;
drop table lrc_section;
drop table lrc_template;
drop table lrc_groups;
drop table lrc_template_section_map;

delete from acs_objects where object_type='lrc_lab';
delete from acs_objects where object_type='lrc_template';
delete from acs_objects where object_type='lrc_section';

--
-- Drop object types.
--
select acs_object_type__drop_type ('lrc_lab', 'f');
select acs_object_type__drop_type ('lrc_template', 'f');
select acs_object_type__drop_type ('lrc_section', 'f');