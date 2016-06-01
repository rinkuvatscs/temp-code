function validate()
	{
		var st;
		var ed;	
		var dt;

		
		if (document.form1.reportType[1].checked == true)
		{
			st = document.form1.start.value;
			ed = document.form1.end.value;
			
			stdate = st.substring(0,2);
			stmonth = st.substring(3,5);
			styear = st.substring(6,10);
			
			eddate = ed.substring(0,2);
			edmonth = ed.substring(3,5);
			edyear = ed.substring(6,10);
			
			dt = new Date();
			nowday = dt.getDate();
			nowmonth = dt.getMonth();
			nowyear = dt.getYear();
			nowmonth = nowmonth+1;
			nowyear += (nowyear<1900)? 1900:0
			
			
			var sday = nowday.toString();
			var smonth = nowmonth.toString();
			var syear = nowyear.toString();
			
			if(sday <= 9)
			{
				sday= '0'+sday;
			}
			if(smonth <= 9)
			{
				smonth = '0'+smonth;
			}	
		var Date_today = sday+'-'+smonth+'-'+syear;
		if ((ed == "") || (st == ""))
			{
				alert("Enter start date and end date");
				return false;
				document.form1.start.focus();
				
			}

		if (st == "")
			{
				alert("Enter start date");
				return false;
				document.form1.start.focus();
				
			}
			
		if (ed == "")
			{
				alert("Enter end date");
				return false;
				document.form1.end.focus();
				
			}
		
		if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
			{
				alert("Start date must be less than end date");
				return false;
				document.form1.start.focus();
				
			}
	
		if ( parseInt(edyear+edmonth+eddate) > parseInt(syear+smonth+sday) )
			{
				alert("End date cannot be greater than current date"+Date_today);
				end="";
				document.form1.end.focus();
				return false;
			}
		}
	} //validate
function validate1()
{
		var st;
		var ed;	
		var dt;

		
	//	if (document.form1.reportType[1].checked == true)
	//	{
			st = document.form1.start.value;
			ed = document.form1.end.value;
			
			stdate = st.substring(0,2);
			stmonth = st.substring(3,5);
			styear = st.substring(6,10);
			
			eddate = ed.substring(0,2);
			edmonth = ed.substring(3,5);
			edyear = ed.substring(6,10);
			
			dt = new Date();
			nowday = dt.getDate();
			nowmonth = dt.getMonth();
			nowyear = dt.getYear();
			nowmonth = nowmonth+1;
			nowyear += (nowyear<1900)? 1900:0
			
			
			var sday = nowday.toString();
			var smonth = nowmonth.toString();
			var syear = nowyear.toString();
			
			if(sday <= 9)
			{
				sday= '0'+sday;
			}
			if(smonth <= 9)
			{
				smonth = '0'+smonth;
			}	
		var Date_today = sday+'-'+smonth+'-'+syear;
		if ((ed == "") || (st == ""))
			{
				alert("Enter start date and end date");
				return false;
				document.form1.start.focus();
				
			}

		if (st == "")
			{
				alert("Enter start date");
				return false;
				document.form1.start.focus();
				
			}
			
		if (ed == "")
			{
				alert("Enter end date");
				return false;
				document.form1.end.focus();
				
			}
		
		if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
			{
				alert("Start date must be less than end date");
				return false;
				document.form1.start.focus();
				
			}
	
		if ( parseInt(edyear+edmonth+eddate) > parseInt(syear+smonth+sday) )
			{
				alert("End date cannot be greater than current date"+Date_today);
				end="";
				document.form1.end.focus();
				return false;
			}
		//}
	} //validate1

function disablefield()
	{
		document.form1.start.disabled=true;
		document.form1.end.disabled=true;
//		document.form1.aggre.disabled=true;	
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
		document.form1.start.disabled=false;
		document.form1.end.disabled=false;
	//	document.form1.aggre.disabled=false;
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
	//	document.form1.c1.disabled=false;
	//	document.form1.c2.disabled=false;
	}//enablefield


