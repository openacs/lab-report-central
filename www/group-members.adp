<%
#
#  Copyright (C) 2005 WEG
#
#  This file is part of dotFOLIO.
#
#  dotFOLIO is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by the
#  Free Software Foundation; either version 2 of the License, or (at your 
#  option) any later version.
#
#  dotFOLIO is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#
%>

<master src="resources/main-portal">
<property name="title">#lab-report-central.group_members_admin#</property>
<property name="context">@context;noquote@</property>

#lab-report-central.members_of_group#
<center>
  <listtemplate name="group_members"></listtemplate>
</center>
<BR>
<P>
#lab-report-central.non_members_that_can_be_added#

<center>
  <listtemplate name="non_group_members"></listtemplate>
</center>
