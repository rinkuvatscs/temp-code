
package com.telemune.webadmin.webif;

import com.telemune.dbutilities.*;
import java.text.DateFormat;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
 import org.apache.log4j.*;

public class IMSIManager
{ 
                                 private static Logger logger=Logger.getLogger(IMSIManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;

	public IMSIManager ()
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


				
	public int addIMSIConfig (IMSI imsi)
	{
		logger.debug ("webadmin: addIMSIConfig()");
		try
		{
			con = conPool.getConnection();
			query = "select RANGE_ID from IMSI_RANGE where RANGE_ID = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, imsi.getRangeId ());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				pstmt.close();
				return -2;
			}
			rs.close();
			pstmt.close();
			
			query = "insert into IMSI_RANGE (RANGE_ID, START_AT, ENDS_AT, SUBSCRIBER_TYPE, HLR, SCP, SMSC) values (?, ?, ?, ?, 0, 0, 'NA')";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, imsi.getRangeId());
			pstmt.setString (2, imsi.getStartAt());
			pstmt.setString (3, imsi.getEndsAt());
			pstmt.setString (4, imsi.getSubscriberType());
			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in addIMSIConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{conPool.free(con);}
		return 0;
	} //addSMSCConfig
	
	public int updateIMSIConfig (IMSI imsi)
	{
		logger.debug("webadmin updateIMSI"); 
		try
		{
			con = conPool.getConnection();			
			String query = "update IMSI_RANGE set START_AT=?, ENDS_AT=?, SUBSCRIBER_TYPE=? where RANGE_ID=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, imsi.getStartAt());
			pstmt.setString (2, imsi.getEndsAt());
			pstmt.setString (3, imsi.getSubscriberType());
			pstmt.setString (4, imsi.getRangeId());
			pstmt.executeUpdate ();
			pstmt.close ();
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateIMSI, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
		finally { conPool.free(con); }
		return 0;
	
	 } //updateIMSI
	
	public int getIMSIConfig (ArrayList imsiConfigAl, String imsiId)
	{
		logger.debug ("webadmin getIMSIConfig");
		try
		{
			con = conPool.getConnection();
			logger.info ("imsiID = "+imsiId);
			
			if(imsiId.equalsIgnoreCase("x") )  //for all values
			{
			query = "select RANGE_ID, START_AT, ENDS_AT, SUBSCRIBER_TYPE from IMSI_RANGE order by START_AT";
			pstmt = con.prepareStatement (query);
			}
			else
			{
			query = "select RANGE_ID, START_AT, ENDS_AT, SUBSCRIBER_TYPE from IMSI_RANGE where RANGE_ID=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString(1,imsiId);
			}
			rs = pstmt.executeQuery ();
			imsiConfigAl.clear ();
			while(rs.next ())
			{
				IMSI imsi = new IMSI();
				imsi.setRangeId (rs.getString ("RANGE_ID"));
				imsi.setStartAt (rs.getString ("START_AT"));
				imsi.setEndsAt (rs.getString ("ENDS_AT"));
				imsi.setSubscriberType (rs.getString ("SUBSCRIBER_TYPE"));
				imsiConfigAl.add (imsi);
			}
			rs.close ();
			pstmt.close ();
		}//try
		catch (Exception e)
		{
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in getIMSIConfig, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception caught "+e);
			e.printStackTrace ();
			return -1;
		}//catch
		finally{conPool.free(con);}
		return 0;
	}//selectIMSIConfig
	
	public int deleteIMSIConfig (ArrayList imsiIdAl)
	{
		logger.info ("webadmin: deleteIMSIConfig; ID= " + imsiIdAl);
		try
		{
			con = conPool.getConnection();
			query = "delete from IMSI_RANGE where RANGE_ID = ?";
			pstmt = con.prepareStatement (query);
			Iterator ite = imsiIdAl.iterator ();
			while(ite.hasNext ())
			{
				String imsiId = (String)ite.next ();
				pstmt.setString (1, imsiId);
				pstmt.executeUpdate();
			}
			pstmt.close ();
		}
		catch (SQLException e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in deleteIMSIConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
		}
		finally{conPool.free(con);}
		return 0;
	} // deleteIMSIConfig

} //class IMSIManager
