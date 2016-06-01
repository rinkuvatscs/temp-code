
<%@ page import="com.telemune.webadmin.webif.*" %>
<%@ page import="java.util.*" %>
<%@ include file = "../conPool.jsp" %>
<%
		SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
		if(sessionHistory ==null || !sessionHistory.isAllowed(100) )
		{
                  %>
                    <%@ include file ="../logouterror.jsp" %>
                       <%
                           session.invalidate();
                             request.getSession(true).setAttribute("lang",defLangId);
                  }
		else
		{
						long messageId = Long.parseLong( request.getParameter("messageId") );
						String roamerType =  request.getParameter("mesgType");

						int mesgType=-1;

						if (roamerType.equals("In Roamer"))
										mesgType=1;
						else if (roamerType.equals("Out Roamer"))
										mesgType=2;

						MessageMapManager mesgMapManager = new MessageMapManager();
                         mesgMapManager.setConnectionPool(conPool);
						MessageMap mesgMap = new MessageMap();
						ArrayList mesgConfigAl = new ArrayList();

						mesgMap.setMesgId(messageId);
						mesgMap.setMesgType(mesgType);

                int i = mesgMapManager.viewMap(mesgConfigAl,messageId,mesgType);
								
							int arr = mesgConfigAl.size();	
%>
 <html>
 <head>

 <title>Modify Mapping </title>

<link rel=stylesheet href="../pagefile/webadmin_style.css" type="text/css" > 
<link rel="stylesheet" type="text/css" media="all" href="../pagefile/calendar-win2k-cold-1.css" title="win2k-cold-1" />
<script type ="text/javascript" src="../pagefile/calendar.js"></script>
<script type ="text/javascript" src="../pagefile/calendar-setup.js"></script>
<script type ="text/javascript" src="../pagefile/lang/calendar-en.js"></script>
<script type ="text/javascript" src="../pagefile/DynamicOptionList.js"></script>
  <Script type="text/javascript" src="../Scripts/numberOnly.js"></script>
  <Script type="text/javascript" src="../Scripts/dateCheck.js"></script>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">

		<script type="text/javascript">
			
			function validate()
			{
							var mapValue = document.forms.form.map_value.value 
							var mesgOrder = document.forms.form.mesg_order.value 

							
							if(mapValue =="")
							{
											alert("Enter Number")
											return false
											document.forms.form.map_value.focus()
							}
							if(mesgOrder =="")
							{
											alert("Enter Message Order")
											return false
											document.forms.form.mesg_order.focus()
							}

							return dateCheck()
			}//validate


			function mesgtype()
			{
				var msgType = document.getElementById("mesg_type")
				var msgValue = msgType.options[msgType.selectedIndex].text
        var subType =  document.getElementById("sub_type")

				 if(msgValue=="In Roamer")
				 {
								document.forms['form'].sub_type.options.length=0;
								document.forms['form'].sub_type.options[0]=new Option('Not Applicable','NA');
								subType.disabled=true                  //disabled
				 }
				 else if(msgValue=="Out Roamer")
				 {
								 subType.disabled=false             //enabled
								document.forms['form'].sub_type.options.length=0;
								document.forms['form'].sub_type.options[0]=new Option('Not Applicable','0');
								document.forms['form'].sub_type.options[1]=new Option('Prepaid','1');
								document.forms['form'].sub_type.options[2]=new Option('Postpaid','2');
				 }
			} //mesgtype()
	
			function changeCriteria()
			{
				var mapType = document.getElementById("map_type")
				var mapValue = mapType.options[mapType.selectedIndex].text

				 if(mapValue=="NW Group Id" || mapValue=="CC")
				 {
							  document.getElementById("delivery_criteria").disabled=false
								document.forms['form'].delivery_criteria.options.length=0;
								document.forms['form'].delivery_criteria.options[0]=new Option('When Not Found','NF');
								document.forms['form'].delivery_criteria.options[1]=new Option('Always','AL');
								document.forms['form'].delivery_criteria.options[2]=new Option('Not Applicable','NA');
				 }
				 else 
				 {
								document.forms['form'].delivery_criteria.options.length=0;
								document.forms['form'].delivery_criteria.options[0]=new Option('Not Applicable','NA');
								changeOrder();
							  document.getElementById("delivery_criteria").disabled=true
				 }
       
			} //changeCriteria()
			
			function changeOrder()
			{ 
			 
					var mapType = document.getElementById("map_type")
					var mapValue = mapType.options[mapType.selectedIndex].text
			   var delCriteria = document.getElementById("delivery_criteria")
				 var delValue = delCriteria.options[delCriteria.selectedIndex].text				 
				 if( (mapValue=="NW Group Id" || mapValue=="CC") && delValue =="Always" )
				 {
											document.forms['form'].delivery_order.options.length=0;
											document.forms['form'].delivery_order.options[0]=new Option('Before','B');
											document.forms['form'].delivery_order.options[1]=new Option('After','A');
				 }
				 else  if( mapValue!="NW Group Id" || mapValue!="CC" ||  delValue !="Always" )

				 {
											document.forms['form'].delivery_order.options.length=0;
											document.forms['form'].delivery_order.options[0]=new Option('Not Applicable','NA');
											document.forms['form'].delivery_order.options[1]=new Option('Before','B');
											document.forms['form'].delivery_order.options[2]=new Option('After','A');
								 
				 }
								 
		} //changeOrder
			
		</script>


</HEAD>
<body >
<%@ include file = "../pagefile/header.html" %>
  
 <form name="form" action="mesg_modify_delete.jsp?id=mod"	method="post" onSubmit="return validate()" >
	  <table width="70%"  border="1" cellspacing="0" cellpadding="0" align="center">
			<tr class="tableheader"><td colspan="2">Welcome SMS for IN/OUT ROAMER </td></tr>
			<input type="hidden" name="messageId"value="<%=messageId%>">
			<%
					for(int x=0;x<arr;x++)
					{
									mesgMap = (MessageMap) mesgConfigAl.get(x);

			%>

			<tr class="tfields">
			   <td>Roamer Type</td>
				 <td><select name="mesg_type" id="mesg_type" onchange="mesgtype()">
								<option value="1" selected> In Roamer </option> 
								<option value="2"> Out Roamer </option>
							</select> &nbsp;[<%=roamerType%>]
    		 </td>									 
		</tr>
		<tr class="tfields">
					<td>Message to be send on </td>    
					<td><select name="event_type">
								<option value="1" selected>Entry </option> 
								<option value="2">Exit  </option>
							</select>&nbsp;[<%=mesgMap.getEventType()%>] 
    		 </td>		 
		 </tr>
		  <tr class="tfields">
					<td>Roaming Visit type </td> 
					<td><select name="visit_type">
								<option value="1" selected>New </option> 
								<option value="2">Repeat  </option>
								<option value="3">Frequent Repeat  </option>
					<!--			<option value="4">Repeat & Frequent Repeat  </option>
								<option value="5">Any  </option>
					-->			
						</select>	 &nbsp;[<%=mesgMap.getVisitType()%>] </td>
			</tr> 				
			<tr class="tfields">
			    <td>Set Message for</td>
					<td><select name="map_type" id="map_type" onchange="changeCriteria()">
								<option value="1" selected>IMSI </option> 
								<option value="2">MSISDN  </option>
								<option value="3">MNC  </option>
								<option value="4">NDC  </option>
								<option value="5">NW Group Id </option>
								<option value="6">MCC </option>
								<option value="7">CC </option>
								<option value="8">VLR Number </option>
								<option value="9">Default </option> 
					</select>	 &nbsp;[<%=mesgMap.getMapType()%>] </td>
				</tr> 		 
			<tr class="tfields">
			      <td> Enter Number</td>
						<td><input type"text" name="map_value" onkeypress="return numberOnly(event)" >&nbsp; <sup class="notice">* digits [0-9] only</sup>  &nbsp;[<%=mesgMap.getMapValue()%>]</td>
						
			</tr>				  
			<tr class="tfields">
			      <td> Start Date</td>
					  <td><input type="text" name="start_date" id="f_date_c1" readonly="1"  />  
							  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  />   &nbsp;[<%=mesgMap.getStartDate()%>]</td>
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
			      <td> End Date</td>
            <td><input type="text" name="end_date" id="f_date_c2" readonly="1"  /> 
							  <img src="../images/img.gif" id="f_trigger_c2" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  />   &nbsp;[<%=mesgMap.getEndDate()%>]</td>
			</tr>
								<script type ="text/javascript">
									Calendar.setup({
										inputField     :  "f_date_c2",  // id of the input field
										ifFormat       :  "%d-%m-%Y", // format of the input field
										button         :  "f_trigger_c2",// trigger for the calendar (button ID)
						        align          :  "Tl",           // alignment (defaults to "Bl")
										singleClick    :  true
									});
								</script>
 						  
			<tr class="tfields">
			    <td>Subscriber Type</td>
					<td><select name="sub_type" id="sub_type" disabled> 
								<option value="0" selected>Not Applicable </option> 
								<option value="1">Prepaid </option> 
								<option value="2">Postpaid </option> 
					</select>  &nbsp;[<%=mesgMap.getSubType()%>]</td>
			</tr>		
			<tr class="tfields">
			   <td>Messgage Order</td> 
				 <td>	<input type="text" name="mesg_order" onkeypress="return numberOnly(event)" ><sup class="notice">* digits [0-9] only</sup>	 &nbsp;[<%=mesgMap.getMesgOrder()%>]</td>
			</tr>	
			<tr class="tfields">
			   <td>Message Delivery</td>
				 <td><select name="delivery_criteria" id="delivery_criteria"  disabled onchange="changeOrder()">
				 			<option value="NF">When Not Found</option>
				 			<option value="AL">Always</option>
				 			<option value="NA" selected>Not Applicable</option>
					</select>  &nbsp;[<%=mesgMap.getDeliveryCriteria()%>] </td>
			</tr>	
			<tr class="tfields">
				 <td>Message Delivery Order	</td>
				 <td><select name="delivery_order" id="delivery_order">
				 			<option value="NA" selected>Not Applicable</option>
				 			<option value="B" >Before</option>
				 			<option value="A">After</option>
						</select>   &nbsp;[<%=mesgMap.getDeliveryOrder()%>]	
			</td>
			</tr>
			<tr class="button1">
						<td colspan="2"><input type="submit" name="submit" Value="Modify"> <input type="reset" name="reset" value="RESET">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </td>
			</tr>
						
	</table>	 			
 </form>
 
 <%
		   }//for

		}//else
 %>	
	
