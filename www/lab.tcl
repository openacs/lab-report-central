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

if { [info exists description] } {
    set description [template::util::richtext::get_property html_value \
			 $description]
} else {
    set description ""
}

db_multirow -extend { view_url edit_url delete_url } rt rt {} {
    set view_url [export_vars -url -base template {template_id}]
    set edit_url [export_vars -url -base template-ae {lab_id}]
    set delete_url [export_vars -url \
			-base detach-template {lab_id template_id}]
}

set create_url [export_vars -url -base attach-template { lab_id }]

set marker_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege lab_report_central_admin]

set add_student_url [export_vars -url -base attach-student {lab_id}]

# Select all students that belong to the marker that is viewing this page.
db_multirow -extend {dotfolio_url} student select_marking_group {} {
    set dotfolio_base_url "[dotfolio::user::dotfolio_url -user_id $student_id]"
    set dotfolio_url [export_vars -url \
			  -base "${dotfolio_base_url}pracs/view-lab" {lab_id}]
}

set view_students_url [export_vars -url -base students {lab_id}]

# Is the user the instructor that the lab is assigned to?
set lab_instructor_p 0
if { $user_id == $instructor_id} {
    set lab_instructor_p 1
}

set show_buttons_p 0
if { $lab_instructor_p } {
    set show_buttons_p 1
}

set create_group_url [export_vars -url -base groups {lab_id}]

ad_return_template
