ad_page_contract {
    Add/Edit a lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-18
    @cvs-id $Id$
} {
    lab_id:integer,optional
    {return_url "."}
}

auth::require_login

if { [info exists lab_id] } {
    set page_title [_ lab-report-central.edit_lab]
} else {
    set page_title [_ lab-report-central.add_lab]
}

set context [list $page_title]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

ad_form -name lab -cancel_url $return_url -form {
    {lab_id:key(acs_object_id_seq)}
    {return_url:text(hidden) {value $return_url}}
    {name:text
	{html {size 50}}
	{label "[_ lab-report-central.name]" }
	{help_text "[_ lab-report-central.help_enter_lab_name]"}
    }
    {description:richtext(richtext),optional
	{label "[_ lab-report-central.description]" }
	{help_text "[_ lab-report-central.help_enter_lab_description]"}
	{html {cols 80 rows 12}}
	{nospell}
    }
    {instructor_id:search
	{result_datatype integer}
	{label "[_ lab-report-central.instructor]" }
	{help_text "[_ lab-report-central.help_select_lab_instructor]"}
	{options [lab_report_central::instructors_get_options]}
	{search_query {[db_map dbqd.lab-report-central.tcl.lab-report-central-procs.instructors_search]}}
    }
    {start_date:date,to_sql(sql_date),to_html(display_date)
	{label "[_ lab-report-central.lab_start_date]" }
	{help_text "[_ lab-report-central.help_enter_lab_start_date]"}
	{format "[lc_get formbuilder_date_format]"}
    }
    {end_date:date,to_sql(sql_date),to_html(display_date)
	{label "[_ lab-report-central.lab_end_date]" }
	{help_text "[_ lab-report-central.help_enter_lab_end_date]"}
	{format "[lc_get formbuilder_date_format]"}
    }
} -select_query {
       SELECT name, description, instructor_id, start_date, end_date
	   FROM lrc_lab WHERE lab_id = :lab_id
} -validate {
    {start_date
        { [template::util::date::compare $start_date $end_date] <= 0 }
        "#lab-report-central.start_date_must_be_set_before_end_date#"
    }
} -new_data {

    # Can't use package_instantiate_object because the underlying
    # db_exec_plsql can't know that the contents of the start_date and
    # end_date contain functions and not variables
    db_exec_plsql object_new {}

} -edit_data {
    set modifying_user [ad_conn user_id]
    set modifying_ip [ad_conn peeraddr]

    db_dml lab_update {}
    db_dml object_update {}
} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}
