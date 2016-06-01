
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if (sessionHistory == null || !sessionHistory.isAllowed(302)) 
{
%>
<%@ include file ="../logouterror.jsp" %>
<%
}
else
{
    %>
    <%@ include file="../lang.jsp" %>
    <%

		SMSTemplateManager smsManager = new SMSTemplateManager();
           smsManager.setConnectionPool(conPool);
   	TemplateSMS smsTemplate = new TemplateSMS();
				
 //   int templateType =Integer.parseInt( request.getParameter("ttype"));
      int templateType = 10;      // template type is 10 by default				
		
    String description = request.getParameter("desc").toUpperCase().trim();
    String message = request.getParameter("mesg").trim();
    String token = request.getParameter("token").trim();    
    int language =Integer.parseInt( request.getParameter("languageId"));
   
		smsTemplate.setTemplateDescription(description);
		smsTemplate.setTemplateType(templateType);
		smsTemplate.setTemplateMessage(message);
		smsTemplate.setTokensAllowed(token);
		smsTemplate.setLanguage(language);
	   

    int i = smsManager.addTemplateSMS (smsTemplate);
		
    if(i < 0)
    {
						if(i == -2)
						{

%>
        <script language="JavaScript">
            alert("<%=TSSJavaUtil.instance().getKeyValue("alsmstempalready",defLangId)%>")
            window.location="smsTemplate_add.jsp";
        </script>
<%
						}
%>
        <script language="JavaScript">
            alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
            window.location="../home.jsp";
        </script>
<%
    }
    else if(i == 0)
    {
%>
        <script language="JavaScript">
            alert("<%=TSSJavaUtil.instance().getKeyValue("alsmsadded",defLangId)%>!!!")
            window.location="home.jsp"
        </script>
<%
    }
}
%>
