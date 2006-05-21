-- $Id$

--
-- Create some privileges.
--
begin;
        select acs_privilege__create_privilege('lab_report_central_admin', null, null);
        select acs_privilege__create_privilege('lab_report_central_admin_create', null, null);
        select acs_privilege__create_privilege('lab_report_central_admin_modify', null, null);
        select acs_privilege__create_privilege('lab_report_central_admin_delete', null, null);
        select acs_privilege__create_privilege('lab_report_central_write', null, null);
       	select acs_privilege__create_privilege('lab_report_central_read', null, null);
end;

--
-- Define hierarchy of privileges.
--
begin;
        select acs_privilege__add_child('lab_report_central_admin','lab_report_central_admin_create');
        select acs_privilege__add_child('lab_report_central_admin','lab_report_central_admin_modify');
        select acs_privilege__add_child('lab_report_central_admin','lab_report_central_admin_delete');
        select acs_privilege__add_child('admin','lab_report_central_admin');
        select acs_privilege__add_child('read','lab_report_central_read');
        select acs_privilege__add_child('write','lab_report_central_write');
end;


--
-- Define object types.
--
select  acs_object_type__create_type (
    'lrc_lab',
    '#lab-report-central.lab#',
    '#lab-report-central.labs#',
    'acs_object',
    'lrc_lab',
    'lab_id',
    null,
    'f',
    null,
    null
   );

select acs_object_type__create_type (
    'lrc_template',
    '#lab-report-central.template#',
    '#lab-report-central.templates#',
    'acs_object',
    'lrc_template',
    'template_id',
    null,
    'f',
    null,
    null
   );

select acs_object_type__create_type (
    'lrc_section',
    '#lab-report-central.section#',
    '#lab-report-central.sections#',
    'acs_object',
    'lrc_section',
    'section_id',
    null,
    'f',
    null,
    null
   );

select acs_object_type__create_type (
    'lrc_resource',
    '#lab-report-central.resource#',
    '#lab-report-central.resources#',
    'acs_object',
    'lrc_resource',
    'resource_id',
    null,
    'f',
    null,
    null
   );

--
-- Create tables
--
create table lrc_lab (
	lab_id			integer
				constraint lrc_lab_lab_id_fk
				references acs_objects (object_id)
				constraint lrc_lab_pk
				primary key,
	name			varchar (5120)
				constraint lrc_lab_name_nn
				not null,
	description		text,
	instructor_id		integer
				constraint lrc_lab_instructor_id_fk
				references users(user_id),
	start_date		timestamptz,
	end_date		timestamptz,
	package_id		integer
				constraint lrc_lab_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lrc_template (
	template_id		integer
				constraint lrc_template_template_id_fk
				references acs_objects (object_id)
				constraint lrc_template_pk
				primary key,
	name			varchar (5120)
				constraint lrc_template_name_nn
				not null,
	description		text,
	package_id		integer
				constraint lrc_template_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lrc_section (
	section_id		integer
				constraint lrc_section_section_id_fk
				references acs_objects (object_id)
				constraint lrc_section_pk
				primary key,
	template_id		integer
				constraint lrc_section_template_id_fk
				references lrc_template (template_id)
				on delete cascade,
	name			varchar (5120)
				constraint lrc_section_name_nn
				not null,
	description		text,
	package_id		integer
				constraint lrc_section_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lrc_resource (
	resource_id		integer
				constraint lrc_resource_resource_id_fk
				references acs_objects (object_id)
				constraint lrc_resource_pk
				primary key,
	section_id		integer
				constraint lrc_resource_section_id_fk
				references lrc_section (section_id)
				on delete cascade,
	name			varchar (5120)
				constraint lrc_resource_name_nn
				not null,
	url			varchar (5120),
	description		text,
	package_id		integer
				constraint lrc_resource_package_id_fk
				references apm_packages (package_id)
				on delete cascade
);

create table lrc_groups (
	magic_name		varchar(512)
				constraint lrc_groups_name_nn
				not null,
	group_id		integer
				constraint lrc_groups_group_id_nn
				not null
				constraint lrc_groups_group_id_fk
				references groups (group_id)
				on delete cascade
);

create table lrc_lab_template_map (
	lab_id			integer
				constraint lrc_lt_map_lab_id_fk
				references lrc_lab (lab_id)
				on delete cascade,
	template_id		integer
				constraint lrc_lt_map_template_id_fk
				references lrc_template (template_id)
				on delete cascade
);

create table lrc_lab_student_map (
	lab_id			integer
				constraint lrc_lab_student_map_lab_id_fk
				references lrc_lab (lab_id)
				on delete cascade,
	user_id			integer
				constraint lrc_lab_student_map_user_id_fk
				references users (user_id)
				on delete cascade
);


--
-- Create functions
--
select define_function_args('lrc_lab__new','lab_id,name,description,instructor_id,start_date,end_date,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lrc_lab__new (
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
) returns integer as '
declare
	p_lab_id		alias for $1;        	-- default null
    	p_name			alias for $2;
    	p_description           alias for $3;
	p_instructor_id         alias for $4;
        p_start_date            alias for $5;
	p_end_date		alias for $6;
	p_package_id		alias for $7;
    	p_creation_date         alias for $8;        	-- default now()
    	p_creation_user         alias for $9;        	-- default null
    	p_creation_ip           alias for $10;		-- default null
    	p_context_id            alias for $11;		-- default null

    	v_lab_id                lrc_lab.lab_id%TYPE;
	v_inst_group_id		integer;
begin

    	v_lab_id := acs_object__new (
        	p_lab_id,
        	''lrc_lab'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lrc_lab (
       		lab_id,
		name,
		description,
		instructor_id,
		start_date,
		end_date,
	        package_id
    	) VALUES (
        	v_lab_id,
		p_name,
		p_description,
		p_instructor_id,
		p_start_date,
		p_end_date,
        	p_package_id
    	);

    	SELECT group_id into v_inst_group_id
      	FROM lrc_groups
        WHERE magic_name = ''instructors'';

	-- Grant permissions to instructors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_lab_id,
          	v_inst_group_id,
	        ''lab_report_central_read''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_lab_id,
          	v_inst_group_id,
          	''lab_report_central_write''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_lab_id,
          	v_inst_group_id,
          	''lab_report_central_admin''
    	);

    	return v_lab_id;

end;' language 'plpgsql';


select define_function_args('lrc_lab__del','lab_id');

create function lrc_lab__del (integer)
returns integer as '
declare
	p_lab_id          	alias for $1;
begin
    	DELETE FROM acs_permissions
        	WHERE object_id = p_lab_id;

    	DELETE FROM lrc_lab
           	WHERE lab_id = p_lab_id;

    	raise NOTICE ''Deleting degree...'';
    	PERFORM acs_object__delete(p_lab_id);

    	return 0;

end;' language 'plpgsql';


select define_function_args('lrc_lab__name','lab_id');

create function lrc_lab__name (integer)
returns varchar as '
declare
    	p_lab_id      		alias for $1;
    	v_lab_name    		lrc_lab.name%TYPE;
begin
    	SELECT name INTO v_lab_name
        	FROM lrc_lab
        	WHERE lab_id = p_lab_id;

    	return v_lab_name;
end;
' language 'plpgsql';


select define_function_args('lrc_template__new','template_id,name,description,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lrc_template__new (
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
) returns integer as '
declare
	p_template_id		alias for $1;        	-- default null
    	p_name			alias for $2;
    	p_description           alias for $3;
	p_package_id		alias for $4;
    	p_creation_date         alias for $5;        	-- default now()
    	p_creation_user         alias for $6;        	-- default null
    	p_creation_ip           alias for $7;		-- default null
    	p_context_id            alias for $8;		-- default null

    	v_template_id           lrc_template.template_id%TYPE;
	v_inst_group_id		integer;
begin

    	v_template_id := acs_object__new (
        	p_template_id,
        	''lrc_template'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lrc_template (
       		template_id,
		name,
		description,
	        package_id
    	) VALUES (
        	v_template_id,
		p_name,
		p_description,
        	p_package_id
    	);

    	SELECT group_id into v_inst_group_id
      	FROM lrc_groups
        WHERE magic_name = ''instructors'';

	-- Grant permissions to instructors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_template_id,
          	v_inst_group_id,
	        ''lab_report_central_read''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_template_id,
          	v_inst_group_id,
          	''lab_report_central_write''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_template_id,
          	v_inst_group_id,
          	''lab_report_central_admin''
    	);

    	return v_template_id;

end;' language 'plpgsql';


select define_function_args('lrc_template__del','template_id');

create function lrc_template__del (integer)
returns integer as '
declare
	p_template_id          	alias for $1;
begin
    	DELETE FROM acs_permissions
        	WHERE object_id = p_template_id;

    	DELETE FROM lrc_template
           	WHERE template_id = p_template_id;

    	raise NOTICE ''Deleting template...'';
    	PERFORM acs_object__delete(p_template_id);

    	return 0;

end;' language 'plpgsql';


select define_function_args('lrc_template__name','template_id');

create function lrc_template__name (integer)
returns varchar as '
declare
    	p_template_id      		alias for $1;
    	v_template_name    		lrc_template.name%TYPE;
begin
    	SELECT name INTO v_template_name
        	FROM lrc_template
        	WHERE template_id = p_template_id;

    	return v_template_name;
end;
' language 'plpgsql';


select define_function_args('lrc_section__new','section_id,template_id,name,description,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lrc_section__new (
	integer,
	integer,
	varchar,
	text,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
) returns integer as '
declare
	p_section_id		alias for $1;        	-- default null
	p_template_id		alias for $2;
    	p_name			alias for $3;
    	p_description           alias for $4;
	p_package_id		alias for $5;
    	p_creation_date         alias for $6;        	-- default now()
    	p_creation_user         alias for $7;        	-- default null
    	p_creation_ip           alias for $8;		-- default null
    	p_context_id            alias for $9;		-- default null

    	v_section_id           lrc_section.section_id%TYPE;
	v_inst_group_id		integer;
begin

    	v_section_id := acs_object__new (
        	p_section_id,
        	''lrc_section'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lrc_section (
		section_id,
       		template_id,
		name,
		description,
	        package_id
    	) VALUES (
		v_section_id,
        	p_template_id,
		p_name,
		p_description,
        	p_package_id
    	);

    	SELECT group_id into v_inst_group_id
      	FROM lrc_groups
        WHERE magic_name = ''instructors'';

	-- Grant permissions to instructors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_section_id,
          	v_inst_group_id,
	        ''lab_report_central_read''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_section_id,
          	v_inst_group_id,
          	''lab_report_central_write''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_section_id,
          	v_inst_group_id,
          	''lab_report_central_admin''
    	);

    	return v_section_id;

end;' language 'plpgsql';


select define_function_args('lrc_section__del','section_id');

create function lrc_section__del (integer)
returns integer as '
declare
	p_section_id          	alias for $1;
begin
    	DELETE FROM acs_permissions
        	WHERE object_id = p_section_id;

    	DELETE FROM lrc_section
           	WHERE section_id = p_section_id;

    	raise NOTICE ''Deleting section...'';
    	PERFORM acs_object__delete(p_section_id);

    	return 0;

end;' language 'plpgsql';


select define_function_args('lrc_section__name','section_id');

create function lrc_section__name (integer)
returns varchar as '
declare
    	p_section_id      		alias for $1;
    	v_section_name    		lrc_section.name%TYPE;
begin
    	SELECT name INTO v_section_name
        	FROM lrc_section
        	WHERE section_id = p_section_id;

    	return v_section_name;
end;
' language 'plpgsql';


select define_function_args('lrc_resource__new','resource_id,section_id,name,url,description,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function lrc_resource__new (
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
) returns integer as '
declare
	p_resource_id		alias for $1;        	-- default null
	p_section_id		alias for $2;
    	p_name			alias for $3;
	p_url			alias for $4;
    	p_description           alias for $5;
	p_package_id		alias for $6;
    	p_creation_date         alias for $7;        	-- default now()
    	p_creation_user         alias for $8;        	-- default null
    	p_creation_ip           alias for $9;		-- default null
    	p_context_id            alias for $10;		-- default null

    	v_resource_id           lrc_resource.resource_id%TYPE;
	v_inst_group_id		integer;
begin

    	v_resource_id := acs_object__new (
        	p_resource_id,
        	''lrc_resource'',
        	p_creation_date,
        	p_creation_user,
        	p_creation_ip,
        	p_context_id
    	);

    	INSERT INTO lrc_resource (
		resource_id,
       		section_id,
		name,
		url,
		description,
	        package_id
    	) VALUES (
		v_resource_id,
        	p_section_id,
		p_name,
		p_url,
		p_description,
        	p_package_id
    	);

    	SELECT group_id into v_inst_group_id
      	FROM lrc_groups
        WHERE magic_name = ''instructors'';

	-- Grant permissions to instructors on this object.
    	PERFORM acs_permission__grant_permission(
          	v_resource_id,
          	v_inst_group_id,
	        ''lab_report_central_read''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_resource_id,
          	v_inst_group_id,
          	''lab_report_central_write''
    	);

    	PERFORM acs_permission__grant_permission(
          	v_resource_id,
          	v_inst_group_id,
          	''lab_report_central_admin''
    	);

    	return v_resource_id;

end;' language 'plpgsql';


select define_function_args('lrc_resource__del','resource_id');

create function lrc_resource__del (integer)
returns integer as '
declare
	p_resource_id          	alias for $1;
begin
    	raise NOTICE ''Deleting resource...'';

    	DELETE FROM acs_permissions
        	WHERE object_id = p_resource_id;

    	DELETE FROM lrc_resource
           	WHERE resource_id = p_resource_id;

    	PERFORM acs_object__delete(p_resource_id);

    	return 0;

end;' language 'plpgsql';


select define_function_args('lrc_resource__name','resource_id');

create function lrc_resource__name (integer)
returns varchar as '
declare
    	p_resource_id      		alias for $1;
    	v_resource_name    		lrc_resource.name%TYPE;
begin
    	SELECT name INTO v_resouce_name
        	FROM lrc_resource
        	WHERE resource_id = p_resource_id;

    	return v_resource_name;
end;
' language 'plpgsql';
