package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class WebAdminLogManager
{
        private static Logger logger=Logger.getLogger(WebAdminLogManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private Connection con = null;
	private String query = null;
 
	public WebAdminLogManager()
	{
	//	conPool = new ConnectionPool();
	}

        public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }
  
 public int getLinks(ArrayList logList)
	{
				try
									{
																	con = conPool.getConnection();

																									query = "SELECT distinct(LINK_LOGS) FROM WEB_ADMIN_LOGS ";
																								pstmt = con.prepareStatement (query);  
																									rs = pstmt.executeQuery ();
																									while (rs.next())
																									{
																													WebAdminLog weblog=new WebAdminLog();
																													weblog.setlink(rs.getString(1));
																													logList.add(weblog);
																													
																									}
																									rs.close();
																									pstmt.close();
								}
									catch (Exception e)
									{
																	try
																	{
																									if(rs != null) rs.close ();
																									if(pstmt != null) pstmt.close ();
																	}catch(SQLException sqle)
																	{
																									logger.error ("Exception in getChargingCode: " + sqle.getMessage ());
																	}
																	e.printStackTrace ();
																	return -1;
									}
									finally{ conPool.free(con); }
									return 1;


	}
	public int getLog (ArrayList logsAl,String keyword,String sdate, String edate,int page)
	{
									logger.info("getLog()==1== "+keyword+"sdate=="+sdate+"edate=="+edate+"page"+page);
									int count=0;
									int pageno=page;
									pageno=pageno*5;
									int pagend=pageno+5;

									try
									{
																	con = conPool.getConnection();
																	if(keyword.equalsIgnoreCase("X"))
																	{ 
																									logger.info("2== "+keyword+"sdate=="+sdate+"edate=="+edate);
																									query = "SELECT count(LINK_LOGS) FROM WEB_ADMIN_LOGS WHERE UPDATED_DATE >= ? AND UPDATED_DATE <= ?";
																									pstmt = con.prepareStatement (query);  
																									pstmt.setString (1, sdate);  
																									pstmt.setString (2, edate);
																									rs = pstmt.executeQuery ();
																									if (rs.next())
																									{
																																	count = rs.getInt(1);
																									}
																									logger.debug("count==="+count);
																									rs.close();
																									pstmt.close();

																									if(count>pageno)
																									{}
																																	query = "SELECT LINK_LOGS,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE FROM ( SELECT LINK_LOGS,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE,ROWNUM rm FROM WEB_ADMIN_LOGS WHERE UPDATED_DATE >=? AND UPDATED_DATE <=? ORDER BY UPDATED_DATE ) WHERE rm >="+pageno+" and rm < "+pagend;
																									pstmt = con.prepareStatement (query);
																									pstmt.setString (1, sdate);
																									pstmt.setString (2, edate);

																	}
																	else
																	{

																									query = "SELECT count(LINK_LOGS) FROM WEB_ADMIN_LOGS WHERE UPDATED_DATE >= ? AND UPDATED_DATE <= ? AND UPPER(LINK_LOGS)=UPPER(?)";
																									pstmt = con.prepareStatement (query);  
																									pstmt.setString (1, sdate);  
																									pstmt.setString (2, edate);
																									pstmt.setString (3, keyword);
																									rs = pstmt.executeQuery ();
																									if (rs.next())
																									{
																																	count = rs.getInt(1);
																									}
																									logger.debug("count==="+count);

																									if(count>pageno)
																									logger.debug("3== "+keyword+"sdate=="+sdate+"edate=1111="+edate);
																									query = "SELECT LINK_LOGS,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE FROM ( select LINK_LOGS,CURRENT_VALUE,PREVIOUS_VALUE,UPDATED_BY,UPDATED_DATE ,ROWNUM rm FROM WEB_ADMIN_LOGS where UPDATED_DATE >=? AND UPDATED_DATE <=? AND UPPER(LINK_LOGS)=UPPER(?)) where rm>="+pageno+" and rm < "+pagend;
																									pstmt = con.prepareStatement (query);
																									pstmt.setString (1, sdate);
																									pstmt.setString (2, edate);
																									pstmt.setString (3, keyword);

																	}
																	rs = pstmt.executeQuery ();
																	while(rs.next ())
																	{
																									WebAdminLog webobj= new WebAdminLog ();
																									webobj.setlink (rs.getString ("LINK_LOGS"));
																									webobj.setCurrentvalue (rs.getString ("CURRENT_VALUE"));
																									webobj.setPreviousvalue (rs.getString ("PREVIOUS_VALUE"));
																									webobj.setuser (rs.getString ("UPDATED_BY"));
																									webobj.setDate (rs.getString ("UPDATED_DATE"));
																									logsAl.add (webobj);
																									logger.info("1== "+rs.getString ("LINK_LOGS")+"2=="+rs.getString ("CURRENT_VALUE")+"3=="+rs.getString ("PREVIOUS_VALUE")+"4=="+rs.getString ("UPDATED_BY")+"5=="+rs.getString ("UPDATED_DATE"));
																	}
																	rs.close ();
																	pstmt.close ();
									} //try
									catch (Exception e)
									{
																	try
																	{
																									if(rs != null) rs.close ();
																									if(pstmt != null) pstmt.close ();
																	}catch(SQLException sqle)
																	{
																									logger.error ("Exception in getChargingCode: " + sqle.getMessage ());
																	}
																	e.printStackTrace ();
																	return -1;
									}
									finally{ conPool.free(con); }
									int temp=count%5;
									if(temp==0)
																	temp=count/5;
									else
																	temp=(count/5)+1;
									logger.debug("page no=="+temp);
									if(count==0)
									return count;
									else
									return temp;

									//		return 1;
	}//getLogs
/*
	public int getrateplan (ArrayList chargecode,String keyword, String order,String searchkey)
	{
					logger.debug("getrateplan ");
					try
					{
									con = conPool.getConnection();
					if(searchkey.equalsIgnoreCase("X") )  // show all Keywords
    	{
									query = "select PLAN_INDICATOR, REMARKS from CRBT_RATE_PLANS ORDER BY "+keyword+" "+order;
									pstmt = con.prepareStatement (query);
						}
						else
						{
									query = "SELECT PLAN_INDICATOR, REMARKS from CRBT_RATE_PLANS where UPPER(REMARKS) like UPPER(?) ORDER BY "+keyword+" "+order;
									pstmt = con.prepareStatement (query);
									pstmt.setString(1,"%"+searchkey+"%");
						}
									rs = pstmt.executeQuery ();

									while(rs.next ())
									{
													RbtRatePlan RR_plan = new RbtRatePlan ();
													RR_plan.setPlanId (rs.getInt ("PLAN_INDICATOR"));
													RR_plan.setRemarks (rs.getString ("REMARKS"));
													chargecode.add (RR_plan);
									}
									rs.close ();
									pstmt.close ();
					} //try
					catch (Exception e)
					{
									try
									{
													if(rs != null) rs.close ();
													if(pstmt != null) pstmt.close ();
									}catch(SQLException sqle)
									{
													logger.debug ("Exception in getChargingCode, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;

	}//getrateplan()
	public int viewRatePlan (RbtRatePlan RRPObj,int planId)
	{
		logger.debug("webadmin: viewRatePlan");
		try
		{
			con = conPool.getConnection();
			//query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, MONOTONE_CHARGE_CODE, RBT_NO_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, RBT_RECORDED_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, planId);
			rs = pstmt.executeQuery ();
			while(rs.next())
			{
			RRPObj.setPlanId (rs.getInt ("PLAN_INDICATOR"));
			RRPObj.setRbtChgCode (rs.getString("RBT_CHARGE_CODE"));
			RRPObj.setRbtGiftChgCode (rs.getString("GIFT_CHARGE_CODE"));
	//		RRPObj.setRbtMonoChgCode (rs.getString("MONOTONE_CHARGE_CODE"));
	//		RRPObj.setRbtNoChgCode(rs.getString("RBT_NO_CHARGE_CODE"));
			RRPObj.setRbtNormalChgCode(rs.getString("RBT_NORMAL_CHARGE_CODE"));
			RRPObj.setSubChgCode(rs.getString("SUBSCRIPTION_CHARGE_CODE"));
		//	RRPObj.setRbtRecChgCode(rs.getString("RBT_RECORDED_CHARGE_CODE"));
			RRPObj.setRemarks(rs.getString("REMARKS"));
			RRPObj.setMRentCode(rs.getString("MONTHLY_RENT_CODE"));
			RRPObj.setThreeWeek(rs.getString("THREE_WEEK_RENT_CODE"));
			RRPObj.setTwoWeek(rs.getString("TWO_WEEK_RENT_CODE"));
			RRPObj.setOneWeek(rs.getString("ONE_WEEK_RENT_CODE"));
}
		logger.debug("webadmin: query execute");
			rs.close ();
			pstmt.close ();
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.info ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully

	}// viewRatePlan()
	public int getRowCodeModify (ArrayList chargecode,RbtRatePlan RRPObj,int planId)
	{
		logger.info("webadmin: getRowCodeModify");
		try
		{
																	con = conPool.getConnection();
                 query = "select DESCRIPTION,CHARGING_CODE from CRBT_CHARGING_CODE";
                 pstmt = con.prepareStatement (query);
                 rs = pstmt.executeQuery ();
                 while(rs.next ())
                 {
                         RbtRatePlan rrpOb = new RbtRatePlan ();
                         rrpOb.setDesc (rs.getString ("DESCRIPTION"));
                         rrpOb.setRbtChgCode (rs.getLong ("CHARGING_CODE")+"");
                         chargecode.add (rrpOb);
                 }
                 rs.close ();
                 pstmt.close ();

			//query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, MONOTONE_CHARGE_CODE, RBT_NO_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, RBT_RECORDED_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, planId);
			rs = pstmt.executeQuery ();
			while(rs.next())
			{
			RRPObj.setPlanId (rs.getInt ("PLAN_INDICATOR"));
			RRPObj.setRbtChgCode (rs.getString("RBT_CHARGE_CODE"));
			RRPObj.setRbtGiftChgCode (rs.getString("GIFT_CHARGE_CODE"));
			//RRPObj.setRbtMonoChgCode (rs.getString("MONOTONE_CHARGE_CODE"));
			//RRPObj.setRbtNoChgCode(rs.getString("RBT_NO_CHARGE_CODE"));
			RRPObj.setRbtNormalChgCode(rs.getString("RBT_NORMAL_CHARGE_CODE"));
			RRPObj.setSubChgCode(rs.getString("SUBSCRIPTION_CHARGE_CODE"));
			//RRPObj.setRbtRecChgCode(rs.getString("RBT_RECORDED_CHARGE_CODE"));
			RRPObj.setRemarks(rs.getString("REMARKS"));
			RRPObj.setMRentCode(rs.getString("MONTHLY_RENT_CODE"));
			RRPObj.setThreeWeek(rs.getString("THREE_WEEK_RENT_CODE"));
			RRPObj.setTwoWeek(rs.getString("TWO_WEEK_RENT_CODE"));
			RRPObj.setOneWeek(rs.getString("ONE_WEEK_RENT_CODE"));
}
		logger.info("webadmin: query execute");
			rs.close ();
			pstmt.close ();
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.info ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully

	}// getRowCodeModify
public int saveEditRatePlan(RbtRatePlan rbtObj,int pid)
	{
		logger.info("webadmin: saveEditRatePlan");
		try
		{
			con = conPool.getConnection();
	
			//query = "UPDATE CRBT_RATE_PLANS SET RBT_CHARGE_CODE=?, GIFT_CHARGE_CODE=?, MONOTONE_CHARGE_CODE=?, RBT_NO_CHARGE_CODE=?, RBT_NORMAL_CHARGE_CODE=?, SUBSCRIPTION_CHARGE_CODE=?, RBT_RECORDED_CHARGE_CODE=?, REMARKS=?, MONTHLY_RENT_CODE=?, THREE_WEEK_RENT_CODE=?,TWO_WEEK_RENT_CODE=?,ONE_WEEK_RENT_CODE=? WHERE PLAN_INDICATOR=?";
			query = "UPDATE CRBT_RATE_PLANS SET RBT_CHARGE_CODE=?, GIFT_CHARGE_CODE=?, RBT_NORMAL_CHARGE_CODE=?, SUBSCRIPTION_CHARGE_CODE=?, REMARKS=?, MONTHLY_RENT_CODE=?, THREE_WEEK_RENT_CODE=?,TWO_WEEK_RENT_CODE=?,ONE_WEEK_RENT_CODE=? WHERE PLAN_INDICATOR=?";
			pstmt = con.prepareStatement (query);

			pstmt.setString (1, rbtObj.getRbtChgCode());
			pstmt.setString (2, rbtObj.getRbtGiftChgCode());
//			pstmt.setString (3, rbtObj.getRbtMonoChgCode());
	//		pstmt.setString (4, rbtObj.getRbtNoChgCode());
			pstmt.setString (3, rbtObj.getRbtNormalChgCode());
			pstmt.setString (4, rbtObj.getSubChgCode());
	//		pstmt.setString (7, rbtObj.getRbtRecChgCode());
			pstmt.setString (5, rbtObj.getRemarks());
			pstmt.setString (6, rbtObj.getMRentCode());
			pstmt.setString (7, rbtObj.getThreeWeek());
			pstmt.setString (8, rbtObj.getTwoWeek());
			pstmt.setString (9, rbtObj.getOneWeek());
			pstmt.setInt (10, pid);

			pstmt.executeUpdate ();
		logger.info("webadmin: query execute");
			pstmt.close ();
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.info ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully
	//	return 2; //  added susccessfully

	}// saveEditRatePlan
	public int DeleteRbtRatePlan(int planId)
{
								logger.info("webadmin: DeleteRbtRatePlan");
								try
								{
																con = conPool.getConnection();
																query = "DELETE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
																pstmt = con.prepareStatement (query);
																pstmt.setInt (1, planId);
																pstmt.executeUpdate();
																logger.info("webadmin: query execute");
																pstmt.close ();
								}//try
								catch (Exception e)
								{
																e.printStackTrace ();
																return -1;
								}
								finally  { conPool.free(con); } 
								return 0; //  added susccessfully

}// DeleteRbtRatePlan
*/
	public int createLog (WebAdminLog webobj)
{
								logger.debug("webadmin: createLog");
								try
								{
																con = conPool.getConnection();
																query = "INSERT INTO WEB_ADMIN_LOGS (USE_TABLE, CURRENT_VALUE, PREVIOUS_VALUE, LINK_LOGS, UPDATED_BY, UPDATED_DATE) VALUES (?,?,?,?,?,sysdate)";

																								pstmt = con.prepareStatement (query);
																								pstmt.setString (1, webobj.getTableName());
																								pstmt.setString (2, webobj.getCurrentvalue());
																								pstmt.setString (3, webobj.getPreviousvalue());
																								pstmt.setString (4, webobj.getlink());
																								pstmt.setString (5, webobj.getuser());
																								pstmt.executeUpdate ();
																								logger.debug("webadmin: query execute");
																pstmt.close ();
								}//try
								catch (Exception e)
								{
																try
																{
																								if(pstmt != null) pstmt.close ();
																								if(rs != null) rs.close ();
																}catch(SQLException sqle)
																{
																								logger.error ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
																}

																e.printStackTrace ();
																return -1;
								}
								finally  { conPool.free(con); } 
								return 0; //  log create susccessfully

}// createLog()
	public int createLog (ArrayList logArray)
{
								logger.debug("webadmin: createLog");
								try
								{
																con = conPool.getConnection();
																query = "INSERT INTO WEB_ADMIN_LOGS (USE_TABLE, CURRENT_VALUE, PREVIOUS_VALUE, LINK_LOGS, UPDATED_BY, UPDATED_DATE) VALUES (?,?,?,?,?,sysdate)";
																for(int i=0;i<logArray.size();i++)
																{
												WebAdminLog webobj= (WebAdminLog)logArray.get(i);

																								pstmt = con.prepareStatement (query);
																								pstmt.setString (1, webobj.getTableName());
																								pstmt.setString (2, webobj.getCurrentvalue());
																								pstmt.setString (3, webobj.getPreviousvalue());
																								pstmt.setString (4, webobj.getlink());
																								pstmt.setString (5, webobj.getuser());
																								pstmt.executeUpdate ();
																								logger.debug("webadmin: query execute");
																pstmt.close ();
												}
								}//try
								catch (Exception e)
								{
																try
																{
																								if(pstmt != null) pstmt.close ();
																								if(rs != null) rs.close ();
																}catch(SQLException sqle)
																{
																								logger.error ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
																}

																e.printStackTrace ();
																return -1;
								}
								finally  { conPool.free(con); } 
								return 0; //  log create susccessfully

}

}//class
