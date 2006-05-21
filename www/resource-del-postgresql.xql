<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="resource_delete">
     <querytext>
       SELECT lrc_resource__del(:resource_id)
     </querytext>
   </fullquery>

</queryset>
