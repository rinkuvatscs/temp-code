function validate()
	{
		var st;
		var ed;	
		var dt;

		
		
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
				//alert("Enter start date and end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstend",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}

		if (st == "")
			{
				//alert("Enter start date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstdate",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}
			
		if (ed == "")
			{
				//alert("Enter end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alenddate",defLangId)%> ");
				return false;
				document.form1.end.focus();
				
			}
		
		if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
			{
				//alert("Start date must be less than end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstless",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}
	
		if ( parseInt(edyear+edmonth+eddate) > parseInt(syear+smonth+sday) )
			{
			//	alert("End date cannot be greater than current date"+Date_today);
			alert("<%=TSSJavaUtil.instance().getKeyValue("End_date_cannot_greater",defLangId)%>+Date_today ");
				end="";
				document.form1.end.focus();
				return false;
			}
		
	} //validate

function validatemonth()
{
				var dt;
				var st;
				var ed;
				if (document.form1.reportType[1].checked == true)
				{
								var theindex = document.getElementById("aggre");

								if (theindex.selectedIndex == 0)
								{
												st = document.getElementById("f_date_c1").value;
												ed = document.getElementById("f_date_c2").value;

												stmonth = st.substring(0,2);
												styear = st.substring(3,7);

												edmonth = ed.substring(0,2);
												edyear = ed.substring(3,7);

												dt = new Date();
												nowday = dt.getDate();
												nowmonth = dt.getMonth();
												nowyear = dt.getYear();
												nowmonth = nowmonth+1;
												nowyear += (nowyear<1900)? 1900:0


																var smonth = nowmonth.toString();
												var syear = nowyear.toString();

												if(smonth <= 9)
												{
																smonth = '0'+smonth;
												}
												var Date_today = smonth+'-'+syear;
												if (st == "")
												{
										//alert("Enter start month");
					alert("<%=TSSJavaUtil.instance().getKeyValue("start_month",defLangId)%> ");
																document.form1.start.focus();
																return false;

												}

												if (ed == "")
												{
											//alert("Enter end month");
						alert("<%=TSSJavaUtil.instance().getKeyValue("end_month",defLangId)%> ");
																document.form1.end.focus();
																return false;

												}

												if ( parseInt(styear+stmonth) > parseInt(edyear+edmonth) )
												{
					//	alert("Start month must be less than or equal to end month");
				alert("<%=TSSJavaUtil.instance().getKeyValue("Smonth",defLangId)%> ");
																document.form1.start.focus();
																return false;

												}

												if ( parseInt(edyear+edmonth) > parseInt(syear+smonth) )
												{
					//alert("End month cannot be greater than current month= "+Date_today);Endmonth
			 alert("<%=TSSJavaUtil.instance().getKeyValue("Endmonth",defLangId)%> ");
																end="";
																document.form1.end.focus();
																return false;
												}
												if ( parseInt(edyear+edmonth) == parseInt(syear+smonth) )
												{
								//alert("End month cannot be equal to current month= "+Date_today);
		alert("<%=TSSJavaUtil.instance().getKeyValue("Ecurrent_month",defLangId)%>+Date_today ");
																end="";
																document.form1.end.focus();
																return false;
												}

												if ( parseInt(edyear) != parseInt(styear) )
												{
							//alert("Year must be same for monthly report");
			alert("<%=TSSJavaUtil.instance().getKeyValue("Yearreport",defLangId)%> ");
																end="";
																document.form1.end.focus();
																return false;
												}
								}
								else if(theindex.selectedIndex==1)
								{
												st = document.getElementById("f_date_c1").value;
												ed = document.getElementById("f_date_c2").value;

												styear = st.substring(3,7);
												edyear = ed.substring(3,7);

												dt = new Date();
												nowday = dt.getDate();
												nowmonth = dt.getMonth();
												nowyear = dt.getYear();
												nowmonth = nowmonth+1;
												nowyear += (nowyear<1900)? 1900:0


																var syear = nowyear.toString();

												var Date_today = syear;
												if ((ed == "") && (st == ""))
												{
								//	alert("Enter start year and end year");
			alert("<%=TSSJavaUtil.instance().getKeyValue("Etartyr",defLangId)%> ");
																document.form1.start.focus();
																return false;

												}

												if (st == "")
												{
								//alert("Enter start year");
					alert("<%=TSSJavaUtil.instance().getKeyValue("Enter_start_year",defLangId)%> ");
																document.form1.start.focus();
																return false;

												}

												if (ed == "")
												{
										//alert("Enter end year");
					 alert("<%=TSSJavaUtil.instance().getKeyValue("Enter_end_year",defLangId)%> ");
															document.form1.end.focus();
																return false;

												}

												if ( parseInt(styear) > parseInt(edyear) )
												{
					//		alert("Start year must be less than or equal to end year");
			 alert("<%=TSSJavaUtil.instance().getKeyValue("Starteyr",defLangId)%> ");
																document.form1.start.focus();
																return false;

												}

												if ( parseInt(edyear) > parseInt(syear) )
												{
						//	alert("End year cannot be greater than current year= "+Date_today);
				alert("<%=TSSJavaUtil.instance().getKeyValue("Ecurrentyr",defLangId)%> ");
																end="";
																document.form1.end.focus();
																return false;
												}
								}

				}
} //validatemonth

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
				//alert("Enter start date and end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstend",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}

		if (st == "")
			{
				//alert("Enter start date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstdate",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}
			
		if (ed == "")
			{
				//alert("Enter end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alenddate",defLangId)%> ");
				return false;
				document.form1.end.focus();
				
			}
		
		if ( parseInt(styear+stmonth+stdate) >= parseInt(edyear+edmonth+eddate) )
			{
				//alert("Start date must be less than end date");
				alert("<%=TSSJavaUtil.instance().getKeyValue("alstless",defLangId)%> ");
				return false;
				document.form1.start.focus();
				
			}
	
		if ( parseInt(edyear+edmonth+eddate) > parseInt(syear+smonth+sday) )
			{
				//alert("End date cannot be greater than current date"+Date_today);
				 alert("<%=TSSJavaUtil.instance().getKeyValue("End_date_cannot_greater",defLangId)%>+Date_today ");
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
		document.form1.aggre.disabled=true;	
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
		document.form1.aggre.disabled=false;
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


