
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

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
				RoleTypeManager roleManager = new RoleTypeManager();
                    roleManager.setConnectionPool(conPool);
				AdminUserManager adminManager = new AdminUserManager();
                             adminManager.setConnectionPool(conPool);
				AdminUser adminUser = new AdminUser();
		    
				ArrayList adminUserAl = new ArrayList();
				ArrayList roletypeAl = new ArrayList();
				
				String userName = request.getParameter("userName");
				int roleId = 0;
				String action="view";
				adminUser.setRoleId(roleId);
				adminUser.setUserName(userName);
				adminUser.setUserId(action);
				
				int k = adminManager.getUserData (adminUserAl, adminUser); //  (ArrayList,adminUser )to get data for userName
				
				int i = roleManager.getRoleTypes(roletypeAl);
%>
	
		<%@ include file = "../pagefile/header.html" %>
					
			<table width="80%" border="0" align="center" cellpadding="2" cellspacing="4"> 
					<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("umTop",defLangId)%> -<%=TSSJavaUtil.instance().getKeyValue("umview",defLangId)%> <br> <br></td></tr>
					<%
					for(int z=0;z<adminUserAl.size();z++)
					{
					adminUser = (AdminUser) adminUserAl.get(z);
					%>
					<tr>
				 		<td class="tfield1" width="30%"><%=TSSJavaUtil.instance().getKeyValue("umUser",defLangId)%> </td>
						<td  class="tfield"><%= adminUser.getUserName()%> </td>
					</tr>
					<tr>
						<td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%> </td>
						<td  class="tfield">
					<%
					for(int j=0; j<roletypeAl.size(); j++)
					{
						RoleType roleType = (RoleType) roletypeAl.get(j);
						if( adminUser.getRoleId() == roleType.getRoleId() ) 
						{
							out.print(roleType.getRoleName());
							break;
						}
					}
				%>
					</td>              
				</tr>
				  <tr>
						<td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("email",defLangId)%> </td>
						<td class="tfield"><%=adminUser.getEmail() %> </td>
					</tr>
					<tr class="tfield">
							<td class="tfield1"><%=TSSJavaUtil.instance().getKeyValue("mobile",defLangId)%> </td>
							<td  class="tfield"><%=adminUser.getMobileNum() %> </td>
					</tr>
<%
     }
%>					
			</table>
								

	<%@ include file = "../pagefile/footer.html" %>

<%
}
%>
