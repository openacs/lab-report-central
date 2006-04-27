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

ad_return_template
