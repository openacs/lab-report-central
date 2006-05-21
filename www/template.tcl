ad_page_contract {
    Admin page.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
} {
    template_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

db_1row template_details {}

set page_title $name
set context [list [list templates [_ lab-report-central.templates]] \
		 $page_title]

if { [info exists description] } {
    set description [template::util::richtext::get_property html_value \
			 $description]   
} else {
    set description ""
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

db_multirow -extend {details_url resources_url} section select_sections {} {
    if { [info exists section_desc] } {
	set section_desc \
	    [template::util::richtext::get_property html_value $section_desc]
    } else {
	set section_desc ""
    }

    set details_url [export_vars -url -base section-ae {template_id section_id}]
    set resources_url [export_vars -url -base resources {template_id section_id}]
}

set create_section_url [export_vars -url -base section-ae {template_id}]

# section_id is the last section_id retrieved from the db_multirow block
# above.
set delete_section_url [export_vars -url -base section-del {template_id section_id}]
set confirm_msg "[_ lab-report-central.want_to_delete_section]"

ad_return_template
