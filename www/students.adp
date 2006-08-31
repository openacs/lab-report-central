<master src="resources/main-portal">
<property name="title">@page_title;noquote@</property>
<property name="context">@context;noquote@</property>
<property name="admin_options">[<a href="admin/">#lab-report-central.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report-central/lab-report-central.css" media="all">
</property>


<if @lab_instructor_p@>
<h3>#lab-report-central.students#</h3>
<div id="lrc-report-container">
  <if @show_buttons_p@>
  <ul>
    <li><a class="button" href="@add_student_url@">#lab-report-central.add_student#</a></li>
  </ul>
  </if>

  <multiple name="student">
  <ul class="report">
    <li>
      <span class="label">@student.first_names@ @student.last_name@ (@student.email@)</span>
      <span class="options">
      <a class="button" href="@student.dotfolio_url@">#lab-report-central.view_reports#</a>
      <if @show_buttons_p@><a class="button" href="@student.rem_student_url@" onclick="return confirm('#lab-report-central.want_to_remove_student#')">#lab-report-central.remove#</a></if>
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
