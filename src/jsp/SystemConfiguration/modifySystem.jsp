
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("modifySystem.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(111) )
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

		String param = request.getParameter("param");
		String value = request.getParameter("value");
		String old_value = request.getParameter("old_value");
		String remark = request.getParameter("remark");
        
		SystemConfigManager systemConfigManager = new SystemConfigManager();
          systemConfigManager.setConnectionPool(conPool);
		SystemConfig systemConfig = new SystemConfig();

		systemConfig.setParamTag(param);
		systemConfig.setParamValue(value);
		systemConfig.setRemarks(remark);

		int j = systemConfigManager.updateSystemConfig(systemConfig);
	if(!old_value.equals(value) && j==0)
	{
		String user_name=sessionHistory.getUser();
		int i = systemConfigManager.updateSystemConfiglogs(systemConfig,user_name,old_value);
	}	
		if(j < 0)
		{
						logger.info("webadmin/SystemConfiguration: Errror in updateSystemConfig()");
%>
			<SCRIPT LANGUAGE="JavaScript">
    		alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
    		history.go(-1)
			</SCRIPT>
<%
		}
		else
		{
						logger.info("webadmin/SystemConfiguration: System Configuration modified.");
%>
			<SCRIPT LANGUAGE="JavaScript">
				alert("<%=TSSJavaUtil.instance().getKeyValue("alsysmodi",defLangId)%>!!")
				window.location="../home.jsp"
			</SCRIPT>
<%
		}
	}
%>
