ad_page_contract {
    Attach a report template to a lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-18
    @cvs-id $Id$
} {
    lab_id:integer
    return_url:optional
}

auth::require_login

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege lab_report_central_admin

if { ![info exists return_url] } {
    set return_url [export_vars -url -base lab {lab_id}]
}

set lab_name [db_string lab_name {} -default ""]

set page_title [_ lab-report-central.attach_template]
set context [list [list [export_vars -url -base lab {lab_id}] $lab_name] \
		 $page_title]

ad_form -name attach_template -cancel_url $return_url -form {
    {lab_id:integer(hidden) {value $lab_id}}
    {return_url:text(hidden) {value $return_url}}
    {template_id:integer(select)
 	{label "[_ lab-report-central.template]" }
 	{help_text "[_ lab-report-central.help_select_template_to_attach]"}
 	{options "[lab_report_central::unmapped_templates_get_options \
		      -lab_id $lab_id]"}
    }
} -after_submit {
    # Map report template to lab.
    db_dml attach_template {}

    ad_returnredirect $return_url
    ad_script_abort
}
