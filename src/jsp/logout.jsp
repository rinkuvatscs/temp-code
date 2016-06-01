
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%--
	catboll.jsp. shows details about each category.
--%>
<%@ page import = "com.telemune.webadmin.webif.SessionHistory" %>
<%@ page import="com.telemune.webadmin.webif.TSSJavaUtil"%>
<%@ page import = "java.io.*" %>
<%@ page import = "org.apache.log4j.*" %>
 <%@ include file="../lang.jsp" %>
<%
Logger logger = Logger.getLogger("logout.jsp");
logger.debug("In logout.jsp page");
session.invalidate();
System.out.println("session invalidated "+session);

//Object defLangId_bkp=session.getAttribute("lang");
//System.out.println(session+"after invalidate lang is"+defLangId_bkp);
//System.out.println("after invalidate lang is"+defLangId_bkp);
 request.getSession(true).setAttribute("lang",defLangId);
%>

<%@ include file = "pagefile/header1.html" %>


        <table width="80%" border="0" cellspacing="1" align="center" >
          <tr> 
            <td colspan="2" class="bluetext"><p><%=TSSJavaUtil.instance().getKeyValue("logoutthnx",defLangId)%> </p> </td>
          </tr>
          <tr >
            <td  colspan="2" class="pglnk"><%=TSSJavaUtil.instance().getKeyValue("logoutagn",defLangId)%>  </td>
          </tr>
     </table> 
			<script language="JavaScript">
		<!--
		document.form1.msisdn.focus();
		//-->
		</script>
      
<%@ include file = "pagefile/footer.html" %>
