<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="admin_options">[<a href="admin/">#lab-report-central.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report-central/lab-report-central.css" media="all">
</property>

#lab-report-central.feedback_criteria_for_this_section#

<if @feedback:rowcount@ eq 0>
<div class="notice">#lab-report-central.notice_currently_no_feedback_criteria#</div>
</if>

<div id="lrc-resource-container">
  <multiple name="feedback">
  <ul>
    <li class="name">@feedback.criteria_name@</li>
    <li class="description">@feedback.criteria_desc;noquote@</li>
    <li class="edit"><if @create_p@><a class="button" href="@feedback.details_url@">#lab-report-central.edit_details#</a></if></li>
  </ul>
  </multiple>
</div>

<div id="lrc-navlist">
  <if @create_p@>
    <div class="float">
      <a href="@create_feedback_url@" title="#lab-report-central.add_feedback_component#">+</a>
    </div>
    <if @feedback:rowcount@ gt 0>
    <div class="float">
      <a href="@delete_feedback_url@" title="#lab-report-central.delete_feedback_component#" onclick="return confirm('@confirm_msg;noquote@');">-</a>
    </div>
    </if>
  </if>
</div>
<div class="spacer"></div>
