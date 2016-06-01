
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("RatePlanlogs.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
//if(sessionHistory == null || !sessionHistory.isAllowed(1))
if(sessionHistory == null || !sessionHistory.isAllowed(2072))
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
		//						String order="";
								int searchId=0;
								String keywords="";
								searchtext = request.getParameter("srchtext");
								searchId =Integer.parseInt(request.getParameter("searchId"));
								keywords ="RatePlanModify";
									WebAdminLogManager weblogs  = new WebAdminLogManager();
                           weblogs.setConnectionPool(conPool);		 
				WebAdminLog webobj  = new WebAdminLog();		 
        ArrayList logscode= new ArrayList();

								int i = -1;
								int pageId = -1;
								int pageCount = 0;

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
																								i = weblogs.getLog (logscode,keywords);
																								logger.info("webadmin/RbtRatePlan: logscode size= "+ logscode.size() );

																}
								else 
								{
																								i = weblogs.getLog (logscode,keywords);
																//								i=1;
								}
								if(( logscode != null || pageId != -1) && logscode.size()!=0)    
								{
																pageCount = logscode.size()/10;
																%>
<!--
																								<form name="form1" method="post" action="rateplan_manage.jsp" >

																								<input type=hidden name="pid" value="0">
																								<input type=hidden name="searchId" value="0">
																							<input type=hidden name="keywords" value="PLAN_INDICATOR">
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
-->
																								<form name="form" method="post" action="DeleteRatePlan.jsp" onSubmit="return validate()">
																								<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
																								<tr class="tableheader"><td colspan="4">Crbt Rate Plan Management - Logs <br> <br> </td></tr>
																								<%
																								if(i < 0 || pageId < 0)
																								{
																																%>
																																								<tr class="notice"><td colspan="5">There is some Error. Please Try Later!!! </td></tr>
																																								<%
																								}
																								else if(logscode.size() < 0 || logscode == null)
																								{
																																%>
																																								<tr class="notice"><td colspan="5">Data Not Found. Please Try Later!!! </td></tr>
																																								<%
																								}
																								else if( logscode.size() > 0)
																								{
																																%>
																																								<tr class="tfields" bgcolor="#a5c7d0">
																																								<td width="40%" >Updated Value Name </td>
																																								<td width="40%" >Previous Value </td>

																																								<td width="20%" >Current Value </td>
																																																								<td > Updated By</td>
																																																<td >Date </td>
																																								</tr>
																																								<%
																																Object chargecodeArr[] = logscode.toArray();
																																int start = (pageId *10) + 1;
																																int end = ((start+10) > chargecodeArr.length)? (chargecodeArr.length): (start+9) ;
																																for(int r=start; r<=end; r++)
																																{
																																								%>
																																																<tr		 <%if ( (r % 2) == 0){ %> class="rowcolor1"<%} else {%> class="rowcolor2" <%}%>   >
																																																<td align="left"><%= ((WebAdminLog)chargecodeArr[r-1]).getColName() %> </td>
																																																<td align="left"><%= ((WebAdminLog)chargecodeArr[r-1]).getPreviousvalue() %> </td>
																																																<td ><%= ((WebAdminLog)chargecodeArr[r-1]).getCurrentvalue() %></td>
																																																<td ><%= ((WebAdminLog)chargecodeArr[r-1]).getuser()%> </td>
																																																<td ><%=((WebAdminLog)chargecodeArr[r-1]).getDate()%> </td>
																																																</tr>
																																																<%
																																}
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
																																								<a href="rateplan_manage.jsp?pid=<%=pageId-1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&searchId=0">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a> &nbsp;&nbsp;
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
																																																																<a href="rateplan_manage.jsp?pid=<%=cnt-1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&searchId=0"><%=cnt%></a>
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
																																																								&nbsp;&nbsp;<a href="rateplan_manage.jsp?pid=<%=pageId+1%>&keywords=<%=keywords%>&srchtext=<%=searchtext%>&searchId=0"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt;</a>
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
																								<tr class="tableheader"><td colspan="4">Crbt Rate Plan Management - Logs <br> <br> </td></tr>
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
