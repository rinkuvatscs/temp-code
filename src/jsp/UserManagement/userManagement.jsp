
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %> 
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(150))
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
		AdminUserManager adminManager = new AdminUserManager();
                 adminManager.setConnectionPool(conPool);
		AdminUser adminUser = new AdminUser();
    ArrayList adminUserAl = new ArrayList();
				RoleTypeManager roleManager = new RoleTypeManager();
                     roleManager.setConnectionPool(conPool);
				ArrayList roletypeAl = new ArrayList();
    
		int i = -1;
    int pageId = -1;
    int pageCount = 0;
		int start = -1;
		int end = -1;
	  pageId = Integer.parseInt(request.getParameter("pid"));
  

		String userName = request.getParameter("userName");
		if( userName != null && !userName.equalsIgnoreCase("") )
			{
			  String action = "user";
				adminUser.setUserId(action);
			}
			int roleId = Integer.parseInt( request.getParameter("roleId") );
							
			adminUser.setUserName(userName);
			adminUser.setRoleId(roleId);
        
	//	 if(pageId == 0)
	//	 {
		i = adminManager.getUserData(adminUserAl, adminUser);  // roleId=0 for getting data of all users.
	// }
//		 else
       if(pageId != 0)
	 {
	//	i = adminManager.getUserData(adminUserAl, adminUser);  // roleId=0 for getting data of all users.
		i =1;
	 }
				 
				int x = roleManager.getRoleTypes(roletypeAl);
				 if(i > 0 || adminUserAl != null || pageId != -1)   
				 {
					 pageCount = adminUserAl.size()/10;

%>
<html>
<head>
<Script Language="JavaScript">
    function validate() 
		{
        var chkbox = document.forms.form.delUser
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
            alert("<%=TSSJavaUtil.instance().getKeyValue("alonedel",defLangId)%>")
            return false
        }
        return confirm("<%=TSSJavaUtil.instance().getKeyValue("aldelsure",defLangId)%>?")
    }
</script>
</head>

<%@ include file = "../pagefile/header.html" %>

     <form name="form" method="post" action="deleteUser.jsp" onSubmit="return validate()">
         <table width="90%" border="0" align="center" cellpadding="2" cellspacing="5">
				 
        		<tr class="tableheader"><td colspan="5"><%=TSSJavaUtil.instance().getKeyValue("umTop",defLangId)%> - <%=TSSJavaUtil.instance().getKeyValue("searchResult",defLangId)%><BR><BR></td></tr>
	<%
						if( i == -1 || pageId <0 )
						{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("error1",defLangId)%>.<br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
						}
					  else if( adminUserAl.size() == 0 )
						{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%><br><a href="home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
						}
						else if( adminUserAl.size() < 0 || adminUserAl == null )
						{
	%>			 
	       <tr class="notice"><td colspan="6"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%><br><a href="../home.jsp"><%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%></a></p></td></tr>
<%
						}
						else
						{
%>						
            <tr class="tfields" >
              <td width="40%"><%=TSSJavaUtil.instance().getKeyValue("umUser",defLangId)%></td>
              <td width="40%"><%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%></td>
              <td width="9%"><%=TSSJavaUtil.instance().getKeyValue("view",defLangId)%></td>
<%
        if( sessionHistory.isAllowed(151))
        {
%>
              <td ><%=TSSJavaUtil.instance().getKeyValue("modify",defLangId)%> </td>
<%
        }
        if( sessionHistory.isAllowed(152))
        {
%>
              <td ><%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%></td>
<%
        }
%>
        </tr>
<%
          Object adminUserArr[] = adminUserAl.toArray();
            start = (pageId *10) + 1;
            end = ((start+10) > adminUserArr.length)? (adminUserArr.length): (start+9) ;
          for(int r=start; r<=end; r++)
          {
%>
            <tr   <%if ( (r % 2) == 0){ %> class="rowcolor1"<%} else {%> class="rowcolor2" <%}%>   >
              <td align="left"><%=((AdminUser)adminUserArr[r-1]).getUserName() %> </td>
	      <td  class="tfield">
		<%
			for(int j=0; j<roletypeAl.size(); j++)
			{
			RoleType roleType = (RoleType) roletypeAl.get(j);
			if( ((AdminUser)adminUserArr[r-1]).getRoleId() == roleType.getRoleId() ) 
			{
				out.print(roleType.getRoleName());
				break;
			}
			}
		%>
		</td>              
              <td ><a href="user_view.jsp?userName=<%=((AdminUser)adminUserArr[r-1]).getUserName()%>"><img src="../images/view.gif" height="20" border="0"></a> </td>
<%
            if( sessionHistory.isAllowed(151))
            {
%>
              <td ><a href="user_modify.jsp?userName=<%=((AdminUser)adminUserArr[r-1]).getUserName()%>"><img src="../images/modify.gif" height="20" border="0"></a> </td>
<%
            }
            if( sessionHistory.isAllowed(152))
            {
%>
              <td >  <input type="checkbox" name="delUser" value="<%=((AdminUser)adminUserArr[r-1]).getUserName()%>"> </td>
<%
            }
%>
          </tr>
<%
            }
            if(sessionHistory.isAllowed(152))
            {
%>
            <tr class="button1">
	 <td colspan="5"><BR> <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("delete",defLangId)%>">
                								 <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
                </td>
            </tr>
<%
            }
				  } //for		
%>
          </table>
        </form>
		 <table border="0" width="50%" align="right">
				 <tr class="pglnk">
				  <td align="right" valign="top" width="50%">
<%            
            if( pageId >= 1 )
            {
%>
            <a href="userManagement.jsp?pid=<%=pageId-1 %>&roleId=<%=roleId%>&userName=<%=userName%>">&lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a> &nbsp;&nbsp;
<%
            }
						else
						{
%> &nbsp;&nbsp;&nbsp;&nbsp;								
<%					}
%>
          </td>
					<td align="left">
<%						
            if(pageCount > 1 || pageId < pageCount)
            {
%>
							&nbsp;&nbsp;<a href="userManagement.jsp?pid=<%=pageId+1%>&roleId=<%=roleId%>&userName=<%=userName%>"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt;</a>
<%
            }
						else
						{
%> &nbsp;&nbsp;&nbsp;&nbsp;								
										
<% 					}
 %>
          </td>
			 </tr>		
					<tr class="pagenum" >
						 <td align="center" colspan="2" >
<%			 
            if(pageCount>=1)
            {
%>
          <%=TSSJavaUtil.instance().getKeyValue("showing",defLangId)%> <%=start%> - <%=end%> <%=TSSJavaUtil.instance().getKeyValue("of",defLangId)%> <%=adminUserAl.size() %> 
<%
            }
      
%>
          	</td></tr>
		<%
	  }
			
		%>
				</table>



<%@ include file = "../pagefile/footer.html" %>
<%
    
}
%>
