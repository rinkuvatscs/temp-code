

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
  SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory ==null || !sessionHistory.isAllowed(100) )
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
<html>

<head>
 <title> Message Mapping </title>
 <link rel="stylesheet" href="../pagefile/webadmin_style.css" type="text/css" >
 <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=isp-8859-1" >
 
</head>
<%@ include file="../pagefile/header.html"%>
      <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="tableheader" colspan="2"> MessageMapping Configuration & Management <br><br></td></tr>
				
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr>
				<td class="homemenu">   <a href="mesg_map.jsp">Add for MessageMapping</a>		</td>
			</tr>	
			<tr><td  >&nbsp; </td> </tr>
<%
    }
%>
      <tr>
				<td class="homemenu"> <a href="mesg_config.jsp">MessageMapping Management</a></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
