
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(290))
{
%>
		<%@ include file="../logouterror.jsp" %>
<%
}
else
{
   			KeywordParserManager keywordManager = new KeywordParserManager();
             keywordManager.setConnectionPool(conPool);
        KeywordParser keywordParser = new KeywordParser();
        
    		ArrayList keywordParserAl = new ArrayList();
				
				String keyword = request.getParameter("keyword");
        int i = keywordManager.getKeywordDetail (keywordParserAl,keyword);
%>

<%@ include file = "../pagefile/header.html" %>

      <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
            <tr class="tableheader"><td colspan="2">Keyword Parser Management - View Keyword <br><br></td></tr>
						<%
						if(i<0 || keywordParserAl.size()<=0)
						{
						%>
						<tr class="notice"><td colspan="2"> There is some ERROR, Please Try Later.</td></tr>
						<%
						}
						else
						{
										for( int l = 0;l< keywordParserAl.size();l++)
														keywordParser = (KeywordParser) keywordParserAl.get(l);
						%>
             <tr class="tfield">
                 <td class="tfield1">Keyword </td>
                 <td > <%=keyword%> </td>
             </tr>
             <tr class="tfield">
                  <td class="tfield1">Process </td>
                  <td width="65%"> <%=keywordParser.getProcessName()%> </td>
             </tr>
             <tr class="tfield">
                  <td class="tfield1" >Min Arguments </td>
                  <td > <%=keywordParser.getMinArgument()%></td>
             </tr>
             <tr class="tfield">
                  <td class="tfield1" >Max Arguments </td>
                  <td > <%=keywordParser.getMaxArgument()%></td>
             </tr>
             <tr class="tfield">
                  <td class="tfield1" >Syntax Message </td>
                  <td > <%=keywordParser.getSyntaxMessage()%></td>
             </tr>
             <tr class="tfield">
                  <td class="tfield1" >Description </td>
                  <td > <%=keywordParser.getDesc()%> </td>
             </tr>
           <%
						} //else
					 %>
<tr class="tfield">
<td class="tfield1"><td>
<td class="tfield1">	
<INPUT TYPE="button" VALUE="Back" onClick="history.go(-1);return true;">
</td>
</tr>
            </table>
<%@ include file = "../pagefile/footer.html" %>
<%
}

%>
