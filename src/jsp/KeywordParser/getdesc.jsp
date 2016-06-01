
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
    Logger logger = Logger.getLogger ("getdesc.jsp");
String process=request.getParameter("process");
	KeywordParserManager Desc  = new KeywordParserManager();		 
      Desc.setConnectionPool(conPool);
   String desc=Desc.getDesc(process);
		logger.info(desc);
		response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write(desc);
%>
