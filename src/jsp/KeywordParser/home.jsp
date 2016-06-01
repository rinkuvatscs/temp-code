
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(290))
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
        <tr class="tableheader"><td> Keyword Parser Management <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(292))
    {
%>
        <tr class="homemenu">
            <td><a href="keyword_add.jsp">Add New Keyword</a> <br><br> </td>
        </tr>
<%
    }
%>
        <tr class="homemenu">
            <td ><a href="keyword_manage.jsp?pid=0&srchtext=X&order=ASC&searchId=0">Keyword Parser - View Existing Keywords</a> <br><br> </td>
        </tr>
        
				  </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
