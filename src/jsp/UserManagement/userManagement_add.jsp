
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(153))
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
		ArrayList roleTypesAl = new ArrayList();

		int i = roleManager.getRoleTypes(roleTypesAl);
		
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
          alert("<%=TSSJavaUtil.instance().getKeyValue("alentusr",defLangId)%>")
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
                    alert("<%=TSSJavaUtil.instance().getKeyValue("alvalnum",defLangId)%> ")
                    return false
                }
        }
    }
    return true
  }
</script>

</head>

<%@ include file ="../pagefile/header.html" %>

    <form name="form" method="post" action="addUser.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
          <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("umaddTop",defLangId)%><br><br> </td></tr>
    	<%
			   if ( i < 0 )
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%></p> </td>
				 </tr>			
			<%
					}
			   else if ( roleTypesAl.size() <= 0)
					 {
			%>						 
         <tr class="notice">
				      <td colspan="2" align="center"><p><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%>.<a href="../RoleManagement/roleManagement_add.jsp"> <%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%> </a></p> </td>
				 </tr>			
			<%
					}
					else
					{
			%>	
		
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("umUser",defLangId)%></td>
             <td ><input type="text" name="userName" maxlength=15 >    </td>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("password",defLangId)%></td>
             <td ><input type="password" name="password" maxlength=15 ></td></tr>
	  <tr><td><td class="notice">   <sup>*</sup><%=TSSJavaUtil.instance().getKeyValue("passwdconditon",defLangId)%> </td>  </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("confpassword",defLangId)%> </td>
             <td ><input type="password" name="confpassword" maxlength=15>       </td>
          </tr>
          <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("umRole",defLangId)%> </td>
              <td ><select name="roleType" >
             <%
								for(int j=0;j<roleTypesAl.size();j++)
								{
												RoleType roleType = (RoleType) roleTypesAl.get(j);
							%>
											<option value="<%=roleType.getRoleId()%>" > <%=roleType.getRoleName()%> </option>
							<%
								}
							%>
                </select>
              </td>
           </tr>
           <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("email",defLangId)%></td>
              <td ><input type="text" name="email" Maxlength=35 >   </td>
            </tr>
           <tr class="tfield">
             <td ><%=TSSJavaUtil.instance().getKeyValue("mobile",defLangId)%></td>
              <td ><input type="text" name="mobilenum"  maxlength=15 onkeypress="return numberOnly(event)" >       </td>
           </tr>
           <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"> <input type="reset" name="Clear" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
	}
%>
