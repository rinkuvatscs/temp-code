
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import ="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>

<%
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(154))
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

<html>
<head>

<script type="text/javascript">
  function validate()
	{
									var corpName = document.forms.form.corpName.value = document.forms.form.corpName.value.trim()
									var userName = document.forms.form.userName.value = document.forms.form.userName.value.trim()
									var password = document.forms.form.password.value = document.forms.form.password.value.trim()
									var confpassword = document.forms.form.confpassword.value = document.forms.form.confpassword.value.trim()
								
								if(corpName=="")
									{
											alert("<%=TSSJavaUtil.instance().getKeyValue("alentcorp",defLangId)%>")
																	return false
									}
									else if(userName=="")
									{
									alert("<%=TSSJavaUtil.instance().getKeyValue("alentusr",defLangId)%>")
																	return false
									}
									else if(userName==corpName)
									{
						alert("<%=TSSJavaUtil.instance().getKeyValue("alnottouse",defLangId)%>")
																	return false
									}
									else if(password=="" || password.length < 8 || password.length > 15 )
									{
					alert("<%=TSSJavaUtil.instance().getKeyValue("alpasschar",defLangId)%>")
																	document.forms.form.password.value = ""
																	document.forms.form.confpassword.value=""
																	document.forms.form.password.focus()
																	return false
									}
									else if(confpassword==""|| confpassword.length < 8 || confpassword.length >15 )
									{
							alert("<%=TSSJavaUtil.instance().getKeyValue("alentconfpass",defLangId)%>")
																	document.forms.form.password.value = ""
																	document.forms.form.confpassword.value=""
																	document.forms.form.password.focus()
																	return false
									}
									else if (password.length != confpassword.length)
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

					return true
	}
</script>

</head>

<%@ include file ="../pagefile/header.html" %>

    <form name="form" method="post" action="addCorp.jsp" onSubmit="return validate()">
        <table width="80%" border="0" align="center" cellpadding="2" cellspacing="5">
          <tr class="tableheader"><td colspan="2"> Add Corporate User<br><br> </td></tr>

          <tr class="tfield">
             <td >Corporate Name </td>
             <td ><input type="text" name="corpName" maxlength=25 >    </td>
          </tr>
          <tr class="tfield">
             <td >Login Name </td>
             <td ><input type="text" name="userName" maxlength=15 >    </td>
          </tr>
          <tr class="tfield">
             <td >Password</td>
             <td ><input type="password" name="password" maxlength=9 ></td></tr>
	  			<tr>
					   <td></td>
						 <td class="notice">   <sup>*</sup>Password is 8-15 characters long   </td> 
					</tr>
          <tr class="tfield">
             <td >Confirm Password </td>
             <td ><input type="password" name="confpassword" maxlength=9>       </td>
          </tr>
				  <tr class="button1">
               <td colspan="2"><br><input type="submit" name="submit" value="Add Corporate"> <input type="reset" name="Clear" value="Clear"></td>
           </tr>
						
          </table>
					
        </form>

<%@ include file = "../pagefile/footer.html" %>
<%
 			}
%>
