
<%@ page import="com.telemune.webadmin.webif.TSSJavaUtil"%>
<HTML>

<HEAD>
<TITLE>Login</TITLE>
<link rel=stylesheet href="pagefile/webadmin_style.css" type="text/css" > 
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" SRC="./Scripts/UtilityFunc.js" TYPE="TEXT/JAVASCRIPT"> </SCRIPT>
<script type="text/javascript">
function validate()
{
	document.forms.form1.msisdn.value = document.forms.form1.msisdn.value.trim()
	document.forms.form1.password.value = document.forms.form1.password.value.trim()
	if(document.forms.form1.msisdn.value =="")
	{
		alert("<%=TSSJavaUtil.instance().getKeyValue("allogin1")%> ")
		document.forms.form1.msisdn.focus()
		return false
	}
	if(document.forms.form1.password.value =="")
	{
		alert("<%=TSSJavaUtil.instance().getKeyValue("allogin2")%> ")
		document.forms.form1.password.focus()
		return false
	}
	return true;
}
</script>
</HEAD>

<%@ include file = "pagefile/header1.html" %>

	<form name="form1" method="post" action="login.jsp" onSubmit = "return validate()">

        <table width="70%" border="1" cellspacing="1" align="center" >
          <tr class="bluetext">
            <td colspan="2" align="center"><%=TSSJavaUtil.instance().getKeyValue("loginwel")%> </td>
          </tr>
          <tr class="bluetext">
            <td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("loginnote")%> </td>
          </tr>
          <tr class="tfields">
            <td ><%=TSSJavaUtil.instance().getKeyValue("login")%> </td>
            <td align="left"><input type="text" name="msisdn">          </td>
          </tr>
          <tr class="tfields">
            <td ><%=TSSJavaUtil.instance().getKeyValue("password")%>  </td>
            <td align="left">    <input type="password" name="password"> </td>
          </tr>
          <tr class="button1">
					  <td colspan="2">   <input type="submit" name="Submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%> "> <input type="reset" name="Submit2" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%> "> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </td>
          </tr>
        </table>
      </form>
      <script language="JavaScript">
		<!--
		document.form1.msisdn.focus();
		//-->
		</script>
      
<%@ include file = "pagefile/footer.html" %>
