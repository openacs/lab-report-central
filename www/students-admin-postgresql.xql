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

  <fullquery name="students">
    <querytext>
      SELECT c.last_name || ', ' || c.first_names AS name, c.user_id
          FROM cc_users c
          WHERE c.user_id IN (SELECT s.user_id FROM lrc_lab_student_map s
              WHERE s.lab_id = :lab_id)
	  ORDER BY name ASC
    </querytext>
  </fullquery>

  <fullquery name="non_students">
    <querytext>
      SELECT c.last_name || ', ' || c.first_names AS name, c.user_id
	  FROM cc_users c
          WHERE c.user_id NOT IN (SELECT s.user_id
              FROM lrc_lab_student_map s
              WHERE s.lab_id = :lab_id)
	  ORDER BY name ASC
    </querytext>
  </fullquery>

</queryset>
