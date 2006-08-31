ad_page_contract {

    Deletes the group matching the specified group_id.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    group_id:integer,notnull
    lab_id:integer,notnull
}

set context [list [list [export_vars -url -base lab {lab_id}] [lab_report_central::lab_name -lab_id $lab_id]] [list [export_vars -url -base groups {lab_id}] [_ lab-report-central.groups]] [_ lab-report-central.delete_group]]

ad_form \
    -name del_group \
    -cancel_url "[export_vars -url -base groups {lab_id}]" \
    -export { group_id lab_id } \
    -form {
        {prompt:text(inform) {label "[_ lab-report-central.confirm]"} {value "[_ lab-report-central.continue_with_delete_group]"}}
    } \
    -on_submit {
        db_transaction {
            # Delete entry from lrc_marker_group_map.
            db_dml delete_group {}
            
            # Delete group.
            group::delete $group_id
        }
    } \
    -after_submit {
        ad_returnredirect [export_vars -url -base groups {lab_id}]
    }
