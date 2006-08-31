<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="lab_details">
     <querytext>
       SELECT name, description, person__name(instructor_id) AS instructor,
	   instructor_id,
           to_char(start_date, 'DD Month, YYYY') AS start_date,
	   to_char(end_date, 'DD Month, YYYY') AS end_date
       FROM lrc_lab
       WHERE lab_id = :lab_id
     </querytext>
   </fullquery>

   <fullquery name="rt">
     <querytext>
       SELECT t.template_id, t.name AS template_name,
           t.description AS template_desc,
           to_char(m.start_date, 'DD Month, YYYY') AS release_date,
           to_char(m.end_date, 'DD Month, YYYY') AS submission_date
       FROM lrc_template t, lrc_lab_template_map m
       WHERE m.lab_id = :lab_id
       AND m.template_id = t.template_id
       AND t.package_id = :package_id
       ORDER BY m.end_date ASC
     </querytext>
   </fullquery>

   <fullquery name="select_marking_group">
     <querytext>
       SELECT u.user_id AS student_id, u.first_names, u.last_name, u.email
       FROM cc_users u, lrc_lab_student_map s, lrc_marker_group_map g,
           group_member_map m
       WHERE u.user_id = m.member_id 
       AND s.lab_id = :lab_id
       AND g.lab_id = s.lab_id
       AND g.marker_id = :user_id
       AND g.group_id = m.group_id
     </querytext>
   </fullquery>

</queryset>
