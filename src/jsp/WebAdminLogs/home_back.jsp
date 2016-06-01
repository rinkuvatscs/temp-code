
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2065))
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
%>

<HTML>
<HEAD>
<script type="text/javascript">
function validate()
{
//				var musicfile = document.forms.form1.musicfile.value
								var startDate = document.forms.form1.startDate.value
								var endDate = document.forms.form1.endDate.value

	/*							if(musicfile == "")
								{
												alert("<%=TSSJavaUtil.instance().getKeyValue("almusicfile")%>");
												document.forms.form1.musicfile.focus();
												return false;
								}*/
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

				if ( parseInt(styear+stmonth+stdate+sthour) >= parseInt(edyear+edmonth+eddate+edhour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstless")%>");
								return false;
								document.form1.startDate.focus();

				}

				if ( parseInt(edyear+edmonth+eddate+edhour) < parseInt(syear+smonth+sday+shour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alendgr")%>"+Date_today);
								end="";
								document.form1.endDate.focus();
								return false;
				}
				if ( parseInt(styear+stmonth+stdate+sthour) < parseInt(syear+smonth+sday+shour) )
				{
								alert("<%=TSSJavaUtil.instance().getKeyValue("alstcur")%>"+Date_today);
								end="";
								document.form1.startDate.focus();
								return false;
				}


		//		return true;
}
</script>
</HEAD>

<%@ include file = "../pagefile/headerlogs.html" %>

   <table width="80%" border="0" align="center">
        <tr class="tableheader"><td> Web Admin Logs Management <br><br></td></tr>

<tr><td>
<form name="form1" method="post" action="all_logsfile.jsp" enctype="multipart/form-data" onSubmit="return validate()"> 
<table width="80%" border="0" align="center" cellpadding="1" cellspacing="2"> 
<tr ><td colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("logoption")%></td>
<td><select name="logs">
<%
if(sessionHistory.isAllowed(2066) && sessionHistory.isAllowed(2067) && sessionHistory.isAllowed(2068) &&  sessionHistory.isAllowed(2069) && sessionHistory.isAllowed(2070) && sessionHistory.isAllowed(2071) && sessionHistory.isAllowed(2072) &&  sessionHistory.isAllowed(2073) &&  sessionHistory.isAllowed(2074) &&  sessionHistory.isAllowed(2075) && sessionHistory.isAllowed(2076) && sessionHistory.isAllowed(2077) && sessionHistory.isAllowed(2078) && sessionHistory.isAllowed(2079) && sessionHistory.isAllowed(2080) && sessionHistory.isAllowed(2081) && sessionHistory.isAllowed(2082) && sessionHistory.isAllowed(2083) && sessionHistory.isAllowed(2084) && sessionHistory.isAllowed(2085))
    {
    %>

								<option value="1" selected> All logs </option>
								<%}
                if(sessionHistory.isAllowed(2066))
                {
                %>
								<option value="2"><%=TSSJavaUtil.instance().getKeyValue("sysmonitorlog")%></option>
									<%}
											
																if(  sessionHistory.isAllowed(2067) )
																{
																%>
								<option value="3"><%=TSSJavaUtil.instance().getKeyValue("sysconfiglog")%> </option>
										<%}

                if(  sessionHistory.isAllowed(2068) )
                {
                %>

								<option value="4"><%=TSSJavaUtil.instance().getKeyValue("smscconfiglog")%> </option>
											<%}
                if(  sessionHistory.isAllowed(2069) )
                {
                %>

								<option value="5"><%=TSSJavaUtil.instance().getKeyValue("hlrconfiglog")%> </option>
								<%}
                if(  sessionHistory.isAllowed(2070) )
                {
                %>

								<option value="6"><%=TSSJavaUtil.instance().getKeyValue("imsiconfiglog")%> </option>
<%}
if(  sessionHistory.isAllowed(2071) )
                {

%>
								<option value="7"><%=TSSJavaUtil.instance().getKeyValue("homesublog")%> </option>
<%}
if(  sessionHistory.isAllowed(2072) )
                {

%>

								<option value="8"><%=TSSJavaUtil.instance().getKeyValue("usermgmtlog")%> </option>
<%}
if(  sessionHistory.isAllowed(2073) )
                {

%>

								<option value="9"><%=TSSJavaUtil.instance().getKeyValue("corpacclog")%> </option>
<%}
if(  sessionHistory.isAllowed(2074) )
                {

%>

								<option value="10"><%=TSSJavaUtil.instance().getKeyValue("occmgmtlog")%> </option>
<%}
if(  sessionHistory.isAllowed(2075) )
                {

%>

								<option value="11"><%=TSSJavaUtil.instance().getKeyValue("keywordlog")%> </option>
<%}
if(  sessionHistory.isAllowed(2076) )
                {

%>

								<option value="12"><%=TSSJavaUtil.instance().getKeyValue("smstemplatelog")%> </option>
<%}
if(  sessionHistory.isAllowed(2077) )
                {

%>

								<option value="13"><%=TSSJavaUtil.instance().getKeyValue("roletypelog")%> </option>
<%}
if(  sessionHistory.isAllowed(2078) )
                {

%>

								<option value="14"><%=TSSJavaUtil.instance().getKeyValue("activatelog")%> </option>
<%}
if(  sessionHistory.isAllowed(2079) )
                {

%>

								<option value="15"><%=TSSJavaUtil.instance().getKeyValue("deactivatelog")%> </option>
<%}
if(  sessionHistory.isAllowed(2080) )
                {

%>

								<option value="16"><%=TSSJavaUtil.instance().getKeyValue("ivroutdiallog")%></option>
<%}
if(  sessionHistory.isAllowed(2081) )
                {

%>

								<option value="17"><%=TSSJavaUtil.instance().getKeyValue("chargingrulelog")%> </option>
<%}
if(  sessionHistory.isAllowed(2082) )
                {

%>

								<option value="17"><%=TSSJavaUtil.instance().getKeyValue("rateplanlog")%> </option>
<%}
if(  sessionHistory.isAllowed(2083) )
                {

%>

								<option value="17"><%=TSSJavaUtil.instance().getKeyValue("vsrmanaglog")%> </option>
<%}
if(  sessionHistory.isAllowed(2084) )
                {

%>

								<option value="17"><%=TSSJavaUtil.instance().getKeyValue("rbtpromologs")%> </option>
<%}
if(  sessionHistory.isAllowed(2085) )
                {

%>

								<option value="17"><%=TSSJavaUtil.instance().getKeyValue("rbtreqlog")%> </option>
<%}
%>
</select>
</td></tr>
<tr class="tfield">
<td></td><td>Select Date for Logs</td>
</TR>
<tr >
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("sdate")%></td>
<td class="tfield"><input type="text" name="startDate" id="f_date_c1" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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
<td class="tfield"><%=TSSJavaUtil.instance().getKeyValue("edate")%></td>
<td class="tfield"><input type="text" name="endDate" id="f_date_c2" readonly="1"  /><img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" name ="c1"  title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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
<td colspan="2"><br></td><td>
<input type="hidden" name="todo" value="upload">
<input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%>">
<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%>"> 
</td>
</tr> 
</form>


				
    <tr class="homemenu"><td></td><td><a href="../home.jsp">Web Admin Home</a></td></tr>    
</table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
