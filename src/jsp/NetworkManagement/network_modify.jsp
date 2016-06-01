
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*"  %>
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
			long networkId = Long.parseLong( request.getParameter("networkId") );
				
			TimeZoneManager timeZoneManager = new TimeZoneManager();
                  timeZoneManager.setConnectionPool(conPool);
			ArrayList timeZoneAl = new ArrayList();
			int i = timeZoneManager.viewTimeZone(timeZoneAl);
		  int	number_timeZone = timeZoneAl.size() ;
			String zoneName="";	
				
			NetworkMasterManager networkManager = new NetworkMasterManager();
          networkManager.setConnectionPool(conPool);

			ArrayList networkMasterAl = new ArrayList();
			int q = networkManager.viewNetwork(networkMasterAl,name,networkId); //show network: viewNetwork(ArrayList ,String name,long networkId)

		%>
<HTML>
<HEAD>
<TITLE>Network Master - Modify</TITLE>
<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
<script type="text/javascript">

		function validate()
		{
/*			var name = document.forms.form.name.value
			var brandName = document.forms.form.brandName.value
*/			
			var mnc = document.forms.form.mnc.value
			var mcc = document.forms.form.mcc.value
			var networkType = document.forms.form.networkType.value
			var timeZone = document.forms.form.timeZone.value
  
			var defaultLang = document.forms.form.defaultLang.value
			var enableTest = document.forms.form.enableTest.value
			var visitInterval_In = document.forms.form.visitInterval_In.value
			var repInterval_In = document.forms.form.repInterval_In.value
			var visitInterval_Out = document.forms.form.visitInterval_Out.value
			var repInterval_Out = document.forms.form.repInterval_Out.value
		  var time_MaxMesg = document.forms.form.timeMaxMesg.value
			var MaxMesg_Time = document.forms.form.maxMesgTime.value
			var oneTime_Mesg = document.forms.form.maxMesgOneTime.value
			var sleep_Start_hr = document.forms.form.sleepStartHr.value
			var sleep_Start_min = document.forms.form.sleepStartMin.value
			var sleep_End_hr = document.forms.form.sleepEndHr.value
			var sleep_End_min = document.forms.form.sleepEndMin.value
     
	/*		if(name =="")
			 {
							 alert("Enter Network Name ")
							 document.forms.form.name.focus()
							 return false
			 }
			if(brandName =="")
			 {
							 alert("Enter Network Brand Name")
							 document.forms.form.brandName.focus()
							 return false
			 }
	*/	
			if(mnc=="")
			 {
							 alert("Enter MNC")
							 document.forms.form.mnc.focus()
							 return false
			 }
			if(mcc=="")
			 {
							 alert("Enter MCC")
							 document.forms.form.mcc.focus()
							 return false
			 }
			if(networkType=="")
			 {
							 alert("Enter Network Type")
							 document.forms.form.networkType.focus()
							 return false
			 }

			if(timeZone=="" || timeZone=="No Time Zone Found")
			 {
							 alert("Enter Time Zone")
							 document.forms.form.timeZone.focus()
							 return false
			 }

			if(defaultLang=="")
			 {
							 alert("Enter Default Language")
							 document.forms.form.defaultLang.focus()
							 return false
			 }
			if(enableTest=="")
			 {
							 alert("Enter Enable Test")
							 document.forms.form.enableTest.focus()
							 return false
			 }

			if(visitInterval_In =="")
			 {
							 alert("Enter New Wait Interval for Inroamer")
							 document.forms.form.visitInterval_In.focus()
							 return false
			 }
			if(repInterval_In =="")
			 {
							 alert("Enter Repetition Interval for Inroamer")
							 document.forms.form.repInterval_In.focus()
							 return false
			 }
			if(visitInterval_Out =="")
			 {
							 alert("Enter New Wait Interval for Outroamer")
							 document.forms.form.visitInterval_Out.focus()
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
							 document.forms.form.timeMaxMesg.focus()
							 return false
			 }
			if(MaxMesg_Time =="")
			 {
							 alert("Enter Max. Messages in Time Period")
							 document.forms.form.maxMesgTime.focus()
							 return false
			 }
			if(oneTime_Mesg =="")
							
			 {
							 alert("Enter Max. Messages in One Time")
							 document.forms.form.maxMesgOneTime.focus()
							 return false
			 }
			if(sleep_Start_hr =="")
			 {
							 alert("Enter Sleep Period hrs.")
							 document.forms.form.sleepStartHr.focus()
							 return false
			 }
			if(sleep_Start_min =="")
			 {
							 alert("Enter Sleep Period min.")
							 document.forms.form.sleepStartMin.focus()
							 return false
			 }
			if(sleep_End_hr =="")
			 {
							 alert("Enter Sleep End Time  hrs.")
							 document.forms.form.sleepEndHr.focus()
							 return false
			 }
			if(sleep_End_min =="")
			 {
							 alert("Enter Sleep End Time min.")
							 document.forms.form.sleepEndMin.focus()
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
		 if(document.forms.form.sleepEnable.checked)
		 {
						document.forms.form.sleepStartHr.disabled = false
						document.forms.form.sleepStartMin.disabled = false
		 }
		 else if(!document.forms.form.sleepEnable.checked)
		 {
						document.forms.form.sleepStartHr.disabled = true
						document.forms.form.sleepStartMin.disabled = true
		 }
		 if(document.forms.form.sleepEnable.checked)
		 {
						document.forms.form.sleepEndHr.disabled = false
						document.forms.form.sleepEndMin.disabled = false
		 }
		 else if(!document.forms.form.sleepEnable.checked)
		 {
						document.forms.form.sleepEndHr.disabled = true
						document.forms.form.sleepEndMin.disabled = true
		 }

	return true;
	}//disable

</script>
</HEAD>
<%@ include file = "../pagefile/header.html" %>

  <form name="form" method="post" action="network_modify_delete.jsp?id=mod" onSubmit="return validate()">
   
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">Modify - Network Master Details  <br><br></td>	 </tr>
			 <%
			    if (networkMasterAl.size() <= 0)
					{
			 %>
			 <tr class="notice"><td colspan="2" align="center">Network Master Configuration not available </td></tr>
			 <%}
				 else 
				 {
						 for(int z=0;z<networkMasterAl.size();z++)
						 {
								NetworkMaster network_config = (NetworkMaster) networkMasterAl.get(z);
				%>			
			 				<input type="hidden" name="networkId" value="<%=networkId%>">
			 				<input type="hidden" name="name" value="<%=name%>">
			 				<input type="hidden" name="brandName" value="<%=network_config.getBrandName()%>">

			 <tr class="tfields">      
						<td width="40%">Network Name<sup class="notice">*</sup>  </td>
						<td > <%=network_config.getNetworkName() %>	  </td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Brand Name </td>
						<td valign="top"><%=network_config.getBrandName()%>  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%">MNC </td>
						<td valign="top"><input type="text" name="mnc"value="<%=network_config.getMnc()%>"  onkeypress="return numberOnly(event)">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> MCC </td>
						<td valign="top"><input type="text" name="mcc"value="<%=network_config.getMcc()%>" onkeypress="return numberOnly(event)">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Network Type </td>
						<td valign="top"><input type="text"value="<%=network_config.getNetworkType()%>" name="networkType">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Time Zone </td>
						<td valign="top">
						         <select name="timeZone" id="timeZone">
								<% if (number_timeZone <= 0)
									 {
								%>
								   <option selected>No Time Zone Found </option>
								<% }
								   else
										 {
						         for (int s = 0; s< number_timeZone;s++) 
							  			  {
													TimeZones timeZone_config = (TimeZones) timeZoneAl.get(s);
													if(timeZone_config.getTimeZone() == network_config.getTimeZone() )
																{	zoneName = timeZone_config.getZoneName();}
								%>		
										    	 <option value="<%=timeZone_config.getTimeZone()%>" selected ><%=timeZone_config.getZoneName()%></option>
							<%  		
												}//for
										 }//else
							 %>												
									  	</select>&nbsp; [<%=zoneName%>]
						</td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%">Default Language </td>
						<td valign="top"><input type="text"value="<%=network_config.getDefaultLang()%>" name="defaultLang">  </td>
		   </tr>
			 <tr class="tfields">      
			 			<td width="40%"> Enable Test </td>
						<td valign="top"><input type="text"value="<%=network_config.getEnableTest()%>" name="enableTest" onkeypress="return numberOnly(event)"> </td>
		   </tr>
    </table>		
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting This Network [INBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp; Inbound Roamer</td>
					<td  height="20"><input type="checkbox" name="inbound" value="A">  &nbsp;[<%=network_config.getInbound()%>]    </td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="visitInterval_In"value="<%=network_config.getVisitInterval_in()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_In"value="<%=network_config.getRepInterval_in()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp;Time Period for Max. Messages (days)  </td>
						<td >&nbsp;<input type="text" name="timeMaxMesg"value="<%=network_config.getTimeMaxMesg()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in Time Period  </td>
						<td >&nbsp;<input type="text" name="maxMesgTime"value="<%=network_config.getMaxMesgTime()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Max. Message in One Time  </td>
						<td >&nbsp;<input type="text" name="maxMesgOneTime"value="<%=network_config.getMaxMesgOneTime()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
	</table>
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
       <tr><td colspan="2" class="tableheader">For Roamers Visiting From Network [OUTBOUND]   <br><br></td>	 </tr>
				<tr class="tfields">
					<td width="40%">&nbsp; Outbound Roamer</td>
					<td height="20"><input type="checkbox" name="outbound"value="A" >&nbsp; [<%=network_config.getOutbound()%>]</td>
				</tr>	
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; New Visit/Wait Interval (hr) </td>
						<td >&nbsp;<input type="text" name="visitInterval_Out"value="<%=network_config.getVisitInterval_out()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Repetition Interval (min) </td>
						<td >&nbsp;<input type="text" name="repInterval_Out"value="<%=network_config.getRepInterval_out()%>" onkeypress="return numberOnly(event)" ></td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Period Enable</td>
						<td >&nbsp;<input type="checkbox" name="sleepEnable"value="A" onClick="return disable()" >&nbsp;[<%=network_config.getSleepEnable()%>]</td>
       </tr>
			 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep Start Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleepStartHr"value="<%=network_config.getSleepStartHr()%>" size="10" maxlength="2" disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleepStartMin"value="<%=network_config.getSleepStartMin()%>" size="10" maxlength="2" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>
				 <tr class="tfields">      
			 			<td width="40%">&nbsp; Sleep End Time </td>
						<td >&nbsp;from&nbsp;<input type="text" name="sleepEndHr" size="10" maxlength="2" value="<%=network_config.getSleepEndHr()%>" disabled onkeypress="return numberOnly(event)" >&nbsp;hr
										 &nbsp;&nbsp;<input type="text" name="sleepEndMin" size="10"maxlength="2" value="<%=network_config.getSleepEndMin()%>" disabled onkeypress="return numberOnly(event)" >&nbsp;min.</td>
       </tr>

				<tr class="button1">
						<td colspan="2"> <input type="Submit" name="submit" value="Modify">&nbsp; <input type="reset" name="reset" value="RESET">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</table>	 
		
</form>

<%@ include file = "../pagefile/footer.html" %>  
<%
				}//for
			} //else
}	//else main		
%>
