
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("corpManage.jsp");
   
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(2042))
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
		  CorpManager 	corpManager = new CorpManager();
           corpManager.setConnectionPool(conPool);
			ArrayList corpAl =  new ArrayList();
      long corpid = 0; //to get all corporates  
			String corpName="all";
			int val = corpManager.getCorporateData(corpAl,corpid,corpName);     //corpid=0 and corpName="all" - to get all corporates
			logger.info(corpAl.size()+ " Corporates found()");
	%>
<HTML>
<HEAD>
    <script language="JavaScript">
			function validate()
			{
				var chkbox = document.forms.form.delCorp
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
				if( allunchecked == true) {
					alert("<%=TSSJavaUtil.instance().getKeyValue("alselat",defLangId)%>")
						return false
				}
			}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
      
     <form name="form" method="post" action="deleteCorp.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">
				
								<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("corpTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%> <br><br></td></tr>
      	<%
			if( val < 0 )
			{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%><br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
			}
			else if( corpAl.size() <= 0 || corpAl == null)
			{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%>.<br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
			}
			else
			{
%>
		 <tr class="tfields" bgcolor="#a5c7d0">
            <td width="45%"><%=TSSJavaUtil.instance().getKeyValue("corpName",defLangId)%></td>
            <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("login",defLangId)%> </td>
				<%
					if(sessionHistory.isAllowed(2042) )
					{
				%>		
            <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
				<%
					}
					if(sessionHistory.isAllowed(2043) )
					{
				%>
            <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%> </td>
        <%
					}
				%>
				 </tr>
<%
				for (int j=0; j<corpAl.size(); j++) 
				{
					CorpUser corpUser = (CorpUser) corpAl.get(j);
					%>
						<tr <%if ( (j % 2) == 0){ %>class="rowcolor1"<%} else {%> class="rowcolor2"<%}%>   >
						<%
						if(corpUser.getCorpId()==0)
						{}
						else{
					%>		
						<td  align="left"><%=corpUser.getCorpName().trim()%> </td>
						<td  align="left"><%=corpUser.getUserName().trim()%> </td>
						<%
						if(sessionHistory.isAllowed(2042) )
						{
					%>		
						<td ><a href="corp_modify.jsp?corpId=<%=corpUser.getCorpId()%>&corpname=<%=corpUser.getCorpName().trim()%>"><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%></a> </td>
					<%}
					if(sessionHistory.isAllowed(2043) )
					{
					%>
					<td >  <input type="checkbox" name="delCorp" value="<%=corpUser.getCorpId()%>"> </td>
					<%}
					}%>	
						</tr>
						<%
				} // for loop
				%>
					<%
					if(sessionHistory.isAllowed(2043) )
					{
						%>		
							<tr class="button1">
							<td colspan="6"><br>   <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%>">
							<input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
							</td>
							</tr>		
							<%
					}
			} //else 

	%>
					
      </table>
				
    </form>
<%@ include file = "../pagefile/footer.html" %>

<%
	}
%>
