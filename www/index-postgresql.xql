<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="labs">
     <querytext>
       SELECT lab_id, name, start_date, end_date,
           to_char(start_date, 'YYYY') AS year
       FROM lrc_lab
       WHERE package_id = :package_id
       ORDER BY year DESC, name ASC
     </querytext>
   </fullquery>

</queryset>
