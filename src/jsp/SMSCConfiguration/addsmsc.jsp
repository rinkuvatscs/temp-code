  <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(121))
	{
            %>
             <%@ include file ="../logouterror.jsp" %>
               <%
                 session.invalidate();
                    request.getSession(true).setAttribute("lang",defLangId);
                     }

	else
		{
		
		String clienttype = new String("");
		String smscstatus = new String("");
		if(request.getParameter("clienttype").equals("TRANSMITTER"))
			clienttype="T";
		if(request.getParameter("clienttype").equals("RECIEVER"))
			clienttype="R";
		if(request.getParameter("clienttype").equals("TRANSRECIEVER"))
			clienttype="TR";
		if(request.getParameter("status").equals("ACTIVATED"))
			smscstatus="A";
		if(request.getParameter("status").equals("DEACTIVATED"))
			smscstatus="D";
			
		SmscConfig smscConfig = new SmscConfig();
		SmscConfigManager smscConfigManager = new SmscConfigManager();
		smscConfigManager.setConnectionPool(conPool);
		smscConfig.setUserId( request.getParameter("username"));
		smscConfig.setPassword( request.getParameter("password"));
		smscConfig.setSmscIp( request.getParameter("serverip"));
		smscConfig.setSmscPort( Integer.parseInt(request.getParameter("serverport")));
		smscConfig.setSmscStatus( smscstatus);
		smscConfig.setTon( Integer.parseInt(request.getParameter("ton")));
		smscConfig.setNpi( Integer.parseInt(request.getParameter("npi")));
		smscConfig.setAddressRange( request.getParameter("range"));
		smscConfig.setNumOfConAllow( Integer.parseInt(request.getParameter("numofconallow"),10));
		smscConfig.setSpeed(Integer.parseInt(request.getParameter("speed")));
		smscConfig.setSystemType( request.getParameter("protocol"));
		smscConfig.setClientType(clienttype);
		
		int i = smscConfigManager.addSMSCConfig(smscConfig);
		if(i < 0)
		{
			%>
			<script language="JavaScript">
				alert("Error!!! Please try again")
				history.go(-1)
			</script>
			<%
		}
		else
		{
%>
		<script language="JavaScript">
			alert("SMSC Configuration added successfully!!")
			window.location="home.jsp"
		</script>
<%
		}
	}
%>
