<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="template_name">
     <querytext>
       SELECT name FROM lrc_template WHERE template_id = :template_id
     </querytext>
   </fullquery>

   <fullquery name="resource_update">
     <querytext>
       UPDATE lrc_resource
           SET name = :name,
	   url = :url,
	   description = :description
	   WHERE resource_id = :resource_id
     </querytext>
   </fullquery>

   <fullquery name="object_update">
     <querytext>
       UPDATE acs_objects
           SET modifying_user = :modifying_user,
	   modifying_ip = :modifying_ip,
	   package_id = :package_id
	   WHERE object_id = :resource_id
     </querytext>
   </fullquery>

</queryset>
