
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("add.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(321))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
//			String url = response.encodeRedirectURL("../logouterror.jsp");
//			response.sendRedirect(url);
}
else
{
					BlackListManager blacklistManager = new BlackListManager();
       blacklistManager.setConnectionPool(conPool);

					BlackList blackList = new BlackList();
				
				
				  String imsi =  request.getParameter("imsi") ;	

					if(imsi.equals("") || imsi== null)			imsi ="NA";
					
					logger.info("webadmin/BlackList: IMSI= "+imsi);
				  blackList.setImsi(imsi);	
				  blackList.setMsisdn( request.getParameter("msisdn") );	
				  blackList.setExDate( request.getParameter("expiry_date") );	
				  blackList.setRemark( request.getParameter("remark") );
					
					logger.info("webadmin/BlackList: Adding blackList");
					int i  = blacklistManager.addBlackList(blackList);

		if ( i == -2)	
	   {
	%>
	 <script language="JavaScript">
	 	 alert("<%=TSSJavaUtil.instance().getKeyValue("alreadyex")%>")
		 history.go(-1)
		</script> 
	<%
	   }
	 else if(i ==0)
			{
	%>
	 <script language="JavaScript">
	 	 alert("<%=TSSJavaUtil.instance().getKeyValue("bladsuccess")%>")
		 window.location="../home.jsp"
		</script> 
	<%
	   }
		else
		 {
	%>					 
		<script language="JavaScript">
			alert("Error!!!<%=TSSJavaUtil.instance().getKeyValue("trylater")%>")
			history.go(-1)
		</script>
	<%
		}


}
%>

