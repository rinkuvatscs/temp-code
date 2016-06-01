
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if (sessionHistory == null || !sessionHistory.isAllowed(2063)) 
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
								//ViralSMSRange viralsmsrange  = new ViralSMSRange();		 
								String oldmsisdn =request.getParameter("planId");
								//int m = viralsmsrange.getrangeModify(msisdn);

								%>
																<HTML>
																<HEAD>
																<script type="text/javascript">
																function validate() 
																{
																				var x = document.form.msisdn.value = document.form.msisdn.value.trim();
																								if(x == "")
																								{
																																alert("The Msisdn Range is Missing");
																																document.form.msisdn.focus();
																																return false;
																								}
																						return true
																}
								</script>
																</HEAD>

																<%@ include file = "../pagefile/header.html" %>

																<form name="form" method="post" action="viralsmsrangemodify.jsp" onSubmit="return validate()" >
																<table width="80%" border="0" align="center" cellpadding="2" cellspacing="5" name ="table1" id="table1" style="display:block;">
																	<input type="hidden" name="oldmsisdn" value="<%=oldmsisdn%>">
																<tr class="tableheader"><td colspan="2"><%=TSSJavaUtil.instance().getKeyValue("rangemodify",defLangId)%> <br><br> </td></tr>
																<tr class="tfield">
																<td >Modify Msisdn Range </td>
																<td >  <input type="text" name="msisdn" value="<%=oldmsisdn%>">
																		</td>
																</tr>
														
																<tr class="button1">
																<td colspan="2" align="left"><br> <input type="submit" name="submit" value="Edit Msisdn Range" > <input type="reset" name="Clear" value="Clear"> </td>
																</tr>

																</table>

																<tr class="homemenu"><td></td><td><a href="viralrange_manage.jsp?pid=0&srchtext=X&order=ASC&searchId=0">Back</a></td></tr>
																</form>

																<%@ include file = "../pagefile/footer.html" %>
																<%
}
%>

