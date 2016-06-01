
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file="../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(100))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
}
else
{

 %>
<HTML>
<HEAD>
<TITLE><%=TSSJavaUtil.instance().getKeyValue("advManage")%> </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript">

    function validate()
		{
			if(document.forms.form.catName.value=="")
			{
							alert("<%=TSSJavaUtil.instance().getKeyValue("aladv1")%> ")
							return false
			}
			return  true;
		}//validate

</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
<form name="form" method="post" action="add.jsp?id=cat" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("advnote1")%> </td></tr>
			<tr class="tfields">
			  <td> <%=TSSJavaUtil.instance().getKeyValue("catName")%> </td>
				<td align="left"><input type="text" name="catName" size="20"></td>
			</tr>
			<tr class="tfields">
			  <td> <%=TSSJavaUtil.instance().getKeyValue("catFreq")%> </td>
				<td align="left"><select name="catFre">
				     <option value="1"><%=TSSJavaUtil.instance().getKeyValue("low")%></option>
				     <option value="2"><%=TSSJavaUtil.instance().getKeyValue("medium")%></option>
				     <option value="3"><%=TSSJavaUtil.instance().getKeyValue("high")%></option>
						</select> 
				</td>
			</tr>
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%> "> <input type="reset" name="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%> ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
 
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%

}

%>
