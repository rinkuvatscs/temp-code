<%@ page import = "com.telemune.webadmin.webif.*" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
<HTML>
<HEAD>
<TITLE>VLR Configuration - Add</TITLE>
<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<script type="text/javascript">
function validate()
{
	var  num = document.forms.form1.num.value;
	var ValidChars = "0123456789";
	var Char;
	if(num =="")
	{
		alert("Please enter the VLR Id")
		document.forms.form1.num.focus()
		return false
	}
	for (i = 0; i < num.length ; i++)
	{
		Char = num.charAt(i);
		if (ValidChars.indexOf(Char) == -1)
		{
			alert("VLR Number should contain only digits ")
			return false
		}
	}
	return true;
 }
</script>
</HEAD>
<%@ include file = "../pagefile/header.html" %>

  <form name="form1" method="post" action="addVLR.jsp" onSubmit="return validate()">
   
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader"> VLR Configuration - Add <br><br></td>	 </tr>
			 <tr class="tfields">      
					 <td width="20%">VLR Name  </td>
           <td align="left"> <input type="text" name="num" maxlength="20">   </td>
       </tr>
       <tr class="tfields">
           <td width="20%"> Description </td>
           <td align="left"><input type="text" name="desc" maxlength="100"> </td>
       </tr>
       <tr class="tfields">
           <td width="20%">Enabled </td>
           <td height="20" align="left"><input type="checkbox" name="roam" value="A"></td>
       </tr>
       <tr class="button1">
           <td colspan="2" > <input type="submit" name="submit" value="Submit"> <input type="reset" name="clear" value="Clear"> </td>
       </tr>
     </table>
  
	 </form>
        <script language="JavaScript">
		<!--
		document.form1.num.focus();
		//-->
	</script>
<%@ include file = "../pagefile/footer.html" %>  
<%
}
%>
