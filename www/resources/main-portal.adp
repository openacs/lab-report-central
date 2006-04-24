<master>
<property name="title">@title@</property>
<property name="context">@context;noquote@</property>
<property name="header_stuff">
@header_stuff;noquote@
<link rel="stylesheet" type="text/css" href="@css@" media="all"/>
</property>

<P>
<div class="visualClear"></div>

<table id="portal-columns">
  <tbody>
    <tr>
      <td id="portal-column-content">
        <div class="visualPadding">
          <div class="documentBorder">
            <if @admin_p@ eq "1">
            <div class="portletOptions">
              @admin_options;noquote@
            </div>
	    </if>
            <div class="portletOptions">
              @user_options;noquote@
            </div>
            <div class="documentContent">
              <slave>
            </div>
          </div>
        </div>
      </td>
    </tr>
  </tbody>
</table>
