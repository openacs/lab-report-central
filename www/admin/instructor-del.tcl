ad_page_contract {
    Deletes a user from the staff group and redirects back to listing of
    staff.  Able to specify a return_url if the default is not suitable.

    @param staff_id The ID of the user that needs to be removed from the
    staff list.
    @param return_url Optional url to redirect to when the delete operation
    is complete.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-12-04
    @cvs-id $Id$
} {
    instructor_id:integer
    {return_url "instructors"}
}

set package_id [ad_conn package_id]

# Revoke privileges.
permission::revoke -party_id $instructor_id \
    -object_id $package_id \
    -privilege lab_report_central_admin

permission::revoke -party_id $instructor_id \
    -object_id $package_id \
    -privilege lab_report_central_read

permission::revoke -party_id $instructor_id \
    -object_id $package_id \
    -privilege lab_report_central_write

# Revoke membership.
group::remove_member -group_id [lab_report_central::instructor_group_id] \
    -user_id $instructor_id

ad_returnredirect $return_url
ad_script_abort
