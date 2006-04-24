ad_library {

    Lab Report Central library

    @creation-date 2006-04-17
    @author Nick Carroll <ncarroll@ee.usyd.edu.au>
    @cvs-id $Id$
}


namespace eval lab_report_central {}

ad_proc lab_report_central::non_instructors_get_options {} {
    Retrieves an options list of users that aren't instructors..
} {
    set users_list [db_list_of_lists non_instructors {}]
    set users_list [concat [list [list Search ":search:"]] $users_list]

    return $users_list
}

ad_proc lab_report_central::instructors_get_options {} {
    Retrieves an options list of users that are instructors..
} {
    set users_list [db_list_of_lists instructors {}]
    set users_list [concat [list [list Search ":search:"]] $users_list]

    return $users_list
}

ad_proc lab_report_central::instructor_group_id {} {
    Retrieves the instructor group_id.
} {
    return [db_string instructor_group {} -default ""]
}
