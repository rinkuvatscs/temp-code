%--
		Modified by Jatinder Pal
		on Jan. 11, 2006.
--%>
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
  Logger logger = Logger.getLogger ("addRole.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(194) )
	{
%>
			<%@ include file ="../logouterror.jsp" %>
<%
	}
	else
{%>      
         <%@ include file="../lang.jsp" %>
	<%
						RoleTypeManager roleManager = new RoleTypeManager();
                              roleManager.setConnectionPool(conPool);
            RoleType roleType = new RoleType();
						 
						 String roleName = request.getParameter("roleName");
						 String roleDesc = request.getParameter("roleDesc");
						 String[] links = request.getParameterValues("links");
 
							roleType.setRoleName(roleName);
							roleType.setRoleDesc(roleDesc);						 
              
						 int i = roleManager.addRoleData(roleType, links); // links may be many, hence these are passed as String arg.
						 
						 
		if(i < 0)
		{
			if(i == -2 )
			{
			%>
        <script language="JavaScript">
					alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("alroleexist",defLangId)%>")
					history.go(-1)
				</script>
<%
			}
			else
      {
			%>
        <script language="JavaScript">
						alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
						window.location="../home.jsp"
				</script>
<%
      }
   }
   else
     {
             logger.info("webadmin/RoleManage: role added successfully");
%>
        <script language="JavaScript">
						alert("<%=TSSJavaUtil.instance().getKeyValue("alroleadded",defLangId)%>!!!")
						window.location="home.jsp"
			</script>
<%
		}
	}
%>
