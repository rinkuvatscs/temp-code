
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class HomeSubscriberManager

{
                                 private static Logger logger=Logger.getLogger(HomeSubscriberManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private PreparedStatement pstmt1 = null;
				private Connection con = null;
				private ResultSet rs =null;
				private ResultSet rs1 =null;
				private String query = null;
				private String query1 = null;
				
 public HomeSubscriberManager()				 
 {
				// conPool = new ConnectionPool();
 }


   public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

 public int addHomeSubscriber (HomeSubDetail homeSubDetail)
	{
		logger.debug ("webadmin: addHomeSubscriber ");
		try
		{
			con = conPool.getConnection();
			int retVal = checkRange (homeSubDetail);
			if(retVal < 0)
			{
				return retVal; //if -1 then exception occured otherwise User ALREADY EXISTS
			}
			
			// NOT Condition
			if( (!homeSubDetail.getStartAt ().equalsIgnoreCase ("")) && (!homeSubDetail.getStartAt ().equalsIgnoreCase (null)) && (!homeSubDetail.getStartAt ().equalsIgnoreCase ("null")) )
			{
				if(insertRange (homeSubDetail) < 0)
				{
					return -1; //Error in insert
				}
			}
			if(insertExcludes (homeSubDetail) < 0)
			{
				return -1; //Error in insert
			}
		}//try
		catch (Exception e)
		{
				logger.error ("In addHomeSubscriber, SQLException is : " + e.getMessage ());
     		e.printStackTrace ();
		  	return -1;
		}//catch
		finally { conPool.free(con); } 
		return 0;
	} // addHomeSubscriber

	private int checkRange (HomeSubDetail homeSubDetail)
	{
		logger.debug("webadmin: checkRange() in HomeSubscriberManager");
		try
		{
			String interStartMsisdn = TSSJavaUtil.instance ().getInternationalNumber ( homeSubDetail.getStartAt ());
			String interEndMsisdn = TSSJavaUtil.instance ().getInternationalNumber (homeSubDetail.getEndsAt ());
			
			query = "select RANGE_ID from OPERATOR_SUBSCRIBER where to_number(STARTS_AT) <= to_number(?)and to_number(ENDS_AT) >= to_number(?)";
			pstmt = con.prepareStatement (query);
			
			logger.info ("checking for Starting MSISDN "+ interStartMsisdn);
			pstmt.setString (1, interStartMsisdn);
			pstmt.setString (2, interStartMsisdn);
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.info ("This Number Exists ");
				rs.close();
				pstmt.close();
				return -3; //Range already exists(checking starting no. of new range)
			}
			
			logger.info ("checking for Ending MSISDN "+interEndMsisdn);
			pstmt.setString (1, interEndMsisdn);
			pstmt.setString (2, interEndMsisdn);
			rs = pstmt.executeQuery ();
			pstmt.clearParameters ();
			while(rs.next ())
			{
				logger.debug("This Number Exists ");
				rs.close();
				pstmt.close();
				return -3; //Range already exists(checking ending no. of new range)
			}
				rs.close();
				pstmt.close();

			query = "select RANGE_ID from OPERATOR_SUBSCRIBER where to_number(STARTS_AT) >=to_number(?) and to_number(STARTS_AT)<=to_number(?)";
			pstmt = con.prepareStatement (query);
			logger.info ("checking for MSISDN Range "+interStartMsisdn+"-"+interEndMsisdn);
			pstmt.setString (1, interStartMsisdn);
			pstmt.setString (2, interEndMsisdn);
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

	private int insertRange (HomeSubDetail homeSubDetail)
	{
		logger.debug ("webadmin: insertRange()");
		try
		{
			int rangeId = -1;
			query = "select crbt_range_id.nextval from dual";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				rangeId = rs.getInt(1);			
				homeSubDetail.setRangeId(rangeId);
				rs.close();
				pstmt.close();
			}
			else
			{
				logger.info ("HomeSubscriberManager insertRange: rangeId not created");
				rs.close();
				pstmt.close();
				return -2;  // 
			}
			
			String interStartAt = TSSJavaUtil.instance ().getInternationalNumber (homeSubDetail.getStartAt ());
			String interEndsAt = TSSJavaUtil.instance ().getInternationalNumber (homeSubDetail.getEndsAt ());
			
			query = "INSERT INTO operator_subscriber(RANGE_ID, STARTS_AT, ENDS_AT, HLR_ID) VALUES(? , ? ,  ?, ?)";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, homeSubDetail.getRangeId ());
			pstmt.setString (2, interStartAt);
			pstmt.setString (3, interEndsAt);
			pstmt.setInt (4, homeSubDetail.getHLRId());
			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (SQLException e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.error("Exception in insertRange, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		return 0;
	}//insertRange
	
	private int insertExcludes (HomeSubDetail homeSubDetail)
	{
		logger.debug ("webadmin insertExcludes()");
		try
		{
			Iterator ite = (homeSubDetail.getExcludes ()).iterator ();
			 query = "INSERT INTO operator_subscriber_exclude(RANGE_ID, EXCLUDE_NUM) VALUES (?, ?)";
			pstmt = con.prepareStatement (query);
			while(ite.hasNext ())
			{
				String strExclude = (String) ite.next ();
				String interExcludeMsisdn = TSSJavaUtil.instance ().getInternationalNumber (strExclude);
				pstmt.setInt (1, homeSubDetail.getRangeId ());
				pstmt.setString (2, interExcludeMsisdn);
				pstmt.executeUpdate();
			}
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
			     logger.error ("In insertExcludes, SQLException is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		return 0;
	} //insertExcludes


 public int getHomeSubscriber (ArrayList homeSubDetailAl)
	{
		logger.debug("webadmin getHomeSubscriber()");
		try
		{
			con = conPool.getConnection();
			query = "select RANGE_ID, STARTS_AT, ENDS_AT, OS.HLR_ID, HLR_NAME from OPERATOR_SUBSCRIBER OS, CRBT_HLR_CONFIG CHC where OS.HLR_ID = CHC.HLR_ID order by STARTS_AT";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				HomeSubDetail homeSubDetail = new HomeSubDetail ();
				homeSubDetail.setRangeId (rs.getInt ("RANGE_ID"));
				homeSubDetail.setStartAt (rs.getString ("STARTS_AT"));
				homeSubDetail.setEndsAt (rs.getString ("ENDS_AT"));
				homeSubDetail.setHLRName (rs.getString ("HLR_NAME"));
				homeSubDetail.setHLRId (rs.getInt ("HLR_ID"));
				
				int i = listExcludes(homeSubDetail);					// get list of numbers excluded from this Range
				homeSubDetailAl.add (homeSubDetail);
	  	}
			
			rs.close ();
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in getHomeSubscriber, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally { conPool.free(con); } 
		return 0;
	
	}// getHomeSubscriber

	private int listExcludes (HomeSubDetail homeSubDetail)
	{
		logger.debug("webadmin listExcludes()");
		try
		{
			ArrayList excludeAl = new ArrayList ();
			query1 = "select EXCLUDE_NUM from OPERATOR_SUBSCRIBER_EXCLUDE where RANGE_ID = ?";
			pstmt1 = con.prepareStatement (query1);
			pstmt1.setInt (1, homeSubDetail.getRangeId ());
			rs1 = pstmt1.executeQuery ();
			while(rs1.next ())
			{
				excludeAl.add (rs1.getString ("EXCLUDE_NUM"));
			}
			homeSubDetail.setExcludes (excludeAl);
			rs1.close ();
			pstmt1.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(rs1 != null) rs1.close ();
				if(pstmt1 != null) pstmt1.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in listExcludes, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		return 0;
	} //listExcludes()

 public int deleteHomeSubscriber (int rangeIdArr[])
	{
		logger.debug("webadmin deleteHomeSubscriber()");
		try
		{
			con = conPool.getConnection();
			for(int z=0; z<rangeIdArr.length;z++)
			{
				int rangeId = rangeIdArr[z];
				
				query = "delete from OPERATOR_SUBSCRIBER_EXCLUDE where RANGE_ID = ?";
				pstmt = con.prepareStatement (query);
				pstmt.setInt (1, rangeId);
				pstmt.executeQuery ();
				
				query = "delete from  OPERATOR_SUBSCRIBER where RANGE_ID = ?";
				pstmt = con.prepareStatement (query);
				pstmt.setInt (1, rangeId);
				pstmt.executeQuery ();
				pstmt.close ();
			}
		
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in deleteHomeSubscriber, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
		finally { conPool.free(con); }

		return 0;
	} // deleteHomeSubscriber
	
 public int updateHomeSubscriber (HomeSubDetail homeSubDetail)
	{
		logger.debug ("webadmin updateHomeSubscriber()");  // remove all  previous Values and then Insert New 
		try
		{
			con = conPool.getConnection();
			query = "delete from  OPERATOR_SUBSCRIBER_EXCLUDE where RANGE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, homeSubDetail.getRangeId ());
			pstmt.executeUpdate();
		  pstmt.close();	
			
			query = "delete from  OPERATOR_SUBSCRIBER where RANGE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, homeSubDetail.getRangeId ());
			pstmt.executeUpdate();
		  pstmt.close();	
			return addHomeSubscriber (homeSubDetail); // con.commit() is done inside this method
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("In updateHomeSubscriber, SQLException is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
	// 	finally { conPool.free(con); } // connection is closed in addHomeSubscriber function
	
	} // updateHomeSubscriber

} // class HomeSubscriberManager
