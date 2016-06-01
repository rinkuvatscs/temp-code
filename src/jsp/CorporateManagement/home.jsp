
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(2040))
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
					
        <tr class="tableheader"><td ><%=TSSJavaUtil.instance().getKeyValue("corpTop",defLangId)%><br><br> </td></tr>
	<%
		if(sessionHistory.isAllowed(2041) )
		{
	%>			
        <tr  class="homemenu">
           <td> <a href="corp_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("corpAdd",defLangId)%></a><br><br> </td>
        </tr>
	<%
		}
		if(sessionHistory.isAllowed(2042) )
		{
%>
        <tr class="homemenu" >
           <td ><a href="corpManage.jsp"><%=TSSJavaUtil.instance().getKeyValue("corpView",defLangId)%></a><br><br> </td>
        </tr>
  	<%
			}
		if(sessionHistory.isAllowed(158) )
		{
	%>			
      
<!--				<tr class="homemenu" >
           <td ><a href="corpRbtManage.jsp"><%=TSSJavaUtil.instance().getKeyValue("corpChangesetting",defLangId)%></a><br><br> </td>
        </tr>
-->
	<%
		}
%>
    </table>
    </table>

<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
