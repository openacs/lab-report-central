<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="add_student">
     <querytext>
       INSERT INTO lrc_lab_student_map (lab_id, user_id)
       VALUES (:lab_id, :student_id)
     </querytext>
   </fullquery>

</queryset>
