<master src="resources/main-portal">
<property name="admin_options">[<a href="admin/">#lab-report-central.admin#</a>]</property>
<property name="header_stuff">
<link rel="stylesheet" type="text/css" href="/resources/lab-report-central/lab-report-central.css" media="all">
</property>

<div id="lrc-lab-container">
  <if @create_p@>
  <ul>
    <li><a class="button" href="lab-ae">#lab-report-central.create_lab#</a></li>
  </ul>
  </if>

  <multiple name="labs">
  <ul id="years">
    <li>@labs.year@</li>
    <ul id="lab">
      <group column="year">
      <li>
        <span class="label">@labs.name@</span>
	<span class="options">
	<a class="button" href="@labs.view_url@">#lab-report-central.view#</a>
	<if @modify_p@><a class="button" href="@labs.edit_url@">#lab-report-central.edit#</a>&nbsp;</if>
        <if @delete_p@><a class="button" href="@labs.delete_url@" onclick="return confirm('#lab-report-central.want_to_delete_lab#')">#lab-report-central.delete#</a></if>
        </span>
        <div class="spacer"></div>
      </li>
      </group>
    </ul>
  </ul>
  </multiple>
</div>

<if @labs:rowcount@ eq 0>
#lab-report-central.no_labs_created#
</if>
