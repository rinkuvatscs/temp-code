

function RTrim(str)
{
	var whitespace = new String(" \t\n\r");
	var s = new String(str);

	if (whitespace.indexOf(s.charAt(s.length-1)) != -1) 
	{
		var i = s.length - 1;       // Get length of string

		while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
			i--;
		s = s.substring(0, i+1);
	}
	return s;
}

function LTrim(str)
{
	var whitespace = new String(" \t\n\r");
	var s = new String(str);

	if (whitespace.indexOf(s.charAt(0)) != -1) 
	{
		s = s.substring(1,s.length);       // Get length of string

		while (s.length >= 0 && whitespace.indexOf(s.charAt(0)) != -1)
			s = s.substring(1, s.length);
	}
	return s;
}
