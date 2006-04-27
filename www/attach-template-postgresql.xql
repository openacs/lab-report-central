<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="lab_name">
     <querytext>
       SELECT name
       FROM lrc_lab
       WHERE lab_id = :lab_id
     </querytext>
   </fullquery>

   <fullquery name="attach_template">
     <querytext>
       INSERT INTO lrc_lab_template_map (lab_id, template_id)
       VALUES (:lab_id, :template_id)
     </querytext>
   </fullquery>

</queryset>
