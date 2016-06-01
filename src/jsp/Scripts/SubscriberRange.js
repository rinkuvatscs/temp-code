
function RTrim(str)
/* PURPOSE: Remove trailing blanks from our string. IN: str - the string we want to RTrim */
{
	// We don't want to trip JUST spaces, but also tabs. line feeds, etc.  Add anything else you want to
	// "trim" here in Whitespace
	var whitespace = new String(" \t\n\r");
	var s = new String(str);
	if (whitespace.indexOf(s.charAt(s.length-1)) != -1) 	// We have a string with trailing blank(s)...
	{
		var i = s.length - 1;       // Get length of string
		// Iterate from the far right of string until we  don't have any more whitespace...
		while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
		i--;
		// Get the substring from the front of the string to where the last non-whitespace character is...
		s = s.substring(0, i+1);
	}
	return s;
}

function validRange()
{
	var inValidChars=" \t"
	var Char
	var x=document.forms.form
	x.startat.value = x.startat.value.trim()
	x.endsat.value = x.endsat.value.trim()
	x.excludes.value = x.excludes.value.trim()
	var exclude = x.excludes.value
	var start = x.startat.value
	var end = x.endsat.value
 //***********************************************************************
	var ValidChars1 = "0123456789";
	 if((start =="" && end =="") && include=="")
	{
		alert("Error!!!! Either enter a particular range or add individual numbers in Other Numbers")
                return false
	}
	if((start !="" && end =="") || (start =="" && end!=""))
        {
	   alert("Error!!!! You must enter both the From  & To parameters for entering a valid range")
           return false
        }
	if((start =="" && end =="") && exclude !="")
        {
   	     alert("Error!!!! To enter exclusion numbers you must firstly enter a Range ")
	     return false
        }
	var validMobile
	if(start!="")
	{
		validMobile= valid(start)
		if(validMobile==false)
			return false
	}
	if(end!="")
	{
		 validMobile = valid(end)
		 if(validMobile==false)
			return false
	}
	if(start!="" && x.end!="")
	{
		if(parseInt(start) > parseInt(end))
		{
			alert("Error!!! Starting number of range should not be greater than Ending number of range")
			return false
		}
	}

// *********************************************************************************    
	exclude = RTrim(exclude)
	var excludeArray = exclude.split("\n")
	var allexcludeArray = new Array()
	var excludeCount = 0
	number_line=0
	while(number_line<excludeArray.length)
  	{
	      	number_space=0
		var excludeLineArray = excludeArray[number_line].split(" ")
	      	while(number_space<excludeLineArray.length)
      		{
	        	if(RTrim(excludeLineArray[number_space]) =="")
        	  	{
	              		number_space +=1
		        	continue
	        	}
		        allexcludeArray[excludeCount] = excludeLineArray[number_space]
		        excludeCount += 1
	        	isValid= valid(excludeLineArray[number_space])
		        if(isValid==false)
        	  	{
              			return false
          		}
		        number_space+=1
       		}
	        number_line += 1
	}
	 //Checking for multiple same number entries
	count=0
	while(count<allexcludeArray.length)
	{
 		 if (parseInt(allexcludeArray[count]) < parseInt(start) || parseInt(allexcludeArray[count]) > parseInt(end))
			{
         		alert("Exclusion Numbers must lie in between the range "+allexcludeArray[count])
		       		return false
			}
	     checkCount=count+1
	     while(checkCount<allexcludeArray.length)
	     {
	         if(allexcludeArray[count]==allexcludeArray[checkCount])
         	 {
	         	alert("Error in " + allexcludeArray[count] + " \n- Same number is found multiple times ")
		        return false
                 }
	        checkCount+=1
     	    }
 	    count+=1
 	}
	return true
}
