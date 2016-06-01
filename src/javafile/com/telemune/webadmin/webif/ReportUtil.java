/*
 * This class is having all function to generate Reports.
 *
 *
 *
 */
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.text.*;
import com.telemune.dbutilities.*;
  import org.apache.log4j.*;

public class ReportUtil
{
       private static Logger logger=Logger.getLogger(ReportUtil.class);
		
	private ResultSet rs = null;
	private Connection con = null;
	private ConnectionPool conPool = null;
	private	PreparedStatement pstmt = null;

	private String time = "DD-MM-YYYY HH24";
	private String startDate = "";
	private String endDate = "";
	private String query="";

 
	public ReportUtil()
	{
	//	conPool = new ConnectionPool();
		//query="";
	}

        public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

	public void setStartDate(String start)
	{
		startDate = start;
	}
	public void setEndDate(String end)
	{
		endDate = end;
	}

public int getInvoice(Stat stat,ArrayList statsAl, int reportDay)
{

	logger.debug("in getInvoice() ");
	time ="MON-YYYY";
	try
	{
		con = conPool.getConnection();
		if(reportDay ==0) //current report
		{
			logger.info("in getInvoice() "+ startDate + " to "+endDate);
			
			//get total number of subscribers to CRBT
		query ="select count(*) TOTAL_SUBS from CRBT_SUBSCRIBER_MASTER";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs = pstmt.executeQuery ();
			if(rs.next())
			{
				stat.setColumn6(rs.getLong("TOTAL_SUBS")); // total  subscribers
				statsAl.add(stat);
			}

			rs.close();
			pstmt.close();

			//get active subscribers to CRBT
			query ="select count(*) ACTIVE_SUBS from CRBT_SUBSCRIBER_MASTER where to_date(to_char(date_registered,'MM-YYYY'),'MM-YYYY')<=to_date(to_char(sysdate,'MM-YYYY'),'MM-YYYY') and status='A' and corp_id >=0";
//			query ="select count(*) ACTIVE_SUBS from CRBT_SUBSCRIBER_MASTER where to_date(to_char(date_registered,'MM-YYYY'),'MM-YYYY')<=to_date(to_char(sysdate,'MM-YYYY'),'MM-YYYY') and status='A' and corp_id >=0 and IS_MONTHLY_CHARGEABLE='Y'";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs = pstmt.executeQuery ();
			if(rs.next())
			{
				stat.setColumn5(rs.getLong("ACTIVE_SUBS")); // active subscribers
				statsAl.add(stat);
			}

			rs.close();
			pstmt.close();

//get free trial (promotional) subscribers to CRBT
			query ="select count(*) TRIAL_SUBS from CRBT_SUBSCRIBER_MASTER where to_date(to_char(date_registered,'MM-YYYY'),'MM-YYYY')<=to_date(to_char(sysdate,'MM-YYYY'),'MM-YYYY') and status='A' and corp_id = -1";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs = pstmt.executeQuery ();
			if(rs.next())
			{
				stat.setColumn8(rs.getLong("TRIAL_SUBS")); // TRIAL subscribers
				statsAl.add(stat);
			}

			rs.close();
			pstmt.close();

		
		//get subscribers added in a given month to CRBT
			query = "select count(*) SUBSCRIPTION from CRBT_PREPAID_SUBSCRIPTION_CDR where  to_date(to_char(update_time,'MM-YYYY'),'MM-YYYY')=to_date(to_char(add_months(sysdate,0),'MM-YYYY'),'MM-YYYY') and action='S'";

			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs = pstmt.executeQuery ();

			while(rs.next())
			{
				stat.setColumn3(rs.getLong("SUBSCRIPTION"));
				statsAl.add(stat);
			}
			rs.close();
			pstmt.close();

			//get Number of IVR calls made during a month to CRBT	

			query = "select sum(num_calls) IVR_CALL from CRBT_IVR_CALL_REPORT  where to_date(to_char(call_Date,'MM-YYYY'),'MM-YYYY')=to_date(to_char(add_months(sysdate,0),'MM-YYYY'),'MM-YYYY')";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

			rs = pstmt.executeQuery();

			while(rs.next())
			{
				stat.setColumn2(rs.getLong("IVR_CALL"));
				statsAl.add(stat);
			}
			rs.close();
			pstmt.close();

			//get sms request to CRBT 		

			query = "select sum(tot_sms) SMS from crbt_sms_request_report where to_date(to_char(sms_Date,'MM-YYYY'),'MM-YYYY')=to_date(to_char(add_months(sysdate,0),'MM-YYYY'),'MM-YYYY')";
			
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery ();

			while(rs.next())
			{
				stat.setColumn1(rs.getLong("SMS"));
				statsAl.add (stat);
			}

			rs.close();
			pstmt.close();

			//get RBT Purchase for a given month from CRBT

			query="select count(*) RBT_SUBSCRIPTION from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'MM-YYYY'),'MM-YYYY')=to_date(to_char(add_months(sysdate,0),'MM-YYYY'),'MM-YYYY')";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery ();

			while(rs.next())
			{
				stat.setColumn4(rs.getLong("RBT_SUBSCRIPTION"));
				statsAl.add (stat);
			}

			rs.close();
			pstmt.close();

		} //if(reportDay)
		else if(reportDay ==1) //archieve report
		{
		
			query = "select to_char(invoice_date, '"+time+"') start_date, SMS, IVR_CALL, SUBSCRIPTION, RBT_SUBSCRIPTION, ACTIVE_SUBS, TOTAL_SUBS from  MONTHLY_INVOICE where invoice_date = to_date( ?, 'DD-MM-YYYY')";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, startDate);

			rs = pstmt.executeQuery ();
			if(rs.next())
			{
				stat.setColumn1(rs.getLong("SMS")); //  SMS
				stat.setColumn2(rs.getLong("IVR_CALL")); //  IVR call sessions
				stat.setColumn3(rs.getLong("SUBSCRIPTION")); // new subscribers
				stat.setColumn4(rs.getLong("RBT_SUBSCRIPTION")); //  rbt purchase
				stat.setColumn5(rs.getLong("ACTIVE_SUBS")); // active subscribers
				stat.setColumn6(rs.getLong("TOTAL_SUBS")); // total subscribers
				statsAl.add(stat);
			}
			else
			{
				logger.info("Invoice data not found for "+startDate);
			rs.close();
			pstmt.close();
				return -9;
			}

			rs.close();
			pstmt.close();
//get free trial (promotional) subscribers to CRBT
			/*query ="select count(*) TRIAL_SUBS from CRBT_SUBSCRIBER_MASTER where (trunc(date_registered)<=(to_date(?,'DD-MM-YYYY')) and date_registered>=to_date(?,'DD-MM-YYYY')) and status='A' and corp_id = -1";
			pstmt = con.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
      pstmt.setString(1,endDate);
			pstmt.setString(2, startDate);

			rs = pstmt.executeQuery ();
			if(rs.next())
			{
				stat.setColumn8(rs.getLong("TRIAL_SUBS")); // TRIAL subscribers
				statsAl.add(stat);
			}
			rs.close();
			pstmt.close();
*/




		} // else if(reportDay)
		return 1;
	}//try
	 catch (Exception exp)
	 {
		 try
		 {
			 if(rs != null) rs.close ();
			 if(pstmt != null) pstmt.close ();
		 }catch(SQLException sqle)
		 {
		 }
		 exp.printStackTrace ();
		 return -1;
	 }
	finally {conPool.free(con);  }

}//getInvoice()


public int getCPInvoice(Stat stat,ArrayList statsAl, int reportDay)
{

	logger.debug("in getCPInvoice() ");
	time ="MON-YYYY";
	String query,query1,query2;
	try
	{
		con = conPool.getConnection();
		if(reportDay ==0) //current report
		{
			logger.info("in getInvoice() "+ startDate + " to "+endDate);
		  ArrayList cpcodelist = new ArrayList();	
  		query1 ="select b.name name,a.code code from content_provider_webaccess a,crbt_content_provider b where a.code = b.code";
			PreparedStatement pstmt1 = con.prepareStatement(query1);
			rs = pstmt1.executeQuery();
			while(rs.next())
			{
			Stat statn = new Stat();
			statn.setDate(rs.getString("name"));
			statn.setColumn1(rs.getLong("code"));
		  	cpcodelist.add(statn);	
			}
			rs.close();
			Iterator ite = cpcodelist.iterator();
        														        		Stat stats = new Stat();
			query2 ="select sum(nm) sum_num from (select a.* from (select count(*) nm , rbt_code from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'YYYY-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') group by rbt_code) a where a.rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?))";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
																		while(ite.hasNext())
																			{
																		stats = (Stat)ite.next();
			pstmt2.setLong(1, stats.getColumn1());
			rs = pstmt2.executeQuery();
			while(rs.next())
			{
			Stat statn = new Stat();
			statn.setDate(stats.getDate());
			statn.setColumn1(stats.getColumn1());
			statn.setColumn2(rs.getLong("sum_num"));
		  statsAl.add(statn);	
			}
			}
			rs.close();   
			pstmt1.close();pstmt2.close();


		} //if(reportDay)
		else if(reportDay ==1) //archieve report
		{
		
			//query = "select to_char(invoice_date, '"+time+"') start_date, SMS, IVR_CALL, SUBSCRIPTION, RBT_SUBSCRIPTION, ACTIVE_SUBS from  MONTHLY_INVOICE where invoice_date = to_date( ?, 'DD-MM-YYYY')";
			query ="select subscriptions ,cp_name,cp_code from cp_monthly_invoice where to_date(to_char(invoice_date,'DD-MM-YYYY'),'DD-MM-YYYY') = to_date(?, 'DD-MM-YYYY')";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, startDate);

			rs = pstmt.executeQuery ();
			boolean flag1 = true;
			while(rs.next())
			{
        			flag1 = false;	
				Stat statn = new Stat();
				statn.setDate(rs.getString("cp_name")); // total SMS
				statn.setColumn1(rs.getLong("cp_code")); // total SMS
				statn.setColumn2(rs.getLong("subscriptions")); // total IVR callsrs
				statsAl.add(statn);
			}
			if (flag1 == true)
			{
				logger.info("Invoice data not found for "+startDate);
				return -9;
			}

			rs.close();
			pstmt.close();



		} // else if(reportDay)
		return 1;
	}//try
	 catch (Exception exp)
	 {
		 try
		 {
			 if(rs != null) rs.close ();
			 if(pstmt != null) pstmt.close ();
		 }catch(SQLException sqle)
		 {
		 }
		 exp.printStackTrace ();
		 return -1;
	 }
	finally {conPool.free(con);  }

}//getCPInvoice()
	public void hourTimeList(ArrayList arrList)
	{
		logger.debug("In hour time list");
		Calendar calendar = new GregorianCalendar();
		Date startTime = new Date();
		calendar.setTime(startTime);
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DATE);
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		DateStruct stDate = new DateStruct();
		stDate.DateStruct(day,month,year,0,0);
		DateStruct etDate = new DateStruct();
		etDate.DateStruct(day,month,year,hour,59);
		GregorianCalendar gc = new GregorianCalendar (stDate.yy,stDate.mm,stDate.dd,stDate.hh,stDate.mi);
		GregorianCalendar gce = new GregorianCalendar (etDate.yy,etDate.mm,etDate.dd,etDate.hh,etDate.mi);
		while(true)
		{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH");
			String dateString = formatter.format(gc.getTime());
			arrList.add(dateString);
			gc.add(Calendar.HOUR,1);
			if(gc.after(gce))
			{
				break;
			}
		}
	}//hourTimeList()

} //class ReportUtil
