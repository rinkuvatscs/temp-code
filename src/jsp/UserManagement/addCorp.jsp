<%--
	All authentication logic resides in this class
	This class also initializes a SubscriberProfile Object depending on profile
	of msisdn. This SubscriberProfile Object is then used later by other jsps
--%>

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>

<%
  Logger logger = Logger.getLogger ("addCorp.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(154))
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
         <%	
	  CorpManager 	corpManager = new CorpManager();
  corpManager.setConnectionPool(conPool);
		  CorpUser corpUser = new CorpUser();

		corpUser.setCorpName( request.getParameter("corpName"));
		corpUser.setUserName( request.getParameter("userName"));
		corpUser.setPassword( request.getParameter("password"));
	
		int i = corpManager.addCorporate(corpUser);

		if(i < 0)
		{
			if(i == -2 )
			{
		
						logger.info("webadmin/UserManagement: The Corporate User name already exists");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alusrexist",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else
			%>
				<script language="JavaScript">
					alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
					window.location="../home.jsp"
				</script>
			<%
		}
		else if(i > 0)
		{
						logger.info("webadmin/UserManagement: The Corporate User is added Successfully");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alusradded",defLangId)%>!!!")
					window.location="home.jsp"
				</script>
<%
		}
	}
%>
