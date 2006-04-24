<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.4</version></rdbms>

    <fullquery name="lab_report_central::install::create_instructor_group.insert">
      <querytext>
      INSERT INTO lrc_groups (magic_name, group_id) VALUES (:magic_name, :group_id)  
      </querytext>
    </fullquery>

</queryset>
