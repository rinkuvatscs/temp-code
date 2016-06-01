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
 
<HTML>
<HEAD>
<script type="text/javascript">
function validate()
{
}


</script>
</HEAD>
<%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>

<form name="form1" method="post" action="add_listfile.jsp" enctype="multipart/form-data" onSubmit="return validate()"> 
 <table width="80%" border="0" align="center" cellpadding="1" cellspacing="2"> 
	<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("camIVRTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("camaddlist",defLangId)%><br><br></td</tr>
	 
	<tr class="tfield">
		<TD><%=TSSJavaUtil.instance().getKeyValue("camaddlist",defLangId)%></TD>
		<TD><INPUT TYPE="file" NAME="msisdnfile"ACCEPT="text/html"></TD>
	</TR>

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
