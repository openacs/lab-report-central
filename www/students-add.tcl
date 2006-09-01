ad_page_contract {

    Adds the given list of users to the class list for the specified lab..

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    lab_id:integer,notnull
    user_id:integer,multiple
} 

set count 0
# For each member in the list of user IDs, add that user to the group.
foreach student_id $user_id {
    db_dml add_student {}
    incr count
}

ad_returnredirect -message "Added $count users to class list." [export_vars -url -base {students-admin} {lab_id}]
