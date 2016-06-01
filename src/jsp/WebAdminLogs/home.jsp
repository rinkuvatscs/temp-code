
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2070))
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
ArrayList linkLogs=new ArrayList();
WebAdminLogManager webMan=new WebAdminLogManager();
  webMan.setConnectionPool(conPool);
webMan.getLinks(linkLogs);
%>
<script type="text/javascript">
function validate()
{
								var startDate = document.forms.form1.startDate.value
								var endDate = document.forms.form1.endDate.value

				var st;
				var ed;	
				var dt;

				st = document.form1.startDate.value;
				ed = document.form1.endDate.value;

				stdate = st.substring(0,2);
				stmonth = st.substring(3,5);
				styear = st.substring(6,10);
				//sthour = st.substring(11,13);

				eddate = ed.substring(0,2);
				edmonth = ed.substring(3,5);
				edyear = ed.substring(6,10);
			//	edhour = ed.substring(11,13);

				dt = new Date();
				nowday = dt.getDate();
				nowmonth = dt.getMonth();
				nowyear = dt.getYear();
				nowmonth = nowmonth+1;
			//	nowTime=dt.getHours();
				nowyear += (nowyear<1900)? 1900:0


				var sday = nowday.toString();
				var smonth = nowmonth.toString();
				var syear = nowyear.toString();
			//	var shour = nowTime.toString();

				if(sday <= 9)
				{
								sday= '0'+sday;
				}
				if(smonth <= 9)
				{
								smonth = '0'+smonth;
				}	
				var Date_today = sday+'-'+smonth+'-'+syear;
				if ((ed == "") && (st == ""))
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstend")%>");
								return false;
								document.form1.startDate.focus();

				}

				if (st == "")
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstdate")%>");
								return false;
								document.form1.startDate.focus();

				}

				if (ed == "")
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alenddate")%>");
								return false;
								document.form1.endDate.focus();

				}

				//if ( parseInt(styear+stmonth+stdate+sthour) >= parseInt(edyear+edmonth+eddate+edhour) )
				if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstless")%>");
								return false;
								document.form1.startDate.focus();

				}

				//if ( parseInt(edyear+edmonth+eddate+edhour) < parseInt(syear+smonth+sday+shour) )
				/*if ( parseInt(edyear+edmonth+eddate) >= parseInt(syear+smonth+sday) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alenlsr")%>"+" "+Date_today);
								end="";
								document.form1.endDate.focus();
								return false;
				}*/
			/*	if ( parseInt(styear+stmonth+stdate+sthour) < parseInt(syear+smonth+sday+shour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstcur")%>"+Date_today);
								end="";
								document.form1.startDate.focus();
								return false;
				}
*/

		//		return true;
}
</script>

<%@ include file = "../pagefile/header.html" %>
 <table width="90%" border="0" align="center">
        <tr class="tableheader"><td></td><td> Web Admin Logs Management <br><br></td></tr>

<form name="form1" method="post" action="viewlogs.jsp" onSubmit="return validate()"> 
<tr ><td > <%=TSSJavaUtil.instance().getKeyValue("logoption")%></td>
<td><select name="keywords">
<%
								if(sessionHistory.isAllowed(2080))
{
				%>

								<option value="X" selected> All logs </option>
								<%
								for(int i=0 ;i<linkLogs.size();i++)
								{
												WebAdminLog webLog=(WebAdminLog) linkLogs.get(i);
												%>
																<option value="<%=webLog.getlink()%>"><%=webLog.getlink()%></option>
																<%
								}
}
%>
</select>
</td></tr>
<tr width="80%">
<td></td><td>Select Date for Logs</td>
</TR>
<tr width="80%">
<td ><%=TSSJavaUtil.instance().getKeyValue("startdate")%></td>
<td class="tfield"><input type="text" name="startDate" id="f_date_c1" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
Calendar.setup({
inputField     :  "f_date_c1",  // id of the input field
ifFormat       :  "%d-%m-%Y", // format of the input field
button         :  "f_trigger_c1",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : false
});
</script>
<tr>
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("enddate")%></td>
<td class="tfield"><input type="text" name="endDate" id="f_date_c2" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
</tr>
<script type ="text/javascript">
Calendar.setup({
inputField     :  "f_date_c2",  // id of the input field
ifFormat       :  "%d-%m-%Y", // format of the input field
button         :  "f_trigger_c2",// trigger for the calendar (button ID)
align          :  "Tl",           // alignment (defaults to "Bl")
singleClick    :  true,
showsTime      : false
});
</script>

<tr class="button1">
<td ><br><br></td><td>
<input type="hidden" name="searchId" value="1"> 
<input type="hidden" name="pid" value="0"> 
<input type="hidden" name="order" value="ASC">
<input type="hidden" name="type" value="1"> 
<input type="hidden" name="pageno" value="0"> 
<input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%>">
<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%>"> 
</td>
</tr> 
<!--</table>-->
</form>
<!--</td></tr>-->
	
    <tr class="homemenu"><td></td><td><a href="../home.jsp">Web Admin Home</a></td></tr>    
</table>
</td></tr>
</table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
