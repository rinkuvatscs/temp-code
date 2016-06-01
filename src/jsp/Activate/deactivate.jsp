
<%@ page import = "com.telemune.webadmin.webif.*"%>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(180))
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
	<script language = "Javascript">
  var click = confirm("<%=TSSJavaUtil.instance().getKeyValue("deactconf",defLangId)%> ")
  if(click == false)
	{
		history.go(-1)
	}
  else
  {
		window.location="deactivate_con.jsp";
	}
	</script>
<%
}
%>
