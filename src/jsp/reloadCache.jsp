

<%@ page import=" com.telemune.webadmin.webif.TSSJavaUtil" %>
 <%@ page import="org.apache.log4j.*" %>

<%
 Logger logger=Logger.getLogger("reloadCache");
 logger.info("reloding cache by hitting a URL");
  TSSJavaUtil.reload();
 logger.info("cache Reloaded successfully");
 %>
 
