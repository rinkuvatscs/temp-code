<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
<HTML>
<HEAD>
<TITLE>VLR Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>

<%@ include file = "../pagefile/header.html" %>
    <table width="70%"  border="0" cellspacing="0" cellpadding="0" align="center">
			<th  > VLR Management </th>
				
			<tr><td  >&nbsp; </td> </tr>
			<tr><td  >&nbsp; </td> </tr>
<%
    if(sessionHistory.isAllowed(100))
    {
%>
    	
			<tr>
				<td>   <a href="vlr_add.jsp">Add VLR</a>		</td>
			</tr>	
			<tr><td  >&nbsp; </td> </tr>
<%
    }
%>
      <tr>
				<td> <a href="vlr_configuration_management.jsp">VLR Configuration - Management</a></td>
			</tr>	

			</table>
				
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
