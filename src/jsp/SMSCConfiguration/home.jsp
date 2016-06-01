
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(120))
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

<%@ include file="../pagefile/header.html"%>

    <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">

			<tr><td class="tableheader" colspan="2"> SMSC Configuration Management<br><br> </td></tr>
<%
    if(sessionHistory.isAllowed(121))
    {
%>
      <tr>
			    <td class="homemenu"><a href="smscConfig_add.jsp">SMSC Configuration - Add</A><br><br></td>
			</tr>		
<%
    }
%>
      <tr> <td class="homemenu"><a href="smscConfiguration.jsp">SMSC Configuration - Management</A><br><br></td></tr>
		</table>

<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>
