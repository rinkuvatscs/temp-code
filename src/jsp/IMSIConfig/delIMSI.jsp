
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(312))
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
 
		IMSIManager imsiManager = new IMSIManager();		
        imsiManager.setConnectionPool(conPool);
		ArrayList imsiIdAl = new ArrayList();
		String imsiIdArr[] = (String [])request.getParameterValues("delid");
		for(int j = 0; j < imsiIdArr.length; j++)
		{
                    String imsiID = imsiIdArr[j];
                    imsiIdAl.add(imsiID);
		}
		int i = imsiManager.deleteIMSIConfig(imsiIdAl);
		if (i == 0)
		{
		%>
			<script language="JavaScript">
                           // alert("IMSI Configuration deleted successfully!!")
                          alert("<%=TSSJavaUtil.instance().getKeyValue("IMSI_Config_del",defLangId)%>")
                            window.location="home.jsp"
			</script>
<%
		}
		else
		{
		%>
			<script language="JavaScript">
                           // alert("Please try again")
                         alert("<%=TSSJavaUtil.instance().getKeyValue("Please_try_again",defLangId)%>")
                            history.go(-1)
			</script>
		<%
		}
	}
%>
