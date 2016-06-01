
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("keyword_manage_back.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
//if(sessionHistory == null || !sessionHistory.isAllowed(1))
if(sessionHistory == null || !sessionHistory.isAllowed(290))
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

String searchtext="";
searchtext = request.getParameter("srchtext");
int language = Integer.parseInt(request.getParameter("languageId"));
   KeywordParserManager keywordManager = new KeywordParserManager();
   keywordManager.setConnectionPool(conPool);
	 KeywordParser keyParser = new KeywordParser();

    ArrayList keywordParserAl = new ArrayList();
	  
    int i = -1;
    int pageId = -1;
    int pageCount = 0;
		String keyword = "X";
   
    pageId = Integer.parseInt(request.getParameter("pid"));
   
   if(pageId == 0)
    {
        i = keywordManager.getKeywordParser (keywordParserAl,keyword);
				logger.info("webadmin/KeywordParser: keywordParserAl size= "+ keywordParserAl.size() );
				
    }
    else 
    {
        i = keywordManager.getKeywordParser (keywordParserAl,keyword);
        i=1;
     }
    if(i > 0 || keywordParserAl != null || pageId != -1)   
		{
				pageCount = keywordParserAl.size()/10;
%>

<html>
<head>
<script language="JavaScript">
    function validate() 
		{
						var chkbox = document.forms.form.keyword
						var allunchecked = true
						for (i=0 ;i<chkbox.length;i++)
						 {
								if(chkbox[i].checked == true)
								 {
												allunchecked = false
												break
						  	 }
						}
						if (chkbox.length == undefined) 
						 {
										if(chkbox.checked == true)
										allunchecked = false
						}
						if( allunchecked == true) 
						{
										alert("Please select atleast one keyword  to delete")
										return false
						}
						
						return confirm("Are you sure you want to delete the selected keyword(s) ?")
		}
</script>
</head>

<%@ include file = "../pagefile/header.html" %>

     <form name="form" method="post" action="deleteKeyword.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
        	<tr class="tableheader"><td colspan="5">Keyword Parser Management - Search Results <br> <br> </td></tr>
<%
    	if(i < 0 || pageId < 0)
    	{
%>
      <tr class="notice"><td colspan="5">There is some Error. Please Try Later!!! </td></tr>
<%
			}
			else if(keywordParserAl.size() < 0 || keywordParserAl == null)
			{
%>
      <tr class="notice"><td colspan="5">Data Not Found. Please Try Later!!! </td></tr>
<%
			}
			else if( keywordParserAl.size() > 0)
			{
%>
<tr>
<td >Search:</td><td align="right" > <input type="text" name="srchtext" size=20> </td>
</tr>
<tr>
			<td colspan="2" ></td><td align="right" > <input type="submit" name="submit" value="Go">  
</td>
</tr>

</table>
		</form>
</td></tr>
<tr><td>
          <tr class="tfields" bgcolor="#a5c7d0">
       	     <td width="40%" ><a href="keyword_manage.jsp?pid=<%=pageId%>&languageId=<%=language%>&srchtext=<%=searchtext%>">Keyword</a> </td>
             <td width="20%" >View </td>
<%
            if( sessionHistory.isAllowed(291))
            {
%>
              <td > Modify</td>
<%
            }
            if( sessionHistory.isAllowed(293))
            {
%>
              <td >Delete </td>
<%
            }
%>
         </tr>
<%
            Object keywordParserArr[] = keywordParserAl.toArray();
            int start = (pageId *10) + 1;
            int end = ((start+10) > keywordParserArr.length)? (keywordParserArr.length): (start+9) ;
            for(int r=start; r<=end; r++)
            {
%>
          <tr		 <%if ( (r % 2) == 0){ %> class="rowcolor1"<%} else {%> class="rowcolor2" <%}%>   >
              <td align="left"><%= ((KeywordParser)keywordParserArr[r-1]).getRequestKeyword() %> </td>
              <td ><a href="keyword_view.jsp?keyword=<%= ((KeywordParser)keywordParserArr[r-1]).getRequestKeyword() %>"><img src="../images/view.gif" height="20" border="0"></a> </td>
<%
                if( sessionHistory.isAllowed(291))
                {
%>
              <td ><a href="keyword_modify.jsp?keyword=<%= ((KeywordParser)(keywordParserArr[r-1])).getRequestKeyword().trim() %>"><img src="../images/modify.gif"height="20" border="0"></a> </td>
<%
                }
                if( sessionHistory.isAllowed(293))
                {
%>
              <td ><input type="checkbox" name="keyword" value="<%=((KeywordParser)(keywordParserArr[r-1])).getRequestKeyword()%>"></td>
<%
                }
%>          
         </tr>
<%
            }
%>

<table align=right width=90% border=0>
<tr align=right>
<td>
<%            
            if( pageId >= 1 )
            {
%>
            <a href="keyword_manage.jsp?pid=<%=pageId-1%>&languageId=<%=language%>&srchtext=<%=searchtext%>">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a> &nbsp;&nbsp;
<%
            }
	    else
	    {
%> &nbsp;&nbsp;&nbsp;&nbsp;								
<%	    }
%>
          </td>
  <td align ="center" width=70%>      
<%
   for(int cnt = 1; cnt <= pageCount; cnt++)
			{
											if((pageId+1)==cnt)
											{
																			%>
																											<%=cnt%>
																											<%
											}
											else
											{
																			%>
																											<a href="keyword_manage.jsp?pid=<%=cnt-1%>&languageId=<%=language%>&srchtext=<%=searchtext%>"><%=cnt%></a>
																											<%

											}
											if(cnt<pageCount)
											{
																			%>,<%
											}

			}
%>
     </td>
	<td align="left">
<%						
         if(pageCount > 1 && pageId < pageCount)
            {
%>
	&nbsp;&nbsp;<a href="keyword_manage.jsp?pid=<%=pageId+1%>&languageId=<%=language%>&srchtext=<%=searchtext%>"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt;</a>
<%
            }
            else
	    {
%> &nbsp;&nbsp;&nbsp;&nbsp;								
										
<% } %>
          </td>
   </tr>		
</table>
















<%
            if( sessionHistory.isAllowed(293))
            {
%>
          <tr class="button1">
            <td colspan="5" ><br>  <input type="submit" name="submit" value="Delete"> <input type="reset" name="Clear" value="Clear">  </td>
           </tr>
<%
            }
%>
          </table>
        </form>
<!--        <table border="0" width="50%" align="right">
				 <tr class="pglnk">
				  <td align="right" valign="top" width="50%">
<%            
            if( pageId >= 1 )
            {
%>
            <a href="keyword_manage.jsp?pid=<%=pageId-1 %>">&lt;&lt; Previous</a> &nbsp;&nbsp;
<%
            }
						else
						{
%> &nbsp;&nbsp;&nbsp;&nbsp;								
<%						}
%>
          </td>
					<td align="left">
<%						
            if(pageCount > 1 && pageId < pageCount)
            {
%>
							&nbsp;&nbsp;<a href="keyword_manage.jsp?pid=<%=pageId+1 %>">Next &gt;&gt;</a>
<%
            }
						else
						{
%> &nbsp;&nbsp;&nbsp;&nbsp;								
										
<% } %>
          </td>
			 </tr>		
					<tr class="pagenum" >
						 <td align="center" colspan="2" >
<%			 
            if(pageCount>1)
            {
%>
           		Showing <%=start%> - <%=end%> of <%=keywordParserAl.size() %> 
<%
            }
      }
%>
          	</td></tr>
	<%
	  } 
	%>
				</table>
-->
<%@ include file = "../pagefile/footer.html" %>
<%
}
%>
