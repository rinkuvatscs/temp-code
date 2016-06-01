
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
    SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
    if ((sessionHistory == null) || (!sessionHistory.isAllowed(130)))
    {
	 %>
	  <%@ include file ="../logouterror.jsp" %>
	    <%
	      session.invalidate();
	         request.getSession(true).setAttribute("lang",defLangId);
	          }
	
	else	
    {
        float curValue = 97f;
        String msg = "Normal";     // Message to be displayed 
        String msgColor = "Red";
%>
 <%@ include file="../lang.jsp" %>
<%@ include file = "../pagefile/header.html" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Refresh" CONTENT="60">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>

   
     <table width="80%" border="0" align="center">
        <tr class="tableheader"><td >System Monitoring for CRBT System<br><br></td></tr>
        
				<tr class="homemenu">
        <td ><a href="han.jsp">CRBT Service Platform</a><br><br></td>
        </tr>
       <!--
           <tr class="homemenu">
          <td ><a href="dan.jsp">Danang Site</a><br><br></td>
        </tr>
        <tr class="homemenu">
         <td ><a href="hcm.jsp">Ho Chi Minh City</a><br><br></td>
        </tr>
	-->			
    </table>
		
<%@ include file = "../pagefile/footer.html" %>

<%
} 
%>



