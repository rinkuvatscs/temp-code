package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class ChargingCodeManager
{
       private static Logger logger=Logger.getLogger(ChargingCodeManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;

	/*public ChargingCodeManager()
	{
		conPool = new ConnectionPool();
	}*/

        public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }



	public int addChargingCode (ChargingCode chgObj)
	{
		logger.debug("webadmin: addChargingCode");
		long chg_id=0;
		try
		{
			con = conPool.getConnection();
			query = "SELECT DESCRIPTION FROM CRBT_CHARGING_CODE WHERE DESCRIPTION=? ";
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
			pstmt.close ();
			query="select chg_code_id.nextval from dual";
			pstmt=con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				chg_id = rs.getLong(1);
			}
			rs.close ();
			pstmt.close ();
			query = "INSERT INTO CRBT_CHARGING_CODE (REQ_ID, CHARGING_CODE, AMOUNT_PRE, AMOUNT_POST,DESCRIPTION) VALUES (?,?,?,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setLong (1, chg_id);
			pstmt.setLong (2, chg_id);
			pstmt.setDouble (3, chgObj.getAmountP());
			pstmt.setDouble (4, chgObj.getAmountO());
			pstmt.setString (5, chgObj.getDesc ());

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
				logger.error ("webadmin-addChargingCode: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; //  added susccessfully

	}// addChargingCode()

	public int getChargingCode (ArrayList chgAl)
	{
		logger.debug("getChargingCode() ");
		try
		{
			con = conPool.getConnection();
			query = "select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST, CHARGING_CODE from CRBT_CHARGING_CODE";
			//query="select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST,CHARGING_CODE from CRBT_CHARGING_CODE where CHARGING_CODE not in (select charging_code from crbt_rbt)";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				ChargingCode chgOb = new ChargingCode ();
				chgOb.setDesc (rs.getString ("DESCRIPTION"));
				chgOb.setAmountP (rs.getDouble ("AMOUNT_PRE"));
				chgOb.setAmountO (rs.getDouble ("AMOUNT_POST"));
				chgOb.setChgCode (rs.getLong ("CHARGING_CODE"));
				chgAl.add (chgOb);
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
	}//getChargingCode

	public int getChargingCode (ArrayList ocAl,long chgCode)
	{
					logger.debug("getChargingCode() ");
					try
					{
									con = conPool.getConnection();
									query = "select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST, CHARGING_CODE from CRBT_CHARGING_CODE where CHARGING_CODE=?";
									pstmt = con.prepareStatement (query);
									pstmt.setLong(1,chgCode);
									rs = pstmt.executeQuery ();

									while(rs.next ())
									{
													ChargingCode ocob = new ChargingCode ();
													ocob.setDesc (rs.getString ("DESCRIPTION"));
													ocob.setAmountP (rs.getDouble ("AMOUNT_PRE"));
													ocob.setAmountO (rs.getDouble ("AMOUNT_POST"));
													ocob.setChgCode (chgCode);
													ocAl.add (ocob);
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

	}//getChargingCode()

	public int updateChargingCode (ChargingCode ocobj, long chgCode)
	{
					logger.debug("in function updateChargingCode() "+chgCode);

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
													logger.error ("Exception in updateChargingCode: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{conPool.free(con); }
					return 1;
	} // updateChargingCode

	public int deleteChargingCode (String[] codes)
	{
					logger.debug("deleteChargingCode()");
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
													logger.error ("Exception in deleteChargingCode: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
	}//deleteChargingCode

	public int getTableCol (ArrayList colAl)
	{
		logger.debug("getTableCol() ");
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
				logger.error ("Exception in getTableCol: " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;
	}//getTableCol

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
