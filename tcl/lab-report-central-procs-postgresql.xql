<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="non_instructors_search">
     <querytext>
       select distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
      from   cc_users u
      where  lower(coalesce(u.first_names || ' ', '')  ||
             coalesce(u.last_name || ' ', '') ||
             u.email || ' ' ||
             coalesce(u.screen_name, '')) like lower('%'||:value||'%')
       AND u.user_id NOT IN (
           SELECT user_id
           FROM cc_users u, lrc_groups g, group_member_map m
           WHERE u.user_id = m.member_id
           AND m.group_id = g.group_id
           AND g.magic_name = 'instructors'
       )
       ORDER by name
     </querytext>
   </fullquery>

   <fullquery name="instructors_search">
     <querytext>
       select distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
      from   cc_users u
      where  lower(coalesce(u.first_names || ' ', '')  ||
             coalesce(u.last_name || ' ', '') ||
             u.email || ' ' ||
             coalesce(u.screen_name, '')) like lower('%'||:value||'%')
       AND u.user_id IN (
           SELECT user_id
           FROM cc_users u, lrc_groups g, group_member_map m
           WHERE u.user_id = m.member_id
           AND m.group_id = g.group_id
           AND g.magic_name = 'instructors'
       )
       ORDER by name
     </querytext>
   </fullquery>

   <fullquery name="lab_report_central::non_instructors_get_options.non_instructors">
     <querytext>
       SELECT distinct u.last_name || ', ' || u.first_names || ' (' || u.email || ')' AS name,
           u.user_id
       FROM cc_users u
       WHERE u.user_id NOT IN (
           SELECT user_id
           FROM cc_users u, lrc_groups g, group_member_map m
           WHERE u.user_id = m.member_id
           AND m.group_id = g.group_id
           AND g.magic_name = 'instructors'
       )
     </querytext>
   </fullquery>

   <fullquery name="lab_report_central::instructors_get_options.instructors">
     <querytext>
       SELECT distinct u.last_name || ', ' || u.first_names || ' (' || u.email || ')' AS name,
           u.user_id
       FROM cc_users u
       WHERE u.user_id IN (
           SELECT user_id
           FROM cc_users u, lrc_groups g, group_member_map m
           WHERE u.user_id = m.member_id
           AND m.group_id = g.group_id
           AND g.magic_name = 'instructors'
       )
     </querytext>
   </fullquery>

   <fullquery name="lab_report_central::instructor_group_id.instructor_group">
     <querytext>
       SELECT group_id FROM lrc_groups WHERE magic_name = 'instructors'
       LIMIT 1
     </querytext>
   </fullquery>

   <fullquery name="lab_report_central::unmapped_templates_get_options.templates">
     <querytext>
       SELECT t.name, t.template_id
       FROM lrc_template t
       WHERE t.template_id NOT IN (select template_id from lrc_lab_template_map where lab_id = :lab_id)
     </querytext>
   </fullquery>

   <fullquery name="lab_student_search">
     <querytext>
       select distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
      from   cc_users u
      where  lower(coalesce(u.first_names || ' ', '')  ||
             coalesce(u.last_name || ' ', '') ||
             u.email || ' ' ||
             coalesce(u.screen_name, '')) like lower('%'||:value||'%')
       AND u.user_id NOT IN (
           SELECT user_id
           FROM lrc_lab_student_map m
           WHERE m.lab_id = $lab_id
       )
       ORDER by name
     </querytext>
   </fullquery>

   <fullquery name="lab_report_central::unmapped_students_get_options.students">
     <querytext>
       select distinct u.first_names || ' ' || u.last_name || ' (' || u.email || ')' as name, u.user_id
      from   cc_users u
      WHERE u.user_id NOT IN (
           SELECT user_id
           FROM lrc_lab_student_map m
           WHERE m.lab_id = :lab_id
       )
       ORDER by name
     </querytext>
   </fullquery>

</queryset>
