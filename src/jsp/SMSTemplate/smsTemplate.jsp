
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("smsTemplate.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(300))
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
    ArrayList templateSmsAl = new ArrayList();
		//String str ="64,7,213,9,14,11,10,61,60,62,15,40,37,36,42,16,17,18,21,80,82,83,84,92,81,87,93,25,94,95,96,115,89,91,90,104,103,105,106,151,152,150,145,300,201,202,203,204";
	//	StringTokenizer st = new StringTokenizer(str,",");
	//	String[] stra = new String[st.countTokens()];
//		int s =0;
//		while(st.hasMoreTokens())
	//	{
	//	 stra[s]=st.nextToken();
	//	 s++;
	//	 }
    int i = -1;
    	  
   //int i = -1;
    int pageId = -1;
    int pageCount = 0;
int searchId=0;
int tempId=0;
int orderby=0;
String searchtext="";

   
    pageId = Integer.parseInt(request.getParameter("pid"));
    orderby = Integer.parseInt(request.getParameter("ordrby"));
    int language = Integer.parseInt(request.getParameter("languageId"));
    searchId = Integer.parseInt(request.getParameter("srchId"));
    searchtext = request.getParameter("srchtext");
  if(searchtext==null)
  searchtext="";
logger.info(searchtext+ "    "+ searchId+"     "+language +"     "+orderby+"     "+pageId);
if(searchId==4)
{
tempId=Integer.parseInt(searchtext);
}

   
    	i = smsManager.getTemplateSMS (templateSmsAl, language, searchtext,tempId,orderby,searchId);   
    if(i > 0 || templateSmsAl != null || pageId != -1)   
	{
		pageCount = templateSmsAl.size()/10;
 		
%>
<HTML>
<HEAD>
<script language="JavaScript">


    function validate2() 
    {
	    var chkbox = document.forms.form.tid
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
		    alert("<%=TSSJavaUtil.instance().getKeyValue("alselonerec",defLangId)%>")
		    return false
	    }
	    return confirm("<%=TSSJavaUtil.instance().getKeyValue("alsuretodel",defLangId)%>?")
    }
function validate1() 
{
								var srchby = document.forms.form1.srchId.value
																var srchtxt = document.forms.form1.srchtext.value
								if( srchby >0)
							{
																if( srchtxt == "")
																{
																								//alert("Please enter the value by which you want to search")
																								 alert("<%=TSSJavaUtil.instance().getKeyValue("enter_value_search",defLangId)%>")
																																return false
																}
							}
								if( srchby == 4)
								{
																var ValidChars = "0123456789"
																								for(var i = 0; i < srchtxt.length ; i++)
																								{
																																var Char = srchtxt.charAt(i);
																																if (ValidChars.indexOf(Char) == -1)
																																{
																																								alert("Please enter a valid template ID")
																																																return false
																																}
																								}

								}
								return true
}
function enbdes()
{
								var srchby = document.forms.form1.srchId.value
																if(srchby==0)
																{
																								document.forms.form1.srchtext.disabled=true;
																}
																else
																{
																								document.forms.form1.srchtext.disabled=false;
																}
}
</script>
</HEAD>
</HTML>
<%@ include file = "../pagefile/header.html" %>

      	<form name="form1" method="post" action="smsTemplate.jsp" onSubmit="return validate1()">
        <table width="100%" border="0">
<tr><td>
        <table width="100%" border="0">
           <tr class="tableheader"><td colspan="5"><%=TSSJavaUtil.instance().getKeyValue("smsTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%><br><br></td></tr>
<%  
		if(i < 0 ||  pageId < 0)
    		{
%>
	         <tr class="notice"><td colspan="5" align="center"><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%></td></tr>
<%
		}
		else if( templateSmsAl.size() <= 0 || templateSmsAl == null  )
    		{
%>
	         <tr class="notice"><td colspan="5" align="center"><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%></td></tr>
<%
		}
		else if(templateSmsAl.size()>0)
		{
		%>
<tr>
<td align ="left" width=50%>&nbsp;</td>
<td align="right" width=50%>
Search by:
     <select name="srchId" class="formField" onChange="enbdes()">
               <option value=0>view All</option>
               <option value=1>Template Message</option>
               <option value=2>Template Description</option>
               <option value=3>Template Type</option>
               <option value=4>Template ID</option>
   </select>
</td>

</tr>
<tr>
<td align ="left" width=50%>&nbsp;</td>
<td align="right" width=50%>Search : <input type="text" name="srchtext" size=20 disabled=true>  </td>
</tr>
<tr>
<td>
<input type=hidden name="ordrby" value="<%=orderby%>">
<input type=hidden name="pid" value=0>
<input type=hidden name="languageId" value="<%=language%>">

</td>
			<td align="right" colspan="5" > <input type="submit" name="submit" value="Go">  
			<input type="reset" name="Clear" value="Reset">
</td>
</tr>

</table>

		</form>
</td></tr>

<tr>  <td>
      <table width="100%" border="1"  cellpadding="2" cellspacing="2">
			<tr class="tfields" bgcolor="#a5c7d0">
				<td width="5%" ><a href="smsTemplate.jsp?pid=<%=pageId%>&languageId=<%=language%>&ordrby=0&srchId=<%=searchId%>&srchtext=<%=searchtext%>">ID</a></td>
				<td width="30%" ><a href="smsTemplate.jsp?pid=<%=pageId%>&languageId=<%=language%>&ordrby=2&srchId=<%=searchId%>&srchtext=<%=searchtext%>"><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%></a></td>
				<td width="55%"><a href="smsTemplate.jsp?pid=<%=pageId%>&languageId=<%=language%>&ordrby=1&srchId=<%=searchId%>&srchtext=<%=searchtext%>"><%=TSSJavaUtil.instance().getKeyValue("smsMesg",defLangId)%></a> </td>
				<td width="10%"><a href="smsTemplate.jsp?pid=<%=pageId%>&languageId=<%=language%>&ordrby=3&srchId=<%=searchId%>&srchtext=<%=searchtext%>">Template Type<a></td>
				<td ><%=TSSJavaUtil.instance().getKeyValue("view",defLangId)%> </td>
				<%
				if( sessionHistory.isAllowed(301))
				{
				%>
				<td ><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%></td>
				<%
				}
				%>
			</tr>
				<%
            Object templateSMSArr[] = templateSmsAl.toArray();
            int start = (pageId *10) + 1;
            int end = ((start+10) > templateSMSArr.length)? (templateSMSArr.length): (start+9) ;
            for(int r = start; r <= end; r++)
	    {
		%>
		 <input type="hidden" name="ttype" value="<%=((TemplateSMS)templateSMSArr[r-1]).getTemplateType ()%>">
		 <input type="hidden" name="languageId" value="<%=language%>" >
		<tr 
		<%if ( (r % 2) == 0){ %>class="rowcolor1"<%} else {%> class="rowcolor2"<%}%> >
			<td align="left"><%= ((TemplateSMS)templateSMSArr[r-1]).getTemplateId() %> </td>
			<td align="left"><%= ((TemplateSMS)templateSMSArr[r-1]).getTemplateDescription() %> </td>
			<td align="left"><%=((TemplateSMS)templateSMSArr[r-1]).getTemplateMessage () %> </td>
			<td align="left"><%=((TemplateSMS)templateSMSArr[r-1]).getTemplateType () %> </td>
			<td > <a href="smsTemplate_view.jsp?tid=<%=((TemplateSMS)templateSMSArr[r-1]).getTemplateId() %>&ttype=<%= ((TemplateSMS)templateSMSArr[r-1]).getTemplateType() %>&languageId=<%=language%>"><img src="../images/view.gif" height="20" border="0"></a> </td>
		<%
		if( sessionHistory.isAllowed(301))
		{
		%>
			<td ><a href="smsTemplate_modify.jsp?tid=<%=((TemplateSMS)templateSMSArr[r-1]).getTemplateId()%>&ttype=<%=((TemplateSMS)templateSMSArr[r-1]).getTemplateType()%>&languageId=<%=language%>"><img src="../images/modify.gif" height="20" border="0"></a> </td>
		<%
		}
		%>          
		</tr>
		<%
	} //for
		if( sessionHistory.isAllowed(302))
			{	
		%>
		<%
			}
		%>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<table align=right width=90% border=0>
<tr align=right>
<td>
<%            
            if( pageId >= 1 )
            {
%>
            <a href="smsTemplate.jsp?pid=<%=pageId-1%>&languageId=<%=language%>&ordrby=<%=orderby%>&srchId=<%=searchId%>&srchtext=<%=searchtext%>">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a> &nbsp;&nbsp;
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
																											<a href="smsTemplate.jsp?pid=<%=cnt-1%>&languageId=<%=language%>&ordrby=<%=orderby%>&srchId=<%=searchId%>&srchtext=<%=searchtext%>"><%=cnt%></a>
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
	&nbsp;&nbsp;<a href="smsTemplate.jsp?pid=<%=pageId+1%>&languageId=<%=language%>&ordrby=<%=orderby%>&srchId=<%=searchId%>&srchtext=<%=searchtext%>"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt;</a>
<%
            }
            else
	    {
%> &nbsp;&nbsp;&nbsp;&nbsp;								
										
<% } %>
          </td>
   </tr>		
	<tr class="pagenum" >
	 <td align="right" colspan="5" >
<%			 
            if(pageCount>1)
            {
%>
           		<%=TSSJavaUtil.instance().getKeyValue("showing",defLangId)%> <%=start%> - <%=end%> <%=TSSJavaUtil.instance().getKeyValue("of",defLangId)%> <%=templateSmsAl.size() %> 
<%
            }
%>
          	</td></tr>
	<%
      }
	  } 
	%>
</table>
<tr class="homemenu"><td></td><td><a href="home.jsp">Back</a></td></tr>
</td></tr>
</table>



	<%@ include file = "../pagefile/footer.html" %>
<%
}//else
%>
