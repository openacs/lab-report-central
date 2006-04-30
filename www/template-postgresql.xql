<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="template_details">
     <querytext>
       SELECT name, description
       FROM lrc_template
       WHERE template_id = :template_id
       AND package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="select_sections">
     <querytext>
       SELECT section_id, name AS section_name, description AS section_desc
       FROM lrc_section
       WHERE template_id = :template_id
       AND package_id = :package_id
       ORDER BY section_id ASC
     </querytext>
   </fullquery>   

</queryset>
