<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
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
	vlr.setVlrId(request.getParameter("num").toUpperCase());
	vlr.setDescription(request.getParameter("desc"));

	String enable = request.getParameter("roam");
	if (enable == null) enable = "N";

	vlr.setEnabled(enable);
	int i = vlrManager.addVLRConfig(vlr);
	if(i == 0)
	{
%>
		<script language="JavaScript">
			alert("VLR Configuration added successfully!!")
			window.location="home.jsp"
		</script>
<%
	}
	else if (i == -2)
	{
%>
		<script language="JavaScript">
			alert("A VLR with the name already exist, please select different name")
			history.go(-1)
		</script>
<%
	}
	else 
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
