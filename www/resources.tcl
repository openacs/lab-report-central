ad_page_contract {
    Page for displaying resources for a specific section of a template
    report.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-05-21
    @cvs-id $Id$
} {
    template_id
    section_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

db_1row section_details {}

set page_title [_ lab-report-central.section_resources_for_section_name]
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

db_multirow -extend {details_url resources_url} resource select_resources {} {
    if { [info exists resource_desc] } {
	set resource_desc \
	    [template::util::richtext::get_property html_value $resource_desc]
    } else {
	set resource_desc ""
    }

    set details_url [export_vars -url -base resource-ae {template_id section_id resource_id}]
}

set create_resource_url [export_vars -url -base resource-ae {template_id section_id}]

# resource_id is the last resource_id retrieved from the db_multirow block
# above.
set delete_resource_url [export_vars -url -base resource-del {template_id section_id resource_id}]
set confirm_msg "[_ lab-report-central.want_to_delete_resource]"

ad_return_template
