<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.*" %>
 <%@ include file = "../conPool.jsp" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("vendorrbts.jsp");
logger.info("reportid="+request.getParameter("id"));
	int reportId  = Integer.parseInt(request.getParameter("id"));
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	
     if(reportId==1)
	{
	if(sessionHistory == null || !sessionHistory.isAllowed(2035))
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
	if(sessionHistory == null || !sessionHistory.isAllowed(2036))
	{
		 %>
		  <%@ include file ="../logouterror.jsp" %>
		    <%
		      session.invalidate();
		        request.getSession(true).setAttribute("lang",defLangId);
      }

	}

//	else
	{
%>
 <%@ include file="../lang.jsp" %>
<%
logger.info("==========");
   ReportUtil2 repManager = new ReportUtil2();
   repManager.setConnectionPool(conPool);

	ArrayList reportList = new ArrayList();
	int cd = 0;
	String reportHeader="";
	if(reportId==1)
	{
        
			cd =	repManager.getRBTUploaded(reportList);
				reportHeader="RBT Upload Report";
				}
				else 	if(reportId==2)
				{
             logger.info("case-2");
						cd =repManager.getRBTDownloads(reportList);
			logger.info("return val from "+cd);
                          reportHeader= TSSJavaUtil.instance().getKeyValue("RBT_Download_Report",defLangId);
				}
				if(cd <0)
				{
				%>
				<script language="JavaScript">
					alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>");
				location.href="../home.jsp"
		</script>
<%
  }
		else
		{

%>
<%@ include file = "../pagefile/headerReport.html" %>
          
								<table width="80%" border="0" align="center" cellpadding="3" cellspacing="5">
										<tr class="tableheader"> <td colspan="4"><%=reportHeader%> <BR></td>  </tr>
    <tr  class="tfields" bgcolor="#a5c7d0">
					<td><%=TSSJavaUtil.instance().getKeyValue("Content_Provider",defLangId)%> </td>
			 	<td> <%=TSSJavaUtil.instance().getKeyValue("RBT_count",defLangId)%></td>
											</tr>					
											<%
											for(int i  = 0; i <reportList.size(); i++)
											{
											  ContentProvider repU = (ContentProvider) reportList.get(i);
											%>
												<tr class="tabledata_center" <%if ( (i % 2) == 0){ %>class="rowcolor2"<%} else {%> class="rowcolor1"<%}%>   >
																<td><%=repU.getName()%></td>
																<td align="center"><%=repU.getcount()%></td>
												</tr>				
											<%}%>
								</table>
<%}%>
<%@ include file = "../pagefile/footer.html" %>
  <%
		}
		%>

											
