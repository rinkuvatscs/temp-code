package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
  import org.apache.log4j.*;
public class RbtRatePlanManager
{
         private static Logger logger=Logger.getLogger(RbtRatePlanManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;

	public RbtRatePlanManager()
	{
		//conPool = new ConnectionPool();
	}

          public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }


	public int addRbtRatePlan (RbtRatePlan rbtObj)
	{
		logger.debug("webadmin: addRbtRatePlan");
		long pln_id=0;
		try
		{
			con = conPool.getConnection();
		/*	query = "SELECT DESCRIPTION FROM CRBT_RATE_PLANS WHERE DESCRIPTION=? ";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1,chgObj.getDesc());
			rs = pstmt.executeQuery ();
			if(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2; //Record already exists
			}
			rs.close ();
			pstmt.close ();*/
			query="select CHG_PLAN_ID.nextval from dual";
			pstmt=con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				pln_id = rs.getLong(1);
			}
			rs.close ();
			pstmt.close ();
//		logger.info("webadmin: query execute");


			//query = "INSERT INTO CRBT_RATE_PLANS (PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, MONOTONE_CHARGE_CODE, RBT_NO_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, RBT_RECORDED_CHARGE_CODE, REMARKS, FILE_EXTENSION, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE) VALUES (?,?,?,?,?,?,?,?,?,'cdr',?,?,?,?)";
			query = "INSERT INTO CRBT_RATE_PLANS (PLAN_INDICATOR, RBT_CHARGE_CODE, GIFT_CHARGE_CODE, RBT_NORMAL_CHARGE_CODE, SUBSCRIPTION_CHARGE_CODE, REMARKS, FILE_EXTENSION, MONTHLY_RENT_CODE, THREE_WEEK_RENT_CODE,TWO_WEEK_RENT_CODE,ONE_WEEK_RENT_CODE) VALUES (?,?,?,?,?,?,'cdr',?,?,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setLong (1, pln_id);
			pstmt.setString (2, rbtObj.getRbtChgCode());
			pstmt.setString (3, rbtObj.getRbtGiftChgCode());
			//pstmt.setString (4, rbtObj.getRbtMonoChgCode());
		//	pstmt.setString (5, rbtObj.getRbtNoChgCode());
			pstmt.setString (4, rbtObj.getRbtNormalChgCode());
			pstmt.setString (5, rbtObj.getSubChgCode());
		//	pstmt.setString (8, rbtObj.getRbtRecChgCode());
			pstmt.setString (6, rbtObj.getRemarks());
			pstmt.setString (7, rbtObj.getMRentCode());
			pstmt.setString (8, rbtObj.getThreeWeek());
			pstmt.setString (9, rbtObj.getTwoWeek());
			pstmt.setString (10, rbtObj.getOneWeek());

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
		return 0; //  added susccessfully
	//	return 2; //  added susccessfully

	}// addChargingCode()

	public int getRowCode (ArrayList chgAl)
	{
									logger.debug("getChargingCode() ");
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
																									logger.error ("Exception in getChargingCode: " + sqle.getMessage ());
																	}
																	e.printStackTrace ();
																	return -1;
									}
									finally{ conPool.free(con); }
									return 1;
	}//getRowCode

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
													logger.error ("Exception in getChargingCode, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;

	}//getrateplan()
public int getRatePlans (ArrayList RateArray)
	{
		logger.debug("webadmin: viewRatePlan");
		try
		{
			con = conPool.getConnection();
			query = "SELECT PLAN_INDICATOR,REMARKS FROM CRBT_RATE_PLANS";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next())
			{
							RbtRatePlan RRPObj =new RbtRatePlan();
				   RRPObj.setPlanId (rs.getInt ("PLAN_INDICATOR"));
				   RRPObj.setRemarks(rs.getString("REMARKS"));
							RateArray.add(RRPObj);
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
				logger.error ("webadmin-addRatePlan: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully

	}// viewRatePlan()

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
				logger.error ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully

	}// viewRatePlan()
	public int getRowCodeModify (ArrayList chargecode,RbtRatePlan RRPObj,int planId)
	{
		logger.debug("webadmin: getRowCodeModify");
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
				logger.error ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0; //  added susccessfully

	}// getRowCodeModify
public int saveEditRatePlan(RbtRatePlan rbtObj,int pid)
	{
		logger.debug("webadmin: saveEditRatePlan");
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
		return 0; //  added susccessfully
	//	return 2; //  added susccessfully

	}// saveEditRatePlan
	public int DeleteRbtRatePlan(int planId)
{
								logger.debug("webadmin: DeleteRbtRatePlan");
								try
								{
																con = conPool.getConnection();
																query = "DELETE FROM CRBT_RATE_PLANS WHERE PLAN_INDICATOR = ? ";
																pstmt = con.prepareStatement (query);
																pstmt.setInt (1, planId);
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

}// DeleteRbtRatePlan

/*	public int RatePlanLog (RbtRatePlan oldObj,RbtRatePlan newObj,int pid)
	{
		logger.info("webadmin: addRbtRatePlan");
		long pln_id=0;
		try
		{
			con = conPool.getConnection();
			query = "INSERT INTO WEB_ADMIN_LOGS (USE_TABLE, TABLE_FIELD, CURRENT_VALUE, PREVIOUS_VALUE, LINK_LOGS, UPDATED_BY, UPDATED_DATE, INDICATOR_VALUE) VALUES ('CRBT_RATE_PLANS',?,?,?,'Rate_Plan_Modify',?,sysdate,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setLong (1, pln_id);
			pstmt.setString (2, rbtObj.getRbtChgCode());
			pstmt.setString (3, rbtObj.getRbtGiftChgCode());
			//pstmt.setString (4, rbtObj.getRbtMonoChgCode());
		//	pstmt.setString (5, rbtObj.getRbtNoChgCode());
			pstmt.setString (4, rbtObj.getRbtNormalChgCode());
			pstmt.setString (5, rbtObj.getSubChgCode());
		//	pstmt.setString (8, rbtObj.getRbtRecChgCode());
			pstmt.setString (6, rbtObj.getRemarks());
			pstmt.setString (7, rbtObj.getMRentCode());
			pstmt.setString (8, rbtObj.getThreeWeek());
			pstmt.setString (9, rbtObj.getTwoWeek());
			pstmt.setString (10, rbtObj.getOneWeek());

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

	}// addChargingCode()

*/
/*
	public int updateChargingCode (ChargingCode ocobj, long chgCode)
	{
					logger.info("in function updateChargingCode() "+chgCode);

					try
					{
									con = conPool.getConnection();

									query = "UPDATE CRBT_CHARGING_CODE SET AMOUNT_PRE=?,AMOUNT_POST=? where Charging_Code=?";
									pstmt = con.prepareStatement (query);

									pstmt.setDouble (1, ocobj.getAmountP ());
									pstmt.setDouble (2, ocobj.getAmountO ());
									pstmt.setLong (3, chgCode);

									pstmt.executeUpdate ();
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
													logger.info ("Exception in updateChargingCode: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{conPool.free(con); }
					return 1;
	} // updateChargingCode

	public int deleteChargingCode (String[] codes)
	{
					logger.info("deleteChargingCode()");
					try
					{
									con = conPool.getConnection();
									query = "delete from CRBT_CHARGING_CODE WHERE CHARGING_CODE=?";
									pstmt = con.prepareStatement(query);
									for(int i=0; i<codes.length; i++)
									{
													pstmt.setLong (1,Long.parseLong(codes[i]));
													pstmt.executeUpdate();
									}
									pstmt.close();
					}//try
					catch (Exception e)
					{
									try
									{
													if(pstmt != null) pstmt.close ();
									}catch(SQLException sqle)
									{
													logger.info ("Exception in deleteChargingCode: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
	}//deleteChargingCode

	public int getTableCol (ArrayList colAl)
	{
		logger.info("getTableCol() ");
		try
		{
			con = conPool.getConnection();
			query = "SELECT column_name FROM USER_TAB_COLS WHERE TABLE_NAME ='CRBT_RATE_PLANS'";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				ChargingCode chgOb = new ChargingCode ();
				chgOb.setColName (rs.getString ("column_name"));
				colAl.add (chgOb);
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
				logger.info ("Exception in getTableCol: " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;
	}*///getTableCol

	/*
	public int defineChargingRule (ChargingCode chgObj)
	{
		logger.info("webadmin: defineChargingRule");
		int plan_id=0;
		try
		{
			con = conPool.getConnection();
			query="select chg_plan_id.nextval from dual";
			pstmt=con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				plan_id = rs.getInt(1);
			}
			rs.close ();
			pstmt.close ();
			pstmt.setString (3, chgObj.getRbtChgCode());
			pstmt.setString (4, chgObj.getRbtGiftChgCode ());
			pstmt.setString (5, chgObj.getRbtMonoChgCode ());
			pstmt.setString (6, chgObj.getRbtNoChgCode());
			pstmt.setString (7, chgObj.getRbtNormalChgCode ());
			pstmt.setString (8, chgObj.getSubChgCode ());
			pstmt.setString (9, chgObj.getRbtRecChgCode ());
			pstmt.setInt (10, chgObj.getValidity());
			pstmt.setString (11, chgObj.getRemarks());
			pstmt.setString (12, "S");
			pstmt.setString (13, "U");
			pstmt.setString (14, "cdr");

			pstmt.executeUpdate ();
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
				logger.info ("webadmin/defineChargingRule, Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; //  added susccessfully

	}// defineChargingRule
*/
}//class
