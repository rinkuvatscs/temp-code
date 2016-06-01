
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("updateOcc.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(1022))
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

       		  OccasionManager 	ocManager = new OccasionManager();
                  ocManager.setConnectionPool(conPool);       
		  Occasion ocob = new Occasion();
String user_name=sessionHistory.getUser();

		
		ocob.setOccasionName( request.getParameter("occasionName"));
		String oldName = request.getParameter("occasionName_old");
		ocob.setOccasionDate( request.getParameter("occasionDate"));
		ocob.setIsConstant( request.getParameter("occasionConst"));
		ocob.setDescription( request.getParameter("occasionDesc"));

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
			String old_values="OCCASION_NAME:"+request.getParameter("occasionName_old")+";";	
			String new_values="OCCASION_NAME:"+request.getParameter("occasionName_old")+";";	
if(!request.getParameter("old_occasionDate").equals(request.getParameter("occasionDate")))
{
old_values=old_values+"OCCASION_DATE:"+request.getParameter("old_occasionDate")+";";
new_values=new_values+"OCCASION_DATE:"+request.getParameter("occasionDate")+";";
k=1;
}
if(!request.getParameter("old_occasionConst").equals(request.getParameter("occasionConst")))
{
old_values=old_values+"IS_CONSTANT:"+request.getParameter("old_occasionConst")+";";
new_values=new_values+"IS_CONSTANT:"+request.getParameter("occasionConst")+";";
k=1;
}
if(!request.getParameter("old_occasionDesc").equals(request.getParameter("occasionDesc")))
{
old_values=old_values+"DESCRIPTION:"+request.getParameter("old_occasionDesc")+";";
new_values=new_values+"DESCRIPTION:"+request.getParameter("occasionDesc")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("CRBT_OCCASION_LIST");
                logobj.setlink("occasionmanagementlog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}
	
		int i = ocManager.updateOccasion(ocob, oldName);
if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}
			if(i == 1)
	  	{
					logger.info("webadmin/OccasionManagement: The Occasion details are modified successfully");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("aloccmodi",defLangId)%>")
					window.location="home.jsp"
				</script>
<%
		  }
			else if(i == -2)
	  	{
					logger.info("webadmin/OccasionManagement: name exists already");
			%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("aloccalready",defLangId)%>")
					window.location="occManage.jsp"
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
%>
