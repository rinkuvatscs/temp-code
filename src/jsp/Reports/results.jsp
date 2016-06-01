<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "org.jfree.chart.*" %>
<%@ page import = "java.util.zip.*"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.io.*"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "java.text.SimpleDateFormat" %>
  <%@ include file = "../conPool.jsp" %>
<%@ page import = "org.jfree.chart.entity.StandardEntityCollection" %>
<%@ page import = "org.jfree.data.category.DefaultCategoryDataset" %>
 <%@page import = "org.apache.log4j.*" %>
<%
 Logger logger = Logger.getLogger ("results.jsp");
SubscriberProfile subscriberProfile = (SubscriberProfile)session.getAttribute("subscriberProfile");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
if(sessionHistory == null)
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
	ArrayList reportAl = new ArrayList();
	ReportUtil2 reputil = new ReportUtil2();
        reputil.setConnectionPool(conPool);
	long count=0;
	int pageCount =0;
  int rbtId = -1, catId =-1;
	int lookif  = Integer.parseInt(request.getParameter("lookif"));
	int reportId  = Integer.parseInt(request.getParameter("reportId"));
	String cpName = request.getParameter("cpName");
	int reportday = 0;
	String format = "Tabular";
	String start = "",end = "" ,aggre = "";
	if(lookif == 1 ) // from report1.jsp
	{
					//rbtId and catId is extacted from @getvalue param of report1.jsp( rbt list box) 
					String getvalue= request.getParameter("getvalue");
					int offset = getvalue.indexOf(',');
					rbtId = Integer.parseInt(getvalue.substring(0,offset));
					catId = Integer.parseInt(getvalue.substring(offset+1,getvalue.length()));
					logger.info("getvalue="+ getvalue+" offset="+offset);
	}
	else if(lookif == 0 ) // from report.jsp
	{
					rbtId = Integer.parseInt(request.getParameter("rbt_id"));
					catId = Integer.parseInt(request.getParameter("cat_id"));
	}
	else if(lookif == 2 ) // from result.jsp Previous/Next
	{
					rbtId = Integer.parseInt(request.getParameter("rbt_id"));
					catId = Integer.parseInt(request.getParameter("cat_id"));
	}
	logger.info(" rbtId= "+rbtId+" catId="+catId);

/* * hence rbtNAme and CatNAme found in TSSJavaUtil * */
  String rbtName = TSSJavaUtil.instance().getRbtName(Integer.toString(rbtId));
  String catName = TSSJavaUtil.instance().getCategoryName(Integer.toString(catId));
	logger.info("rbtName="+ rbtName+" catNAme="+catName);
  if (reportId != 2)
	{
	end = request.getParameter("end");
	reportday = Integer.parseInt(request.getParameter("reportType"));  //  current=0/archive=1
	start = request.getParameter("start");
	aggre = request.getParameter("aggre");
	reputil.setStartDate(start);
	reputil.setEndDate(end);
	logger.info("startdate= "+ start +" and endDt= "+end);
	if (reportday == 1)
	{
		reputil.setAggregation(aggre);
	}
	}
	format = request.getParameter("format");
	reputil.setFormat(format);

	int pageId    = Integer.parseInt(request.getParameter("pageId"));
  String setting="";	
	String title ="";
	String nm ="";
	switch(reportId)
	{
		case 1:
			title = TSSJavaUtil.instance().getKeyValue("curRBTsubs",defLangId);
	  	nm = "RBTSubStats";
			break;
		case 2:
			title = TSSJavaUtil.instance().getKeyValue("curSUBmsisdn",defLangId);
			nm = "SysStats";
			break;
		case 10:
			title = TSSJavaUtil.instance().getKeyValue("curRbtUsage",defLangId);
			nm = "IVRStats";
			break;
		case 4:
			title = TSSJavaUtil.instance().getKeyValue("curSMSChange",defLangId);
			nm = "SmsStats";
			break;
	
	}


	reputil.setRBTId(rbtId);
	//reputil.setFormat(format);
	reputil.setPageNumber(pageId);

	pageCount = reputil.generateReport(reportAl, reportday, reportId);
	logger.info("pageCount(return)= "+pageCount+" and count="+reportAl.size());
	
	if(pageCount<0)
	{
	  if(reportId ==2)
		{
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			location.href="report2.jsp?reportId=<%=reportId%>&a=1"
		</script>
<%
   }
	 else if(reportId ==10)
	 {
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			location.href="report1.jsp?reportId=<%=reportId%>&a=1"
		</script>
<%
   }
	 else
	 {
%>
		<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			location.href="report.jsp?reportId=<%=reportId%>&a=1"
		</script>
<%
   }

	}
	else
	{
		if(pageId == 1 || pageCount >= pageId)
		{
%>
<html>
<head>
  <script language="JavaScript">
function back()
{
history.go(-1);
}
</script>
</head>

<%@include file = "../pagefile/headerReport.html"%>

     <table width="90%" border="0" cellspacing="1" cellpadding="3" align="center">
          <tr class="tableheader"> <td colspan="4"><%=title%> for <%=cpName%><BR></td>  </tr>
					<tr>
					   <td colspan=4 class="notice">#<%=TSSJavaUtil.instance().getKeyValue("rbtName",defLangId)%>: <font size="2"><%=rbtName%></font> &nbsp;&nbsp; #<%=TSSJavaUtil.instance().getKeyValue("cat",defLangId)%>: <font size="2"><%=catName%></font></td>
					</tr>	 
<%
			if(pageCount==0)
			{
%>
  	<tr class="notice"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%></td></tr>
<%
			}
			else
			{
				if(format.equalsIgnoreCase("Tabular"))		// Tabular reports starts here
				{
%>
    <tr class="tfields" bgcolor="#a5c7d0">
      <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("date",defLangId)%></td>
<%
					for (int  i = 1; i<=reputil.getColumnCount(); i++)
					{
%>
           <%if(reportId==2){%><td width="20%"><%}
					 	 else if((reportId==1||reportId==10) && !setting.equalsIgnoreCase("")){%> <td width="30%"><%}
					   else if((reportId==1||reportId==10) && setting.equalsIgnoreCase("")){%>	 <td width="35%"><%}
					   else if(reportId==5){%> <td width="15%"><%}
						 else{%><td width="20%"><%}%>
					 <%=reputil.getHeader(i)%></td>
<%
					}
%>
    </tr>
<%
					Iterator ite = reportAl.iterator();
					Stat stats = new Stat();
			int row=0;		
			while(ite.hasNext())
					{
						stats = (Stat)ite.next();
%>
    <tr class="tabledata_center" <% if( (row % 2) == 0){ %> bgcolor="#ffffff" <%} else {%>bgcolor="#edf0f1"<%}%> >
		<td ><%= stats.getDate()%></td>
<%
						for (int i = 1; i<=reputil.getColumnCount(); i++)
						{
%>
      <td ><%= stats.getColumn(i) %></td>
<%
						}
%>
    </tr>
<%
				row++;	}
%>
  <!-- </table> -->
<%
				}

				else if(format.equalsIgnoreCase("Bar Graph"))
				{
					logger.info("Generating BAR Graph");
					Date date = new Date();
					String filename = new String("temp"+date.getTime()+".jpeg");
					String filepath = application.getRealPath("/") + "GraphReports";
					File graphDir = new File(filepath);
								// if dir(s) does not exist create it
					if (!graphDir.exists()) 
					{
						graphDir.mkdirs();
					}
					filepath = graphDir.getPath() + "/"+filename;
					org.jfree.data.category.DefaultCategoryDataset defaultCategoryDataset = new org.jfree.data.category.DefaultCategoryDataset();
					Iterator ite = reportAl.iterator();
					Stat stats = new Stat();
					while(ite.hasNext())
					{
						stats = (Stat)ite.next();
						for (int i = 1; i <= reputil.getColumnCount(); i++)
						{
						defaultCategoryDataset.addValue(new Long(stats.getColumn(i)), reputil.getHeader(i), stats.getDate());
						}
					}
					org.jfree.chart.JFreeChart chart = com.telemune.webadmin.webif.AdminChartBean.getChart(title, "Dates", "Value", defaultCategoryDataset);
					logger.info("created chart ");
					ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
					File imgFile = new File(filepath);
					int width=650, height=450;
					float quality=1.0f; // range can be 0.0f to 1.0f
					ChartUtilities.saveChartAsJPEG(imgFile, quality, chart, width, height, info);
%>
<!--	<TABLE> -->
	<TR ><TD ><IMG SRC="GraphReports/<%=filename%>" ALT="<%=title%>" WIDTH="<%=width%>" HEIGHT="<%=height%>" BORDER="1" ALIGN="MIDDLE"></TD></TR>
<%
				}

				
				else if(format.equalsIgnoreCase("Line Graph"))
				{
					logger.info("Generating Line Graph");
					Date date = new Date();
					String filename = new String("temp"+date.getTime()+".jpeg");
					String filepath = application.getRealPath("/") + "GraphReports";
					File graphDir = new File(filepath);
								// if dir(s) does not exist create it
					if (!graphDir.exists()) 
					{
						graphDir.mkdirs();
					}
					filepath = graphDir.getPath() + "/"+filename;
					org.jfree.data.category.DefaultCategoryDataset defaultCategoryDataset = new org.jfree.data.category.DefaultCategoryDataset();
					Iterator ite = reportAl.iterator();
					Stat stats = new Stat();
					while(ite.hasNext())
					{
						stats = (Stat)ite.next();
						for (int i = 1; i <= reputil.getColumnCount(); i++)
						{
						defaultCategoryDataset.addValue(new Long(stats.getColumn(i)), reputil.getHeader(i), stats.getDate());
						}
					}
					org.jfree.chart.JFreeChart chart = com.telemune.webadmin.webif.AdminChartBean.getChart1(title, "Dates", "Value", defaultCategoryDataset);
					ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
					File imgFile = new File(filepath);
					int width=650, height=450;
					float quality=1.0f; // range can be 0.0f to 1.0f
					ChartUtilities.saveChartAsJPEG(imgFile, quality, chart, width, height, info);
%>
<!--			<TABLE> -->
	<TR ><TD ><IMG SRC="GraphReports/<%=filename%>" ALT="<%=title%>" WIDTH="<%=width%>" HEIGHT="<%=height%>" BORDER="1" ALIGN="MIDDLE"></TD></TR>
<!--					</TABLE>-->
<%
				}

        else if(format.equalsIgnoreCase("CSV"))
				{
					logger.info("Generating CSV file");
					Date date = new Date();
					String filename = new String(nm);
					SimpleDateFormat formatter = new SimpleDateFormat("ddMMyyyyhhmmss");
					String dt = formatter.format(new Date());
					filename += dt+".zip";
					String filepath = application.getRealPath("/") + "CSVReports";
					File csvDir = new File(filepath);
					if (!csvDir.exists()) 
					{
						csvDir.mkdirs();
					}
					filepath = csvDir.getPath() + "/"+filename;
					String zipFilename = new String("");
					zipFilename = filename;
					ZipOutputStream outstream = null; 
					try
					{
						File zipFile = new File(filepath);
						if(! zipFile.createNewFile())
						{
							logger.info("Could not create zip file : " + filepath + ",Pl.check directory permissions");
%>
							<script language="JavaScript">
								alert("Error!!! <%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
								window.location="results.jsp"
							</script>
<%
						}
						outstream = new ZipOutputStream (new FileOutputStream(zipFile));
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}			
					filename +=  "temp.csv";
						//logger.info(filename);
					ZipEntry e1 = new ZipEntry(filename);
					e1.setMethod(ZipEntry.DEFLATED);
					outstream.putNextEntry(e1);
					Iterator ite = reportAl.iterator();
					
					/*String index = "RBT Name= "+rbtName+"  "+"Category="+catName+ "\n\n"+ "Date" + ", " + "Default Settings" + ", " + "Friend Settings" +", "+"Group Settings"+", "+ "Day-Date Settings"+", " +"Total RBT Users"+ "\n";
					outstream.write(index.getBytes());
					while(ite.hasNext())
					{
						Stat stat = (Stat)ite.next();
						String printstring = stat.getDate()+ ", " + stat.getColumn1()+ ", " + stat.getColumn2()  +", "+ stat.getColumn3()+", "+ stat.getColumn4()+", "+ stat.getColumn5()+ "\n";
						outstream.write(printstring.getBytes());
					}*/
					String index = "RBT Name= "+rbtName+"  "+"Category="+catName+ "\n\n"+ "Date";
          int ccount=reputil.getColumnCount();
					for (int i=1;i<=ccount;i++)
					{
					index = index+", "+reputil.getHeader(i); 
					}
					index = index + "\n";
					outstream.write(index.getBytes());
						Stat stat = new Stat();
					while(ite.hasNext())
					{
						stat = (Stat)ite.next();
						String printstring = stat.getDate();
						for (int i=1;i<=ccount;i++)
						{
						printstring = printstring+", "+stat.getColumn(i);
						}
						printstring = printstring+"\n";
						outstream.write(printstring.getBytes());
					}
					outstream.closeEntry();
					outstream.close();
%>
                <tr class="bluetext"><td colspan="4" align="center"><a href="../CSVReports/<%=zipFilename%>"><%=TSSJavaUtil.instance().getKeyValue("downloadfile",defLangId)%></a></td></tr>
<%
				}

        if( (format.equalsIgnoreCase("Tabular")) || (format.equalsIgnoreCase("Line Graph")) || (format.equalsIgnoreCase("Bar Graph")) )
        {
					if(pageCount==1)
					{
%>  
        <!--		         <tr><td class="button1"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td></tr>-->
<%
					}
%>
            <tr ><td class="pglnk" colspan="4">
<%
          if( pageId > 1)
          {
%>
		<a href="results.jsp?reportId=<%=reportId%>&start=<%=start%>&end=<%=end%>&aggre=<%=aggre%>&format=<%=format%>&pageId=<%=(pageId-1)%>&reportType=<%=reportday%>&lookif=2&rbt_id=<%=rbtId%>&cat_id=<%=catId%>&setting=<%=setting%>&cpName=<%=cpName%>">  &lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a>
<%
					}
          if(pageCount > 1 && pageId < pageCount)
          {
%>
			&nbsp;&nbsp;&nbsp; 
		<a href="results.jsp?reportId=<%=reportId%>&start=<%=start%>&end=<%=end%>&aggre=<%=aggre%>&format=<%=format%>&pageId=<%=(pageId+1)%>&reportType=<%=reportday%>&lookif=2&rbt_id=<%=rbtId%>&cat_id=<%=catId%>&setting=<%=setting%>&cpName=<%=cpName%>"><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt; </a>
<%
					}
%>
	</td></tr>			
<%
					if(pageCount>1)
					{
%>  
		<tr>
						<td class="pagenumcurrent" colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("showing",defLangId)%> page <%=pageId%> of <%=pageCount%> </td>
				<!-- <td class="button1"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td>-->
		</tr>
<%
					}
				}
			}
%>
		</table>
<%@include file = "../pagefile/footer.html"%>
<%
		}
	}
}
%>
