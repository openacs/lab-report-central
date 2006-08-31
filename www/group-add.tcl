ad_page_contract {

    Maps the specified marker to a newly created group with the given
    group name.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_name:notnull,trim
    marker_id:integer,notnull
    lab_id:integer,notnull
}

db_transaction {
    # Create group with given group_name.
    set group_id [group::new -group_name $group_name group]

    # Add marker to group.
    #group::add_member -group_id $group_id -user_id $marker_id

    # Use group_id from above and insert with marker_id into
    # lrc_marker_group_map.
    db_dml insert_group_marker_ids {}
}

ad_returnredirect [export_vars -url -base groups {lab_id}]
