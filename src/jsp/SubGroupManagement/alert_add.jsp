
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "../conPool.jsp" %>
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
        SubGroupManager subGroupManager = new SubGroupManager();
       subGroupManager.setConnectionPool(conPool);
				 SubGroup subGroup = new SubGroup();
				 ArrayList subGroupAl = new ArrayList();

				 int i = -1;
				 i = subGroupManager.viewSubGroupAlert(subGroupAl, 0);
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
			if(document.forms.form.grpName.value=="")
			{
							alert("Enter Name for Group")
							document.forms.form.grpName.focus()
							return false
			}
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
<form name="form" method="post" action="alertAdd.jsp" onSubmit="return validate()">
     <table border="1" width="70%" cellpadding="0" cellspacing="0" align="center">
     
		  <tr class="tableheader"><td colspan="2"> Subscriber Group Alerts</td></tr>
				<% 
			       if(i<=0 || subGroupAl.size()<=0)
						 {
			%>
			 <tr class="notice"><td colspan="8">No Subscriber Group Found!!! </tD></tr>
			<%
						 }
		         else
							{
											 
			%>								
			<tr class="tfield">
			  <td> Group Name</td>
				<td align="left">
				  <select name="grpName" >
			<%
							for(int x =0;x<subGroupAl.size();x++)
			    			{
											subGroup = (SubGroup) subGroupAl.get(x);
			%>
					<option value="<%=subGroup.getGrpName()%>"><%=subGroup.getGrpName()%></option>
			<%
								}
							}
			%>				
				 </select>
				</td>
			</tr>
		  <tr class="tfield">
			   <td> Start Msisdn</td>	
				 <td> <input type="text" name="startMsisdn" onkeypress="return numberOnly(event)"></td>
			</tr>	 
		  <tr class="tfield">
			   <td> End Msisdn</td>	
				 <td> <input type="text" name="endMsisdn" onkeypress="return numberOnly(event)" ></td>
			</tr>	 
			
			<tr class="button1">
			   <td colspan="2"><input type="submit" name="submit" value="SUBMIT"> <input type="reset" name="reset" value="CLEAR">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
 
     </table>
</form>
		 
<%@ include file = "../pagefile/footer.html" %>

<%

}

%>
