package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class PrePostManager
{
        private static Logger logger=Logger.getLogger(PrePostManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;

	public PrePostManager()
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

 
	private int checkRange (PrePost scObj)
	{
		try
		{
			con = conPool.getConnection();
			
			query = "select RANGE_ID from SERVICE_CLASS_RANGE where ST_CLASS <= ? and  ET_CLASS >=  ?";
			pstmt = con.prepareStatement (query);
			
			logger.info ("checking for Starting MSISDN "+ scObj.getStartsAt());
			pstmt.setInt(1,scObj.getStartsAt() );
			pstmt.setInt (2, scObj.getStartsAt());
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.info ("This Number Exists ");
				rs.close();
				pstmt.close();
				return -3; //Range already exists(checking starting no. of new range)
			}
			
			logger.info ("checking for Ending MSISDN "+scObj.getEndsAt());
			pstmt.setInt (1,scObj.getEndsAt() );
			pstmt.setInt (2, scObj.getEndsAt());
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.info ("This Number Exists ");
				rs.close();
				pstmt.close();
				return -3; //Range already exists(checking ending no. of new range)
			}
				rs.close();
				pstmt.close();

			query = "select RANGE_ID from SERVICE_CLASS_RANGE where ST_CLASS >= ? and  ST_CLASS <= ?";
			pstmt = con.prepareStatement (query);
			logger.info ("checking for MSISDN Range "+scObj.getStartsAt()+"-"+scObj.getEndsAt());
			pstmt.setInt (1, scObj.getStartsAt());
			pstmt.setInt (2, scObj.getEndsAt());
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.info ("This Range Exists ");
				rs.close();
				pstmt.close();
				return -4; //Range already exists(checking whether new range is superset of some existing range)
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
			}
			catch(SQLException sqle)
			{
				logger.error ("In checkRange method, SQLException is :" + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		
		return 0;
	} // checkRange
	public int addPrePost (PrePost scObj)
	{
		logger.debug("webadmin: addPrePost");
		int range_id=0;
		int exist=0;
  int ret = checkRange (scObj);
  if(ret < 0)
  {
								return ret; //if -1 then exception occured otherwise User ALREADY EXISTS
  }
									
		try
		{
			con = conPool.getConnection();
  	query="select count(*) from SERVICE_CLASS_RANGE where ST_CLASS=? and ET_CLASS=?";
			pstmt=con.prepareStatement(query);
			pstmt.setInt (1, scObj.getStartsAt());
			pstmt.setInt (2, scObj.getEndsAt());
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				exist = rs.getInt(1);
			}
			rs.close ();
			pstmt.close ();
			if(exist>0)
			{
							return -2;
			}

			query="select max(RANGE_ID) from SERVICE_CLASS_RANGE";
			pstmt=con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				range_id = rs.getInt(1);
			}
			rs.close ();
			pstmt.close ();
			range_id=range_id+1;
			query = "INSERT INTO SERVICE_CLASS_RANGE (RANGE_ID, ST_CLASS, ET_CLASS, SUB_TYPE) VALUES (?,?,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setInt (1, range_id);
			pstmt.setInt (2, scObj.getStartsAt());
			pstmt.setInt (3, scObj.getEndsAt());
			pstmt.setString (4, scObj.getsub_type());

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
				logger.error ("webadmin-addPrePost: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; //  added susccessfully

	}// addPrePost()

	public int getPrePost (ArrayList scAl)
	{
		logger.debug("getPrePost() ");
		try
		{
			con = conPool.getConnection();
			query = "select RANGE_ID,ST_CLASS,ET_CLASS, SUB_TYPE from SERVICE_CLASS_RANGE";
			//query="select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST,CHARGING_CODE from CRBT_CHARGING_CODE where CHARGING_CODE not in (select charging_code from crbt_rbt)";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				PrePost scOb = new PrePost ();
				scOb.setRangeId (rs.getInt ("RANGE_ID"));
				scOb.setStartsAt (rs.getInt ("ST_CLASS"));
				logger.info("ST_CLASS"+rs.getInt("ST_CLASS"));
				scOb.setEndsAt (rs.getInt ("ET_CLASS"));
				logger.info("ET_CLASS"+rs.getInt ("ET_CLASS"));
				scOb.setsub_type (rs.getString ("SUB_TYPE"));
				scAl.add (scOb);
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
				logger.error ("Exception in getPrePost: " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;
	}//getPrePost

	public int getPrePost (ArrayList ocAl,int scCode)
	{
					logger.debug("getPrePost() ");
					try
					{
									con = conPool.getConnection();
			query = "select RANGE_ID,ST_CLASS,ET_CLASS, SUB_TYPE from SERVICE_CLASS_RANGE where RANGE_ID=?";
									pstmt = con.prepareStatement (query);
									pstmt.setInt(1,scCode);
									rs = pstmt.executeQuery ();

									while(rs.next ())
									{
													PrePost scOb = new PrePost ();
													scOb.setStartsAt (rs.getInt ("ST_CLASS"));
													scOb.setEndsAt (rs.getInt ("ET_CLASS"));
													scOb.setsub_type (rs.getString("SUB_TYPE"));
													scOb.setRangeId (scCode);
													ocAl.add (scOb);
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
													logger.error ("Exception in getPrePost, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;

	}//getPrePost()

	public int updatePrePost (PrePost ocobj, int scCode)
	{
					logger.debug("in function updatePrePost() "+scCode);

					try
					{
									con = conPool.getConnection();

									query = "UPDATE SERVICE_CLASS_RANGE set ST_CLASS=?,ET_CLASS=?,SUB_TYPE=? where RANGE_ID=?";
									pstmt = con.prepareStatement (query);

									pstmt.setInt (1, ocobj.getStartsAt ());
									logger.info("ST_CLASS AT"+ocobj.getStartsAt());
									pstmt.setInt (2, ocobj.getEndsAt ());
									logger.info("ET_CLASS AT"+ocobj.getEndsAt());
									pstmt.setString (3, ocobj.getsub_type ());
									logger.info("RATE PLAN"+ocobj.getsub_type());
									pstmt.setInt (4, scCode);
									logger.info("ID"+scCode);

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
													logger.error ("Exception in updatePrePost: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{conPool.free(con); }
					return 1;
	} // updatePrePost

	public int deletePrePost (int[] codes)
	{
					logger.debug("deletePrePost()");
					try
					{
									con = conPool.getConnection();
									query = "delete from SERVICE_CLASS_RANGE WHERE RANGE_ID=?";
									pstmt = con.prepareStatement(query);
									for(int i=0; i<codes.length; i++)
									{
													pstmt.setInt (1,codes[i]);
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
													logger.error ("Exception in deletePrePost: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
	}//deletePrePost
}
/*	public int getTableCol (ArrayList colAl)
	{
		logger.info("getTableCol() ");
		try
		{
			con = conPool.getConnection();
			query = "SELECT plan_id,description FROM CRBT_SUB_TYPES";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				PrePost chgOb = new PrePost ();
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
	}//getTableCol
*/
	/*
	public int defineChargingRule (PrePost chgObj)
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
