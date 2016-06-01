
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if (sessionHistory == null || !sessionHistory.isAllowed(292)) 
{
   %>
    <%@ include file ="../logouterror.jsp" %>
      <%
        session.invalidate();
           request.getSession(true).setAttribute("lang",defLangId);
   }
else
{
		KeywordParserManager keywordManager  = new KeywordParserManager();
          keywordManager.setConnectionPool(conPool);
		KeywordParser keywordParser = new KeywordParser();

    String keyword = request.getParameter("keyword").toUpperCase();
    String process = request.getParameter("proc");
    String syntax = request.getParameter("syntax");
    String desc = request.getParameter("desc");
    String lngID = request.getParameter("lngID");
    String userId = ((AuthAdmin) session.getAttribute("authenticate")).getUserId();

		keywordParser.setRequestKeyword(keyword);
		keywordParser.setProcessName(process);
		//keywordParser.setPackageName(packg);
		keywordParser.setCreatedBy(userId);
		/* language id is 1 by default*/
    
		int i = keywordManager.addKeywordParser (keywordParser,lngID);

    if(i == -2 )
    {
%>
            <script language="JavaScript">
                alert("Keyword Name already exists");
                history.go(-1);
            </script>
<%
    }
    else if(i == 0 )
    {
%>
        <script language="JavaScript">
            alert("Keyword added successfully!!!")
            window.location="home.jsp"
        </script>
<%
     }
    else
 	  {
%>
            <script language="JavaScript">
                alert("Error!!! Try Again");
                window.location="../home.jsp";
            </script>
<%
    }
}

%>
