ad_page_contract {
    Add an instructor.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-11-20
    @cvs-id $Id$
} {
    instructor_id:integer,optional
    {return_url "instructors"}
}

set page_title [_ lab-report-central.add_instructor]

set context [list [list instructors [_ lab-report-central.instructors]] $page_title]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

ad_form -name instructor -cancel_url $return_url -form {
    {instructor_id:key(acs_object_id_seq)}
    {return_url:text(hidden) {value $return_url}}
    {user:search,optional
	{result_datatype integer}
	{label "#lab-report-central.name#" }
	{help_text "[_ lab-report-central.help_search_users]"}
	{options [lab_report_central::non_instructors_get_options]}
	{search_query {[db_map dbqd.lab-report-central.tcl.lab-report-central-procs.non_instructors_search]}}
    }
} -after_submit {
    group::add_member -group_id [lab_report_central::instructor_group_id] \
	-user_id $user
    
    # TODO: Add privileges for new member.
    permission::grant -party_id $user \
	-object_id $package_id \
	-privilege lab_report_central_admin

    permission::grant -party_id $user \
	-object_id $package_id \
	-privilege lab_report_central_read

    permission::grant -party_id $user \
	-object_id $package_id \
	-privilege lab_report_central_write

    ad_returnredirect $return_url
    ad_script_abort
}
