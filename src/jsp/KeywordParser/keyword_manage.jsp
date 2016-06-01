
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
  <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("keyword_manage.jsp");
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
								String order="";
								int searchId=0;
								searchtext = request.getParameter("srchtext");
								searchtext = searchtext.toUpperCase();
								order = request.getParameter("order");
								searchId =Integer.parseInt(request.getParameter("searchId"));
								if(searchId==1)
								{
																if(order.equals("ASC"))
																{
																								order="DESC";
																}
																else
																{
																								order="ASC";
																}
								}
								else
																order="ASC";	
								KeywordParserManager keywordManager = new KeywordParserManager();
                                    keywordManager.setConnectionPool(conPool);
								KeywordParser keyParser = new KeywordParser();

								ArrayList keywordParserAl = new ArrayList();

								int i = -1;
								int pageId = -1;
								int pageCount = 0;
								//String keyword = "X";

								pageId = Integer.parseInt(request.getParameter("pid"));
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
																<%if(pageId == 0)
																{
																								i = keywordManager.getKeywordParser (keywordParserAl,searchtext,order);
																								logger.info("webadmin/KeywordParser: keywordParserAl size= "+ keywordParserAl.size() );

																}
								else 
								{
																i = keywordManager.getKeywordParser (keywordParserAl,searchtext,order);
																//								i=1;
								}
								if(( keywordParserAl != null || pageId != -1) && keywordParserAl.size()!=0)    
								{
																pageCount = keywordParserAl.size()/10;
																%>

																								<form name="form1" method="post" action="keyword_manage.jsp" >

																								<input type=hidden name="pid" value="0">
																								<input type=hidden name="searchId" value="0">
																								<!--<input type=hidden name="srchtext" value=<%=searchtext%>>-->
																								<input type=hidden name="order" value=<%=order%>>
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






																								<form name="form" method="post" action="deleteKeyword.jsp" onSubmit="return validate()">
																								<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
																								<tr class="tableheader"><td colspan="4">Keyword Parser Management - Search Results <br> <br> </td></tr>
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
																																								<tr class="tfields" bgcolor="#a5c7d0">
																																								<td width="40%" ><a href="keyword_manage.jsp?pid=0&srchtext=<%=searchtext%>&order=<%=order%>&searchId=1">Keyword</a> </td>
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
																								}
																%>

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
																								<table align=right width=90% border=0>
																								<tr align=right>
																								<td>
																								<%            
																								if( pageId >= 1 )
																								{
																																%>
																																								<a href="keyword_manage.jsp?pid=<%=pageId-1%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a> &nbsp;&nbsp;
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
																																																																<a href="keyword_manage.jsp?pid=<%=cnt-1%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0"><%=cnt%></a>
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
																																																								&nbsp;&nbsp;<a href="keyword_manage.jsp?pid=<%=pageId+1%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt;</a>
																																																								<%
																																								}
																																								else
																																								{
																																																%> &nbsp;&nbsp;&nbsp;&nbsp;								

																																																<% } %>
																																																</td>
																																																</tr>	
<tr class="homemenu"><td></td><td><a href="home.jsp">Back</a></td></tr>	
																																																</table>

																																																<%
								}
								else
								{
																%>
																								<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
																								<tr class="tableheader"><td colspan="4">Keyword Parser Management - Search Results <br> <br> </td></tr>
																								<tr class="tableheader">
																								<td colspan="4">0 Data found</td>
																								</tr>
																								</table>
																								<% } %>
																</form>
																<%@ include file = "../pagefile/footer.html" %>

																<%
}
%>
