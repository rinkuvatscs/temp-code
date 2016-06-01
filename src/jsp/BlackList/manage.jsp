 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%@ page import="com.telemune.webadmin.webif.*"%>

<%
       Logger logger = Logger.getLogger ("manage.jsp");
   SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	 if(sessionHistory ==null || !sessionHistory.isAllowed(322) || !sessionHistory.isAllowed(323) )
	 	 {
					 session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%

	 }
	 else
	 {
					 BlackListManager blackListManager = new BlackListManager();
                     blackListManager.setConnectionPool(conPool);
					 BlackList blackList = new BlackList();
           int i=-1;
					String id  = request.getParameter("id");

					String imsi = request.getParameter("imsi");
					if(imsi == null)
					{
									imsi="NULL";
					}
					String msisdn = request.getParameter("msisdn");

					blackList.setImsi(imsi);
					blackList.setMsisdn(msisdn);

					if(id.equals("del") )
					{
									logger.info("webadmin/BlackList: Deleting BlackList: "+imsi+" "+msisdn);
									 i = blackListManager.delBlackList(blackList);
					}
					else if(id.equals("mod") )
					{
								blackList.setExDate(request.getParameter("expiry_date") );
								blackList.setRemark(request.getParameter("remark") );


									logger.info("webadmin/BlackList: Modifying BlackList for: "+msisdn);
									 i = blackListManager.modifyBlackList(blackList);

					}

	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("msgmapmodi")%>!!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("msgmapdel")%>!!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater")%>")
			history.go(-1)
		</script>

<% 
   }
}
	%>
