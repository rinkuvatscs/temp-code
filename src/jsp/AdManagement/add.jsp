
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
}
else
{
        AdvertiseManager adManager = new AdvertiseManager();
           adManager.setConnectionPool(conPool);
				 Advertise advertise = new Advertise();
				 int i=-1;
     
        String id = request.getParameter("id") ;
				if(id.equals("cat"))
				{
 				advertise.setCatName( request.getParameter("catName").toUpperCase());
				advertise.setCatFrequency( Integer.parseInt( request.getParameter("catFre") ) );

				 i = adManager.addAdCategory(advertise);
				 
				if(i == 0)
				 {
%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("adcatsuccess")%> !!")
					window.location="home.jsp"
			</script>
<%
		      }
		   }// id=cat
		else if(id.equals("ad"))
		{
 				advertise.setAdName( request.getParameter("adName").toUpperCase());
				advertise.setAdCategory( Long.parseLong( request.getParameter("adCat") ) );
				advertise.setAdFrequency( Integer.parseInt( request.getParameter("adFre") ) );
 				advertise.setStartDate( request.getParameter("start_date"));
 				advertise.setEndDate( request.getParameter("end_date"));
				advertise.setAdMax( Integer.parseInt( request.getParameter("adMax") ) );
				advertise.setAdSent( Integer.parseInt( request.getParameter("adSent") ) );

				i = adManager.addAdDetail(advertise);

        
			if(i == 0)
			{
%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("adsuccess")%> !!")
					window.location="../home.jsp"
				</script>
<%
			}

		}//id=ad
	if (i == -2)
	{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("adalready")%> ")
			history.go(-1)
		</script>
<%
	}
	else 
	{
%>
		<script language="JavaScript">
			alert("Error!!!<%=TSSJavaUtil.instance().getKeyValue("trylater")%> ")
			history.go(-1)
		</script>
<%
	}
}
%>
