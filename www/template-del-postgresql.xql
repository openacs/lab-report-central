<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="template_delete">
     <querytext>
       SELECT lrc_template__del(:template_id)
     </querytext>
   </fullquery>

</queryset>
