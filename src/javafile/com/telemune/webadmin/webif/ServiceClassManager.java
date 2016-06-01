package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class ServiceClassManager
{
        private static Logger logger=Logger.getLogger(ServiceClassManager.class);
	private ConnectionPool conPool = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt1 = null;
	private Connection con = null;
	private String query = null;
	private String query1 = null;

	public ServiceClassManager()
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


	private int checkRange (ServiceClass scObj)
	{
		try
		{
			con = conPool.getConnection();
			
			query = "select RANGE_ID from SERVICE_CLASS_RANGES where STARTS <= ? and  ENDS >=  ?";
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
				logger.debug ("This Number Exists ");
				rs.close();
				pstmt.close();
				return -3; //Range already exists(checking ending no. of new range)
			}
				rs.close();
				pstmt.close();

			query = "select RANGE_ID from SERVICE_CLASS_RANGES where STARTS >= ? and  STARTS <= ?";
			pstmt = con.prepareStatement (query);
			logger.info ("checking for MSISDN Range "+scObj.getStartsAt()+"-"+scObj.getEndsAt());
			pstmt.setInt (1, scObj.getStartsAt());
			pstmt.setInt (2, scObj.getEndsAt());
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.debug ("This Range Exists ");
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
				System.err.println ("In checkRange method, SQLException is :" + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		
		return 0;
	} // checkRange
	public int addServiceClass (ServiceClass scObj)
	{
		logger.debug("webadmin: addServiceClass");
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
  	query="select count(*) from SERVICE_CLASS_RANGES where STARTS=? and ENDS=?";
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

			query="select service_class_id.nextval from dual";
			pstmt=con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				range_id = rs.getInt(1);
			}
			rs.close ();
			pstmt.close ();
			query = "INSERT INTO SERVICE_CLASS_RANGES (RANGE_ID, STARTS, ENDS, RATE_PLAN) VALUES (?,?,?,?)";
			pstmt = con.prepareStatement (query);

			pstmt.setInt (1, range_id);
			pstmt.setInt (2, scObj.getStartsAt());
			pstmt.setInt (3, scObj.getEndsAt());
			pstmt.setInt (4, scObj.getRatePlan());

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
				logger.error ("webadmin-addServiceClass: Exception is: " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 1; //  added susccessfully

	}// addServiceClass()

	public int getServiceClass (ArrayList scAl)
	{
		logger.debug("getServiceClass() ");
		try
		{
			con = conPool.getConnection();
			query = "select RANGE_ID,STARTS,ENDS, RATE_PLAN from SERVICE_CLASS_RANGES";
			//query="select DESCRIPTION, AMOUNT_PRE,AMOUNT_POST,CHARGING_CODE from CRBT_CHARGING_CODE where CHARGING_CODE not in (select charging_code from crbt_rbt)";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				ServiceClass scOb = new ServiceClass ();
				scOb.setRangeId (rs.getInt ("RANGE_ID"));
				scOb.setStartsAt (rs.getInt ("STARTS"));
				logger.info("STARTS"+rs.getInt("STARTS"));
				scOb.setEndsAt (rs.getInt ("ENDS"));
				logger.info("ENDS"+rs.getInt ("ENDS"));
				scOb.setRatePlan (rs.getInt ("RATE_PLAN"));
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
				logger.error ("Exception in getServiceClass: " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;
	}//getServiceClass

	public int getServiceClass (ArrayList ocAl,int scCode)
	{
					logger.debug("getServiceClass() ");
					try
					{
									con = conPool.getConnection();
			query = "select RANGE_ID,STARTS,ENDS, RATE_PLAN from SERVICE_CLASS_RANGES where RANGE_ID=?";
									pstmt = con.prepareStatement (query);
									pstmt.setInt(1,scCode);
									rs = pstmt.executeQuery ();

									while(rs.next ())
									{
													ServiceClass scOb = new ServiceClass ();
													scOb.setStartsAt (rs.getInt ("STARTS"));
													scOb.setEndsAt (rs.getInt ("ENDS"));
													scOb.setRatePlan (rs.getInt ("RATE_PLAN"));
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
													logger.error ("Exception in getServiceClass, Exception is : " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con); }
					return 1;

	}//getServiceClass()

	public int updateServiceClass (ServiceClass ocobj, int scCode)
	{
					logger.debug("in function updateServiceClass() "+scCode);

					try
					{
									con = conPool.getConnection();

									query = "UPDATE SERVICE_CLASS_RANGES set STARTS=?,ENDS=?,RATE_PLAN=? where RANGE_ID=?";
									pstmt = con.prepareStatement (query);

									pstmt.setInt (1, ocobj.getStartsAt ());
									logger.info("STARTS AT"+ocobj.getStartsAt());
									pstmt.setInt (2, ocobj.getEndsAt ());
									logger.info("ENDS AT"+ocobj.getEndsAt());
									pstmt.setInt (3, ocobj.getRatePlan ());
									logger.info("RATE PLAN"+ocobj.getRatePlan());
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
													logger.error ("Exception in updateServiceClass: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{conPool.free(con); }
					return 1;
	} // updateServiceClass

	public int deleteServiceClass (int[] codes)
	{
					logger.debug("deleteServiceClass()");
					try
					{
									con = conPool.getConnection();
									query = "delete from SERVICE_CLASS_RANGES WHERE RANGE_ID=?";
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
													logger.error ("Exception in deleteServiceClass: " + sqle.getMessage ());
									}
									e.printStackTrace ();
									return -1;
					}
					finally{ conPool.free(con);  }
					return 1;
	}//deleteServiceClass
}
/*	public int getTableCol (ArrayList colAl)
	{
		logger.info("getTableCol() ");
		try
		{
			con = conPool.getConnection();
			query = "SELECT plan_id,description FROM CRBT_RATE_PLANS";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				ServiceClass chgOb = new ServiceClass ();
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
	public int defineChargingRule (ServiceClass chgObj)
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
