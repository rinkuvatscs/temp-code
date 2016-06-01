
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

        <tr class="tableheader"><td>System Monitoring - Ho chi minh<br><br></td></tr>
				
           <tr class="tfield1">
              <td >Ring Back Tone Server 1</td>
           </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt1&par=cpu&dur=day">CPU Usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt1&par=mem&dur=day">Memory usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt1&par=disk&dur=day">Disk usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt1&par=eth0&dur=day">Network Traffic (eth0)</A></td>
            </tr>
            <tr class="tfield1">
              <td >Ring Back Tone Server 2 </td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt2&par=cpu&dur=day">CPU Usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt2&par=mem&dur=day">Memory usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt2&par=disk&dur=day">Disk usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt2&par=eth0&dur=day">Network Traffic (eth0)</A></td>
            </tr>
            <tr class="tfield1">
              <td >Ring Back Tone Server 3 </td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt3&par=cpu&dur=day">CPU Usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt3&par=mem&dur=day">Memory usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt3&par=disk&dur=day">Disk usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmrbt3&par=eth0&dur=day">Network Traffic (eth0)</A></td>
            </tr>
            <tr class="tfield1">
              <td >IVR Server </td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmivr1&par=cpu&dur=day">CPU Usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmivr1&par=mem&dur=day">Memory usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmivr1&par=disk&dur=day">Disk usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmivr1&par=eth0&dur=day">Network Traffic (eth0)</A></td>
            </tr>
            <tr class="tfield1">
              <td >DK Server </td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmdk1&par=cpu&dur=day">CPU Usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmdk1&par=mem&dur=day">Memory usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmdk1&par=disk&dur=day">Disk usage</A></td>
            </tr>
            <tr class="homemenu">
              <td ><a href="show.jsp?ser=hcmdk1&par=eth0&dur=day">Network Traffic (eth0)</A></td>
            </tr>
      </table>


<%@ include file = "../pagefile/footer.html" %>
<%
} 
%>
