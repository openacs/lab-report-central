<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="rem_student">
     <querytext>
       DELETE FROM lrc_lab_student_map
       WHERE user_id = :student_id
       AND lab_id = :lab_id
     </querytext>
   </fullquery>

</queryset>
