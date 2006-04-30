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

   <fullquery name="attach_student">
     <querytext>
       INSERT INTO lrc_lab_student_map (lab_id, user_id)
       VALUES (:lab_id, :student_id)
     </querytext>
   </fullquery>

</queryset>
