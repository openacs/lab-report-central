<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="detach_template">
     <querytext>
       DELETE FROM lrc_lab_template_map
       WHERE template_id = :template_id
       AND lab_id = :lab_id
     </querytext>
   </fullquery>

</queryset>
