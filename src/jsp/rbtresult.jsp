
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.zip.*"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.io.*"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.*" %>
  <%@ include file = "conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<head>
  <script language="JavaScript">
 
  function back()
   {
      history.go(-1);
   }

</head>

<%
  Logger logger = Logger.getLogger ("rbtresult.jsp");
SubscriberProfile subscriberProfile = (SubscriberProfile)session.getAttribute("subscriberProfile");
SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
//if(sessionHistory == null || !sessionHistory.isAllowed(230))
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
	ReportUtil2 reputil = new ReportUtil2();
       reputil.setConnectionPool(conPool);
     reputil.setConnectionPool(conPool);
	ArrayList reportAl = new ArrayList();
	ContentProvider cp = new ContentProvider();
	int cpCode = Integer.parseInt(request.getParameter("contentp"));
	cp.setCode(cpCode);
	int getCp = reputil.getContentProvider(cp);

	String end = request.getParameter("end");
	String start = request.getParameter("start");
	String aggre = request.getParameter("aggre");
	String format = request.getParameter("format");

	logger.info("startdate= "+ start +" and endDt= "+end);

	int catId=-1, rbtId=-1;
	String catName="", rbtName="";
	String title = TSSJavaUtil.instance().getKeyValue("curdetailTop",defLangId);
	String nm="ContentUsage";
	int pageId = Integer.parseInt(request.getParameter("pageId"));	
	int reportId  = Integer.parseInt(request.getParameter("reportId"));
	int reportday = Integer.parseInt(request.getParameter("reportType"));  //  current=0/archive=1
if(reportday==1 && (start==null || end==null || start.equalsIgnoreCase("") || end.equalsIgnoreCase("")))
{
	%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			location.href="../home.jsp"
			</script>
			<%

}
else
{
	reputil.setStartDate(start);
	reputil.setEndDate(end);

	logger.info("startdate= "+ start +" and endDt= "+end);

	if (reportday == 1)
	{
		reputil.setAggregation(aggre);
	}
	else
	{
		reputil.setAggregation("Daily");
	}

	reputil.setFormat(format);
	//	reputil.setSubscriberType(subType);
	reputil.setPageSize(20);
	reputil.setPageNumberRbt(pageId);
	reputil.setCpCode(cpCode);

	long count=0;
	int pageCount =0;
	pageCount = reputil.generateReport(reportAl, reportday, reportId);
	logger.info("pageCount(return)= "+pageCount+" and count="+reportAl.size());
	if(pageCount<0)
	{
		%>
			<script language="JavaScript">
			alert("<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
			location.href="home.jsp?cpId=<%=cpCode%>&pageId=0&catId=7"
			</script>
			<%
	}

	if(pageId == 1 || pageCount >= pageId)
	{
		%>

			<%@include file = "../pagefile/headerReport.html"%>
			<table width="85%" border="1" cellspacing="1" cellpadding="3" align="center">
			<tr class="tableheader"> <td colspan="4"><%=title%> for <%=cp.getName()%><br><BR></td>  </tr>
			<tr>
			<td class="notice" width="50%"><%=TSSJavaUtil.instance().getKeyValue("curTotalRbt",defLangId)%> = <%=reputil.getTotalReturn()%></td>
			<td colspan="5" align="right" class="notice"><%=TSSJavaUtil.instance().getKeyValue("showing",defLangId)%> RBTs From <%=reputil.getStart()%> to <%=reputil.getEnd()%></td> 
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
					if (reportday == 0)
					{
						%>
							<tr class="tfields" bgcolor="#a5c7d0">
							<%
							for (int  i = 1; i<=reputil.getColumnCount(); i++)
							{
								%>
									<th width="20%">
									<%=reputil.getHeader(i)%></th>
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
								<td align="left"><%= stats.getDate()%></td>
								<%
								for (int i = 1; i<reputil.getColumnCount(); i++)
								{
									%>
										<td ><%= stats.getColumn(i) %></td>
										<%
								}//for
							%>
								</tr>
								<%
								row++;	
						}//while
					}
					else
					{
						%>
							<tr class="tfields" bgcolor="#a5c7d0">
							<th width="20%"><%=TSSJavaUtil.instance().getKeyValue("rbtName",defLangId)%></th>
							<th width="20%"><%=TSSJavaUtil.instance().getKeyValue("rbtCode",defLangId)%></th>
							<%
							Iterator iten = reportAl.iterator();
						ArrayList arrrbtlist = (ArrayList)iten.next();
						ArrayList arrdatelist = (ArrayList)iten.next();
						Statele statn=(Statele)iten.next();
						int numrow,numcol,rowcounter=0,colcounter=0;
						numrow=statn.getRows();
						numcol=statn.getCols();
						logger.info("numrow"+numrow+"numcol"+numcol);
						Iterator itedate = arrdatelist.iterator();
						Stat statd = new Stat();
						String dateStr;
						for (int  i = 1; i<=numcol; i++)
						{
							dateStr = (String)itedate.next();
							%>
								<th width="7%"><%=dateStr%></th>
								<%
						}
						%>
							</tr>
							<%
							Iterator ite = arrrbtlist.iterator();
						Stat stats = new Stat();
						long startc,endc,row=1;
						startc=reputil.getStart();
						endc=reputil.getEnd();
						while(ite.hasNext())
						{
							stats = (Stat)ite.next();
							%>
								<tr class="tabledata_center" <% if( (row % 2) == 0){ %> bgcolor="#ffffff" <%} else {%>bgcolor="#edf0f1"<%}%> >
								<td align="left"><%= stats.getDate()%></td>
								<td ><%= stats.getColumn(1)%></td>
								<%
								for (int i = 0; i<numcol; i++)
								{
									%>
										<td ><%= statn.getData(rowcounter,i) %></td>
										<%
								}//for
							%>
								</tr>
								<%
								rowcounter++;

						}//while

					}
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
								alert("Error!!!<%=TSSJavaUtil.instance().getKeyValue("trylater",defLangId)%>")
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
					if (reportday==0)
					{
						Iterator ite = reportAl.iterator();

						String index = "RBT Name";
						int ccount=reputil.getColumnCount();
						for (int i=2;i<=ccount;i++)
						{
							index = index+", "+reputil.getHeader(i); 
						}
						index = index + "\n";
						outstream.write(index.getBytes());
						while(ite.hasNext())
						{
							Stat stat = (Stat)ite.next();
							String printstring = stat.getDate();
							for (int i=1;i<=(ccount-1);i++)
								printstring = printstring+", "+stat.getColumn(i);
							printstring = printstring+"\n";
							outstream.write(printstring.getBytes());
						}
					}
					else
					{
						Iterator iten = reportAl.iterator();
						ArrayList arrrbtlist = (ArrayList)iten.next();
						ArrayList arrdatelist = (ArrayList)iten.next();
						Statele statn=(Statele)iten.next();
						int numrow,numcol,rowcounter=0,colcounter=0;
						numrow=statn.getRows();
						numcol=statn.getCols();
						logger.info("numrow"+numrow+"numcol"+numcol);
						Iterator itedate = arrdatelist.iterator();
						Stat statd = new Stat();
						String dateStr;
						String index = "Rbt Name, Rbt Code";	
						for (int  i = 1; i<=numcol; i++)
						{
							dateStr = (String)itedate.next();
							index = index+", "+dateStr;
							/*statd = (Stat)itedate.next();
							  index = index+", "+statd.getDate();	*/
						}
						index = index+"\n"; 
						outstream.write(index.getBytes());
						Iterator ite = arrrbtlist.iterator();
						Stat stats = new Stat();
						long startc,endc,row=1;
						startc=reputil.getStart();
						endc=reputil.getEnd();
						while(ite.hasNext())
						{
							stats = (Stat)ite.next();
							if (row>=startc && row<=endc)
							{
								String printstr = stats.getDate() +", "+stats.getColumn(1);	
								for (int i = 0; i<numcol; i++)
								{
									printstr = printstr+", "+statn.getData(rowcounter,i); 
								}
								
								printstr = printstr + "\n";	
								outstream.write(printstr.getBytes());
							}
							rowcounter++;
							row++;
						}
					}
					outstream.closeEntry();
					outstream.close();
					%>
						<tr class="bluetext"><td colspan="4" align="center"><a href="../CSVReports/<%=zipFilename%>"><%=TSSJavaUtil.instance().getKeyValue("downloadfile",defLangId)%></a></td></tr>
						<%
				}//if (Tabular)
				if( (format.equalsIgnoreCase("Tabular")) || (format.equalsIgnoreCase("Line Graph")) || (format.equalsIgnoreCase("Bar Graph")) )
				{
					if(pageCount==1)
					{
						%>  
							<tr><td class="button1"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td></tr>
							<%
					}

					%>	
						<tr><td class="pglnk" colspan="4">
						<%
						if( pageId > 1)
						{
							%>
								<a href="rbtresult.jsp?reportId=<%=reportId%>&start=<%=start%>&end=<%=end%>&&aggre=<%=aggre%>&format=<%=format%>&pageId=<%=(pageId-1)%>&reportType=<%=reportday%> ">  &lt;&lt; <%=TSSJavaUtil.instance().getKeyValue("previous",defLangId)%></a>
								<%
						}
					if(pageCount > 1 && pageId < pageCount)
					{
						%>
							&nbsp;&nbsp;&nbsp;
						<a href="rbtresult.jsp?reportId=<%=reportId%>&start=<%=start%>&end=<%=end%>&&aggre=<%=aggre%>&format=<%=format%>&pageId=<%=(pageId+1)%>&reportType=<%=reportday%> "><%=TSSJavaUtil.instance().getKeyValue("next",defLangId)%> &gt;&gt; </a>
							<%
					}
					%>
						</td></tr>
						<%
						if(pageCount>1)
						{
							%>
								<tr><td class="pagenumcurrent" colspan="2"> <%=TSSJavaUtil.instance().getKeyValue("showing",defLangId)%> page <%=pageId%> of <%=pageCount%> </td><td class="button1"><input type="button" name="Submit3" value="<%=TSSJavaUtil.instance().getKeyValue("back",defLangId)%>" onclick="return back()"></td></tr>
								<%
						}

				}
			}//else	
	}
	%>
		<%@include file = "../pagefile/footer.html"%>
		<%
		}
} //else(main)

%>
