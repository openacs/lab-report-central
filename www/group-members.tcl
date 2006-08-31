ad_page_contract {

    Displays members for a given group ID.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
    lab_id:integer,notnull
}

set context "[list [list [export_vars -url -base lab {lab_id}] [lab_report_central::lab_name -lab_id $lab_id]] [list [export_vars -url -base groups {lab_id}] [_ lab-report-central.groups]] [_ lab-report-central.group_members]]"

set group_name [lang::util::localize [db_string group_name {} -default ""]]

db_multirow group_members group_members {}

template::list::create \
    -name group_members \
    -multirow group_members \
    -key user_id \
    -bulk_actions {
	"Remove" "group-members-rem" "Remove user from group"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id group_id lab_id
    } \
    -no_data {#lab-report-central.no_members_added_to_group#} \
    -elements {
	name {
	    label #lab-report-central.name#
	}
    } \
    -html {width 60%}

db_multirow non_group_members non_group_members {}

template::list::create \
    -name non_group_members \
    -multirow non_group_members \
    -key user_id \
    -bulk_actions {
	"Add" "group-members-add" "Add user to group"
    } \
    -bulk_action_method post -bulk_action_export_vars {
	user_id group_id lab_id
    } \
    -no_data {#lab-report-central.no_members_added_to_group#} \
    -elements {
	name {
	    label #lab-report-central.name#
	}
    } \
    -html {width 60%}

ad_return_template
