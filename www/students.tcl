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

set page_title "$name - [_ lab-report-central.class_list]"
set context [list [list [export_vars -url -base lab {lab_id}] $name] [_ lab-report-central.class_list]]

if { [info exists description] } {
    set description [template::util::richtext::get_property html_value \
			 $description]
} else {
    set description ""
}

set admin_p [permission::permission_p -party_id $user_id \
		  -object_id $package_id \
		  -privilege lab_report_central_admin]

set add_student_url [export_vars -url -base students-admin {lab_id}]

db_multirow -extend {rem_student_url dotfolio_url} student select_students {} {
    set rem_student_url [export_vars -url -base detach-student {lab_id student_id}]

    set dotfolio_base_url "[dotfolio::user::dotfolio_url -user_id $student_id]"
    set dotfolio_url [export_vars -url \
			  -base "${dotfolio_base_url}pracs/view-lab" {lab_id}]
}

# Is the user the instructor that the lab is assigned to?
set lab_instructor_p 0
if { $user_id == $instructor_id} {
    set lab_instructor_p 1
}

set show_buttons_p 0
if { $lab_instructor_p } {
    set show_buttons_p 1
}

ad_return_template
