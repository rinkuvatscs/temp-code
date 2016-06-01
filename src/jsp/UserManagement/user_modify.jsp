
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

 <%@ include file = "../conPool.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory == null || !sessionHistory.isAllowed(151))
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

				ArrayList roletypeAl = new ArrayList();
				int i = roleManager.getRoleTypes(roletypeAl);
				
				AdminUserManager adminManager = new AdminUserManager();
                                adminManager.setConnectionPool(conPool);
				AdminUser adminUser = new AdminUser();
				ArrayList adminUserAl = new ArrayList();
		
				String userName = request.getParameter("userName");
				int roleId = 0;
				String action="view";
				adminUser.setRoleId(roleId);
				adminUser.setUserName(userName);
				adminUser.setUserId(action);
				
				int k = adminManager.getUserData (adminUserAl, adminUser); //  (ArrayList,adminUser )to get data for userName
				
%>
<html>
<head>
<script type="text/javascript">
    function validate()
    {
      var userName = document.forms.form.userName.value = document.forms.form.userName.value.trim()
      var password = document.forms.form.password.value = document.forms.form.password.value.trim()
      var confpassword = document.forms.form.confpassword.value = document.forms.form.confpassword.value.trim()
      var email = document.forms.form.email.value = document.forms.form.email.value.trim()
      var mobilenum  = document.forms.form.mobilenum.value = document.forms.form.mobilenum.value.trim()
          var ValidChars = "0123456789";
          var Char;
          if(userName=="")
          {
                    alert(" <%=TSSJavaUtil.instance().getKeyValue("alentusr",defLangId)%>")
                    return false
          }
      if(password=="" || password.length < 8 || password.length >15 )
          {
          alert("<%=TSSJavaUtil.instance().getKeyValue("alpasschar",defLangId)%>")
	  document.forms.form.password.value = ""
	  document.forms.form.confpassword.value=""
	  document.forms.form.password.focus()
                    return false
          }
      if(confpassword==""|| confpassword.length < 8 || confpassword.length >15 )
          {
          alert("<%=TSSJavaUtil.instance().getKeyValue("alentconfpass",defLangId)%>")
	  document.forms.form.password.value = ""
	  document.forms.form.confpassword.value=""
	  document.forms.form.password.focus()
                    return false
          }
          if (password.length != confpassword.length)
          {
                    alert("<%=TSSJavaUtil.instance().getKeyValue("alnotsame",defLangId)%>")
	  document.forms.form.password.value = ""
	  document.forms.form.confpassword.value=""
	  document.forms.form.password.focus()
                    return false
          }
          else
          {
                 for(i = 0; i < password.length ; i++)
                 {
                     if (password.charAt(i) != confpassword.charAt(i))
                     {
                    alert("<%=TSSJavaUtil.instance().getKeyValue("alnotsame",defLangId)%>")
                           return false
                     }
                 }
          }
          if(email!="")
          {
                    at=email.indexOf("@")
                    if (at == -1)
                    {
                          alert("<%=TSSJavaUtil.instance().getKeyValue("alvalemail",defLangId)%>")
                          return false
                    }
          }
          if(mobilenum!="")
          {
                    for(i = 0; i < mobilenum.length ; i++)
                    {
                        Char = mobilenum.charAt(i);
                        if (ValidChars.indexOf(Char) == -1)
                        {
                            alert("<%=TSSJavaUtil.instance().getKeyValue("alvalnum",defLangId)%>")
                            return false
                        }
                    }
          }
          return true
   }
</script>
</head>

<%@ include file = "../pagefile/header.html" %>
        
     <form name="form" method="post" action="modifyAdminUser.jsp" onSubmit="return validate()">
          <table width="80%" border="0" align="center" cellpadding="2" cellspacing="4">
							<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("umTop",defLangId)%> -<%=TSSJavaUtil.instance().getKeyValue("ummodify",defLangId)%> <br><br> </td></tr>
					<%
							for(int z=0;z<adminUserAl.size();z++)
							{
								adminUser = (AdminUser) adminUserAl.get(z);
					%>						
            <tr class="tfield">
						<input type="hidden" name="userName" value="<%= adminUser.getUserName() %>">
              <td><%=TSSJavaUtil.instance().getKeyValue("umUser",defLangId)%> </td>
              <td ><input type="text" name="username" value="<%= adminUser.getUserName() %>" disabled>      </td>
            </tr>
            <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("password",defLangId)%></td>
              <td ><input type="password" name="password" maxlength=15 value="<%=adminUser.getPassword()%>">    
<input type="hidden" name="old_password" value="<%=adminUser.getPassword()%>">
   </td>
            </tr>
	  <tr><td><td class="notice">   <sup>*</sup><%=TSSJavaUtil.instance().getKeyValue("passwdconditon",defLangId)%>  </td>          </tr>
            <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("confpassword",defLangId)%> </td>
              <td ><input type="password" name="confpassword" maxlength=15 value="<%=adminUser.getPassword()%>">        </td>
            </tr>
            <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%></td>
              <td ><select name="roletype" >
<%
						    for(int j=0;j<roletypeAl.size();j++)
							    {
							        RoleType roleType = (RoleType) roletypeAl.get(j);
						        
										if( adminUser.getRoleId() == roleType.getRoleId() )  
							        {
%>
              				<option value="<%=roleType.getRoleId()%>" selected >  <%=roleType.getRoleName()%> </option>

<%
							        }
											else
											{
%>
              				 <option value="<%=roleType.getRoleId()%>">  <%=roleType.getRoleName()%> </option>
<%
											}
							    }
%>
              	  </select>
              </td>
<%
						    for(int j=0;j<roletypeAl.size();j++)
										{
																		RoleType roleType = (RoleType) roletypeAl.get(j);

																		if( adminUser.getRoleId() == roleType.getRoleId() )  
																		{
																										%>
																																		<input type="hidden" name="old_roletype" value="<%=roleType.getRoleId()%>">
																																		<% }
										}
%>



            </tr>
            <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("email",defLangId)%></td>
	      <%//if(adminUser.getEmail().equalsIgnoreCase("null") || adminUser.getEmail().equalsIgnoreCase("")){%>
       <!--       <td ><input type="text" name="email" value="" maxlength=35>   </td>-->
	      <%//}else{%>
              <td ><input type="text" name="email" value="<%=adminUser.getEmail()%>" maxlength=35> 
<input type="hidden" name="old_email" value="<%=adminUser.getEmail()%>">
  </td>
	      <%//}%>
            </tr>
            <tr class="tfield">
              <td ><%=TSSJavaUtil.instance().getKeyValue("mobile",defLangId)%></td>
	      <%//if(adminUser.getMobileNum().equalsIgnoreCase("null") || adminUser.getMobileNum().equalsIgnoreCase("")){%>
              <!--<td ><input type="text" name="mobilenum" value="" maxlength=15 onkeypress="return numberOnly(event)" > </td>-->
	      <%//}else{%>
              <td ><input type="text" name="mobilenum" value="<%=adminUser.getMobileNum() %>" maxlength=15 onkeypress="return numberOnly(event)" >
<input type="hidden" name="old_mobilenum" value="<%=adminUser.getMobileNum() %>">
 </td>
	      <%//}%>
            </tr>
            <tr class="button1">
              <td colspan="2"><br> <input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
            </tr>
			<%
							}
			%>
         </table>
      </form>


<%@ include file = "../pagefile/footer.html" %>
<%
			}
%>
