
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("modifySMSTemplate.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(301))
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
    int smscntr = Integer.parseInt(request.getParameter("counts") );
    String templateType = request.getParameter("ttype");
    String description = request.getParameter("tdesc");
    String message ="";// request.getParameter("tmsg");
    int language = Integer.parseInt( request.getParameter("languageId") );

for(int i =0;i<smscntr;i++)
{
//request.getParameter("s"+i);
message=message+request.getParameter("s"+i);
}
logger.info(message);

    
		smsTemplate.setTemplateId(templateId);
		smsTemplate.setTemplateType(templateType);
		smsTemplate.setTemplateDescription(description);
		smsTemplate.setTemplateMessage(message);
		smsTemplate.setLanguage(language);
		
		int i = smsManager.updateTemplateSMS  (smsTemplate);
    
		if(i > 0)
    {
%>
        <script language="JavaScript">
            alert("<%=TSSJavaUtil.instance().getKeyValue("alsmsmodi",defLangId)%>!!");
            window.location="smsTemplate.jsp?pid=0&languageId=1&ordrby=0&srchId=0&srchtxt=";
        </script>
<%
    }
    else
    {
%>
        <script language="JavaScript">
            alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
            window.location="../home.jsp";
        </script>
<%
    }
}
%>
