
<%@ page import = "com.telemune.webadmin.webif.*"%>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(170))
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
     var click = confirm("<%=TSSJavaUtil.instance().getKeyValue("actconf",defLangId)%> ")
     if(click == false)
		 {
				history.go(-1)
		 }
     else
   	{
			window.location="activate_con.jsp";
		}
	</script>
<%
}
%>
