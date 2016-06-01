
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(280))
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
  <%@ include file="../lang.jsp" %>

<%@ include file = "../pagefile/header.html" %>

   <table border="0" width="80%" align="center" >
			 <tr><td colspan="2" class="tableheader"> <%=TSSJavaUtil.instance().getKeyValue("HLR_Configuration_Management",defLangId)%> <br><br></td></tr>
			 
<%
    if(sessionHistory.isAllowed(282))
    {
%>
      <tr><td class="homemenu" > <a href="hlrConfig_add.jsp"><%=TSSJavaUtil.instance().getKeyValue("HLR_Configuration-Add",defLangId)%></a><br><br> </td></tr>
<%
    }
    if(sessionHistory.isAllowed(280))
    {
%>
     <tr><td class="homemenu"> <a href="hlr_configuration.jsp"><%=TSSJavaUtil.instance().getKeyValue("HLR_Configuration-Management",defLangId)%></a><br><br> </td></tr>
<%
		}
%>		

		</table>
<%@ include file = "../pagefile/footer.html" %>
<%
	}
%>
