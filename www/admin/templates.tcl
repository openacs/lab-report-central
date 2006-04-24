ad_page_contract {
    Page for viewing templates.

    @author Nick Carroll (nick.c@rroll.net)
    @creation-date 2006-04-17
    @cvs-id $Id$
} {
    {orderby "name,asc"}
}

set page_title "[_ lab-report-central.templates]"
set context [list $page_title]
set package_id [ad_conn package_id]

set elements {
    edit {
	sub_class narrow
	display_template {
	    <img src="/shared/images/Edit16.gif" height="16" width="16" border="0">
	}
	link_url_eval {[export_vars -url -base template-ae { template_id }]}
    }
    name {
	label "#lab-report-central.name#"
	link_url_eval {[export_vars -url -base template { template_id }]}
    }
    description {
	label "#lab-report-central.description#"
    }
    delete {
	sub_class narrow
	display_template {
	    <img src="/shared/images/Delete16.gif" height="16" width="16" border="0">
	}
	link_url_eval {[export_vars -url -base template-del { template_id }]}
	link_html {title "#lab-report-central.remove_template#" onclick "return confirm(\'[_ lab-report-central.want_to_delete_template]\');"}
    }
}

template::list::create \
    -name templates \
    -actions [list "#lab-report-central.add_template#" [export_vars -base template-ae {}] "#lab-report-central.add_template_to_list#"] \
    -multirow templates \
    -no_data "#lab-report-central.no_templates_created#" \
    -elements $elements \
    -orderby {
        name {orderby {lower(name)}}
    }

db_multirow templates get_templates {} {
    set description [template::util::richtext::get_property content \
			 $description]
}

ad_return_template
