<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="get_templates">
     <querytext>
       SELECT template_id, name, description from lrc_template
       WHERE package_id = :package_id
	   [template::list::orderby_clause -orderby -name "templates"]
     </querytext>
   </fullquery>

</queryset>
