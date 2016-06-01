<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("country_modify_delete.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
   CountryManager countryManager = new CountryManager();
   countryManager.setConnectionPool(conPool);
	 Country country = new Country();

	 int i = -1;
	 

  String id = request.getParameter("id");
		
 int mcc= Integer.parseInt(request.getParameter("mcc") );
	
			country.setMcc(mcc);
		
	if(id.equals("mod") ) //modify country roaming
	{
			String inbound = 		request.getParameter("inbound");
			String outbound = 	request.getParameter("outbound");

			  if(inbound==null) inbound="N";
						country.setInbound(inbound);
				
			  if(outbound==null) outbound="N";
						country.setOutbound(outbound);
				
				logger.info("webadmin/CountryManagement: modify Inbound/Outbound roaming status for country");	
				i = countryManager.modifyCountryConfig(country);
	}			

	else if(id.equals("del")) //delete country details
	{
				logger.debug("to delete country");	
				 i = countryManager.delCountryConfig(country);
	}
	
	
	if(i == 0) //modify
	{

%>
		<script language="JavaScript">
			//alert("Country Details modified successfully!!")
                         alert("<%=TSSJavaUtil.instance().getKeyValue("Country_Details",defLangId)%>");
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			//alert("Country Details Deleted successfully!!")
			alert("<%=TSSJavaUtil.instance().getKeyValue("Country_Details_Deleted",defLangId)%>");
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			//alert("Error!!! Please try again")
			alert("<%=TSSJavaUtil.instance().getKeyValue("try_again",defLangId)%>");
			history.go(-1)
		</script>
<%
	}
}
%>	
