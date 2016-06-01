
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%--
		Modified by Jatinder Pal
		on Jan. 11, 2006.
--%>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(190)	)
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
    RoleTypeManager roleManager = new RoleTypeManager();
   roleManager.setConnectionPool(conPool);
    ArrayList roleAl = new ArrayList();
    
		int i = roleManager.getRoleTypes(roleAl);
%>
<HTML>
<HEAD>
    <script language="JavaScript">
			function validate()
			{
				var chkbox = document.forms.form.delRole
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
					alert("<%=TSSJavaUtil.instance().getKeyValue("alselonerole",defLangId)%>")
						return false
				}
			}
</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
      
     <form name="form" method="post" action="deleteRole.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">
				
					<tr class="tableheader"><td colspan="6"><%=TSSJavaUtil.instance().getKeyValue("rtTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%> <br><br></td></tr>
          <tr class="tfields" bgcolor="#a5c7d0">
           <!-- <td width="10%">Role Id</td>-->
            <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("rtName",defLangId)%></td>
            <td width="30%"><%=TSSJavaUtil.instance().getKeyValue("desc",defLangId)%> </td>
            <td><%=TSSJavaUtil.instance().getKeyValue("view",defLangId)%></td>
				<%
					if(sessionHistory.isAllowed(192) )
					{
				%>		
            <td><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
				<%
					}
					if(sessionHistory.isAllowed(193) )
					{
				%>
            <td><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%> </td>
        <%
					}
				%>
				 </tr>
	<%
			if( i < 0 )
			{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%><br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
			}
			else if( roleAl.size() <= 0 || roleAl == null)
			{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%>.<br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
			}
			else
			{
				for (int j=0; j<roleAl.size(); j++) 
				{
					RoleType roleType = (RoleType) roleAl.get(j);
					String roleDesc =  roleType.getRoleDesc() ;
					if ( roleDesc == null || roleDesc.equals("") )
						roleDesc = "NA";
					%>
						<tr <%if ( (j % 2) == 0){ %>class="rowcolor1"<%} else {%> class="rowcolor2"<%}%>   >
						<!--<td width="10%"><%=roleType.getRoleId()%> </td>-->
						<td  align="left"><%=roleType.getRoleName().trim()%> </td>
						<td  align="left"><%=roleDesc%> </td>
						<td ><a href="roleManagement_view.jsp?id=<%=roleType.getRoleId()%>&name=<%=roleType.getRoleName().trim()%>"><img src="../images/view.gif" border="0"></a> </td>
						<%
						if(sessionHistory.isAllowed(192) )
						{
							%>		
								<td ><a href="roleManagement_modify.jsp?id=<%=roleType.getRoleId()%>&name=<%=roleType.getRoleName().trim()%>"><img src="../images/modify.gif" border="0"></a> </td>
								<%
						}
					if(sessionHistory.isAllowed(192) )
					{
						%>		
							<td >  <input type="checkbox" name="delRole" value="<%=roleType.getRoleId()%>"> </td>
							<%
					}
					%>	
						</tr>
						<%
				} // for loop
				%>
					<%
					if(sessionHistory.isAllowed(192) )
					{
						%>		
							<tr class="button1">
							<td colspan="6"><br>   <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%>">
							<input type="reset" name="Clear"			value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
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
