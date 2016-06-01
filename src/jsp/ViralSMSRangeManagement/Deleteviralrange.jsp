<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
				ViralSMSRange viralsmsrange  = new ViralSMSRange();		 
                   viralsmsrange.setConnectionPool(conPool);
			String msisdn=request.getParameter("keyword");

   int res=viralsmsrange.Deleteviralrange(msisdn);
   if(res == 0 )
    {
%>
        <script language="JavaScript">
            alert("Viral SMS Range Delete successfully!!!")
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
