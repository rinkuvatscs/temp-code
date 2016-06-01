
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(190) )
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
					
        <tr class="tableheader"><td ><%=TSSJavaUtil.instance().getKeyValue("rtTop",defLangId)%><br><br> </td></tr>
	<%
		if(sessionHistory.isAllowed(194) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="roleManagement_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("rtAdd",defLangId)%></a><br><br> </td>
        </tr>
	<%
		}
%>
        <tr class="homemenu" >
           <td ><a href="roleManagement.jsp"><%=TSSJavaUtil.instance().getKeyValue("rtView",defLangId)%></a><br><br> </td>
        </tr>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
