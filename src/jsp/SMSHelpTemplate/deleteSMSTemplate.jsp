
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(302))
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
		SMSTemplateManager smsManager = new SMSTemplateManager();
        smsManager.setConnectionPool(conPool);
   	TemplateSMS smsTemplate = new TemplateSMS();
				
    int templateId = Integer.parseInt(request.getParameter("tid") );
    int templateType = Integer.parseInt(request.getParameter("ttype") );
    int language = Integer.parseInt( request.getParameter("languageId") );
    
		smsTemplate.setTemplateId(templateId);
		smsTemplate.setTemplateType(templateType);
		smsTemplate.setLanguage(language);
		
		
    int i = smsManager.deleteTemplateSMS(smsTemplate);

    if(i > 0)
    {
%>
        <script language="JavaScript">
            alert("<%=TSSJavaUtil.instance().getKeyValue("alsmsdel",defLangId)%>!!");
            window.location="smsTemplate.jsp?pid=0&languageId=1";
        </script>
<%
    }
    else
    {
%>
        <script language="JavaScript">
            alert("Error!!!  <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
            window.location="../home.jsp";
        </script>
<%
    }
}
%>
