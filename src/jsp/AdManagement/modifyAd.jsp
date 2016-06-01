<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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

   AdvertiseManager adManager = new AdvertiseManager();
	 Advertise advertise = new Advertise();

	 int i = -1;
	 

  String id = request.getParameter("id");

	long adId=Long.parseLong( request.getParameter("adId") );
			  advertise.setAdName( request.getParameter("adName").toUpperCase() );			
	advertise.setAdId(adId);

   
	  if(id.equals("del") )
		{
				i = adManager.delAdDetail(advertise);
		}
		else if(id.equals("mod") )
		{
				advertise.setAdCategory( Long.parseLong( request.getParameter("adCat") ) );
				advertise.setAdFrequency( Integer.parseInt( request.getParameter("adFre") ) );
 				advertise.setStartDate( request.getParameter("start_date"));
 				advertise.setEndDate( request.getParameter("end_date"));
				advertise.setAdMax( Integer.parseInt( request.getParameter("adMax") ) );
				advertise.setAdSent( Integer.parseInt( request.getParameter("adSent") ) );

         i = adManager.modifyAdDetail(advertise);      	
		
  	}
	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("addetmodi")%> !!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("addetdel")%> !!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("tryagain")%> ")
			history.go(-1)
		</script>
<%
	}
} //else main
%>


	
