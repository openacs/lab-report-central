<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="admin_options">[<a href="admin/">#lab-report-central.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report-central/lab-report-central.css" media="all">
</property>


<div id="lrc-list-container">
  <table>
    <tr>
      <td class="label">#lab-report-central.name#</td>
      <td class="value">@name;noquote@</td>
    </tr>
    <tr>
      <td class="label">#lab-report-central.description#</td>
      <td class="value"><if @description@ ne "">@description;noquote@</if><else>&nbsp;</else></td>
    </tr>
  </table>
</div>

<if @section:rowcount@ eq 0>
<div class="notice">#lab-report-central.notice_currently_no_sections#</div>
</if>

<div id="lrc-section-container">
  <multiple name="section">
  <ul>
    <li class="name">@section.section_name@</li>
    <li class="description">@section.section_desc;noquote@</li>
    <if @create_p@><li class="edit"><a class="button" href="@section.details_url@">#lab-report-central.edit_details#</a> <a class="button" href="@section.resources_url@">#lab-report-central.edit_resources#</a> <a class="button" href="@section.feedback_url@">#lab-report-central.edit_feedback#</a></li></if>
  </ul>
  </multiple>
</div>

<div id="lrc-navlist">
  <if @create_p@>
    <div class="float">
      <a href="@create_section_url@" title="#lab-report-central.add_section#">+</a>
    </div>
    <if @section:rowcount@ gt 0>
    <div class="float">
      <a href="@delete_section_url@" title="#lab-report-central.delete_section#" onclick="return confirm('@confirm_msg;noquote@');">-</a>
    </div>
    </if>
  </if>
</div>
<div class="spacer"></div>