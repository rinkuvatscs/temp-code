<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(281) )
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
        
		lbsManager lbManager = new lbsManager();
           lbManager.setConnectionPool(conPool);
		lbs lb = new lbs();
		
		lb.setProcessName (request.getParameter("processName"));
		lb.setPackageName ( request.getParameter("packageName") );
		lb.setSyntax (request.getParameter("syntax")) ;
		lb.setMinArg( Integer.parseInt( request.getParameter("minArg") ));
		lb.setMaxArg( Integer.parseInt( request.getParameter("maxArg") ));
		
		int i = lbManager.updateLBSConfig(lb);
		
		if(i < 0)
		{
			%>
			<script language="JavaScript">
				//alert("Error!!! Please try again")
			alert("<%=TSSJavaUtil.instance().getKeyValue("try_again",defLangId)%>")
				history.go(-1)
			</script>
			<%
		}
		else
		{
%>
		<script language="JavaScript">
			//alert("LBS Configuration modified successfully!!")
		alert("<%=TSSJavaUtil.instance().getKeyValue("LBS_Config_modified",defLangId)%>")
			window.location="../home.jsp"
		</script>
<%
		}
	}
%>
