
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(300))
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
        int templateId = Integer.parseInt(request.getParameter("tid"));
        String templateType =request.getParameter("ttype") ;
       	int language = Integer.parseInt( request.getParameter("languageId"));
				String[] str=null;
        
				SMSTemplateManager smsManager = new SMSTemplateManager();
                  smsManager.setConnectionPool(conPool);
				TemplateSMS templateSms = new TemplateSMS();
				ArrayList templateSmsAl = new ArrayList();
        
				templateSms.setTemplateId(templateId);
				templateSms.setTemplateType(templateType);
				templateSms.setLanguage(language);
				
				int i = smsManager.getTemplateSMS(templateSmsAl,language,templateType,templateId, str);
        
				
%>

<%@ include file = "../pagefile/header.html" %>	            

     <table width="80%" border="0" align="center" cellpadding="3" cellspacing="6">
            <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("smsTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("smsView",defLangId)%><br><br></td></tr>
					
					<%
					 		if(templateSmsAl.size() <= 0 || i < 0)
							{
					%>	
            <tr class="notice" > <td colspan="2" ><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%> </td>
				 <%
							}
							else
							{
											for(int x= 0; x< templateSmsAl.size(); x++)
											{
														 templateSms = (TemplateSMS) templateSmsAl.get(x);
															
				 %>			
            <tr class="tfield" >
                <td width="30%" class="tfield1" ><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%> </td>
                <td ><p> <%=templateSms.getTemplateDescription()%></p></td>
            </tr>
            <tr class="tfield">
                 <td width="30%" class="tfield1" ><%=TSSJavaUtil.instance().getKeyValue("smsMesg",defLangId)%> </td>
                 <td ><p><%=templateSms.getTemplateMessage()%></p></td>
            </tr>
            
				<%
											}
							}
				%>
						
<tr class="homemenu"><td></td><td><a href="home.jsp">Back</a></td></tr>
			</table>

<%@ include file = "../pagefile/footer.html" %>
<%
    
}
%>
