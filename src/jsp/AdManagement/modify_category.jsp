
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
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
				AdvertiseManager adManager = new AdvertiseManager();
                             adManager.setConnectionPool(conPool);
				ArrayList advertiseAl = new ArrayList();
        long catId = Long.parseLong( request.getParameter("catId") );
				int i = adManager.viewAdCategory(advertiseAl,catId);


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
<form name="form" method="post" action="modifyCategory.jsp?id=mod" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("modiadcat")%> </td></tr>
			<input type="hidden" name="catId" value="<%=catId%>">
			<%
			          for(int x=0;x<advertiseAl.size();x++)
								{
												Advertise advertise = (Advertise) advertiseAl.get(x);
			%>
			<tr class="tfields">
			  <td> <%=TSSJavaUtil.instance().getKeyValue("catName")%> </td>
				<td align="left"><input type="text" name="catName" value="<%=advertise.getCatName()%>" maxLength="20"></td>
			</tr>
			<tr class="tfields">
			  <td> <%=TSSJavaUtil.instance().getKeyValue("catFreq")%> </td>
				<td align="left"><select name="catFre">
				     <option value="1"><%=TSSJavaUtil.instance().getKeyValue("low")%> </option>
				     <option value="2"><%=TSSJavaUtil.instance().getKeyValue("medium")%> </option>
				     <option value="3"><%=TSSJavaUtil.instance().getKeyValue("high")%> </option>
						</select>&nbsp;[<%=advertise.getCatFrequency()%>] 
				</td>
			</tr>
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit")%> "> <input type="reset" name="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear")%> ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
 
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%
                 }//for
}

%>
