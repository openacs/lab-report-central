<?xml version="1.0"?>
<!DOCTYPE queryset PUBLIC "-//OpenACS//DTD XQL 1.0//EN" "http://www.thecodemill.biz/repository/xql.dtd">

<queryset>

  <fullquery name="members">
    <querytext>
      select first_names, last_name, email
      from cc_users
      where user_id in ([join $user_id_list ,])
    </querytext>
  </fullquery>
  
</queryset>
