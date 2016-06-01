<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>

<%
int reportId  = Integer.parseInt(request.getParameter("reportId"));
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(reportId==5)
{
	if(sessionHistory == null || !sessionHistory.isAllowed(2033))
	{
	 %>
	  <%@ include file ="../logouterror.jsp" %>
	    <%
	      session.invalidate();
	         request.getSession(true).setAttribute("lang",defLangId);
         }

}
if(reportId==1)
{
	if(sessionHistory == null || !sessionHistory.isAllowed(2032))
	{
		 %>
		  <%@ include file ="../logouterror.jsp" %>
		    <%
		      session.invalidate();
		         request.getSession(true).setAttribute("lang",defLangId);
        }
}
if(reportId==2)
{
	if(sessionHistory == null || !sessionHistory.isAllowed(2034))
	{
         %>
          <%@ include file ="../logouterror.jsp" %>
            <%
              session.invalidate();
                 request.getSession(true).setAttribute("lang",defLangId);
         }
}

//																				else
{
	ReportUtil2 cpManager = new ReportUtil2();
     cpManager.setConnectionPool(conPool);

	ArrayList cpList = new ArrayList();
	int cd = cpManager.getAllContentProviders(cpList);
	%>
	    <%@ include file="../lang.jsp" %>
		<%@ include file = "../pagefile/headerReport.html" %>
		<!--<form name="form1" method="post" action="resultrbtlist.jsp?reportId=<%=reportId%>&pageId=1" > -->
		<form name="form1" method="post" <%if(reportId==5){%>action="resultrbtlist.jsp?reportId=<%=reportId%>&pageId=1"<%}else if(reportId==1){%>action="report.jsp?reportId=1&a=1"<%} else if(reportId==2){%>action="report2.jsp?reportId=2&a=1"<%}%> > 
		<table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
		<tr class="t1"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("selectCP",defLangId)%></td></tr>
		<tr class="tfield1">
		<TD><%=TSSJavaUtil.instance().getKeyValue("curCP",defLangId)%></TD>
		<TD> 
		<SELECT NAME="contentp" SIZE="1" >
		<% 
		for(int j=0; j< cpList.size(); j++)
		{
			ContentProvider cp = (ContentProvider) cpList.get(j);
			%>
				<OPTION VALUE="<%=cp.getCode()%>"><%=cp.getName()%></OPTION>
				<%
		}
	%>
		</SELECT> 
		</TD>
		</TR>
		<tr>
		<td class="button1">
		<input name="submit" type="submit" value="<%=TSSJavaUtil.instance().getKeyValue("submit",defLangId)%>"><input name="reset" type="reset" value="<%=TSSJavaUtil.instance().getKeyValue("clear",defLangId)%>">
		</td>
		</tr>		

		<%@ include file  = "../pagefile/footer.html"%>
		<%
}
%>
