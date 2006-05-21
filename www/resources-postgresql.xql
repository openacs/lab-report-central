<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="section_details">
     <querytext>
       SELECT s.name AS section_name, s.description AS section_desc,
           t.name AS template_name
       FROM lrc_section s, lrc_template t
       WHERE s.section_id = :section_id
       AND s.template_id = t.template_id
       AND s.package_id = :package_id
     </querytext>
   </fullquery>

   <fullquery name="select_resources">
     <querytext>
       SELECT resource_id, name AS resource_name, 
           url AS resource_url, description AS resource_desc
       FROM lrc_resource
       WHERE section_id = :section_id
       AND package_id = :package_id
       ORDER BY resource_id ASC
     </querytext>
   </fullquery>   

</queryset>
