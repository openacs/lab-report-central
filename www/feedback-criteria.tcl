ad_page_contract {
    Page for displaying feedback criteria for a specific section of a template
    report.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-08-14
    @cvs-id $Id$
} {
    template_id
    section_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

db_1row section_details {}

set page_title [_ lab-report-central.feedback_criteria_for_section_name]
set context [list [list templates [_ lab-report-central.templates]] \
		 [list [export_vars -url -base template {template_id}] \
		      $template_name] \
		 $page_title]

if { [info exists section_desc] } {
    set section_desc [template::util::richtext::get_property html_value \
			 $section_desc]   
} else {
    set section_desc ""
}

set create_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege lab_report_central_admin_create]

set delete_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege lab_report_central_admin_delete]

set modify_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege lab_report_central_admin_modify]

db_multirow -extend {details_url} feedback select_feedback {} {
    if { [info exists criteria_desc] } {
	set criteria_desc \
	    [template::util::richtext::get_property html_value $criteria_desc]
    } else {
	set criteria_desc ""
    }

    set details_url [export_vars -url -base feedback-criteria-ae \
			 {template_id section_id feedback_criteria_id}]
}

set create_feedback_url [export_vars -url -base feedback-criteria-ae {template_id section_id}]

# feedback_criteria_id is the last feedback_criteria_id retrieved
# from the db_multirow block above.
set delete_feedback_url [export_vars -url -base feedback-criteria-del {template_id section_id feedback_criteria_id}]
set confirm_msg "[_ lab-report-central.want_to_delete_feedback_component]"

ad_return_template
