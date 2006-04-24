ad_page_contract {
    Admin page.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

db_multirow -extend { view_url edit_url delete_url } labs labs {} {
    set view_url [export_vars -url -base lab { lab_id }]
    set edit_url [export_vars -url -base lab-ae { lab_id }]
    set delete_url [export_vars -url -base lab-del { lab_id }]
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
