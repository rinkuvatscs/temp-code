
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
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
		
					
%>
 <%@ include file="../lang.jsp" %>
 <script language="javascript">
  function validate()
  {
		if(document.forms.form1.month.value==-1)
		{
			document.forms.form1.month.focus();
			return false;
		}
		return true;
  }

   function addOption_year()
   {
       var date1 = new Date().getFullYear();
       var date2 = new Date().getMonth();
       var mnt= date2 ;
       var i =0;
       var j =0;
       var arr = new Array();
       var arr1 = new Array();

       //create year list
       while(i < 4 ) {	arr[i]=date1-i;	i++; }
       for(var x=0 ;x<arr.length;++x)
       {
   		addOption(document.forms.form1.year,arr[x],arr[x]);    	
       }
       
       //create month list
        var mnth = new Array ("January","February","March","April","May", "June", "July", "August", "September", "October","November", "December");
       for(j=1;j<=date2;j++) { arr1[j]=j; }
       for( x=0 ;x<(arr1.length-1);x++)
       {
      		addOption(document.forms.form1.month,mnth[x],arr1[x+1]);    	
       }

       
   }
   function addOption(selectbox,text,value)
   {
       var optn=document.createElement("Option");
       optn.text=text;
       optn.value=value;
       selectbox.options.add(optn);
      // disablefield();
   }
/*
   function addOption2(selectbox,text,value)
   {
       var optn=document.createElement("Option");
       optn.text=text;
       optn.value=value;
       selectbox.options.add(optn);
   //    disablefield();
   }
  */
	function disablefield()
	{
		document.form1.month.disabled=true;
		document.form1.year.disabled=true;
		if(document.getElementById)
		{
			document.getElementById("f_trigger_c1").style.visibility="hidden";
			document.getElementById("f_trigger_c2").style.visibility="hidden";
		}
		else
		{
			document.f_trigger_c1.visibility="hidden";
			document.f_trigger_c2.visibility="hidden";
		}

	} //disablefield

function enablefield()
	{
		document.form1.month.disabled=false;
		document.form1.year.disabled=false;
		if(document.getElementById)
		{
			document.getElementById("f_trigger_c1").style.visibility="visible";
			document.getElementById("f_trigger_c2").style.visibility="visible";
		}
		else
		{
			document.f_trigger_c1.visibility="visible";
			document.f_trigger_c2.visibility="visible";
		}
		addOption_year();
	}//enablefield

function year_check()
{
	var selected_year=document.forms.form1.year.selectedIndex;
	var current_year = new Date().getMonth();
	if (selected_year == 0)
	{
		document.getElementById('month').options.length=0
		addOption_year();
	}
	else
	{
		//clear old month list
		document.getElementById('month').options.length=0

		//create month list
		var mnth = new Array ("January","February","March","April","May", "June", "July", "August", "September", "October","November", "December");
		for( x=0 ;x<mnth.length;x++)
		{
			addOption(document.forms.form1.month,mnth[x],x+1);    	
		}

	}
}//year_check()

 </script>
<%@ include file = "../pagefile/header.html" %>
 <body onLoad="disablefield()";>
      <form name="form1" method="post" action="invoice_execute.jsp" > 
    <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
	<tr class="t1"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("invoiceTop",defLangId)%></td></tr>
						
	 <tr class="bluetext">
            <td > <input type="radio"  name="reportType" value="0" size="1" checked onClick="disablefield()"><%=TSSJavaUtil.instance().getKeyValue("invoiceCurr",defLangId)%></td>
            <td > <input type="radio"  name="reportType" value ="1" size="1" onClick = "enablefield()"><%=TSSJavaUtil.instance().getKeyValue("invoiceArc",defLangId)%> </td>
   </tr>
	<tr class="tfield"id="f_trigger_c1">
	   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceMon",defLangId)%></td>
	   <td><select name="month" id="month">
	<!--        <option selected value="-1"><%=TSSJavaUtil.instance().getKeyValue("invoiceMon",defLangId)%></option>
		<option value="1">January</option>
		<option value="2">February</option>
		<option value="3">March</option>
		<option value="4">April</option>
		<option value="5">May</option>
		<option value="6">June</option>
		<option value="7">July</option>
		<option value="8">August</option>
		<option value="9">September</option>
		<option value="10">October</option>
		<option value="11">November</option>
		<option value="12">December</option>-->
	     </select></td>
	 </tr>    
	<tr class="tfield"id="f_trigger_c2">
	   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceYear",defLangId)%></td>
	   <td><select name="year" onchange="year_check()">
	     </select></td>
	 </tr>    
<!--	<tr>
	   <td><%=TSSJavaUtil.instance().getKeyValue("format",defLangId)%></td>
	   <td><select name="format">
		<option value="table">Tabular</option>
		<option value="csv">Download File</option>
	      </select></td>
	</tr>      
-->	      
	 
	 <tr>
	  <td colspan="2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>">
					  <input type="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
	  </td>
	 </tr> 
   </table>
     </form> 
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>

