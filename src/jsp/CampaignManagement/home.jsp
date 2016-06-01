
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2000) )
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
					
        <tr class="tableheader"><td ><%=TSSJavaUtil.instance().getKeyValue("camTop",defLangId)%><br><br> </td></tr>
	<%
		if(sessionHistory.isAllowed(2000) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="add_details.jsp"><%=TSSJavaUtil.instance().getKeyValue("camIvrDetail",defLangId)%></a><br><br> </td>
        </tr>
	<%
		}
		if(sessionHistory.isAllowed(2000) )
		{
%>
        <tr class="homemenu" >
           <td ><a href="add_msisdn_file.jsp"><%=TSSJavaUtil.instance().getKeyValue("camList",defLangId)%></a><br><br> </td>
        </tr>
						<%
						}
						%>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
