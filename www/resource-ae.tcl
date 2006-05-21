ad_page_contract {
    Add/Edit a template section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-18
    @cvs-id $Id$
} {
    template_id:integer
    section_id:integer
    resource_id:integer,optional
    {return_url "."}
}

auth::require_login

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege lab_report_central_admin

if { [info exists resource_id] } {
    set page_title [_ lab-report-central.edit_resource]
} else {
    set page_title [_ lab-report-central.add_resource]
}

set template_name [db_string template_name {} -default ""]

set context [list [list templates [_ lab-report-central.templates]] \
		 [list [export_vars -url -base template {template_id}] $template_name] \
		 [list [export_vars -url -base resources {template_id section_id}] [_ lab-report-central.resources]] \
		 $page_title]

set return_url [export_vars -url -base resources {template_id section_id}]

ad_form -name resource -cancel_url $return_url -form {
    {resource_id:key(acs_object_id_seq)}
    {template_id:integer(hidden) {value $template_id}}
    {section_id:integer(hidden) {value $section_id}}
    {return_url:text(hidden) {value $return_url}}
    {name:text
	{html {size 50}}
	{label "[_ lab-report-central.name]" }
	{help_text "[_ lab-report-central.help_enter_resource_name]"}
    }
    {url:text
	{html {size 50}}
	{label "[_ lab-report-central.URL]" }
	{help_text "[_ lab-report-central.help_enter_resource_url]"}
    }
    {description:richtext(richtext),optional
	{label "[_ lab-report-central.description]" }
	{help_text "[_ lab-report-central.help_enter_resource_description]"}
	{html {cols 48 rows 6}}
	{htmlarea_p 0}
	{nospell}
    }
} -select_query {
    SELECT name, url, description
    FROM lrc_resource
    WHERE resource_id = :resource_id
} -new_data {

    package_instantiate_object \
        -var_list [list [list package_id $package_id] \
		       [list template_id $template_id] \
		       [list section_id $section_id] \
		       [list name $name] \
		       [list url $url] \
		       [list description $description]] \
        -form_id resource lrc_resource

} -edit_data {
    set modifying_user [ad_conn user_id]
    set modifying_ip [ad_conn peeraddr]

    db_dml resource_update {}
    db_dml object_update {}
} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}
