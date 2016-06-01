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
import com.telemune.webadmin.webif.Statele;
  import org.apache.log4j.*;

public class ReportUtil2
{
       private static Logger logger=Logger.getLogger(ReportUtil2.class);
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	private ResultSet rs2 = null;
	private ResultSet rs3 = null;
	private ResultSet rs4 = null;
	private Connection con = null;
	private ConnectionPool conPool = null;
	private	PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private PreparedStatement pstmt2 = null;

	private String time = "DD-MM-YYYY HH24";
	private String aggregation = "Hourly";
	private String format = "";
	private String startDate = "";
	private String endDate = "";
	private String subquery = "";
	private String subType = "";
	private String setting="";
	private String rbtName = "";
	private int rbtId = -1;
	private int pageSize = 20;
	private String header1 = "";
	private String header2 = "";
	private String header3 = "";
	private String header4 = "";
	private String header5 = "";
	private String query="";
	private String query1="";
	private String query2="";
	private String query3="";
	private String query4="";
	private int columnCount = 0;
	private int cat_id, cpCode;
	
 long start=0,end=0,retVal=0;
 private int totalReturn=0; 
 public void setConnectionPool(ConnectionPool conPool)
	{
		this.conPool = conPool;			
	}

	public ConnectionPool getConnectionPool()
	{
		return conPool;		
	}

 
	public ReportUtil2()
	{
	//	conPool = new ConnectionPool();
	//	logger.info("in ReportUtil2()"+conPool);
	}
	public void setAggregation(String aggre)
	{
		this.aggregation = aggre;
		if (aggre.equalsIgnoreCase ("Hourly"))
				time = "DD-MM-YYYY HH24";
		else if (aggre.equalsIgnoreCase ("Daily"))
			time = "DD-MM-YYYY";
		else if(aggre.equalsIgnoreCase ("Monthly"))
			time = "MON-YYYY";
		else if(aggre.equalsIgnoreCase ("Yearly"))
			time = "YYYY";
	}
	public void setSubscriberType(String sub)
	{
		this.subType = sub;
		if (!sub.equalsIgnoreCase("B"))
		{
			subquery = " and subscriber_type = ? ";
		}
	} 
	public void setPageNumberRbt(int pageId)
	{
		start = ((pageId-1) * pageSize) + 1;
		end = start + pageSize - 1;
	}
	public void setPageNumber(int pageId)
	{
		start = ((pageId-1)*10)+1;
		end = start+10;
	}
	public void setStartDate(String start)
	{
		startDate = start;
	}
	public void setEndDate(String end)
	{
		endDate = end;
	}
	public void setSetting(String setting)
	{
		this.setting=setting;
	}
	public void setRBTName(String rbtName)
	{
		this.rbtName = rbtName;
	}
	public void setRBTId(int rbt)
	{
		this.rbtId = rbt;
	}
	public void setFormat(String format)
	{
		this.format = format;
	}
	public void setCpCode(int cpCode)
	{
		this.cpCode = cpCode;
	}
	public void setPageSize(int pageSize)
	{
		this.pageSize = pageSize;
	}
	public void setCatId(int cat_id)
	{
		this.cat_id = cat_id;
	}
	
	public long getStart()
	{
		return start;
	}
	public long getEnd()
	{
		return end;
	}
	public int getTotalReturn()
	{
		return totalReturn;
	}
	public int getPageSize()
	{
		return pageSize;
	}
	
	public int getColumnCount()
	{
		return columnCount;
	}
	public String getHeader(int i)
	{
		if (i == 1)
		{
			return header1;
		}
		else if (i == 2)
		{
			return header2;
		}
		else if (i == 3)
		{
			return header3;
		}
		else if (i == 4)
		{
			return header4;
		}
		else if (i == 5)
		{
			return header5;
		}
		else 
		{
			return "";
		}
	} //getHeader()
  
	public int generateReport(ArrayList reportAl, int duration, int reportId)
	{
		logger.info("in generateReport()"+ reportId+" " + duration);
	  int due = duration; // current=0, archive=1
		
		switch (reportId)
		{
			case 0:
				if (due == 0)
				{
					return rbtDetailStatsCurrent(reportAl);
				}
				else
				{
					return rbtDetailStatsArchive(reportAl);
				}

			case 1:
				if (due == 0)
				{
					return rbtStatsCurrent(reportAl);
				}
				else
				{
					return rbtStatsArchieve(reportAl);
				}
			case 10:
				if (due == 0)
				{
					return rbtStatsCurrent(reportAl);
				}
				else
				{
					return rbtStatsArchieve(reportAl);
				}
			case 2:
					 time ="DD-MM-YYYY HH24:mi:ss";
			   	 return rbtSubscriberList(reportAl);
			case 5:
					 return topRbtList(reportAl);
			case 3:
				if (due == 0)
				{
		//			return smsStatsToday(reportAl);
				}
				else
				{
		//			return listSmsStats(reportAl);
				}
			}
		return -1;
	} //generateReport()

	private String getCompleteQuery(String query)
	{
		String completeQuery = query;
		String queryStart = "select * from (select rownum rm, a.* from( ";
		String queryEnd =") a where rownum<(?)) where rm between ? and (?-1)";
		if(format.equalsIgnoreCase ("Tabular") || format.equalsIgnoreCase ("Line Graph") || format.equalsIgnoreCase("Bar Graph"))
		{
			completeQuery = queryStart+query+queryEnd;
		}
		logger.info(completeQuery);
		return completeQuery;
	} //getCompleteQuery()

	private int setParameter(PreparedStatement pstmt, int pos)
	{
		try
		{
		/*	if( !subType.equalsIgnoreCase ("B") ) // Niether Prepaid nor Postpaid
			{
				pstmt.setString (pos++, subType);
			}
*/
			
			if(format.equalsIgnoreCase ("Tabular") || format.equalsIgnoreCase ("Line Graph") || format.equalsIgnoreCase("Bar Graph"))
			{
				pstmt.setLong (pos++, end);
				pstmt.setLong (pos++, start);
				pstmt.setLong (pos++, end);
			}
		}
		catch(SQLException sqle)
		{
			sqle.printStackTrace();
		}
		logger.info("return from setParameter()");
		return pos;
	} //setParameter()

	// ******************************** Count Report Pages *****************************
	public int countPages (PreparedStatement pstmt, int pos)
	{
		// String query1 = "Select count(*) pages from ("+query+")";
		try
		{
			/*if(!subType.equalsIgnoreCase ("B"))
				pstmt.setString (pos, subType);
       */
			rs = pstmt.executeQuery();
			if(rs.next ())
			{
				int pages = rs.getInt("pages");	
				logger.info(" count(*)="+pages);
				if(pages%10==0)
				{
				rs.close();
					return (pages/10);
					}
				else
				{
				rs.close();
					return ((pages/10)+1);
					}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace ();
			return -1;
		}
		return 0;
	} //countPages()

// ----------------- rbtDetailStatsArchive ----------
	public int rbtDetailStatsArchive(ArrayList statsAl)
	{
	try
		{
			logger.debug("in rbtDetailStatsArchive()");
			con = conPool.getConnection();
		  int columns=1;	
		  String tempstdate="",tempeddate="",tempdate="";
			int stmonth = Integer.parseInt(startDate.substring(0,2));
			int styear = Integer.parseInt(startDate.substring(3,7));
			int edmonth = Integer.parseInt(endDate.substring(0,2));
			int edyear = Integer.parseInt(endDate.substring(3,7));
			if(aggregation.equalsIgnoreCase ("Monthly"))
			{
      if (stmonth<10)
			tempstdate="01-0"+stmonth+"-"+styear;
			else
			tempstdate="01-"+stmonth+"-"+styear;
			
      if (edmonth<10)
			tempeddate="01-0"+edmonth+"-"+styear;
			else
			tempeddate="01-"+edmonth+"-"+styear;
      }
			else if(aggregation.equalsIgnoreCase ("Yearly"))
      {
			tempstdate="01-01-"+styear;
			tempeddate="31-12-"+edyear;
			}
		  
			ArrayList dateArray = new ArrayList();
			hourTimeListAccTime(dateArray);
      
query1="select count(distinct(f.rbt_code)) cnt from ( select s.* from ((select rbt_code,update_time,to_char(update_time,'"+time+"') from crbt_prepaid_setting_cdr a where ((trunc(a.update_time)>=to_date(?,'DD-MM-YYYY')) and (trunc(a.update_time)<=last_day(to_date(?,'DD-MM-YYYY'))))) UNION ALL (select rbt_code,update_time,to_char(update_time,'"+time+"') from crbt_prepaid_gifting_cdr d where ((trunc(d.update_time)>=to_date(?,'DD-MM-YYYY HH24:mi:ss')) and (trunc(d.update_time)<=last_day(to_date(?,'DD-MM-YYYY'))))) ) s where rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?)) f ,crbt_rbt c where (f.rbt_code=c.rbt_code)";
//			query1 ="select count(distinct(rbt_code)) cnt from (select b.*, c.masked_name from (select a.* from (select  to_char(update_time,'"+time+"') update_time,sum(num_subscription) rbt_count, rbt_code from rbt_subscription_history where ((trunc(update_time)>=to_date(?,'DD-MM-YYYY')) and (trunc(update_time)<=last_day(to_date(?,'DD-MM-YYYY')))) group by rbt_code,to_char(update_time,'"+time+"')) a where a.rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?)) b,crbt_rbt c where ((b.rbt_code = c.rbt_code) and rbt_count>0 ))";
			pstmt1 = con.prepareStatement(query1);
			pstmt1.setLong(5, cpCode);
			pstmt1.setString(1, tempstdate);
			pstmt1.setString(2, tempeddate);
			pstmt1.setString(3, tempstdate);
			pstmt1.setString(4, tempeddate);
			logger.info("cp code is = "+cpCode);
			rs1 = pstmt1.executeQuery();
			while(rs1.next())
			{
			logger.info("number of Rbts is"+rs1.getInt("cnt"));
			totalReturn = rs1.getInt("cnt");
			}
		  ArrayList arrrbtname = new ArrayList();	
			rs1.close();pstmt1.close();
			
			if(format.equalsIgnoreCase ("CSV"))
			end=totalReturn;
		  
			if (totalReturn<end)
			end=totalReturn;
			
		  	
			logger.info("start from "+start+" end to "+end);

			this.columnCount = 2+dateArray.size(); 
			Statele statn = new Statele((int)(end-start+1),dateArray.size());

      query2 ="select b.*, c.masked_name from (select a.* from (select  to_char(update_time,'"+time+"') update_time,sum(num_subscription) rbt_count, rbt_code from rbt_subscription_history where ((trunc(update_time)>=to_date(?,'DD-MM-YYYY')) and (trunc(update_time)<=last_day(to_date(?,'DD-MM-YYYY')))) group by rbt_code,to_char(update_time,'"+time+"')) a where a.rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?)) b,crbt_rbt c where ((b.rbt_code = c.rbt_code) and rbt_count>0 ) order by c.rbt_score,b.rbt_code";
			pstmt2 = con.prepareStatement(query2);
			pstmt2.setLong(3, cpCode);
			pstmt2.setString(1, tempstdate);
			pstmt2.setString(2, tempeddate);
			rs2 = pstmt2.executeQuery();
			long rbt_temp_code=0;
			int countr=0;
			int same_row=0;
			int rowcounter=-1;
			while(rs2.next())
			{
					if (rbt_temp_code!=rs2.getLong("rbt_code")) 
					{
					rbt_temp_code=rs2.getLong("rbt_code");
					countr++;
					logger.info("countr is"+countr);
					if (countr>=start && countr<=end)
          {
					rowcounter++;
					Stat stats = new Stat();
					stats.setDate(rs2.getString("masked_name"));
					stats.setColumn1(rs2.getLong("rbt_code"));
					arrrbtname.add(stats);
					for (int i=0;i<dateArray.size();i++)
					{
					if ( ((rs2.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(i)))) == 0)
						{
						logger.info("1.rowcounter"+rowcounter+","+i+","+rs2.getLong("rbt_count"));
						statn.setData(rowcounter,i,rs2.getLong("rbt_count"));
						break;
						}
					}
					}
					else if(countr>end)
					{
					break;
					}
					}
					else
					{
					if (countr>=start && countr<=end)
          	{
						for (int i=0;i<dateArray.size();i++)
							{
							if ( ((rs2.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(i)))) == 0)
							{
						  logger.info("2.rowcounter"+rowcounter+","+i+","+rs2.getLong("rbt_count"));
							statn.setData(rowcounter,i,rs2.getLong("rbt_count"));
							break;
							}
							}
				  	}	
					}
			}	
			statsAl.add(arrrbtname);
			statsAl.add(dateArray);
			statsAl.add(statn);
      pstmt2.close();rs2.close();
      int pagecount = 1;
		  if ((totalReturn%pageSize)==0)
			pagecount = (totalReturn/pageSize);
			else
			pagecount = ((totalReturn/pageSize)+1);
			
			logger.info("generating Page count" + pagecount);
			return pagecount;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

	}//rbtDetailStatsArchive()

// ----------------- rbtDetailStatsCurrent ----------
	public int rbtDetailStatsCurrent(ArrayList statsAl)
	{
		logger.info("in rbtDetailStatsCurrent()");
	try
		{
			con = conPool.getConnection();
			this.columnCount = 3; 
			this.header1="Rbt Name";
			this.header2="Rbt Code";
			this.header3="Invoice for this month";
		  ArrayList arrrbtname = new ArrayList();	
  		//query1 ="select count(*) cnt from (select b.*, c.masked_name , rownum rm from (select a.* from (select count(*) nm , rbt_code from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'YYYY-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') group by rbt_code) a where a.rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?)) b,crbt_rbt c where b.rbt_code = c.rbt_code)";
				query1= "select count(*) cnt from (	select b.*,c.masked_name,rownum rm from ( select a.* from ( select count(*) nm , e.rbt_code from ( select rbt_code from CRBT_SETTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL  select rbt_code  from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM')  UNION ALL select rbt_code  from CRBT_GIFTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL select rbt_code from CRBT_PREPAID_GIFTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM')) e group by e.rbt_code ) a where a.rbt_code in  (select rbt_code from crbt_rbt where content_provider_code=?) ) b, crbt_rbt c where b.rbt_code=c.rbt_code )" ;		
	
			pstmt1 = con.prepareStatement(query1);
			pstmt1.setLong(1, cpCode);
			logger.info("cp code is = "+cpCode);
			rs1 = pstmt1.executeQuery();
			while(rs1.next())
			{
			totalReturn = rs1.getInt("cnt");
			}
			
			if(format.equalsIgnoreCase ("CSV"))
			end=totalReturn;
			if(totalReturn<end)
			end=totalReturn;
			logger.info("start from "+start+" end to "+end);
	//		query2 ="select d.* from (select b.*, c.masked_name , rownum rm from (select a.* from (select count(*) nm , rbt_code from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'YYYY-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') group by rbt_code) a where a.rbt_code in (select rbt_code from crbt_rbt where content_provider_code=?)) b,crbt_rbt c where b.rbt_code = c.rbt_code) d where rm between ? and ?";
	query2="select d.* from ( select b.*,c.masked_name,rownum rm from ( select a.* from ( select count(*) nm , e.rbt_code from ( select rbt_code from CRBT_SETTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL  select rbt_code  from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM')  UNION ALL select rbt_code  from CRBT_GIFTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL select rbt_code from CRBT_PREPAID_GIFTING_CDR where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM')) e group by e.rbt_code ) a where a.rbt_code in  (select rbt_code from crbt_rbt where content_provider_code=?) ) b, crbt_rbt c where b.rbt_code=c.rbt_code ) d where rm between ? and ?";
			pstmt2 = con.prepareStatement(query2);
			pstmt2.setLong(1, cpCode);
			pstmt2.setLong(2, start);
			pstmt2.setLong(3, end);
			rs2 = pstmt2.executeQuery();
			while(rs2.next())
			{
			Stat statn = new Stat();
			statn.setDate(rs2.getString("masked_name"));
			statn.setColumn1(rs2.getLong("rbt_code"));
			statn.setColumn2(rs2.getLong("nm"));
		  statsAl.add(statn);	
			}
			rs1.close();rs2.close();   
			pstmt1.close();pstmt2.close();
      int pagecount = 1;
		  if ((totalReturn%pageSize)==0)
			pagecount = (totalReturn/pageSize);
			else
			pagecount = ((totalReturn/pageSize)+1);
			
			return pagecount;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

	}//rbtDetailStatsCurrent()







// ----------------- rbtStatsCurrent ----------
	
	public int rbtStatsCurrent(ArrayList statsAl)
	{
		logger.info("in rbtStatsCurrent(), rbtId= "+rbtId);
	try
		{
			con = conPool.getConnection();
			this.columnCount = 1;
			this.header1="Invoice for this month";
			//ArrayList dateArray = new ArrayList();
			//hourTimeList(dateArray);
			statsAl.clear ();
			
			query1 ="select to_char(sysdate,'MON-YYYY') month_str,count(*) rbt_count from CRBT_PREPAID_SETTING_CDR where ((rbt_code=? ) and (to_date(to_char(update_time,'YYYY-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM')))";
	    //query1="select to_char(update_time,'YYYY-MM-DD HH24') update_time, count(*) totalfriend from CRBT_FRIEND_SETTING WHERE RBT_CODE=? and (to_date(to_char(update_time,'YYYY-MM-DD'),'YYYY-MM-DD')=to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD')) group by to_char(update_time,'YYYY-MM-DD HH24') order by to_date(update_time,'YYYY-MM-DD HH24')"; 	
	  logger.info("1."+query1);
			pstmt1 = con.prepareStatement(query1);
			pstmt1.setInt(1, rbtId);
			rs1 = pstmt1.executeQuery();
			while(rs1.next())
			{
				Stat stats = new Stat();
				stats.setDate(rs1.getString("month_str"));
				stats.setColumn1(rs1.getLong("rbt_count"));
				statsAl.add (stats);
			} //for
			
			rs1.close();   
			pstmt1.close();

			return 1;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

	}//rbtStatsCurrent()
/*{
		logger.info("in rbtStatsCurrent(), rbtId= "+rbtId);
	try
		{
			con = conPool.getConnection();
			this.columnCount = 5;
			this.header1="Default Settings";
			this.header2="Friend Settings";
			this.header3="Group Settings";
			this.header4="Day-Date Settings";
			this.header5="Total RBT users";
			ArrayList dateArray = new ArrayList();
			hourTimeList(dateArray);
			statsAl.clear ();
			
	    query1="select to_char(update_time,'YYYY-MM-DD HH24') update_time, count(*) totalfriend from CRBT_FRIEND_SETTING WHERE RBT_CODE=? and (to_date(to_char(update_time,'YYYY-MM-DD'),'YYYY-MM-DD')=to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD')) group by to_char(update_time,'YYYY-MM-DD HH24') order by to_date(update_time,'YYYY-MM-DD HH24')"; 	
	  logger.info("1."+query1);
			query2="select to_char(update_time,'YYYY-MM-DD HH24') update_time,count(*) totalgroup from CRBT_GROUP_SETTING WHERE RBT_CODE=? and (to_date(to_char(update_time,'YYYY-MM-DD'),'YYYY-MM-DD')=to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD')) group by to_char(update_time,'YYYY-MM-DD HH24') order by to_date(update_time,'YYYY-MM-DD HH24')"; 	
	  logger.info("2." +query2);

	    query3="select to_char(update_time,'YYYY-MM-DD HH24') update_time,count(*) totaldate from CRBT_EVENTDATE_RBT WHERE RBT_CODE=? and (to_date(to_char(update_time,'YYYY-MM-DD'),'YYYY-MM-DD')=to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD')) group by to_char(update_time,'YYYY-MM-DD HH24') order by to_date(update_time,'YYYY-MM-DD HH24')"; 	
	  logger.info("3." +query3);

	    query4="select to_char(update_time,'YYYY-MM-DD HH24') update_time,count(*) totaldefault from CRBT_DEFAULT_DETAIL WHERE RBT_CODE=? and	(to_date(to_char(update_time,'YYYY-MM-DD'),'YYYY-MM-DD')=to_date(to_char(sysdate,'YYYY-MM-DD'),'YYYY-MM-DD')) group by to_char(update_time,'YYYY-MM-DD HH24') order by to_date(update_time,'YYYY-MM-DD HH24')"; 	
	  logger.info("4." +query4);


			PreparedStatement pstmt1 = con.prepareStatement(query1);
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			PreparedStatement pstmt3 = con.prepareStatement(query3);
			PreparedStatement pstmt4 = con.prepareStatement(query4);

			pstmt1.setInt(1, rbtId);
			pstmt2.setInt(1, rbtId);
			pstmt3.setInt(1, rbtId);
			pstmt4.setInt(1, rbtId);

			rs1 = pstmt1.executeQuery();
			rs2 = pstmt2.executeQuery();
			rs3 = pstmt3.executeQuery();
			rs4 = pstmt4.executeQuery();
	  logger.info("all query executed");
		  
			long totalRecords = 0;
			for(int j = 0; j< dateArray.size(); j++)
			{	
      long totalfriend=0;
			long totalgroup=0;
			long totaldefault=0;
			long totaldate=0;
			while(rs1.next())
			{
				if ( ((rs1.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(j)))) == 0)
				{
											
						totalfriend = rs.getLong("totalfriend");
	  				logger.info("totalfriend= "+totalfriend);
				}
				else
				{
					rs.previous();
					break;
				}
			}
			while(rs2.next())
			{
				if ( ((rs2.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(j)))) == 0)
				{
											
						totalgroup = rs.getLong("totalgroup");
	  				logger.info("totalgroup= "+totalgroup);
				}
				else
				{
					rs.previous();
					break;
				}
			}
			while(rs3.next())
			{
				if ( ((rs3.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(j)))) == 0)
				{
											
						totaldate = rs.getLong("totaldate");
	  				logger.info("totaldate= "+totaldate);
				}
				else
				{
					rs.previous();
					break;
				}
			}
    	while(rs4.next())
			{
				if ( ((rs4.getString("update_time")).compareToIgnoreCase((String)(dateArray.get(j)))) == 0)
				{
											
						totaldefault = rs.getLong("totaldefault");
	  				logger.info("totaldefault= "+totaldefault);
				}
				else
				{
					rs.previous();
					break;
				}
			}
		    totalRecords = totaldefault+totaldate+totalgroup+totalfriend;
				Stat stats = new Stat();
				StringBuffer sDate = new StringBuffer();
				dateConversion(sDate.append((String)dateArray.get(j)));
				stats.setDate(sDate.toString());
				stats.setColumn1(totaldefault);
				stats.setColumn2(totalfriend);
				stats.setColumn3(totalgroup);
				stats.setColumn4(totaldate);
				stats.setColumn5(totalRecords);
				statsAl.add (stats);
			} //for
			
			rs1.close();rs2.close();rs3.close();rs4.close();   
			pstmt1.close();pstmt2.close();pstmt3.close();pstmt4.close();   

			return 1;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

	}*/

/* ************    rbtDetailReportArchieve              ************  */
/*public int rbtDetailReportArchieve(ArrayList reportAl)
{
		logger.info("in rbtDetailReportArchieve() cpCode="+ cpCode );
	try
		{
			con = conPool.getConnection();
			this.columnCount = 2;
			this.header1="RBT Name";
			this.header2="Category";
			this.header3="Usage";
		  String specialCatId ="998";
		  String recordedCatId="999";
		  int ret = -1;
			specialCatId   = TSSJavaUtil.instance().getAppConfigParam("SPECIAL_CONTROL_CATID");
			recordedCatId  = TSSJavaUtil.instance().getAppConfigParam("CRBT_RECORDED_CATEGORY_ID");

			ArrayList dateArray = new ArrayList();
			hourTimeList(dateArray);
			statsAl.clear ();

				query = "select to_char(update_time,'"+time+"'), RBT_CODE, MASKED_NAME, CAT_ID from CRBT_FRIEND_SETTINGASKED_NAME, CAT_ID from CRBT_RBT where RBT_CODE not in (select RBT_CODE from CRBT_RBT_CONTROL) and CONTENT_PROVIDER_CODE = ? order by MASKED_NAME)"; 
			query1 = "select count(RBT_CODE) TOTAL from CRBT_RBT where RBT_CODE not in(select RBT_CODE from CRBT_RBT_CONTROL) and not(CAT_ID=?) and not(CAT_ID=?) and CONTENT_PROVIDER_CODE = ?";
				pstmt = con.prepareStatement(query1);
				pstmt.setString(1, recordedCatId);
				pstmt.setString(2, specialCatId);
				pstmt.setInt(3, cpId);

	
}//rbtDetailReportArchieve()
*/
/* ************    rbtStatsArchieve                     ************  */
public int rbtStatsArchieve(ArrayList statsAl)
{
		logger.info("in rbtStatsArchieve(), rbtId= "+rbtId);
	try
		{
			con = conPool.getConnection();
			this.columnCount = 1;
			statsAl.clear ();
		  
			if(aggregation.equalsIgnoreCase ("Monthly"))
			{
			this.header1="Invoice for Month";
			startDate="01-"+startDate;
			endDate="01-"+endDate;
			}
		else if(aggregation.equalsIgnoreCase ("Yearly"))
		{
			this.header1="Invoice for year";
			int styear = Integer.parseInt(startDate.substring(3,7));
			int edyear = Integer.parseInt(endDate.substring(3,7));
		  startDate="01-01-"+styear;
			endDate="31-12-"+edyear;
		
		}
					query="select to_char(update_time,'"+time+"') update_time, sum(num_subscription) total from (select to_char(update_time,'"+time+"'), sum(num_subscription) from rbt_subscription_history where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL	select to_char(update_time,'"+time+"'), sum(num_subscription) from crbt_prepaid_setting_cdr where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') UNION ALL select to_char(update_time,'"+time+"'), sum(num_subscription) from crbt_prepaid_gifting_cdr where to_date(to_char(update_time,'yyyy-MM'),'YYYY-MM')=to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') ) e WHERE (trunc(update_time) <= last_day(to_date(?,'dd-mm-yyyy')) and update_time >= to_date(?,'dd-mm-yyyy')) and e.RBT_CODE=? group by to_char(update_time,'"+time+"') order by to_date(update_time,'"+time+"')";
					//query="select to_char(update_time,'"+time+"') update_time, sum(num_subscription) total from rbt_subscription_history WHERE (trunc(update_time) <= last_day(to_date(?,'dd-mm-yyyy')) and update_time >= to_date(?,'dd-mm-yyyy')) and RBT_CODE=? group by to_char(update_time,'"+time+"') order by to_date(update_time,'"+time+"')";

			pstmt = con.prepareStatement(getCompleteQuery(query));
			
			pstmt.setString(1,endDate);
			pstmt.setString(2,startDate);
			pstmt.setInt(3, rbtId);
			int i = setParameter(pstmt,4);
			
			rs = pstmt.executeQuery();
		  logger.info("***1." +query);
			while(rs.next())
			{
			Stat stats = new Stat();
				stats.setDate(rs.getString("update_time"));
				stats.setColumn1(rs.getLong("total"));
				statsAl.add (stats);
			}
			pstmt.close();rs.close();
			int pageCount=0;
			pstmt = con.prepareStatement("select count(*) pages from ("+query+")");
			pstmt.setString(1,endDate);
			pstmt.setString(2,startDate);
			pstmt.setInt(3,rbtId);
			pageCount = countPages(pstmt,4);
			
			rs.close();			pstmt.close();      

			return pageCount;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

} //rbtStatsArchieve()

public int topRbtList(ArrayList statsAl)
{
		logger.debug("in topRbtList()");
	try
		{
			con = conPool.getConnection();
			this.columnCount = 3;
			this.header1="Rbt Name";
			this.header2="Rbt Code";
			this.header3="Rbt Score";
			statsAl.clear ();
	  
			query="select rbt_code , masked_name , rbt_score from crbt_rbt WHERE content_provider_code=? order by rbt_score desc";
	//		query="select a.rbt_code rbt_code , a.masked_name masked_name , a.rbt_score rbt_score, b.name name from crbt_rbt a, crbt_content_provider b WHERE a.content_provider_code=? and a.content_provider_code=b.code order by a.rbt_score desc";

			pstmt = con.prepareStatement(getCompleteQuery(query));
			
			pstmt.setInt(1, cpCode);
			int i = setParameter(pstmt,2);
			
			rs = pstmt.executeQuery();
		  logger.info("***1." +query);
			while(rs.next())
			{
			Stat stats = new Stat();
				stats.setDate(rs.getString("masked_name"));
				stats.setColumn1(rs.getLong("rbt_code"));
				stats.setColumn2(rs.getLong("rbt_score"));
		//		stats.setColumn3(rs.getLong("name"));
				statsAl.add (stats);
			}
			int pageCount=0;
			pstmt = con.prepareStatement("select count(*) pages from ("+query+")");
			pstmt.setInt(1,cpCode);
			pageCount = countPages(pstmt,2);
			
			rs.close();			pstmt.close();      

			return pageCount;	
		}//try
		catch (Exception exp)
		{
						exp.printStackTrace()	;
						return -1;
		}//catch
    finally {conPool.free(con);  }

}

public int rbtSubscriberList(ArrayList statsAl)
{
	logger.info("in rbtSubscriberList():"+rbtId+" "+startDate+" "+endDate);
	try
		{
			con = conPool.getConnection();
			this.columnCount = 1;
			this.header1="Subscriber Msisdn";
			ArrayList dateArray = new ArrayList();
			hourTimeList(dateArray);
			statsAl.clear ();
	//		if(due == 0) //current report
			{
      	//query = "select to_char(update_time,'DD-MM-YYYY HH24:mi:ss') update_time, msisdn from CRBT_PREPAID_SETTING_CDR where to_date(to_char(update_time,'YYYY-MM'),'YYYY-MM') = to_date(to_char(sysdate,'YYYY-MM'),'YYYY-MM') and RBT_CODE=? order by to_date(update_time,'dd-mm-yyyy hh24:mi:ss')";
      	query = "select to_char(update_time,'DD-MM-YYYY HH24:mi:ss') update_time, msisdn from CRBT_PREPAID_SETTING_CDR where RBT_CODE=? order by to_date(update_time,'dd-mm-yyyy hh24:mi:ss')";
			 pstmt = con.prepareStatement(getCompleteQuery(query));
			 pstmt.setInt(1,rbtId);
			 int i = setParameter(pstmt,2);
			}//if
/*			else //Archieve Report
			{
	       query = "select to_char(update_time,'"+time+"') update_time, msisdn from testcp where (trunc(update_time)<=(to_date(?,'dd-mm-yyyy')) and update_time>=to_date(?,'dd-mm-yyyy')) and RBT_CODE=? order by to_date(update_time,'"+time+"')";
	    
			 pstmt = con.prepareStatement(getCompleteQuery(query));
			 pstmt.setString(1,endDate);
			 pstmt.setString(2,startDate);
			 pstmt.setInt(3,rbtId);
			 int i = setParameter(pstmt,4);
	    }//else
	*/	 rs = pstmt.executeQuery();
	   logger.info(query);
		 while(rs.next())
			{
	   		Stat stats = new Stat();
			 	stats.setDate(rs.getString("update_time"));
   			stats.setColumn1(Long.parseLong(rs.getString("msisdn")));
		  	statsAl.add (stats);
			}
			rs.close();
			pstmt.close();
			int pageCount= -1;
			
		  pstmt1 = con.prepareStatement("select count(*) pages from ("+query+")");
	/*		if(due ==1 )
			{ 
				pstmt.setString(1,endDate);
				pstmt.setString(2,startDate);
			  pstmt.setInt(3,rbtId);
			}
			else if (due ==0)*/ {	pstmt1.setInt(1,rbtId);}
			pageCount = countPages(pstmt1,4);
		  	
			pstmt1.close();
			return pageCount;
	}//try
	catch (Exception exp)
		{
				try{ 
							if(rs != null ) rs.close();
				     if(pstmt != null ) pstmt.close();
					 }catch(Exception e)
					 {	
					 		e.printStackTrace();
					 }
						 
		  	exp.printStackTrace()	;
		  	return -1;
		}//catch
    finally {conPool.free(con);  }
} //rbtSubscriberList()

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
	  public void hourTimeListAccTime(ArrayList arrList)
    {
		logger.debug("In hourTimeListAccTime");
		Calendar calendar = new GregorianCalendar();
//		Date startTime = new Date();
	//	calendar.setTime(startTime);
		/*int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DATE);
		int hour = calendar.get(Calendar.HOUR_OF_DAY);*/
			int stmonth = Integer.parseInt(startDate.substring(0,2));
			int styear = Integer.parseInt(startDate.substring(3,7));
			int edmonth = Integer.parseInt(endDate.substring(0,2));
			int edyear = Integer.parseInt(endDate.substring(3,7));
		DateStruct stDate = new DateStruct();
		DateStruct etDate = new DateStruct();
		int a=1;
		logger.info("month is "+stmonth+"year is"+styear);
		if(aggregation.equalsIgnoreCase ("Monthly"))
		{
		stDate.DateStruct(2,stmonth-1,styear,0,5);
		
		etDate.DateStruct(1,edmonth,styear,0,4);
		a=1;
		}
		else if(aggregation.equalsIgnoreCase ("Yearly"))
		{
		stDate.DateStruct(1,1,styear,0,5);
		etDate.DateStruct(31,12,edyear,0,5);
		a=2;
		}
		GregorianCalendar gc = new GregorianCalendar (stDate.yy,stDate.mm,stDate.dd,stDate.hh,stDate.mi);
		GregorianCalendar gce = new GregorianCalendar (etDate.yy,etDate.mm,etDate.dd,etDate.hh,etDate.mi);
		while(true)
		{
		  
		  SimpleDateFormat formatter; //= new SimpleDateFormat("MMM-yyyy");
			if(a==1)
		  formatter = new SimpleDateFormat("MMM-yyyy");
		  else 
		  formatter = new SimpleDateFormat("yyyy");
			String dateString = formatter.format(gc.getTime());
			logger.info("date string is"+dateString);
			arrList.add(dateString);
		  if(aggregation.equalsIgnoreCase ("Monthly"))
			gc.add(Calendar.MONTH,1);
		  else if(aggregation.equalsIgnoreCase ("Yearly"))
			gc.add(Calendar.YEAR,1);
			if (gc.after(gce))
			{
			break;
			}
		}
	}
//-----------------Convert Date in DD-MM-YYYY-------------------------------------
	public void dateConversion(StringBuffer startDate)
	{
		String startYear = startDate.substring (0,4);
		String startMonth = startDate.substring(5,7)+"-";
		String startDay = startDate.substring (8,10)+"-";
		String startHour = startDate.substring(10);
		startDate = (startDate.delete(0,14));
		startDate = startDate.append(startDay).append(startMonth).append(startYear).append("").append(startHour).append(".00");
	}//dateConversion()

public int  getAllContentProviders(ArrayList contentProviderList)
{
				try
				{
								con = conPool.getConnection();

								query = "select CODE, NAME from CRBT_CONTENT_PROVIDER";
								pstmt = con.prepareStatement(query);
								rs = pstmt.executeQuery();
								while(rs.next())
								{
												ContentProvider cp = new ContentProvider();
												cp.setCode(rs.getInt(1));
												cp.setName(rs.getString(2));
												contentProviderList.add(cp);
								}
								pstmt.close();
								return CrbtErrorCodes.SUCCESS;
				}//try
				catch (Exception e)
				{//log it
								e.printStackTrace();
								return CrbtErrorCodes.FAILURE;
				}
				finally
				{
								conPool.free(con);
				}
}//getAllContentProviders
	public int  getContentProvider(ContentProvider cp)
{
				try
				{
								con = conPool.getConnection();

								query = "select CODE, NAME from CRBT_CONTENT_PROVIDER where code=?";
								pstmt = con.prepareStatement(query);
								pstmt.setInt(1,cp.getCode());
								rs = pstmt.executeQuery();
								if(rs.next())
								{
												//ContentProvider cp = new ContentProvider();
												cp.setCode(rs.getInt(1));
												cp.setName(rs.getString(2));
											//	contentProviderList.add(cp);
								}
								pstmt.close();
								return CrbtErrorCodes.SUCCESS;
				}//try
				catch (Exception e)
				{//log it
								e.printStackTrace();
								return CrbtErrorCodes.FAILURE;
				}
				finally
				{
								conPool.free(con);
				}
}//getAllContentProviders


public int getRBTUploaded(ArrayList al)
{
								logger.info("getRBTUploaded()");
								try
								{
												con = conPool.getConnection();
												query="select count(*) cnt , b.name name from crbt_rbt a,crbt_content_provider b where  b.code=a.content_provider_code group by name";
												pstmt=con.prepareStatement(query);
								logger.info(query);
												rs = pstmt.executeQuery();
												while(rs.next())
												{
																ContentProvider repU= new ContentProvider();
																repU.setName(rs.getString(2));
																repU.setcount(rs.getInt(1));
																al.add(repU);
												}
												rs.close();
												pstmt.close();
												return CrbtErrorCodes.SUCCESS;
								}
catch (Exception e)
				{
								e.printStackTrace();
								return CrbtErrorCodes.FAILURE;
				}
				finally
				{
								conPool.free(con);
				}
}
public int getRBTDownloads(ArrayList al)
{
	logger.info("getRBTDownloded()");
	try
	{
		con = conPool.getConnection();
		//query="select count(*) cnt , b.name from crbt_rbt a, crbt_content_provider b,rbt_subscription_history c where a.content_provider_code=b.code and a.rbt_code=c.rbt_code group by name";
		query="select count(*) cnt , b.name from crbt_rbt a, crbt_content_provider b,crbt_prepaid_setting_cdr c where a.content_provider_code=b.code and a.rbt_code=c.rbt_code group by name";
		logger.info(query+"con object ="+con);
		pstmt=con.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next())
		{
			ContentProvider repU= new ContentProvider();
			repU.setName(rs.getString(2));
			repU.setcount(rs.getInt(1));
			al.add(repU);
		}
		rs.close();
		pstmt.close();
		return CrbtErrorCodes.SUCCESS;
	}
	catch (Exception e)
	{
		e.printStackTrace();
		return CrbtErrorCodes.FAILURE;
	}
	finally
	{
		conPool.free(con);
	}
}



} //class ReportUtil
