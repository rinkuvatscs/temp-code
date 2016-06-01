
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
   <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(311))
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
		
		IMSI imsi = new IMSI();
		imsi.setRangeId(request.getParameter("Id").toUpperCase());
		imsi.setStartAt(request.getParameter("startat"));
		imsi.setEndsAt(request.getParameter("endsat"));
		imsi.setSubscriberType(request.getParameter("subType"));
		int i = imsiManager.addIMSIConfig(imsi);
		if(i == 0)
		{
%>
			<script language="JavaScript">
				//alert("IMSI Configuration added successfully!!")
			alert("<%=TSSJavaUtil.instance().getKeyValue("IMSI_Conf_add",defLangId)%>")
				window.location="home.jsp"
			</script>
<%
		}
		else if (i == -2)
		{
%>
			<script language="JavaScript">
				//alert("A IMSI- Range Id already exist, please select different Id")
				alert("<%=TSSJavaUtil.instance().getKeyValue("IMSI_Range_Id_already_exist",defLangId)%>")
				history.go(-1)
			</script>
<%
		}
		else 
		{
%>
			<script language="JavaScript">
			//	alert("Error!!! Please try again")
			alert("<%=TSSJavaUtil.instance().getKeyValue("Try_Again",defLangId)%>")
				history.go(-1)
			</script>
<%
		}
	}
%>
