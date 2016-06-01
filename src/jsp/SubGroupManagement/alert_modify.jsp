
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
        SubGroupManager subGroupManager = new SubGroupManager();
       subGroupManager.setConnectionPool(conPool);
				 SubGroup subGroup = new SubGroup();
				 ArrayList subGroupAl = new ArrayList();
				 long grpId = Long.parseLong( request.getParameter("grpId") ) ;

				 int i = -1;
				 i = subGroupManager.viewSubGroup(subGroupAl, grpId);
 %>
<HTML>
<HEAD>
<TITLE>Subscriber Group Management</TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

    function validate()
		{
			var start = document.forms.form.startMsisdn.value
			var end = document.forms.form.endMsisdn.value
/*			if(document.forms.form.grpName.value=="")
			{
							alert("Enter Name for Group")
							document.forms.form.grpName.focus()
							return false
			}
	*/
			if(start =="" || end ==")
			{
							alert("Enter MSISDN")
							return false
			}
			if(end <= start)
			{
							alert("Start MSISDN should be less than End MSISDN")
							return false
			}
			
			return  true;
		}//validate

</script>
</HEAD>

<%@ include file = "../pagefile/header.html" %>
<form name="form" method="post" action="alertModify.jsp?id=mod" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2">Modify Subscriber Group Alerts</td></tr>
			<%
							for(int x =0;x<subGroupAl.size();x++)
			    			{
											subGroup = (SubGroup) subGroupAl.get(x);
			%>
			<tr class="tfield">
			  <input type="hidden" name="grpId" value="<%=subGroup.getGrpId()%>">
			  <input type="hidden" name="grpName" value="<%=subGroup.getGrpName()%>">
				<td> Group Name</td>
				<td align="left"><input type="text" name="grpName" value="<%=subGroup.getGrpName()%>" readonly="1"></td>
			</tr>
		  <tr class="tfield">
			   <td> Start Msisdn</td>	
				 <td> <input type="text" name="startMsisdn"  value="<%=subGroup.getStartMsisdn()%>" onkeypress="return numberOnly(event)"></td>
			</tr>	 
		  <tr class="tfield">
			   <td> End Msisdn</td>	
				 <td> <input type="text" name="endMsisdn"  value="<%=subGroup.getEndMsisdn()%>" onkeypress="return numberOnly(event)" ></td>
			</tr>	 
       <%
								}
			 %>				
			
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="SUBMIT"> <input type="reset" name="reset" value="CLEAR">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%

}

%>
