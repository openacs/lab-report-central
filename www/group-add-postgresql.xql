<?xml version="1.0"?>

<queryset>
  <rdbms><type>postgresql</type><version>7.4</version></rdbms>

  <fullquery name="insert_group_marker_ids">
    <querytext>
      INSERT INTO lrc_marker_group_map (group_id, marker_id, lab_id)
	VALUES (:group_id, :marker_id, :lab_id)
    </querytext>
  </fullquery>

</queryset>
