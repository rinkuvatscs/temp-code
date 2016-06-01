
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("addCorp.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2041))
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

		String msisdn = TSSJavaUtil.instance().getInternationalNumber(request.getParameter("msisdn").trim());
		
		corpUser.setCorpName( request.getParameter("corpName"));
		corpUser.setChargingMsisdn(msisdn);
		corpUser.setUserName( request.getParameter("userName"));
		corpUser.setPassword( request.getParameter("password"));
		corpUser.setPlanIndicator(Integer.parseInt(request.getParameter("billId")));	

		int i = corpManager.addCorporate(corpUser);

		if(i < 0)
		{
			if(i == -2 )
			{
		
						logger.info("webadmin/CorporateManagement: The Corporate User name already exists");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("aluseralready",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else if(i == -3 )
			{
		
						logger.info("webadmin/CorporateManagement: The Corporate billing msisdn already exists");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("albillnumal",defLangId)%>")
					history.go(-1)
				</script>
			<%
			}
			else if(i == -12 )
			{
		
						logger.info("webadmin/CorporateManagement: The Corporate billing msisdn not in specified range");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("alnumrng",defLangId)%>")
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
					alert("<%=TSSJavaUtil.instance().getKeyValue("corpadded",defLangId)%>!!!")
					window.location="home.jsp"
				</script>
<%
		}
	}
%>
