
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>

<%@ include file = "../conPool.jsp" %>
<%
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(293))
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
  <%
    KeywordParserManager keywordManager = new KeywordParserManager();
		keywordManager.setConnectionPool(conPool);
		String[] keywordParsers = (String []) request.getParameterValues("keyword");
    
		int i = keywordManager.deleteKeywordParser (keywordParsers);
    
		if(i > 0)
    {
%>
        <script language="JavaScript">
           // alert("Keyword deleted successfully!!");
           alert("<%=TSSJavaUtil.instance().getKeyValue("Keyword_deleted",defLangId)%>")
            window.location="home.jsp";
        </script>
<%
    }
    else
    {
%>
        <script language="JavaScript">
            //alert("Error!!!  unable to delete the keyword");
            alert("<%=TSSJavaUtil.instance().getKeyValue("unable_to__delete_keyword",defLangId)%>")
            window.location="../home.jsp";
        </script>
<%
    }
}
%>
