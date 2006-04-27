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

