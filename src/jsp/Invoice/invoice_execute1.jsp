
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "com.telemune.webadmin.webif.*" %>
<%@ page import = "java.util.zip.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "java.text.*" %>
 <%@ include file = "../conPool.jsp" %>
  <%@page import = "org.apache.log4j.*" %>
<%
     Logger logger = Logger.getLogger ("invoice_execute1.jsp");
	SessionHistory sessionHistory = (SessionHistory) session.getAttribute("sessionHistory");
	if(sessionHistory == null || !sessionHistory.isAllowed(100))
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
		int reportday = Integer.parseInt(request.getParameter("reportType"));  //  current=0/archive=1
		String month="xx",year="xxxx";
		int mnt = -1, yr =-1,mnt1=-1;
		String startdate="";
		String enddate="";
		String title=TSSJavaUtil.instance().getKeyValue("invoiceExTop",defLangId)+" - ";

		if(reportday == 0) //Current
		{
		        Date now = new Date();
			GregorianCalendar cal = new GregorianCalendar();
			logger.info("webadmin/Invoice: Current date: s="+now);
			yr = cal.get(Calendar.YEAR);
			mnt = cal.get(Calendar.MONTH)+1;
			mnt1 = mnt;
			year = yr +"";
		}
		if(reportday == 1) //Archieve
		{
		 month = request.getParameter("month");
		 year = request.getParameter("year");
		 mnt = Integer.parseInt(request.getParameter("month"));
		 yr = Integer.parseInt(request.getParameter("year"));

		 //mnt1 = mnt +1 ;
		 mnt1 = mnt ;
	 	logger.info("webadmin/Invoice: selected month="+mnt+" and  year="+yr);
		}
		switch(mnt1)
		{
		  case 1:
		    month="January";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="31-0"+mnt1+"-"+year;
		    break;
		  case 2:
		    month="February";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="29-0"+mnt1+"-"+year;
		    break;
		  case 3:
		    month="March";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="31-0"+mnt1+"-"+year;
		    break;
		  case 4:
		    month="April";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="30-0"+mnt1+"-"+year;
		    break;
		  case 5:
		    month="May";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="31-0"+mnt1+"-"+year;
		    break;
		  case 6:
		    month="June";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="30-0"+mnt1+"-"+year;
		    break;
		  case 7:
		    month="July";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="31-0"+mnt1+"-"+year;
		    break;
		  case 8:
		    month="August";
		    startdate="01-0"+mnt1+"-"+year;
		    enddate="31-0"+mnt1+"-"+year;
		    break;
		  case 9:
		    month="September";
		    startdate="01-"+mnt1+"-"+year;
		    enddate="30-"+mnt1+"-"+year;
		    break;
		  case 10:
		    month="October";
		    startdate="01-"+mnt1+"-"+year;
		    enddate="31-"+mnt1+"-"+year;
		    break;
		  case 11:
		    month="November";
		    startdate="01-"+mnt1+"-"+year;
		    enddate="30-"+mnt1+"-"+year;
		    break;
		  case 12:
		    month="December";
		    startdate="01-"+mnt1+"-"+year;
		    enddate="31-"+mnt1+"-"+year;
		    break;
		} //switch
					
		ReportUtil repUtil = new ReportUtil();
          repUtil.setConnectionPool(conPool);

      		Stat stat = new Stat();
		ArrayList reportAl = new ArrayList();
		repUtil.setStartDate(startdate);
		repUtil.setEndDate(enddate);
		int ret = repUtil.getCPInvoice(stat,reportAl,reportday);
		if (ret == -1)
		{
			logger.info("webadmin/Invoice: Invoice Error try again plz");
		%>
		<script language="JavaScript">

			alert("Please Try again")
    			history.go(-1)
			//window.location = "invoice.jsp";
		</script>
	<%}	
		else{
%>

<%@ include file = "../pagefile/header.html" %>
    <table width="90%" border="0" align="center" cellpadding="2" cellspacing="4">
	<tr class="t1"><td colspan="4"><%=title%><%=month%>, <%=year%> </td></tr>
	<%
		if(ret == -9)
		{
	%>
	<tr class="notice"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%>. </td></tr>
	<%}
	else
	{%>
	 <tr><td colspan="8">
    	   <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
	   	<tr class="tfields"><td width="60%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpname",defLangId)%></td>
		    <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpcode",defLangId)%></td>
		    <td width="20%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpNumSubs",defLangId)%></td>
		</tr>
		<%
																		Iterator ite = reportAl.iterator();
																		Stat stats = new Stat();
																				while(ite.hasNext())
																				{
																						stats = (Stat)ite.next();
		
		%>
		<tr class="normaltext">
		   <td><%=stats.getDate()%></tD>
		   <td><%=stats.getColumn1()%></tD>
		   <td><%=stats.getColumn2()%></tD>
               </tr>	

		   <%
		   }
		   %>
	   </table>
	  </td></tr> 

   <!-- </table> -->
    <%

	    String filename = new String("Invoice");
	    SimpleDateFormat formatter = new SimpleDateFormat("ddMMMyyyyhhmmss");
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
			    logger.info("webadmin/Invoice: Could not create zip file : " + filepath + ",Pl.check directory permissions");
			    %>
				    <script language="JavaScript">
				    alert("Error!!! Try Again")
				    window.location="invoice.jsp"
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
	    ZipEntry e1 = new ZipEntry(filename);
	    e1.setMethod(ZipEntry.DEFLATED);
	    outstream.putNextEntry(e1);
		String header = title + " "+month+" - "+year +"\n\n";
	            outstream.write(header.getBytes());

	     String index =TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpname",defLangId)+"        " + "," +TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpcode",defLangId)+ "    "+ ","+TSSJavaUtil.instance().getKeyValue("invoiceEx1_contentpNumSubs",defLangId)+ "   "+"\n";
	      outstream.write(index.getBytes());
	    logger.info(index);
	      
																		Iterator iten = reportAl.iterator();
																		Stat statn = new Stat();
																		String printstring1;
																		while(iten.hasNext())
																		{
																		statn = (Stat)iten.next();
              printstring1 = statn.getDate() + "," + statn.getColumn1() +",     "+ statn.getColumn2()+ "\n";
	      outstream.write(printstring1.getBytes());
																		}
	   outstream.closeEntry();
	    outstream.close();
	    %>
	    <tr class="bluetext"><td colspan="4" align="center"><a href="../CSVReports/<%=zipFilename%>"><%=TSSJavaUtil.instance().getKeyValue("downloadfile",defLangId)%></a></td></tr>

    <%}}//else%>
   </table>
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>

