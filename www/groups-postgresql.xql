<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="select_groups">
    <querytext>
      SELECT groups.group_name,
	cc_users.last_name || ', ' ||
	  cc_users.first_names AS marker, groups.group_id
        FROM groups, lrc_marker_group_map, cc_users
	WHERE groups.group_id = lrc_marker_group_map.group_id
	AND lrc_marker_group_map.marker_id = cc_users.user_id
        ORDER BY groups.group_id ASC
    </querytext>
  </fullquery>

</queryset>
