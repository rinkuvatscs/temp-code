      
			// create the prototype on the String object, trim function
    
    String.prototype.trim = function trimStr() {
        // skip leading and trailing whitespace and return everything in between
        var x=this;
        x = x.replace(/^\s*(.*)/, "$1");
				x = x.replace(/(.*?)\s*$/, "$1");
			return x;
    }
  
    String.prototype.addCode = function addCouCode() {
        // add 91 as code if not there
        var mobNum = this;
        var countryCode = "876";
        switch(mobNum.length){
            case 9: mobNum = "876" + mobNum; break;
            case 10: mobNum = "876" + mobNum.substr(1); break;
            case 12:break;
        }
       return mobNum;
    }

  function valid(mobile)
  {
      var countryCode = "876"
     if(mobile.substr(0,1) == "+")
     {
         alert("Error!! " + mobile +" invalid number pattern")
         return false
     }
     if(mobile.substr(0,2)=="00" || mobile.substr(0,2)==countryCode)
     {
         if(mobile.length<11)
         {
             alert("Error!! " + mobile + " invalid number length")
             return false
         }
     }
     else if(mobile.substr(0,1)=="0")
     {
         if(mobile.length<10)
         {
             alert("Error!! " + mobile + " invalid number length")
         }
     }
	   var ValidChars = "0123456789";
     if(mobile.length<9)
     {
       alert("Error in "+mobile+" !!! Mobile Number must contain atleast 9 digits")
       return false
     }
		 if(mobile.length> 12)
		 {
						 alert("The number "+mobile+" is not valid.\n Its maxlength can be 12")
						 return false
		 }
     for( i = 0; i < mobile.length ; i++)
     {
				Char = mobile.charAt(i);
				if (ValidChars.indexOf(Char) == -1)
				{
				    alert("Error in "+mobile+" !!!! You must enter a valid mobile no.")
				    return false
				}
		 }
		 return true
	}

