
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(282))
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
		HLRManager hlrManager = new HLRManager();
           hlrManager.setConnectionPool(conPool);

		HLR hlr = new HLR();
		hlr.setHLRName(request.getParameter("name").toUpperCase());
		hlr.setHLRIp(request.getParameter("serverip"));
		hlr.setHLRPort(Integer.parseInt(request.getParameter("serverport")));
		hlr.setLogin(request.getParameter("login"));
		hlr.setPassword(request.getParameter("password"));
		hlr.setConnection(Integer.parseInt(request.getParameter("numofconallow"),10));
	
		int i = hlrManager.addHLRConfig(hlr);
		if(i == 0)
		{
%>
			<script language="JavaScript">
				//alert("HLR Configuration added successfully!!")
				 alert(<%=TSSJavaUtil.instance().getKeyValue("HLR_Configuration",defLangId)%>)
				window.location="home.jsp"
			</script>
<%
		}
		else if (i == -2)
		{
%>
			<script language="JavaScript">
				//alert("A HLR with the name already exist, please select differnt name")
                                   alert(<%=TSSJavaUtil.instance().getKeyValue("HLR_name_exists",defLangId)%>)
				history.go(-1)
			</script>
<%
		}
		else 
		{
%>
			<script language="JavaScript">
				//alert("Error!!! Please try again")
				 alert(<%=TSSJavaUtil.instance().getKeyValue("try_again",defLangId)%>)
				window.location="../home.jsp"
			</script>
<%
		}
	}
%>
