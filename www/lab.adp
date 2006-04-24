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
      <td class="label">#lab-report-central.instructor#</td>
      <td class="value">@instructor;noquote@</td>
    </tr>
    <tr>
      <td class="label">#lab-report-central.lab_duration#</td>
      <td class="value">@start_date;noquote@ #lab-report-central.to# @end_date;noquote@</td>
    </tr>
    <tr>
      <td class="label">#lab-report-central.description#</td>
      <td class="value"><if @description@ ne "">@description;noquote@</if><else>&nbsp;</else></td>
    </tr>
  </table>
</div>

<h3>#lab-report-central.lab_report_templates#</h3>
<div id="lrc-report-container">
  <if @create_p@>
  <ul>
    <li><a class="button" href="@create_url@">#lab-report-central.add_template#</a></li>
  </ul>
  </if>

  <multiple name="rt">
  <ul id="report">
    <li>
      <span class="label">@rt.name@</span>
      <span class="options">
      <a class="button" href="@rt.view_url@">#lab-report-central.view#</a>
      <if @modify_p@><a class="button" href="@rt.edit_url@">#lab-report-central.edit#</a>&nbsp;</if>
      <if @delete_p@><a class="button" href="@rt.delete_url@" onclick="return confirm('#lab-report-central.want_to_delete_lab#')">#lab-report-central.delete#</a></if>
      </span>
      <div class="spacer"></div>
    </li>
  </ul>
  </multiple>

  <if @rt:rowcount@ eq 0>
  <ul><li class="notice">#lab-report-central.no_lab_report_templates_added#</li></ul>
  </if>
</div>