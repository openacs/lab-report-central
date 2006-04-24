ad_page_contract {
    Page for viewing details for a lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
} {
    lab_id
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

db_1row lab_details {}

set page_title $name
set context [list $page_title]

set description [template::util::richtext::get_property html_value \
		     $description]

db_multirow -extend { view_url edit_url delete_url } rt rt {} {
    set view_url ""
    set edit_url [export_vars -url -base template-ae { lab_id }]
    set delete_url ""
}

set create_url [export_vars -url -base template-ae { lab_id }]

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
