
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
  Logger logger = Logger.getLogger ("modifyKeyword.jsp");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null || !sessionHistory.isAllowed(291))
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

  String user_name=sessionHistory.getUser();  
		KeywordParserManager keywordManager = new KeywordParserManager();
        keywordManager.setConnectionPool(conPool);
		KeywordParser keyParser  = new KeywordParser();
		
		String keyword = request.getParameter("keyword");
    String process = request.getParameter("proc");
    String syntax = request.getParameter("syntax");
    String desc = request.getParameter("desc");
    String okey = request.getParameter("old_keyword");
    String userId = ((AuthAdmin) session.getAttribute("authenticate")).getUserId();
            
				keyParser.setRequestKeyword(keyword);
		keyParser.setProcessName(process);

WebAdminLogManager webadminlogs= new WebAdminLogManager();
 webadminlogs.setConnectionPool(conPool);
WebAdminLog logobj=new WebAdminLog();
int k=0;
   String old_values="REQUEST_KEYWORD:"+okey+";";
   String new_values="REQUEST_KEYWORD:"+okey+";";
if(!request.getParameter("keyword").equals(okey))
{
old_values=old_values+"REQUEST_KEYWORD:"+request.getParameter("keyword")+";";
new_values=new_values+"REQUEST_KEYWORD:"+okey+";";
k=1;
}
if(!request.getParameter("old_proc").equals(request.getParameter("proc")))
{
old_values=old_values+"PROCESS_NAME:"+request.getParameter("old_proc")+";";
new_values=new_values+"PROCESS_NAME:"+request.getParameter("proc")+";";
k=1;
}
if(k==1)
{
																logobj.setTableName("LBS_PARSER_MASTER");
                logobj.setlink("keywordparserlog");
                logobj.setuser(user_name);
                logobj.setPreviousvalue(old_values);
                logobj.setCurrentvalue(new_values);
}

	//	keyParser.setSyntaxMessage(syntax);
	//	keyParser.setDesc(desc);
		/* language id is 1 by default*/
		
		int i = keywordManager.updateKeywordParser (keyParser,okey);
 if(i>=0 && k==1)
{
int res = webadminlogs.createLog(logobj);
logger.info("logs return =="+res);
}   
		if(i > 0)
    {
%>
        <script language="JavaScript">
           // alert("Keyword modified successfully!!");
           alert("<%=TSSJavaUtil.instance().getKeyValue("Keyword_modified_successfully",defLangId)%>")
            window.location="home.jsp";
        </script>
<%
    }
    else
    {
%>
        <script language="JavaScript">
            //alert("Error!!!  unable to update the keyword");
           alert("<%=TSSJavaUtil.instance().getKeyValue("unable_update_keyword",defLangId)%>")
            history.go(-1);
        </script>
<%
    }
}
%>
