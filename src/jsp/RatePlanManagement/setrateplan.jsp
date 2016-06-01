<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("setrateplan.jsp");
//String process=request.getParameter("process");
				RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();		 
                  rbtrateManager.setConnectionPool(conPool);
				RbtRatePlan rbtrateplan  = new RbtRatePlan();		
String result="";
			rbtrateplan.setRbtChgCode(request.getParameter("crbtchg"));
			rbtrateplan.setRbtGiftChgCode(request.getParameter("giftchg"));
			//rbtrateplan.setRbtMonoChgCode(request.getParameter("monotonechg"));
			//rbtrateplan.setRbtNoChgCode(request.getParameter("nochg"));
			rbtrateplan.setRbtNormalChgCode(request.getParameter("normalchg"));
			rbtrateplan.setSubChgCode(request.getParameter("subchg"));
			//rbtrateplan.setRbtRecChgCode(request.getParameter("recordedchg"));
			rbtrateplan.setRemarks(request.getParameter("remark"));
			rbtrateplan.setMRentCode(request.getParameter("monthlychg"));
			rbtrateplan.setThreeWeek(request.getParameter("threechg"));
			rbtrateplan.setTwoWeek(request.getParameter("twochg"));
			rbtrateplan.setOneWeek(request.getParameter("onechg"));

   int res=rbtrateManager.addRbtRatePlan(rbtrateplan);
 if(res == -2 )
    {
%>
            <script language="JavaScript">
                alert("Rate Plan already exists");
                history.go(-1);
            </script>
<%
    }
    else if(res == 0 )
    {
%>
        <script language="JavaScript">
            alert("Rate Plan added successfully!!!")
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







		/*logger.info(result);
		response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write(result);*/
%>
