
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("smsTemplate_modify.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(301))
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
 
String smstext="";
StringTokenizer st;
int cntr=0;
        String templateDesc = request.getParameter("tkey");
       	int language = Integer.parseInt( request.getParameter("languageId"));
				String[] str=null;
        
				SMSTemplateManager smsManager = new SMSTemplateManager();
           smsManager.setConnectionPool(conPool);
				TemplateSMS templateSms = new TemplateSMS();
				ArrayList templateSmsAl = new ArrayList();
        
				
				int i = smsManager.getHelpTemplateSMS(templateSmsAl,language,templateDesc);
      
%>
<%@ include file ="../pagefile/header.html" %>

     <form method="post" action="modifySMSTemplate.jsp" name="form">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
            <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("smsTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("smsModify",defLangId)%><br><br></td></tr>
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
      			
							<input type="hidden" name="tkey" value="<%=templateDesc%>"		>
							<input type="hidden" name="languageId" value="<%=language%>" >
							 
     
		         <tr class="tfield">
                    <td width="30%" ><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%> 
                    :   <%=templateSms.getTemplateDescription()%> </td>
             </tr>
             <tr class="tfield">
<%
smstext=templateSms.getTemplateMessage();
String sp="$(";
st= new StringTokenizer(smstext,sp);
String temp="";
int checksize=-1;
int cnt=0;
String fixed="";
String[] s1=new String[10];
while(st.hasMoreTokens())
{
fixed="";
checksize=-1;
temp=st.nextToken();
checksize=temp.indexOf(")");
if(checksize>0)
{
fixed=temp.substring(0,checksize+1);
s1[cnt]="$("+fixed;
cnt++;
temp=temp.substring(checksize+1);
}
s1[cnt]=temp;
cnt++;
}
%>
                    <td ><%=TSSJavaUtil.instance().getKeyValue("smsMesg",defLangId)%> </b></font></td>
              </tr>
<%
for(cntr=0;cntr<=cnt;cntr++)
{
								logger.info("cnt -"+cntr+" -  "+s1[cntr]);
								if(s1[cntr]!=null)
								{
																if(s1[cntr].startsWith("$("))
																{
																								%>
																																<tr>
																																<td ><input type="hidden" name="s<%=cntr%>" value="<%=s1[cntr]%>" ><%=s1[cntr]%> </td>
																																</tr>
																																<%
																}
																else 
																{
																								if(cntr>0)
																								{		
																																if(!s1[cntr-1].startsWith("$("))
																																{
																																								%>
																																																<tr>
																																																<td ><textarea  maxlength="70" name="s<%=cntr%>" cols="50" rows="2" >$<%=s1[cntr]%></textarea>  </td>
																																																</tr>
																																																<%
																																}
																																else
																																{
																																								%>
																																																<tr>
																																																<td ><textarea  maxlength="70" name="s<%=cntr%>" cols="50" rows="2" ><%=s1[cntr]%></textarea>  </td>
																																																</tr>
																																																<%
																																}
																								}
																								else
																								{
																																%>
																																								<tr>
																																								<td ><textarea  maxlength="70" name="s<%=cntr%>" cols="50" rows="2" ><%=s1[cntr]%></textarea>  </td>
																																								</tr>
																																								<%
																								}
																}
								}
}
if(s1[cntr-1]==null)
{
cntr=cntr-1;
}

%>
<td><input type="hidden" name=counts value=<%=cntr%>> </td>
              <tr class="button1">
                  <td colspan="2"><br>
                      <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">
                      <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
                  </td>
              </tr>
					<%
											}
							}
					%>		
       
			    </table>
       </form>

<%@ include file = "../pagefile/footer.html" %>
<%

}

%>
