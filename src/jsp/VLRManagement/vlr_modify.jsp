
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

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
				String vlr_name = request.getParameter("num");
%>
<HTML>
<HEAD>
<TITLE>VLR Modification </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<script type="text/javascript">

function validate()
{
	var  desc = document.forms.form1.desc.value;
	if(desc =="")
	{
		alert("Please enter the VLR Description")
		document.forms.form1.desc.focus()
		return false
	}
	return true;
 }
</script>

</HEAD>
<%@ include file = "../pagefile/header.html" %>
     
   <form name="form1" method="post" action="vlr_modify_delete.jsp?id=mod" >

			<table width="70%" align="center" border="1" cellpadding="0" cellspacing="0">
		
		   <tr>  <td colspan="2" class="tableheader"> VLR Configuration<br<br> </td></tr>
			<tr class="tfields">
					 <td width="10%">VLR Name  </td>
           <td align="left" > <%=vlr_name%>  <input type="hidden" name="num" value="<%=vlr_name%>">  </td>
       </tr>
       <tr class="tfields">
           <td width="10%"> Description </td>
           <td width="20%" align="left"><input type="text"id="txt1"  name="desc" maxlength="100" size="30"> </td>
       </tr>
       <tr class="tfields">
           <td width="10%">Enabled </td>
           <td width="10%" height="17" align="left"><input type="checkbox"id="txt2" name="roam" value="A"></td>
       </tr>
       <br><br>
			 <tr class="button1">
           <td colspan="2" > <input type="submit" name="submit" value="Modify"> <input type="reset" name="clear" value="Clear"> </td>
       </tr>
     </table>
   </form>
        <script language="JavaScript">
		<!--
		document.form1.desc.focus();
		//-->
	</script>
<%@ include file = "../pagefile/footer.html" %>  
<%
}
%>



