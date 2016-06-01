
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
	String name = request.getParameter("name");
	long grpId = Long.parseLong( request.getParameter("grpId") );
				NetworkGroupManager networkGrpManager = new NetworkGroupManager();
                          networkGrpManager.setConnectionPool(conPool);
				ArrayList networkGrpAl = new ArrayList();

				int i = networkGrpManager.viewNetworkGrp(networkGrpAl,name,grpId);
				
%>
<HTML>
<HEAD>
<TITLE>Network Group Modification </TITLE>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" >
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

		function validate()
		{
//			var name = document.forms.form.name.value
			var desc = document.forms.form.desc.value
			var waitInterval_In = document.forms.form.waitInterval_In.value
			var repInterval_In = document.forms.form.repInterval_In.value
			var waitInterval_Out = document.forms.form.waitInterval_Out.value
			var repInterval_Out = document.forms.form.repInterval_Out.value
		  var time_MaxMesg = document.forms.form.time_MaxMesg.value
			var MaxMesg_Time = document.forms.form.MaxMesg_Time.value
			var oneTime_Mesg = document.forms.form.oneTime_Mesg.value
			var sleep_Start_hr = document.forms.form.sleep_Start_hr.value
			var sleep_Start_min = document.forms.form.sleep_Start_min.value
			var sleep_End_hr = document.forms.form.sleep_End_hr.value
			var sleep_End_min = document.forms.form.sleep_End_min.value

/*
			if(name =="")
			 {
							 alert("Enter Network Name ")
							 document.forms.form.name.focus()
							 return false
			 }
*/
			if(desc =="")
			 {
							 alert("Enter Network Description")
							 document.forms.form.desc.focus()
							 return false
			 }
			if(waitInterval_In =="")
			 {
							 alert("Enter New Wait Interval for Inroamer")
							 document.forms.form.waitInterval_In.focus()
							 return false
			 }
			if(repInterval_In =="")
			 {
							 alert("Enter Repetition Interval for Inroamer")
							 document.forms.form.repInterval_In.focus()
							 return false
			 }
			if(waitInterval_Out =="")
			 {
							 alert("Enter New Wait Interval for Outroamer")
							 document.forms.form.waitInterval_Out.focus()
							 return false
			 }
			if(repInterval_Out =="")
			 {
							 alert("Enter Repetition Interval for Outroamer")
							 document.forms.form.repInterval_Out.focus()
							 return false
			 }
			if(time_MaxMesg =="")
			 {
							 alert("Enter Time Period for Max. Messages")
							 document.forms.form.time_MaxMesg.focus()
							 return false
			 }
			if(MaxMesg_Time =="")
			 {
							 alert("Enter Max. Messages in Time Period")
							 document.forms.form.MaxMesg_Time.focus()
							 return false
			 }
			if(oneTime_Mesg =="")
							
			 {
							 alert("Enter Max. Messages in One Time")
							 document.forms.form.oneTime_Mesg.focus()
							 return false
			 }
			if(sleep_Start_hr =="")
			 {
							 alert("Enter Sleep Period hrs.")
							 document.forms.form.sleep_Start_hr.focus()
							 return false
			 }
			if(sleep_Start_min =="")
			 {
							 alert("Enter Sleep Period min.")
							 document.forms.form.sleep_Start_min.focus()
							 return false
			 }
			if(sleep_End_hr =="")
			 {
							 alert("Enter Sleep End Time  hrs.")
							 document.forms.form.sleep_End_hr.focus()
							 return false
			 }
			if(sleep_End_min =="")
			 {
							 alert("Enter Sleep End Time min.")
							 document.forms.form.sleep_End__min.focus()
							 return false
			 }
			if(sleep_Start_hr > sleep_End_hr)
			{
							alert("Enter correct time.Start time sholud be less than End time")
							return false
			}
			if( sleep_Start_hr > 24 || sleep_Start_min > 60)
			 {
							 alert("Error in Start Time")
							 document.forms.form.sleep_Start_hr=""
							 document.forms.form.sleep_Start_min=""
							 return false
			 }
			if( sleep_End_hr > 24 || sleep_End_min > 60)
			 {
							 alert("Error in End Time")
							 document.forms.form.sleep_End_hr=""
							 document.forms.form.sleep_End_min=""
							 return false
			 }
	
			return true;
		}//validate

  function disable()
	{
		 if(document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_Start_hr.disabled = false
						document.forms.form.sleep_Start_min.disabled = false
		 }
		 else if(!document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_Start_hr.disabled = true
						document.forms.form.sleep_Start_min.disabled = true
		 }
		 if(document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_End_hr.disabled = false
						document.forms.form.sleep_End_min.disabled = false
		 }
		 else if(!document.forms.form.sleep_enable.checked)
		 {
						document.forms.form.sleep_End_hr.disabled = true
						document.forms.form.sleep_End_min.disabled = true
		 }

	return true;
	}//disable

</script>


</head>

 <%@ include file = "../pagefile/header.html" %>
     
  <form name="form" method="post" action="networkGrp_modify_delete.jsp?id=mod"onSubmit="return validate()" >

	<table width="70%" align="center" border="1" cellpadding="0" cellspacing="0">
	  <tr><td colspan="2" class="tableheader">Network Group Details  <br><br></td>	 </tr>
				 <%
						if (networkGrpAl.size() <= 0 )
						{
				 %>
				 	<tr class="notice"><td colspan="16" align="center"><br>Network Group Configuration not Available<br></td></tr>
				 <%}
				    else
						{
							for(int z=0;z<networkGrpAl.size();z++)
								{
										NetworkGroup network_config = (NetworkGroup) networkGrpAl.get(z);
			//							grpId = 	network_config.getNetworkId();
					%>
			 <tr class="tfields">      
						<input type="hidden" name="grpId" value="<%=grpId%>" >
						<input type="hidden" name="name" value="<%=name%>" >
			 			<td width="40%"><sup class="notice">*</sup> Network Group Name </td>
						<td >&nbsp;<%=name%> </td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Network Group Description </td>
						<td valign="top" >&nbsp;<textarea name="desc" rows="4" cols="45"><%=network_config.getDesc()%></textarea></td>
		   </tr>
    </table>		
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting This Network [INBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp;Inbound Roamer</td>
					<td  height="20" valign="top"><input type="checkbox" name="inbound" value="A" > &nbsp;&nbsp;&nbsp;&nbsp;[<%=network_config.getInbound()%>]   </td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="waitInterval_In" value="<%=network_config.getWaitInterval_In() %>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_In"value="<%=network_config.getRepInterval_In()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Time Period for Max. Messages (days)  </td>
						<td >&nbsp;<input type="text" name="time_MaxMesg"value="<%=network_config.getMaxMesg_Time()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Max. Message in Time Period  </td>
						<td >&nbsp;<input type="text" name="MaxMesg_Time" value="<%=network_config.getTime_MaxMesg()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Max. Message in One Time  </td>
						<td >&nbsp;<input type="text" name="oneTime_Mesg"value="<%=network_config.getOneTime_Mesg()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
	</table>
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting From Network [OUTBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp;Outbound Roamer</td>
					<td height="20" valign="top"> <input type="checkbox" name="outbound"value="A" > &nbsp;&nbsp;&nbsp;&nbsp;[<%=network_config.getInbound()%>]</td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="waitInterval_Out"value="<%=network_config.getWaitInterval_Out()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_Out"value="<%=network_config.getRepInterval_Out()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Period Enable</td>
						<td >&nbsp;<input type="checkbox" name="sleep_enable"value="A" onClick="return disable()" >  &nbsp;&nbsp;&nbsp;&nbsp;[<%=network_config.getSleep()%>]</td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Start Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleep_Start_hr" size="10" maxlength="2" value="<%=network_config.getSleep_Start_hr()%>"  disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleep_Start_min" size="10" maxlength="2" value="<%=network_config.getSleep_Start_min()%>" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>
				 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep End Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleep_End_hr" size="10" maxlength="2" value="<%=network_config.getSleep_End_hr()%>" disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleep_End_min" size="10" maxlength="2" value="<%=network_config.getSleep_End_min()%>" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>

				<tr class="button1">
						<td colspan="2"> <input type="Submit" name="submit" value="ADD">&nbsp; <input type="reset" name="reset" value="RESET">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</table>	 
		
</form>

<%@ include file = "../pagefile/footer.html" %>  
<%
						}//for
				}//else
}//else  main
%>	
		
