<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="admin_options">[<a href="admin/">#lab-report-central.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report-central/lab-report-central.css" media="all">
</property>

#lab-report-central.the_following_resources_have_been_allocated#

<if @resource:rowcount@ eq 0>
<div class="notice">#lab-report-central.notice_currently_no_resources#</div>
</if>

<div id="lrc-resource-container">
  <multiple name="resource">
  <ul>
    <li class="name">@resource.resource_name@</li>
    <li class="description">@resource.resource_desc;noquote@</li>
    <li class="edit"><if @create_p@><a class="button" href="@resource.details_url@">#lab-report-central.edit_details#</a></if> <a class="button" href="@resource.resource_url@" target="_blank">#lab-report-central.visit_resource#</a></li>
  </ul>
  </multiple>
</div>

<div id="lrc-navlist">
  <if @create_p@>
    <div class="float">
      <a href="@create_resource_url@" title="#lab-report-central.add_resource#">+</a>
    </div>
    <if @resource:rowcount@ gt 0>
    <div class="float">
      <a href="@delete_resource_url@" title="#lab-report-central.delete_resource#" onclick="return confirm('@confirm_msg;noquote@');">-</a>
    </div>
    </if>
  </if>
</div>
<div class="spacer"></div>
