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

   <fullquery name="select_feedback">
     <querytext>
       SELECT feedback_criteria_id, name AS criteria_name, 
           description AS criteria_desc
       FROM lrc_feedback_criteria
       WHERE section_id = :section_id
       AND package_id = :package_id
       ORDER BY feedback_criteria_id ASC
     </querytext>
   </fullquery>   

</queryset>
