
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<jsp:useBean id="authenticate" class="com.telemune.webadmin.webif.AuthAdmin" scope="page"/>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");

if(sessionHistory == null || !sessionHistory.isAllowed(740))
{
	session.invalidate();
%>
	<%@ include file = "../logouterror.jsp" %>
<%
}
else
{
       %>
       <%@ include file="../lang.jsp" %>
       <%
	String user      = sessionHistory.getUser();
	String oldPass   = request.getParameter("oldpass");
	String newPass   = request.getParameter("newpass");
            authenticate.setConnectionPool(conPool);
	int l = authenticate.changePassword(user,oldPass,newPass);

	if(l == 1)
	{
%>
		<script language="Javascript">
			alert("Succesfully Changed the Password")
			window.location="../home.jsp"
		</script>
<%
	}
	else if(l == 12)
	{
%>
		<script language="Javascript">
			alert("Please check the old password")
			history.back(-1)
		</script>
<%
	}
	else
	{
%>
		<script language="Javascript">
			alert("Couldnt Change the password")
			history.back(-1)
		</script>
<%
	}
}
%>
