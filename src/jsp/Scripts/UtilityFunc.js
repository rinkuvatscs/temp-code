    // create the prototype on the String object, trim function
    
    String.prototype.trim = function trimStr() {
        // skip leading and trailing whitespace and return everything in between
        var x=this;
        x = x.replace(/^\s*(.*)/, "$1");
	x = x.replace(/(.*?)\s*$/, "$1");
	return x;
    }

    function isNumeric(str) 
    {
        var ValidChars = ".0123456789";
        for( var j=0; j < str.length ; j++)
        {
            if (ValidChars.indexOf(str.charAt(j)) == -1)
	    {
                return false
            }
	}
	return true
    }
    
/*
    In JavaScript you can use isNaN to check if the given data is numeric or non-numeric. 
    Syntax : isNaN(testdata) ReturnValue :True if the testdata is non-numeric. 
    False if the testdata is numeric. Here's an example:
*/
    function Numeric(str) {
        return !(isNaN(str));
    }

/*
	isNumber - true for all numeric, false if not
*/

    function isNumber(possibleNumber)
    {
            var PNum = new String(possibleNumber);
            var regex = /[^0-9]/;
            return regex.test(PNum);
    }
