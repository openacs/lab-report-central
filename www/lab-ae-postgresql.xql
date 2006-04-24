<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.4</version></rdbms>

   <fullquery name="object_new">
     <querytext>
       SELECT lrc_lab__new (
           NULL,
	   :name,
	   :description,
	   :instructor_id,
	   $start_date,
	   $end_date,
	   :package_id,
	   now(),
	   :user_id,
	   :peeraddr,
	   :package_id
       )
     </querytext>
   </fullquery>

   <fullquery name="lab_update">
     <querytext>
       UPDATE lrc_lab
           SET name = :name,
	   description = :description,
	   instructor_id = :instructor_id,
	   start_date = :start_date,
	   end_date = :end_date
	   WHERE lab_id = :lab_id
     </querytext>
   </fullquery>

   <fullquery name="object_update">
     <querytext>
       UPDATE acs_objects
           SET modifying_user = :modifying_user,
	   modifying_ip = :modifying_ip,
	   package_id = :package_id
	   WHERE object_id = :lab_id
     </querytext>
   </fullquery>

</queryset>
