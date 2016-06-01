
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
   <%@page import = "org.apache.log4j.*" %>
<%
   Logger logger = Logger.getLogger ("rateplan_manage.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
//if(sessionHistory == null || !sessionHistory.isAllowed(1))
if(sessionHistory == null || !sessionHistory.isAllowed(2056))
{
 %>
    <%@ include file ="../logouterror.jsp" %>
         <%
         session.invalidate();
          request.getSession(true).setAttribute("lang",defLangId);
  }
else
{



								String searchtext="";
								String order="";
								int searchId=0;
								String keywords="";
								searchtext = request.getParameter("srchtext");
						//		searchtext = searchtext.toUpperCase();
								order = request.getParameter("order");
								searchId =Integer.parseInt(request.getParameter("searchId"));
								keywords =request.getParameter("keywords");
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
	
				RbtRatePlanManager rbtrateManager  = new RbtRatePlanManager();	
                        rbtrateManager.setConnectionPool(conPool);	 
				RbtRatePlan rbtrateplan  = new RbtRatePlan();		 
        ArrayList chargecode= new ArrayList();

//								KeywordParserManager keywordManager = new KeywordParserManager();
//								KeywordParser keyParser = new KeywordParser();
//								ArrayList keywordParserAl = new ArrayList();

								int i = -1;
								int pageId = -1;
								int pageCount = 0;
								//String keyword = "X";

								pageId = Integer.parseInt(request.getParameter("pid"));
								%>

																<html>
																<head>
																<script language="JavaScript">
																function checkedA()
                {
                        if((document.forms.form.keyword[0].value==1) && document.forms.form.keyword[0].checked)
                        {
                                document.forms.form.keyword[0].checked=false;
                        }
                        if((document.forms.form.keyword[1].value==2) && document.forms.form.keyword[1].checked)
                        {
                                document.forms.form.keyword[1].checked=false;
                        }
                }

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
																																alert("Please select atleast one Rate Plan to delete")
																																								return false
																								}

																								return confirm("Are you sure you want to delete the selected Rate Plan(s) ?")
																}
								</script>
																</head>

																<%@ include file = "../pagefile/header.html" %>
																<%
																if(pageId == 0)
																{
																								i = rbtrateManager.getrateplan (chargecode,keywords,order,searchtext);
																								logger.info("webadmin/RbtRatePlan: chargecode size= "+ chargecode.size() );

																}
								else 
								{
																i = rbtrateManager.getrateplan (chargecode,keywords,order,searchtext);
																//								i=1;
								}
								if(( chargecode != null || pageId != -1) && chargecode.size()!=0)    
								{
																pageCount = chargecode.size()/10;
																%>

																								<form name="form1" method="post" action="rateplan_manage.jsp" >

																								<input type=hidden name="pid" value="0">
																								<input type=hidden name="searchId" value="0">
																							<input type=hidden name="keywords" value="PLAN_INDICATOR">
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

																								<form name="form" method="post" action="DeleteRatePlan.jsp" onSubmit="return validate()">
																								<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
																								<tr class="tableheader"><td colspan="4">Crbt Rate Plan Management - Search Results <br> <br> </td></tr>
																								<%
																								if(i < 0 || pageId < 0)
																								{
																																%>
																																								<tr class="notice"><td colspan="5">There is some Error. Please Try Later!!! </td></tr>
																																								<%
																								}
																								else if(chargecode.size() < 0 || chargecode == null)
																								{
																																%>
																																								<tr class="notice"><td colspan="5">Data Not Found. Please Try Later!!! </td></tr>
																																								<%
																								}
																								else if( chargecode.size() > 0)
																								{
																																%>
																																								<tr class="tfields" bgcolor="#a5c7d0">
																																								<td width="40%" ><a href="rateplan_manage.jsp?pid=0&keywords=PLAN_INDICATOR&srchtext=<%=searchtext%>&order=<%=order%>&searchId=1">Plan Indicator</a> </td>
																																								<td width="40%" ><a href="rateplan_manage.jsp?pid=0&keywords=REMARKS&srchtext=<%=searchtext%>&order=<%=order%>&searchId=1">Remarks</a> </td>

																																								<td width="20%" >View </td>
																																								<%
																																								if( sessionHistory.isAllowed(2058))
																																								{
																																																%>
																																																								<td > Modify</td>
																																																								<%
																																								}
																																if( sessionHistory.isAllowed(2059))
																																{
																																								%>
																																																<td >Delete </td>
																																																<%
																																}
																																%>
																																								</tr>
																																								<%
																																Object chargecodeArr[] = chargecode.toArray();
																																int start = (pageId *10) + 1;
																																int end = ((start+10) > chargecodeArr.length)? (chargecodeArr.length): (start+9) ;
																																for(int r=start; r<=end; r++)
																																{
																																								%>
																																																<tr		 <%if ( (r % 2) == 0){ %> class="rowcolor1"<%} else {%> class="rowcolor2" <%}%>   >
																																																<td align="left"><%= ((RbtRatePlan)chargecodeArr[r-1]).getPlanId() %> </td>
																																																<td align="left"><%= ((RbtRatePlan)chargecodeArr[r-1]).getRemarks() %> </td>
																																																<td ><a href="rateplan_view.jsp?planId=<%= ((RbtRatePlan)chargecodeArr[r-1]).getPlanId() %>"><img src="../images/view.gif" height="20" border="0"></a> </td>
																																																<%
																																																if( sessionHistory.isAllowed(2058))
																																																{
																																																								%>
																																																																<td ><a href="rateplan_modify.jsp?planId=<%= ((RbtRatePlan)(chargecodeArr[r-1])).getPlanId()%>"><img src="../images/modify.gif"height="20" border="0"></a> </td>
																																																																<%
																																																}
																																								if( sessionHistory.isAllowed(2059))
																																								{
																																																%>
																																																								<td ><input type="checkbox" name="keyword" value="<%=((RbtRatePlan)(chargecodeArr[r-1])).getPlanId()%>" onclick="checkedA();" ></td>
																																																								<%
																																								}
																																								%>          
																																																</tr>
																																																<%
																																}
																								}
																%>

																								<%
																								if( sessionHistory.isAllowed(2059))
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
																																								<a href="rateplan_manage.jsp?pid=<%=pageId-1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous")%></a> &nbsp;&nbsp;
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
																																																																<a href="rateplan_manage.jsp?pid=<%=cnt-1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0"><%=cnt%></a>
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
																																																								&nbsp;&nbsp;<a href="rateplan_manage.jsp?pid=<%=pageId+1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&order=<%=order%>&searchId=0"><%=TSSJavaUtil.instance().getKeyValue("next")%> &gt;&gt;</a>
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
																								<tr class="tableheader"><td colspan="4">Crbt Rate Plan Management - Search Results <br> <br> </td></tr>
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
