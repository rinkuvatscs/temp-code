
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*"%>

<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(160))
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
	<Script type="text/javascript" src="../Scripts/dateCheck.js"></script>
<script type="text/javascript">
	function validate()
	{
				if(document.forms.form.start_time.value=="")
				{
								alert("Enter Time to  Send SMS")
								document.forms.form.start_time.focus()		
								return false
				}
				else if(document.forms.form.start_time.value > 23 )
				{
								alert("Time should be between 0000 to 2300 hours")
								document.forms.form.start_time.value==""		
								document.forms.form.start_time.focus()		
								return false
				}
				if(document.forms.form.message.value=="")
				{
								alert("Enter Message for SMS")
								document.forms.form.message.focus()		
								return false
				}
				return dateCheck1()
				
	}
</script>
</HEAD>
<%@ include file = "../pagefile/header.html" %>    
      
			<form name="form" method="post" action="servicepromo_execute.jsp" onSubmit="return validate()">
        <table width="90%" border="0" cellspacing="5" align="center" cellpadding="3">
          <tr class="tableheader">  <td colspan="2"> Send Service Promotional SMS<br><br> </td>    </tr>
					
          <tr class="tfield1">
           	 <td width="50%">  <input type="radio"  name="subType" value="1" size="1" checked> To CRBT Subscribers </td>
	           <td >  <input type="radio"  name="subType" value ="2" size="1"> To All Mobifone Subscriber </td>
          </tr>
         	<tr class="tfield">
			      <td width="50%"> Start Date</td>
					  <td><input type="text" name="date" id="f_date_c1" readonly="1"  />
							  <img src="../images/img.gif" id="f_trigger_c1" style="cursor: pointer; border: 1px solid red;" title="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''"  /></td>
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
 
            </td>
          </tr>

          <tr class="tfield">
            	<td width="50%" ><b>Start Time (in hours)</td>
       		    <td width="346"><input type="text" name="start_time" maxlength="2" size="2" onkeypress="return numberOnly(event)">
          </tr>
          <tr class="tfield">
        	    <td width="50%" >SMS Type </td>
          	  <td >  <select name="smsType" size="1">
			                  <option value="0" selected>Normal</option>
      			            <option value="1">Flash</option>
            		    </select>
              </td>
          </tr>
          <tr class="tfield">
           		<td width="50%" > Message Text </td>
            	<td ><textarea cols=50 rows=4 name="message" onkeypress="return disableReturnKey(event)"></textarea> </td>
          </tr>
					
          <tr class="button1">
           		 <td  colspan="2"><br> 
							 		<input type="submit" name="Submit" value="Submit"> <input type="reset" name="Submit2" value="Clear">
               </td>
          </tr>
					
        </table>
      </form>
			
<%@ include file = "../pagefile/footer.html" %>

<%
}
%>
