
			function dateCheck()
			{
							var startDate = document.forms.form.start_date.value
							var endDate = document.forms.form.end_date.value
							
							var todayDate = new Date()  // * current date 
							var nowday = todayDate.getDate() //* dd 
							var nowmnt = todayDate.getMonth()//* mm 
							var nowyear = todayDate.getYear()//* yyyy 
							
              nowmnt=nowmnt+1
              nowyear +=( nowyear <1900)? 1900:0
              //  todate is converted to string 
							var Sdate=nowday.toString();
							var Smnt=nowmnt.toString();
							var Syr=nowyear.toString();
						// date part is 1 - 9	of the month 
							if(Sdate <= 9 )
							{
									Sdate = '0'+Sdate  
							}
						// month part is 1 - 9	of the year 
							if(Smnt <= 9 )
							{
											Smnt = '0' + Smnt
							}
							// build the full date (dd-mm-yyyy)
              var Date_today =		Sdate+'-'+Smnt+'-'+Syr

							if(startDate =="")
							{
											alert("Enter Start Date")
											return false
											document.forms.form.start_date.focus()
							}
							if(endDate =="")
							{
											alert("Enter End Date")
											return false
											document.forms.form.end_date.focus()
							}
							if(startDate >= endDate)
							{
											alert("Start Date should be less than End Date")
											return false
											startDate = ""
											endDate =""
							}
						  if(startDate < Date_today )
							{
											alert("Start Date can not be before todate")
											return false
											startDate =""
											document.forms.form.start_date.focus()
							}
						  if(Date_today >= endDate)
							{
											alert("End Date can not be current date/todate or before")
											return false
											endDate =""
											document.forms.form.end_date.focus()
							}
         
						  if(Date_today == endDate)
							{
											alert("End Date can not be current date/todate")
											return false
											endDate =""
											document.forms.form.end_date.focus()
							}
								
	       
        } // dateCheck 

				function dateCheck1()
				{
							var startDate = document.forms.form.date.value
							var todayDate = new Date()
							var nowday = todayDate.getDate()
							var nowmnt = todayDate.getMonth()
							var nowyear = todayDate.getYear()
							
              nowmnt=nowmnt+1
              nowyear +=( nowyear <1900)? 1900:0 

							var Sdate=nowday.toString();
							var Smnt=nowmnt.toString();
							var Syr=nowyear.toString();

							if(Sdate <= 9 )
							{
									Sdate = '0'+Sdate
							}
							if(Smnt <= 9 )
							{
											Smnt = '0' + Smnt
							}
							
              var Date_today =		Sdate+'-'+Smnt+'-'+Syr

							if(startDate =="")
							{
											alert("Enter Start Date")
											document.forms.form.date.focus()
											return false
							}
							
							if(startDate < Date_today )
							{
											alert("Start Date can not be before todate")
											startDate =""
											document.forms.form.date.focus()
											return false
							}

				} //dateCheck1
           


