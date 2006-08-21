<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="feedback_criteria_delete">
     <querytext>
       SELECT lrc_feedback_criteria__del(:feedback_criteria_id)
     </querytext>
   </fullquery>

</queryset>
