
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class HLRManager

{
                                private static Logger logger=Logger.getLogger(HLRManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public HLRManager()				 
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

 public int addHLRConfig (HLR hlr)
	{
		logger.debug ("webadmin: addHLRConfig");
		try
		{
		con = conPool.getConnection();
			query = "select HLR_NAME from CRBT_HLR_CONFIG where HLR_NAME = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, hlr.getHLRName ());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				rs.close();			
				pstmt.close();
				logger.info("webadmin; This HLR Name "+hlr.getHLRName()+ " already exists");
				return -2;
			}
				rs.close();			
				pstmt.close();

			int hlrId = 0;

			query = "select CRBT_HLR_ID.nextval from dual";
			pstmt = con.prepareStatement (query);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				hlrId = rs.getInt(1);
				rs.close();			
				pstmt.close();
			}
			else
			{
				logger.debug("HLRManager addHLRConfig: CRBT_HLR_ID not generated");
				rs.close();			
				pstmt.close();
				return -1;
			}
			
			query = "insert into CRBT_HLR_CONFIG (HLR_ID, HLR_NAME, HLR_IP, HLR_PORT, CONNECTIONS, LOGIN, PASSWORD) values (?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, hlrId);
			pstmt.setString (2, hlr.getHLRName ());
			pstmt.setString (3, hlr.getHLRIp ());
			pstmt.setInt (4, hlr.getHLRPort ());
			pstmt.setInt (5, hlr.getConnection () );
			pstmt.setString (6, hlr.getLogin () );
			pstmt.setString (7, hlr.getPassword () );
			pstmt.executeUpdate ();
			pstmt.close ();
		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
				if(rs != null) rs.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in addHLRConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 0;
	} // addHLRConfig

	public int getHLRConfig (ArrayList hlrConfigAl, int hlrId )
	{
		logger.info ("webadmin: getHLRConfig() for hlrid= "+hlrId);
		try
		{
		con = conPool.getConnection();
			if( hlrId == -1 )
			{
				 query = "select HLR_ID, HLR_NAME, HLR_IP, HLR_PORT, CONNECTIONS, LOGIN, PASSWORD from CRBT_HLR_CONFIG";
					pstmt = con.prepareStatement (query);
			}
			else
			{
				 query = "select HLR_ID, HLR_NAME, HLR_IP, HLR_PORT, CONNECTIONS, LOGIN, PASSWORD from CRBT_HLR_CONFIG where HLR_ID=?";
					pstmt = con.prepareStatement (query);
					pstmt.setInt(1,hlrId);
			}
			rs = pstmt.executeQuery ();
			hlrConfigAl.clear ();
			while(rs.next ())
			{
				HLR hlr = new HLR();
				hlr.setHLRId (rs.getInt ("HLR_ID"));
				hlr.setHLRName (rs.getString ("HLR_NAME"));
				hlr.setHLRPort (rs.getInt ("HLR_PORT"));
				hlr.setHLRIp (rs.getString ("HLR_IP"));
				hlr.setConnection (rs.getInt ("CONNECTIONS"));
				hlr.setLogin (rs.getString ("LOGIN"));
				hlr.setPassword (rs.getString ("PASSWORD"));
				hlrConfigAl.add (hlr);
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
				logger.error ("Exception in getHLRConfig, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception caught "+e);
			e.printStackTrace ();
			return -1;
		}//catch
		finally{ conPool.free(con); }
		
		return 0;
	}//getHLRConfig
 
 public int updateHLRConfig (HLR hlr)
	{
		logger.debug ("webadmin updateHLRConfig() for HLR_ID= "+ hlr.getHLRId() );
		try
		{
		con = conPool.getConnection();
			String query = "update CRBT_HLR_CONFIG set HLR_IP=?, HLR_PORT=?, CONNECTIONS=?, LOGIN=?, PASSWORD=? where HLR_ID=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, hlr.getHLRIp ());
			pstmt.setInt (2, hlr.getHLRPort ());
			pstmt.setInt (3, hlr.getConnection ());
			pstmt.setString (4, hlr.getLogin ());
			pstmt.setString (5, hlr.getPassword ());
			pstmt.setInt (6, hlr.getHLRId ());
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
				logger.error ("Exception in updateHLRConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
		finally { conPool.free(con); }
		return 0;
	}//updateHLRConfig
  
 public int deleteHLRConfig (ArrayList hlrIdAl)
	{
		logger.debug ("webadmin: deleteHLRConfig(), hlr id is" + hlrIdAl);
		try
		{
		con = conPool.getConnection();
			String query = "delete from CRBT_HLR_CONFIG WHERE HLR_ID = ?";
			pstmt = con.prepareStatement (query);
			Iterator ite = hlrIdAl.iterator ();
			while(ite.hasNext ())
			{
				int hlrId = Integer.parseInt ((String)ite.next ());
				pstmt.setInt (1, hlrId);
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
				logger.error("Exception in deleteHLRConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			if (e.getErrorCode() == 2292)
				return -2;
			else
				return -1;
		}
		finally
		 { conPool.free(con); }
		return 0;
	}//deleteHLRConfig


} //class HLRManager
