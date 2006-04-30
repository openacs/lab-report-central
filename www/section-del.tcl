ad_page_contract {
    Delete the specified section.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-30
    @cvs-id $Id$
} {
    section_id:integer
    template_id:integer
}

set user_id [ad_conn user_id]
set package_id [ad_conn package_id]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege lab_report_central_admin

db_transaction {
    db_exec_plsql section_delete {}
}

ad_returnredirect [export_vars -url -base template {template_id}]
ad_script_abort
