
<%@ page import = "com.telemune.webadmin.webif.SessionHistory" %>
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
<%@ include file = "../pagefile/header.html" %>
<HTML>
<HEaD>
<METa HTTP-EQUIV="Refresh" CONTENT="60">
<METa HTTP-EQUIV="Pragma" CONTENT="no-cache">
<METa HTTP-EQUIV="Expires" CONTENT="-1">
</HEaD>


   <table width="80%" border="0" align="center">
        <tr class="tableheader"><td>System Monitoring - Danang<br><br></td></tr>
         <tr class="tfield1">
        	  <td >Ring Back Tone Server 1 </td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt1&par=cpu&dur=day">CPU Usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt1&par=mem&dur=day">Memory usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt1&par=disk&dur=day">Disk usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt1&par=eth0&dur=day">Network Traffic (eth0)</a></td>
            </tr>
            <tr class="tfield1">
              <td >Ring Back Tone Server 2</td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt2&par=cpu&dur=day">CPU Usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt2&par=mem&dur=day">Memory usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt2&par=disk&dur=day">Disk usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danrbt2&par=eth0&dur=day">Network Traffic (eth0)</a></td>
            </tr>
            <tr class="tfield1">
              <td >IVR Server</td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danivr1&par=cpu&dur=day">CPU Usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danivr1&par=mem&dur=day">Memory usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danivr1&par=disk&dur=day">Disk usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=danivr1&par=eth0&dur=day">Network Traffic (eth0)</a></td>
            </tr>
            <tr class="tfield1">
              <td >DK Server</td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=dandk1&par=cpu&dur=day">CPU Usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=dandk1&par=mem&dur=day">Memory usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=dandk1&par=disk&dur=day">Disk usage</a></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=dandk1&par=eth0&dur=day">Network Traffic (eth0)</a></td>
            </tr>
     </table>

<%@ include file = "../pagefile/footer.html" %>

<%
} 
%>

