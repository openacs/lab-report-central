ad_page_contract {
    Detaches the given template from the given lab.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-27
    @cvs-id $Id$
} {
    lab_id:integer
    template_id:integer
    return_url:optional
}

set user_id [ad_conn user_id]
set package_id [ad_conn package_id]

permission::require_permission -party_id $user_id -object_id $package_id \
    -privilege lab_report_central_admin

if { ![info exists return_url] } {
    set return_url [export_vars -url -base lab {lab_id}]
}

db_transaction {
    db_dml detach_template {}
}

ad_returnredirect $return_url
ad_script_abort
