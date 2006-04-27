<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="lab_details">
     <querytext>
       SELECT name, description, person__name(instructor_id) AS instructor,
           to_char(start_date, 'DD Month, YYYY') AS start_date,
	   to_char(end_date, 'DD Month, YYYY') AS end_date
       FROM lrc_lab
       WHERE lab_id = :lab_id
     </querytext>
   </fullquery>

   <fullquery name="rt">
     <querytext>
       SELECT t.template_id, t.name AS template_name,
           t.description AS template_desc
       FROM lrc_template t, lrc_lab_template_map m
       WHERE m.lab_id = :lab_id
       AND m.template_id = t.template_id
       AND t.package_id = :package_id
     </querytext>
   </fullquery>

</queryset>
