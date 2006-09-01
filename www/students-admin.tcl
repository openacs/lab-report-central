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
set lab_instructor_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

permission::require_permission -party_id $lab_instructor_id \
    -object_id $package_id \
    -privilege lab_report_central_admin

if { ![info exists return_url] } {
    set return_url [export_vars -url -base students {lab_id}]
}

set lab_name [db_string lab_name {} -default ""]

set page_title [_ lab-report-central.add_student]
set context [list [list [export_vars -url -base lab {lab_id}] $lab_name] \
		 $page_title]


db_multirow students students {}

template::list::create \
    -name students \
    -multirow students \
    -key user_id \
    -bulk_actions {
	"Remove" "students-rem" "Remove user from class list"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id lab_id
    } \
    -no_data {#lab-report-central.no_members_added_to_group#} \
    -elements {
	name {
	    label #lab-report-central.name#
	}
    } \
    -html {width 60%}

db_multirow non_students non_students {}

template::list::create \
    -name non_students \
    -multirow non_students \
    -key user_id \
    -bulk_actions {
	"Add" "students-add" "Add user to class list"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id lab_id
    } \
    -no_data {#lab-report-central.no_members_added_to_group#} \
    -elements {
	name {
	    label #lab-report-central.name#
	}
    } \
    -html {width 60%}

ad_return_template