<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="get_instructors">
     <querytext>
       SELECT u.last_name || ', ' || u.first_names AS name,
           u.user_id AS instructor_id
           FROM cc_users u, lrc_groups g, group_member_map m
	   WHERE u.user_id = m.member_id
	   AND m.group_id = g.group_id
	   AND g.magic_name = 'instructors'
	   [template::list::orderby_clause -orderby -name "instructors"]
     </querytext>
   </fullquery>

</queryset>
