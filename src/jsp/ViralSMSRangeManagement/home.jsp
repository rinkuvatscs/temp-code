
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2060))
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
        <tr class="tableheader"><td><%=TSSJavaUtil.instance().getKeyValue("vsrmanag")%> <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(2061))
    {
%>
        <tr class="homemenu">
            <td><a href="viralrange_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("addviral")%> </a> <br><br> </td>
        </tr>
<%
    }
%>
<%
    if(sessionHistory.isAllowed(2062))
    {
%>
        <tr class="homemenu">
            <td ><a href="viralrange_manage.jsp?pid=0&srchtext=X&order=ASC&searchId=0"><%=TSSJavaUtil.instance().getKeyValue("viewmodifyviral")%> </a> <br><br> </td>
        </tr>
<%
}
%>
    <tr class="homemenu"><td></td><td><a href="../home.jsp">Back</a></td></tr>    
				  </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
