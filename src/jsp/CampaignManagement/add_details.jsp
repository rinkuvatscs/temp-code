<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.SubscriberProfile"%>
<%@ page import = "com.telemune.webadmin.webif.SessionHistory"%>
<%@ page import = "com.telemune.webadmin.webif.TSSJavaUtil"%>
<%@ page import = "com.telemune.webadmin.webif.Rbt" %>
<%@ page import = "java.util.ArrayList"%>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if(sessionHistory == null || !sessionHistory.isAllowed(2000))
{
	session.invalidate();
%>
	<%@ include file="../logouterror.jsp" %>
<%
}
else
{
%>
 <%@ include file="../lang.jsp" %>
<HTML>
<HEAD>
<script type="text/javascript">
function validate()
{
				var musicfile = document.forms.form1.musicfile.value
								var startDate = document.forms.form1.startDate.value
								var endDate = document.forms.form1.endDate.value

								if(musicfile == "")
								{
												alert("<%=TSSJavaUtil.instance().getKeyValue("almusicfile",defLangId)%>");
												document.forms.form1.musicfile.focus();
												return false;
								}
				var st;
				var ed;	
				var dt;

				st = document.form1.startDate.value;
				ed = document.form1.endDate.value;

				stdate = st.substring(0,2);
				stmonth = st.substring(3,5);
				styear = st.substring(6,10);
				sthour = st.substring(11,13);

				eddate = ed.substring(0,2);
				edmonth = ed.substring(3,5);
				edyear = ed.substring(6,10);
				edhour = ed.substring(11,13);

				dt = new Date();
				nowday = dt.getDate();
				nowmonth = dt.getMonth();
				nowyear = dt.getYear();
				nowmonth = nowmonth+1;
				nowTime=dt.getHours();
				nowyear += (nowyear<1900)? 1900:0


				var sday = nowday.toString();
				var smonth = nowmonth.toString();
				var syear = nowyear.toString();
				var shour = nowTime.toString();

				if(sday <= 9)
				{
								sday= '0'+sday;
				}
				if(smonth <= 9)
				{
								smonth = '0'+smonth;
				}	
				var Date_today = sday+'-'+smonth+'-'+syear+' '+shour;
				if ((ed == "") && (st == ""))
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstend",defLangId)%>");
								return false;
								document.form1.startDate.focus();

				}

				if (st == "")
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstdate",defLangId)%>");
								return false;
								document.form1.startDate.focus();

				}

				if (ed == "")
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alenddate",defLangId)%>");
								return false;
								document.form1.endDate.focus();

				}

				if ( parseInt(styear+stmonth+stdate+sthour) >= parseInt(edyear+edmonth+eddate+edhour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstless",defLangId)%>");
								return false;
								document.form1.startDate.focus();

				}

				if ( parseInt(edyear+edmonth+eddate+edhour) < parseInt(syear+smonth+sday+shour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alendgr",defLangId)%>"+Date_today);
								end="";
								document.form1.endDate.focus();
								return false;
				}
				if ( parseInt(styear+stmonth+stdate+sthour) < parseInt(syear+smonth+sday+shour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstcur",defLangId)%>"+Date_today);
								end="";
								document.form1.startDate.focus();
								return false;
				}


		//		return true;
}


</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>

<form name="form1" method="post" action="add_audiofile.jsp" enctype="multipart/form-data" onSubmit="return validate()"> 
<table width="80%" border="0" align="center" cellpadding="1" cellspacing="2"> 
<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("camIVRTop",defLangId)%><br><br></td</tr>

<tr class="tfield">
<TD><%=TSSJavaUtil.instance().getKeyValue("camMusic",defLangId)%></TD>
<TD><INPUT TYPE="file" NAME="musicfile" ></TD>
</TR>
<tr >
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("sTime",defLangId)%></td>
<td class="tfield"><input type="text" name="startDate" id="f_date_c1" readonly="1"  />
<img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
Calendar.setup({
inputField     :  "f_date_c1",  // id of the input field
ifFormat       :  "%d-%m-%Y %H", // format of the input field
button         :  "f_trigger_c1",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : true
});
</script>
<tr >
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("eTime",defLangId)%></td>
<td class="tfield"><input type="text" name="endDate" id="f_date_c2" readonly="1"  />
<img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
Calendar.setup({
inputField     :  "f_date_c2",  // id of the input field
ifFormat       :  "%d-%m-%Y %H", // format of the input field
button         :  "f_trigger_c2",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : true
});
</script>

<tr class="button1">
<td colspan="2"><br>
<input type="hidden" name="todo" value="upload">
<input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">
<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"> 
</td>
</tr> 
</table>
</form>

<%@ include file  = "../pagefile/footer.html"%>
<%
}
%>
