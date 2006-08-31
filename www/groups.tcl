ad_page_contract {

    Displays a list of groups.  Each group must have at least one 
    marker assigned to it.

    @author Nick Carroll (ncarroll@ee.usyd.edu.au)
    @creation-date 2005-01-02
    @version $Id$

} {
    lab_id
}

set context [list [list [export_vars -url -base lab {lab_id}] [lab_report_central::lab_name -lab_id $lab_id]] [_ lab-report-central.groups]]

db_multirow -extend {extra_form_part} groups select_groups {} {
    set extra_form_part "<a href=\"[export_vars -url -base group-del {group_id lab_id}]\">#lab-report-central.delete#</a>"
}

template::list::create \
    -name groups \
    -multirow groups \
    -no_data [_ lab-report-central.no_groups_created] \
    -elements {
	group_name {
	    label "#lab-report-central.group_name#"
	    display_template {
		<if @groups.rownum@ ne @groups:rowcount@>
		<a href=\"group-members?group_id=@groups.group_id@&lab_id=$lab_id\">@groups.group_name;noquote@</a>
		</if>
		<else>@groups.group_name;noquote@</else>
	    }
	}
	marker {
	    label "#lab-report-central.marker_pretty_name#"
	    display_template {
		@groups.marker;noquote@
	    }
	}
	extra_form_part {
	    display_template {
		@groups.extra_form_part;noquote@
	    }
	}
    }

set new_group_form_part_name "<p align=\"top\"><form name=\"new_group\" action=\"group-add\"><input name=\"group_name\" type=\"text\" size=\"20\">"

append new_group_form_part_name "<input name=\"lab_id\" type=\"hidden\" value=\"$lab_id\"></input>"

set new_group_form_part_marker [lab_report_central::html_list_of_markers]
set new_group_form_part_button "<input type=\"submit\" value=\"#lab-report-central.create_group#\"></form></p>"

template::multirow append groups $new_group_form_part_name \
    $new_group_form_part_marker "" $new_group_form_part_button

ad_return_template
