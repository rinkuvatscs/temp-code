<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
				RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();		 
            rbtrateManager.setConnectionPool(conPool);
			int pid=Integer.parseInt(request.getParameter("keyword"));

   int res=rbtrateManager.DeleteRbtRatePlan(pid);
   if(res == 0 )
    {
%>
        <script language="JavaScript">
            alert("Rate Plan Delete successfully!!!")
            window.location="home.jsp"
        </script>
<%
     }
    else
 	  {
%>
            <script language="JavaScript">
                alert("Error!!! Try Again");
                window.location="home.jsp";
            </script>
<%
    }

%>
