<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2070) )
{
%>
    <%@ include file ="../logouterror.jsp" %>
<%
}
else
{
%>
<%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>

     <table width="80%" border="0" align="center">
					
        <tr class="tableheader"><td ><%=TSSJavaUtil.instance().getKeyValue("rateplanmanagement")%><br><br> </td></tr>
	<%
		if(sessionHistory.isAllowed(2071) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="rateplan_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("addRatePlan")%></a><br><br> </td>
        </tr>
	<%
		}
		if(sessionHistory.isAllowed(2072) )
		{
%>
        <tr class="homemenu" >
           <td ><a href="rateplan_manage.jsp?searchId=0&pid=0"><%=TSSJavaUtil.instance().getKeyValue("viewmodifyRatePlan")%></a><br><br> </td>
        </tr>
<%
}
%>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
