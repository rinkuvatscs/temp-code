package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class ViralSMSRange
{
         private static Logger logger=Logger.getLogger(ViralSMSRange.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private Connection con = null;
	private String query = null;

	public ViralSMSRange()
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



	public int addNewRange (String msisdn)
	{
									logger.debug("webadmin: addNewRange");
									long range_id=0;
									int count=0;
									try
									{
																	con = conPool.getConnection();
																	query="select RANGE_ID from VIRAL_SMS_ALLOWED_RANGES where MSISDN_RANGE like ?";
																	pstmt=con.prepareStatement(query);
																	pstmt=con.prepareStatement(query);
																	pstmt.setString(1,msisdn+"%");
																	rs = pstmt.executeQuery();
																	if(rs.next())
																	{
																									range_id = rs.getLong("RANGE_ID");
																								count=count+1;
																	}
																	rs.close ();
																	pstmt.close ();
																	if(count>=1)
																	{
																		return -2;
																	}

																	query="select CRBT_RANGE_ID.nextval from dual";
																	pstmt=con.prepareStatement(query);
																	rs = pstmt.executeQuery();
																	if(rs.next())
																	{
																									range_id = rs.getLong(1);
																	}
																	rs.close ();
																	pstmt.close ();
																	query = "INSERT INTO VIRAL_SMS_ALLOWED_RANGES (RANGE_ID,MSISDN_RANGE) VALUES (?,?)";
																	pstmt = con.prepareStatement (query);

																	pstmt.setLong (1, range_id);
																	pstmt.setString (2, msisdn);
																	pstmt.executeUpdate ();
																	logger.debug("webadmin: query execute");
																	pstmt.close ();
									}//try
									catch (Exception e)
									{
																	e.printStackTrace ();
																	return -1;
									}
									finally  { conPool.free(con); } 
									return 0; //  added susccessfully
	}// addNewRange
	public int getviralmsisdn (ArrayList chargecode, String order,String searchkey)
	{
									logger.debug("getviralmsisdn ");
									try
									{
																	con = conPool.getConnection();
																	if(searchkey.equalsIgnoreCase("X") )  // show all Keywords
																	{
																									query = "select MSISDN_RANGE from VIRAL_SMS_ALLOWED_RANGES ORDER BY MSISDN_RANGE "+order;
																									pstmt = con.prepareStatement (query);
																	}
																	else
																	{
																									query = "SELECT MSISDN_RANGE from VIRAL_SMS_ALLOWED_RANGES where MSISDN_RANGE like ? ORDER BY MSISDN_RANGE "+order;
																									pstmt = con.prepareStatement (query);
																									pstmt.setString(1,"%"+searchkey+"%");
																	}
																	rs = pstmt.executeQuery ();

																	while(rs.next ())
																	{
																									chargecode.add (rs.getInt ("MSISDN_RANGE"));
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
																									logger.error ("Exception in getChargingCode, Exception is : " + sqle.getMessage ());
																	}
																	e.printStackTrace ();
																	return -1;
									}
									finally{ conPool.free(con); }
									return 1;

	}//getviralmsisdn()
	public int Deleteviralrange(String msisdn)
{
								logger.debug("webadmin: Deleteviralrange");
								try
								{
																con = conPool.getConnection();
																query = "DELETE FROM VIRAL_SMS_ALLOWED_RANGES WHERE MSISDN_RANGE = ? ";
																pstmt = con.prepareStatement (query);
																pstmt.setString (1, msisdn);
																pstmt.executeUpdate();
																logger.debug("webadmin: query execute");
																pstmt.close ();
								}//try
								catch (Exception e)
								{
																e.printStackTrace ();
																return -1;
								}
								finally  { conPool.free(con); } 
								return 0; //  added susccessfully

}
	public int rangeEdit(String msisdn,String oldmsisdn)
{
								logger.info("webadmin: rangeEdit=="+msisdn+"old=="+oldmsisdn);
								try
								{
																con = conPool.getConnection();
																query = "UPDATE VIRAL_SMS_ALLOWED_RANGES SET MSISDN_RANGE=? WHERE MSISDN_RANGE = ? ";
																pstmt = con.prepareStatement (query);
																pstmt.setString (1, msisdn);
																pstmt.setString (2, oldmsisdn);
																pstmt.executeUpdate();
																logger.debug("webadmin: query execute");
																pstmt.close ();
								}//try
								catch (Exception e)
								{
																e.printStackTrace ();
																return -1;
								}
								finally  { conPool.free(con); } 
								return 0; //  

}//rangeEdit

/*
	public int getRowCode (ArrayList chgAl)
	{
									logger.info("getChargingCode() ");
									try
									{
																	con = conPool.getConnection();
																	query = "select DESCRIPTION,CHARGING_CODE from CRBT_CHARGING_CODE";
																	//query="select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST,CHARGING_CODE from CRBT_CHARGING_CODE where CHARGING_CODE not in (select charging_code from crbt_rbt)";
																	pstmt = con.prepareStatement (query);
																	rs = pstmt.executeQuery ();
																	while(rs.next ())
																	{
																									RbtRatePlan rrpOb = new RbtRatePlan ();
																									rrpOb.setDesc (rs.getString ("DESCRIPTION"));
																									rrpOb.setChgCode (rs.getLong ("CHARGING_CODE"));
																									chgAl.add (rrpOb);
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
																									logger.info ("Exception in getChargingCode: " + sqle.getMessage ());
																	}
																	e.printStackTrace ();
																	return -1;
									}
									finally{ conPool.free(con); }
									return 1;
	}//getRowCode

	public int getrateplan (ArrayList chargecode,String keyword, String order,String searchkey)
	{
					logger.info("getrateplan ");
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
													logger.info ("Exception in getChargingCode, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;

	}//getrateplan()
	public int viewRatePlan (RbtRatePlan RRPObj,int planId)
	{
		logger.info("webadmin: viewRatePlan");
		try
		{
			con = conPool.getConnection();
			query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, MONOTONE_CHARGE_CODE, RBT_NO_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, RBT_RECORDED_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, planId);
			rs = pstmt.executeQuery ();
			while(rs.next())
			{
			RRPObj.setPlanId (rs.getInt ("PLAN_INDICATOR"));
			RRPObj.setRbtChgCode (rs.getString("RBT_CHARGE_CODE"));
			RRPObj.setRbtGiftChgCode (rs.getString("GIFT_CHARGE_CODE"));
			RRPObj.setRbtMonoChgCode (rs.getString("MONOTONE_CHARGE_CODE"));
			RRPObj.setRbtNoChgCode(rs.getString("RBT_NO_CHARGE_CODE"));
			RRPObj.setRbtNormalChgCode(rs.getString("RBT_NORMAL_CHARGE_CODE"));
			RRPObj.setSubChgCode(rs.getString("SUBSCRIPTION_CHARGE_CODE"));
			RRPObj.setRbtRecChgCode(rs.getString("RBT_RECORDED_CHARGE_CODE"));
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

			query = "SELECT PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, MONOTONE_CHARGE_CODE, RBT_NO_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, RBT_RECORDED_CHARGE_CODE, REMARKS, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, planId);
			rs = pstmt.executeQuery ();
			while(rs.next())
			{
			RRPObj.setPlanId (rs.getInt ("PLAN_INDICATOR"));
			RRPObj.setRbtChgCode (rs.getString("RBT_CHARGE_CODE"));
			RRPObj.setRbtGiftChgCode (rs.getString("GIFT_CHARGE_CODE"));
			RRPObj.setRbtMonoChgCode (rs.getString("MONOTONE_CHARGE_CODE"));
			RRPObj.setRbtNoChgCode(rs.getString("RBT_NO_CHARGE_CODE"));
			RRPObj.setRbtNormalChgCode(rs.getString("RBT_NORMAL_CHARGE_CODE"));
			RRPObj.setSubChgCode(rs.getString("SUBSCRIPTION_CHARGE_CODE"));
			RRPObj.setRbtRecChgCode(rs.getString("RBT_RECORDED_CHARGE_CODE"));
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
	
			query = "UPDATE CRBT_RATE_PLANS SET RBT_CHARGE_CODE=?, GIFT_CHARGE_CODE=?, MONOTONE_CHARGE_CODE=?, RBT_NO_CHARGE_CODE=?, RBT_NORMAL_CHARGE_CODE=?, SUBSCRIPTION_CHARGE_CODE=?, RBT_RECORDED_CHARGE_CODE=?, REMARKS=?, MONTHLY_RENT_CODE=?, THREE_WEEK_RENT_CODE=?,TWO_WEEK_RENT_CODE=?,ONE_WEEK_RENT_CODE=? WHERE PLAN_INDICATOR=?";
			pstmt = con.prepareStatement (query);

			pstmt.setString (1, rbtObj.getRbtChgCode());
			pstmt.setString (2, rbtObj.getRbtGiftChgCode());
			pstmt.setString (3, rbtObj.getRbtMonoChgCode());
			pstmt.setString (4, rbtObj.getRbtNoChgCode());
			pstmt.setString (5, rbtObj.getRbtNormalChgCode());
			pstmt.setString (6, rbtObj.getSubChgCode());
			pstmt.setString (7, rbtObj.getRbtRecChgCode());
			pstmt.setString (8, rbtObj.getRemarks());
			pstmt.setString (9, rbtObj.getMRentCode());
			pstmt.setString (10, rbtObj.getThreeWeek());
			pstmt.setString (11, rbtObj.getTwoWeek());
			pstmt.setString (12, rbtObj.getOneWeek());
			pstmt.setInt (13, pid);

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
}//class
