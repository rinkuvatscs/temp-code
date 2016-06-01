
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(1021))
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
					
        <tr class="tableheader"><td ><%=TSSJavaUtil.instance().getKeyValue("omTop",defLangId)%><br><br> </td></tr>
	<%
		if(sessionHistory.isAllowed(1020) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="occasion_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("omAdd",defLangId)%></a><br><br> </td>
        </tr>
	<%
		}
		if(sessionHistory.isAllowed(1021) )
		{
%>
        <tr class="homemenu" >
           <td ><a href="occManage.jsp"><%=TSSJavaUtil.instance().getKeyValue("omView",defLangId)%></a><br><br> </td>
        </tr>
  	<%
		}
%>
    </table>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
