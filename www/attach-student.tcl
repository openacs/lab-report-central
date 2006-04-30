ad_page_contract {
    Add a student to a lab.

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

set page_title [_ lab-report-central.add_student]
set context [list [list [export_vars -url -base lab {lab_id}] $lab_name] \
		 $page_title]

ad_form -name attach_student -cancel_url $return_url -form {
    {lab_id:integer(hidden) {value $lab_id}}
    {return_url:text(hidden) {value $return_url}}
    {student_id:search
	{result_datatype integer}
 	{label "[_ lab-report-central.student]" }
 	{help_text "[_ lab-report-central.help_select_student_to_attach]"}
 	{options "[lab_report_central::unmapped_students_get_options \
		      -lab_id $lab_id]"}
	{search_query {[db_map dbqd.lab-report-central.tcl.lab-report-central-procs.lab_student_search]}}
    }
} -after_submit {
    # Map student to lab.
    db_dml attach_student {}

    ad_returnredirect $return_url
    ad_script_abort
}
