<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("vlr_modify_delete.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
 %>
  <%@ include file ="../logouterror.jsp" %>
    <%
      session.invalidate();
         request.getSession(true).setAttribute("lang",defLangId);
          }
 
else
{

	VLRManager vlrManager = new VLRManager();
	VLR vlr = new VLR();
	int i  = -1;

  String id = request.getParameter("id");
	
	String vlr_name = request.getParameter("num");
	String vlr_desc = request.getParameter("desc");
	String vlr_enable = request.getParameter("roam");
	
			
	vlr.setVlrId(vlr_name);
	vlr.setDescription(vlr_desc);
			
			if (vlr_enable == null) vlr_enable = "N";
					vlr.setEnabled(vlr_enable);


	if(id.equals("mod"))  //modify VLR
	{
		logger.info("webadmin/VLRManager: modifying vlr");	
		i = vlrManager.modifyVLRConfig(vlr);
	}

	else if(id.equals("del")) //delete VLR
	{
		logger.info("webadmin/VLRManager: delete vlr");	
		 i = vlrManager.delVLRConfig(vlr);
	}

	if(i == 0) //modify
	{
%>
		<script language="JavaScript">
			alert("VLR Configuration modified successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	if(i == 2)// delete
	{
%>
		<script language="JavaScript">
			alert("VLR Configuration Deleted successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -1)
	{
%>
		<script language="JavaScript">
			alert("Error!!! Please try again")
			history.go(-1)
		</script>
<%
	}
}
%>
