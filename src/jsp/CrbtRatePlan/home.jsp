
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2054))
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
%>

<%@ include file = "../pagefile/header.html" %>

   <table width="80%" border="0" align="center">
        <tr class="tableheader"><td> Crbt Rate Plan Management <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(2056))
    {
%>
        <tr class="homemenu">
            <td><a href="rateplan_add.jsp">Add New Rate Plan</a> <br><br> </td>
        </tr>
<%
    }
%>
<%
    if(sessionHistory.isAllowed(2057))
    {
%>
        <tr class="homemenu">
            <td ><a href="rateplan_manage.jsp?pid=0&keywords=PLAN_INDICATOR&srchtext=X&order=ASC&searchId=0">Rate Plan - View / Modify Rate Plan</a> <br><br> </td>
        </tr>
<%
}
%>
<!--<tr class="homemenu"><td colspan="1"><a href="RatePlanlogs.jsp?pid=0&srchtext=X&searchId=0 "><%=TSSJavaUtil.instance().getKeyValue("rateplanlog")%></a><br><br> </td></tr>-->

    <tr class="homemenu"><td></td><td><a href="../home.jsp">Back</a></td></tr>    
				  </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
