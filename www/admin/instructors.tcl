ad_page_contract {
    Page for viewing instructors.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
} {
    {orderby "name,asc"}
}

set page_title "[_ lab-report-central.instructors]"
set context [list $page_title]
set package_id [ad_conn package_id]

set elements {
    name {
	label "#lab-report-central.name#"
    }
    delete {
	sub_class narrow
	display_template {
	    <img src="/shared/images/Delete16.gif" height="16" width="16" border="0">
	}
	link_url_eval {[export_vars -base instructor-del { instructor_id }]}
	link_html {title "#lab-report-central.remove_instructor#" onclick "return confirm(\'[_ lab-report-central.want_to_delete_instructor]\');"}
    }
}

template::list::create \
    -name instructors \
    -actions [list "#lab-report-central.add_instructor#" [export_vars -base instructor-add {}] "#lab-report-central.add_instructor_to_list#"] \
    -multirow instructors \
    -no_data "#lab-report-central.no_instructors_created#" \
    -elements $elements \
    -orderby {
        name {orderby {lower(last_name)}}
    }

db_multirow instructors get_instructors {}

ad_return_template
