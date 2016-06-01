
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(300))
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

    <table width="70%"  border="1" align="center">
        <tr class="tableheader"><td colspan="2"> CRBT - SMS Template Management<br><br></td></tr>
        <tr class="homemenu">
             <td ><a href="smsTemplate.jsp?pid=0&languageId=1&ordrby=0&srchId=0&srchtxt=">English Templates</a><br><br> </td>
	    	</tr>
        <tr class="homemenu">
              <td ><a href="smsTemplate.jsp?pid=0&languageId=2&ordrby=0&srchId=0&srchtxt=">Spanish Templates</a><br><br> </td>
        </tr>
<!--
<%
    if(sessionHistory.isAllowed(302))
    {
%>
        <tr class="homemenu">
             <td><a href="smsTemplate_add.jsp">Add New SMS Template</a><br><br> </td>
        </tr>
<%
    }
%>
-->
          </table>
    <table width="70%"  border="1" align="center">
        <tr class="tableheader"><td colspan="2"> CRBT - SMS Template Management<br><br></td></tr>
        <tr class="homemenu">
             <td ><a href="smsHelpTemplate.jsp?pid=0&languageId=1&ordrby=0&srchId=0&srchtxt=">English Templates</a><br><br> </td>
	    	</tr>
        <tr class="homemenu">
              <td ><a href="smsHelpTemplate.jsp?pid=0&languageId=2&ordrby=0&srchId=0&srchtxt=">Spanish Templates</a><br><br> </td>
        </tr>
          </table>


<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
