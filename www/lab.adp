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
  <if @admin_p@>
  <ul>
    <li><a class="button" href="@create_url@">#lab-report-central.attach_template#</a></li>
  </ul>
  </if>

  <multiple name="rt">
  <ul class="report">
    <li>
      <span class="label">@rt.template_name@</span>
      <span class="dates">[Release: @rt.release_date@] [Submission: @rt.submission_date@]</span>
      <span class="options">
      <a class="button" href="@rt.view_url@">#lab-report-central.view#</a>
      <if @admin_p@><a class="button" href="@rt.delete_url@" onclick="return confirm('#lab-report-central.want_to_remove_template#')">#lab-report-central.remove#</a></if>
      </span>
      <div class="spacer"></div>
    </li>
  </ul>
  </multiple>

  <if @rt:rowcount@ eq 0>
  <ul><li class="notice">#lab-report-central.no_lab_report_templates_added#</li></ul>
  </if>
</div>

<if @admin_p@>
<h3>#lab-report-central.students#</h3>
<div id="lrc-report-container">
  <ul>
    <li><a class="button" href="@add_student_url@">#lab-report-central.add_student#</a></li>
  </ul>

  <multiple name="student">
  <ul class="report">
    <li>
      <span class="label">@student.first_names@ @student.last_name@ (@student.email@)</span>
      <span class="options">
      <a class="button" href="@student.rem_student_url@" onclick="return confirm('#lab-report-central.want_to_remove_student#')">#lab-report-central.remove#</a>
      </span>
      <div class="spacer"></div>
    </li>
  </ul>
  </multiple>

  <if @student:rowcount@ eq 0>
  <ul><li class="notice">#lab-report-central.no_students_added#</li></ul>
  </if>
</div>
</if>
