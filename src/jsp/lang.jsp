<%
 int defLangId=TSSJavaUtil.instance().getDefaultLang();
	try{
   defLangId=Integer.parseInt(session.getAttribute("lang").toString());
	}
	catch(Exception exp)
	{
	exp.printStackTrace();
	}
	session.setAttribute("lang",defLangId);
%>

