<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@page import = "org.apache.log4j.*" %>
   <%@ include file = "../conPool.jsp" %>
<%
    Logger logger = Logger.getLogger ("viralrangeadd.jsp");
				String msisdn=request.getParameter("msisdn");
				ViralSMSRange NewRange = new ViralSMSRange();		
                    NewRange.setConnectionPool(conPool); 
		   int res=NewRange.addNewRange(msisdn);
    logger.info("return value=="+res);
if(res == -2 )
    {
%>
            <script language="JavaScript">
                alert("Msisdn Range already exists");
                history.go(-1);
            </script>
<%
    }
else if(res == 0 )
    {
%>
        <script language="JavaScript">
            alert("Msisdn Range added successfully!!!")
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
