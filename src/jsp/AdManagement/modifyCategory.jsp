<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
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

     adManager.setConnectionPool(conPool);
	 Advertise advertise = new Advertise();

	 int i = -1;
	 

  String id = request.getParameter("id");

	long catId=Long.parseLong( request.getParameter("catId") );
	advertise.setCatId(catId);

   
	  if(id.equals("del") )
		{
				i = adManager.delAdCategory(advertise);
		}
		else if(id.equals("mod") )
		{

					String name=	request.getParameter("catName").toUpperCase() ;
					int frequency=	Integer.parseInt( request.getParameter("catFre") );


					advertise.setCatName(name);
					advertise.setCatFrequency(frequency);

						i = adManager.modifyAdCategory(advertise);

						
		}
	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("adcatmodis")%> !!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("adcatdels")%> !!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater")%> ")
			history.go(-1)
		</script>
<%
	}
} //else main
%>


	
