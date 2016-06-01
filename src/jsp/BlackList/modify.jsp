 <%@ include file = "../conPool.jsp" %>
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*"%>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(323))
{
    session.invalidate();
%>
	<%@ include file ="../logouterror.jsp" %>
<%
//			String url = response.encodeRedirectURL("../logouterror.jsp");
//			response.sendRedirect(url);
}
else
{
				String oldMsisdn=request.getParameter("msisdn");
				String oldImsi=request.getParameter("imsi");

				BlackListManager blackListManager = new BlackListManager();
                   blackListManager.setConnectionPool(conPool);
				ArrayList blackListAl = new ArrayList();

				int i = blackListManager.viewBlackList(blackListAl,oldImsi,oldMsisdn);

				
%>
<HTML>
<HEAD>

		<script type="text/javascript">
			
			function validate()
			{
							var imsi = document.forms.form.imsi.value
							var msisdn = document.forms.form.msisdn.value
							var remark = document.forms.form.remark.value
	

							
						if(imsi =="")
							{
											var z =  confirm("<%=TSSJavaUtil.instance().getKeyValue("blcof")%>")
											if(z == false)
											{
													return false
													document.forms.form.imsi.focus()
											}
											else
											{ }
							}
			/*				if(msisdn =="")
							{
											alert("<%=TSSJavaUtil.instance().getKeyValue("alblmsisdn")%>")
											return false
											document.forms.form.msisdn.focus()
							}
				*/
							if(remark =="")
							{
											alert("<%=TSSJavaUtil.instance().getKeyValue("alblremark")%>")
											return false
											document.forms.form.remark.focus()
							}
				 
				 return dateCheck()			
			}//validate
							
</script>

</HEAD>

<%@ include file = "../pagefile/header.html" %>

<form name="form" action="manage.jsp?id=mod" method="post" onSubmit="return validate()">
    <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">


				<tr> <td colspan="2" class="tableheader"><%=TSSJavaUtil.instance().getKeyValue("addtobl")%>  <br><br></td></tr>
 
				<tr class="tfields">
				<input type="hidden" name="oldImsi" value="<%=oldImsi%>">
				<input type="hidden" name="msisdn" value="<%=oldMsisdn%>">
       <%
							for(int x=0;x<blackListAl.size();x++)
							{
											BlackList blackList = (BlackList) blackListAl.get(x);
											
			 %>
					<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("imsi")%></td>
					<td align="left"><input type="text" name="imsi" size="30" onkeypress="return numberOnly(event)" >&nbsp;[<%=blackList.getImsi()%>]  </td>
				</tr>	
				<tr class="tfields">
					<td width="30%"><sup class="notice">*</sup><%=TSSJavaUtil.instance().getKeyValue("msisdn")%></td>
					<td align="left" onkeypress="return numberOnly(event)"><%=blackList.getMsisdn()%>  </td>
				</tr>	
			<tr class="tfields">
			      <td><%=TSSJavaUtil.instance().getKeyValue("expDate")%></td>
					  <td align="center"><input type="text" name="expiry_date" id="f_date_c1" readonly="1"  />
							  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /> &nbsp;[<%=blackList.getExDate()%>] </td>
			</tr>
						<script type ="text/javascript">
							Calendar.setup({
								inputField     :  "f_date_c1",  // id of the input field
								ifFormat       :  "%d-%m-%Y", // format of the input field
								button         :  "f_trigger_c1",// trigger for the calendar (button ID)
				        align          :  "Tl",           // alignment (defaults to "Bl")
								singleClick    :  true
							});
						</script>
				<tr class="tfields">
					<td width="30%"><%=TSSJavaUtil.instance().getKeyValue("syscCol3")%></td>
					<td align="left"><textarea name="remark" cols="50" rows="8" onkeypress="return disableReturnKey(event)" ></textarea></td>
				</tr>	
			<tr class="button1">
						<td colspan="2"><input type="submit" name="submit" Value="<%=TSSJavaUtil.instance().getKeyValue("add")%>"> <input type="reset" name="reset" value="<%=TSSJavaUtil.instance().getKeyValue("reset")%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
   
			</table>
	</form>

<%@ include file = "../pagefile/footer.html" %>

<%
             }//for
}//else
 %>	
