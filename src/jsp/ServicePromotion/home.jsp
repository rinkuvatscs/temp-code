
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*"%>
<%@ page import = "java.util.*"%>

<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
			if(sessionHistory == null || !sessionHistory.isAllowed(160))
			{
			 %>
			  <%@ include file ="../logouterror.jsp" %>
			    <%
			      session.invalidate();
			         request.getSession(true).setAttribute("lang",defLangId);
			          }

			else
			{
%>

<%@ include file = "../pagefile/header.html" %>

     <table width="80%" border="0" align="center">
        <tr>
            <td class="tableheader" >Service Promotion  <br><br></td>
        </tr>
        <tr class="homemenu">
          <td ><a href="viralsms.jsp">Viral SMS</a> <br><br></td>
        </TR>
        <tr class="homemenu">
          <td ><a href="ringtonepromo.jsp">RingTone Promotion</a> <br><br></td>
        </tr>
        <tr class="homemenu">
          <td ><a href="contentpromo.jsp">New Content Promotion</a> <br><br></td>
        </tr>
        <tr class="homemenu">
          <td ><a href="servicepromo.jsp">Service Promotion</a> <br><br></td>
        </tr>
     </table>


<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
