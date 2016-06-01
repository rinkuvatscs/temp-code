
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
   Logger logger = Logger.getLogger ("invoice_execute.jsp");
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
		logger.info("startDate= "+startdate+ " enddate="+enddate);			
		ReportUtil repUtil = new ReportUtil();
           repUtil.setConnectionPool(conPool);
      		Stat stat = new Stat();
		ArrayList reportAl = new ArrayList();
		repUtil.setStartDate(startdate);
		repUtil.setEndDate(enddate);
		int ret = repUtil.getInvoice(stat,reportAl,reportday);
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
		

		/** calculate subscription revenue	**/
		double totalSUB = stat.getColumn3();
		int unit_sub = 75;
		double total_sub_cost = totalSUB * unit_sub;
		double cw_cost_sub = Math.floor((((total_sub_cost * 40)/100)*100)+0.5)/100.00;
		double ts_cost_sub = Math.floor((((total_sub_cost * 60)/100)*100)+0.5)/100.00;
		double cp_cost_sub = total_sub_cost * 0;


		// calculate RBT purchase revenue	
		double totalRBT = stat.getColumn4();
		int unit_rbt = 130;
		double total_rbt_cost = totalRBT * unit_rbt; //total
		double cw_cost_rbt = Math.floor((((total_rbt_cost * 20)/100)*100)+0.5)/100.0; //C&W
		double ts_cost_rbt = Math.floor((((total_rbt_cost * 30)/100)*100)+0.5)/100.0; //TELEMUNE
		double cp_cost_rbt = Math.floor((((total_rbt_cost * 50)/100)*100)+0.5)/100.0; //Content Provider

		// calculate IVR calls revenue	
		double totalIVR = stat.getColumn2();
		int unit_ivr = 20;
		double total_ivr_cost = totalIVR * unit_ivr; //total
		double cw_cost_ivr = Math.floor((((total_ivr_cost * 40)/100)*100)+0.5)/100.0;  //C&W
		double ts_cost_ivr = Math.floor((((total_ivr_cost * 60)/100)*100)+0.5)/100.0;  //TELEMUNE
		double cp_cost_ivr = total_ivr_cost * 0;  //Content Provider

		// calculate SMS  revenue	
		double totalSMS = stat.getColumn1();
		int unit_sms = 3;
		double total_sms_cost = totalSMS * unit_sms; //total
		double cw_cost_sms = Math.floor((((total_sms_cost * 40)/100)*100)+0.5)/100.0; //C&W
		double ts_cost_sms = Math.floor((((total_sms_cost * 60)/100)*100)+0.5)/100.0; //TELEMUNE
		double cp_cost_sms = total_sms_cost * 0; //Content Provider
		
		double total_all = total_sub_cost + total_rbt_cost + total_ivr_cost+ total_sms_cost; //grandtotal
		double total_all_cw = cw_cost_sub + cw_cost_rbt + cw_cost_ivr+ cw_cost_sms;  // total for C&W
		double total_all_ts = ts_cost_sub + ts_cost_rbt + ts_cost_ivr+ ts_cost_sms;  // total for TELEMUNE
		double total_all_cp = cp_cost_sub + cp_cost_rbt + cp_cost_ivr+ cp_cost_sms;  // total for Content Provider
%>

<%@ include file = "../pagefile/header.html" %>
    <table width="95%" border="0" align="center" cellpadding="2" cellspacing="4">
	<tr class="t1"><td colspan="4"><%=title%><%=month%>, <%=year%> </td></tr>
	<%
		if(ret == -9)
		{
	%>
	<tr class="notice"><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("nodatafound",defLangId)%></td></tr>
	<%}
	else
	{%>
	<tr class="t1"> 
	           <td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("invoiceExTotSub",defLangId)%> = <%=stat.getColumn6()%></td>
						 <td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("invoiceExActiveSub",defLangId)%>= <%=stat.getColumn5()%></td>
		 </tr>
		 <% if(reportday==0){%>	<tr class="t1"><tD><td colspan="4"><%=TSSJavaUtil.instance().getKeyValue("invoiceExPromoSub",defLangId)%>= <%=stat.getColumn8()%></td></tr><%}%>
	 <tr><td colspan="8">
    	   <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
	   	<tr class="tfields">
				 	<td width="20%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol1",defLangId)%>   </td>
		    <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol2",defLangId)%>   </td>
		    <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol3",defLangId)%> (JMD$)</td>
		    <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol4",defLangId)%> (JMD$)</td>
		    <td width="10%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol5",defLangId)%> </td>
		    <td width="11%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol6",defLangId)%> </td>
		    <td width="15%"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol7",defLangId)%></td>
		</tr>
		<tr class="normaltext">
		   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_r1c1",defLangId)%></td>
		   <td><%=stat.getColumn3()%></tD>
		   <td><%=unit_sub%></td>
		   <td><font color="#669900"><%=total_sub_cost %></font> </td>
		   <td><font color="#993300"><%=cw_cost_sub%></font> </td>
		   <td><font color="#ff9933"><%=ts_cost_sub%></font> </td>
		   <td><font color="#cc9966"><%=cp_cost_sub%></font> </td>
               </tr>	
		<tr class="normaltext">
		   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_r2c1",defLangId)%></td>
		   <td><%=stat.getColumn4()%></tD>
		   <td><%=unit_rbt%></td>
		   <td><font color="#669900"><%=total_rbt_cost %></font> </td>
		   <td><font color="#993300"><%=cw_cost_rbt%></font> </td>
		   <td><font color="#ff9933"><%=ts_cost_rbt%></font> </td>
		   <td><font color="#cc9966"><%=cp_cost_rbt%></font> </td>
               </tr>	
		<tr class="normaltext">
		   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_r3c1",defLangId)%></td>
		   <td><%=stat.getColumn2()%></tD>
		   <td><%=unit_ivr%></td>
		   <td><font color="#669900"><%=total_ivr_cost %> </td>
		   <td><font color="#993300"><%=cw_cost_ivr%></font> </td>
		   <td><font color="#ff9933"><%=ts_cost_ivr%></font> </td>
		   <td><font color="#cc9966"><%=cp_cost_ivr%></font> </td>
               </tr>	
		<tr class="normaltext">
		   <td><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_r4c1",defLangId)%></td>
		   <td><%=stat.getColumn1()%></tD>
		   <td><%=unit_sms%></td>
		   <td><font color="#669900"><%=total_sms_cost %></font> </td>
		   <td><font color="#993300"><%=cw_cost_sms%></font> </td>
		   <td><font color="#ff9933"><%=ts_cost_sms%></font> </td>
		   <td><font color="#cc9966"><%=cp_cost_sms%></font> </td>
               </tr>	
	       <tr><td colspan="7">&nbsp;</td></tr>
	       <tr class="normaltext"><td><b><%=TSSJavaUtil.instance().getKeyValue("invoiceEx_total",defLangId)%>(JMD$)</b></td>
	       	   <td>&nbsp;</td>
	      	   <td>&nbsp;</td>
	           <td><font color="#669900"><b><%=total_all%></b></font></td>
	           <td><font color="#993300"><b><%=total_all_cw%></b></font></td>
	           <td><font color="#ff9933"><b><%=total_all_ts%></b></font></td>
	           <td><font color="#cc9966"><b><%=total_all_cp%></b></font></td>
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
		String header1="";
		if(reportday==0)
	        header1 = TSSJavaUtil.instance().getKeyValue("invoiceExTotSub",defLangId)+","+ stat.getColumn6()+"\n\n"+TSSJavaUtil.instance().getKeyValue("invoiceExActiveSub",defLangId)+"," +" "+ stat.getColumn5()+"\n\n"+TSSJavaUtil.instance().getKeyValue("invoiceExPromoSub",defLangId)+","+" "+stat.getColumn8();
    else 
					 header1 =TSSJavaUtil.instance().getKeyValue("invoiceExTotSub",defLangId)+", "+ stat.getColumn6()+"\n\n"+TSSJavaUtil.instance().getKeyValue("invoiceExActiveSub",defLangId)+", "+ stat.getColumn5();
	            outstream.write(header.getBytes());
	            outstream.write(header1.getBytes());
	    	logger.info(header1);

	     String index =TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol1",defLangId)  + "," + TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol2",defLangId)+ ","+TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol3",defLangId)+" (JMD$)   " + "," +TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol4",defLangId) +" (JMD$) ," +TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol5",defLangId)+","+TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol6",defLangId)+" ,   "+TSSJavaUtil.instance().getKeyValue("invoiceEx_tabCol7",defLangId)+"\n";
	      outstream.write(index.getBytes());
	    logger.info(index);
	      
              String printstring1 = TSSJavaUtil.instance().getKeyValue("invoiceEx_r1c1",defLangId) + "," + totalSUB +",     "+ unit_sub +",     " + total_sub_cost  + ",     " + cw_cost_sub+ ",     " + ts_cost_sub+ ",      "+ cp_cost_sub+ "\n";
	      outstream.write(printstring1.getBytes());
	    logger.info(printstring1);
	      
              String printstring2 =TSSJavaUtil.instance().getKeyValue("invoiceEx_r2c1",defLangId) + "," + totalRBT +",      "+ unit_rbt +",     " + total_rbt_cost  + ",     " + cw_cost_rbt+ ",     " + ts_cost_rbt+ ",     "+ cp_cost_rbt+ "\n";
	      outstream.write(printstring2.getBytes());
	    logger.info(printstring2);
              
	      String printstring3 =TSSJavaUtil.instance().getKeyValue("invoiceEx_r3c1",defLangId) + "," + totalIVR +",     "+ unit_ivr +",     " + total_ivr_cost  + ",     " + cw_cost_ivr+ ",     " + ts_cost_ivr+ ",     "+ cp_cost_ivr+ "\n";
	      outstream.write(printstring3.getBytes());
	    logger.info(printstring3);
	   
	      String printstring4 =TSSJavaUtil.instance().getKeyValue("invoiceEx_r4c1",defLangId) + "," + totalSMS +",      "+ unit_sms +",     " + total_sms_cost  + ",     " + cw_cost_sms+ ",     " + ts_cost_sms+ ",     "+ cp_cost_sms+ "\n";
	      outstream.write(printstring4.getBytes());
	    logger.info(printstring4);

	      String printstring5 =TSSJavaUtil.instance().getKeyValue("invoiceEx_total",defLangId)+" (JMD$) " + "," + ",     " +",     "+  total_all  + ",       " + total_all_cw+ ",     " + total_all_ts+ ",      "+ total_all_cp+ "\n";
	      outstream.write(printstring5.getBytes());
	    logger.info(printstring5);

	   outstream.closeEntry();
	    outstream.close();
	    %>
	    <tr class="bluetext"><td colspan="4" align="center"><a href="../CSVReports/<%=zipFilename%>"><%=TSSJavaUtil.instance().getKeyValue("downloadfile",defLangId)%></a></td></tr>
	   
	   <% if (reportday == 0) 
	   {
	   %> 
	    <tr class="bluetext"><td colspan="4" align="center"><a href="invoice_execute1.jsp?reportType=<%=reportday%>"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx1_rbtpurchase",defLangId)%></a></td></tr>
	    <%}else{ %>
	    <tr class="bluetext"><td colspan="4" align="center"><a href="invoice_execute1.jsp?reportType=<%=reportday%>&month=<%=mnt1%>&year=<%=year%>"><%=TSSJavaUtil.instance().getKeyValue("invoiceEx1_rbtpurchase",defLangId)%></a></td></tr>

    <%}}}//else%>
   </table>
<%@ include file = "../pagefile/footer.html" %>
<%
	}

%>

