<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "org.apache.log4j.*" %>
 <%@ include file="../lang.jsp" %>
 <%@ include file = "conPool.jsp" %>
<jsp:useBean id="authenticate" class="com.telemune.webadmin.webif.AuthAdmin" scope="session"/>
<jsp:setProperty name="authenticate" property="userId" value='<%=request.getParameter("msisdn")%>'/>
<jsp:setProperty name="authenticate" property="password" value='<%=request.getParameter("password")%>'/>

<%
 authenticate.setConnectionPool(conPool);
int authResult = authenticate.authenticate();
SessionHistory sh = authenticate.getSessionHistory();
session.setAttribute("sessionHistory", sh);

	if(authResult == CrbtAdminAppCode.AUTHENTICATED_USER)
	{	//authenticated
				session.setMaxInactiveInterval(60*30);
				String encodedURL = response.encodeRedirectURL("home.jsp");
				response.sendRedirect(encodedURL);
	}
	else
	{
				String errMsg = TSSJavaUtil.instance().getKeyValue("loginerr1",defLangId);
				switch(authResult) 
				{
								case CrbtAdminAppCode.INVALID_USER :
								case CrbtAdminAppCode.INVALID_PASSWORD :
												errMsg = TSSJavaUtil.instance().getKeyValue("loginerr2",defLangId);
												break;
								case CrbtAdminAppCode.USERID_PASSWORD_MISSING :
												errMsg = TSSJavaUtil.instance().getKeyValue("loginerr3",defLangId);
												break;
	}
%>
								<script language="JavaScript">
										alert("<%=errMsg%>");
										history.go(-1);
								</script>
<%
}
%>
