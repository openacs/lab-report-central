ad_page_contract {
    Add/Edit a report template.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-18
    @cvs-id $Id$
} {
    template_id:integer,optional
    {return_url "templates"}
}

auth::require_login

if { [info exists template_id] } {
    set page_title [_ lab-report-central.edit_template]
} else {
    set page_title [_ lab-report-central.add_template]
}

set context [list $page_title]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

ad_form -name template -cancel_url $return_url -form {
    {template_id:key(acs_object_id_seq)}
    {return_url:text(hidden) {value $return_url}}
    {name:text
	{html {size 50}}
	{label "[_ lab-report-central.name]" }
	{help_text "[_ lab-report-central.help_enter_template_name]"}
    }
    {description:richtext(richtext),optional
	{label "[_ lab-report-central.description]" }
	{help_text "[_ lab-report-central.help_enter_template_description]"}
	{html {cols 48 rows 6}}
	{htmlarea_p 0}
	{nospell}
    }
} -select_query {
       SELECT name, description
	   FROM lrc_template WHERE template_id = :template_id
} -new_data {

    package_instantiate_object \
        -var_list [list [list package_id $package_id] \
		       [list name $name] \
		       [list description $description]] \
        -form_id template lrc_template
    
} -edit_data {
    set modifying_user [ad_conn user_id]
    set modifying_ip [ad_conn peeraddr]

    db_dml template_update {}
    db_dml object_update {}
} -after_submit {
    ad_returnredirect $return_url
    ad_script_abort
}
