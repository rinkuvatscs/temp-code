<%@ include file = "../conPool.jsp" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>


<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory==null || !sessionHistory.isAllowed(100) )
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
	 Country country  = new Country();

	 String inbound = request.getParameter("inbound");
	 String outbound = request.getParameter("outbound");

	 if(inbound == null) inbound="N";
	 if(outbound == null) outbound="N";
	
	country.setCode(request.getParameter("code").toUpperCase() ); 
	country.setName(request.getParameter("country_name").toUpperCase() );
	 
	country.setCc( Integer.parseInt(request.getParameter("cc")) ); 
	country.setMcc( Integer.parseInt(request.getParameter("mcc")) ); 

	country.setInbound(inbound);
	country.setOutbound(outbound);

		 int i = countryManager.addCountry(country);

		 if(i==0)
		 {
%>
		<script language="JavaScript">
                        alert("<%=TSSJavaUtil.instance().getKeyValue("Country_Details_added",defLangId)%>");
			//alert("Country Details added successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -2)
	{
%>
		<script language="JavaScript">
                  alert("<%=TSSJavaUtil.instance().getKeyValue("already_exist",defLangId)%>");
			//alert("This Country Details already exist, please select different")
			history.go(-1)
		</script>
<%
	}
	else 
	{
%>
		<script language="JavaScript">
                       alert("<%=TSSJavaUtil.instance().getKeyValue("try_again",defLangId)%>");
			//alert("Error!!! Please try again")
			history.go(-1)
		</script>
<%
	}
}
%>		 
	 
