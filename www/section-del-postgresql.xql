<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="section_delete">
     <querytext>
       SELECT lrc_section__del(:section_id)
     </querytext>
   </fullquery>

</queryset>
