ad_page_contract {
    Delete the specified report template.

    @param template_id The ID of the report template to delete.
    @param return_url Optional url to redirect to when the delete operation
    is complete.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2005-12-04
    @cvs-id $Id$
} {
    template_id:integer
    {return_url "templates"}
}

set user_id [ad_conn user_id]
set package_id [ad_conn package_id]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege lab_report_central_admin

db_transaction {
    db_exec_plsql template_delete {}
}

ad_returnredirect $return_url
ad_script_abort
