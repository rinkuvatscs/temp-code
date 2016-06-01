
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class SmscConfigManager

{
                                 private static Logger logger=Logger.getLogger(SmscConfigManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public SmscConfigManager()				 
 {
//				 conPool = new ConnectionPool();
 }

    public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

 public int addSMSCConfig ( SmscConfig smscConfig)
	{
		logger.debug ("in function addSMSCConfig");
		try
		{
			con = conPool.getConnection();
			query = "INSERT INTO GMAT_SMSC_CONFIG (SMSC_ID,SMSC_USER_ID, SMSC_PASSWORD, SMSC_IP, SMSC_PORT, SYSTEM_TYPE, TON, NPI, ADDRESS_RANGE, NO_OF_CONNECTIONS, SPEED,CLIENT_TYPE,STATUS) VALUES (crbt_smsc_id.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement (query);
			
			pstmt.setString (1, smscConfig.getUserId ());
			pstmt.setString (2, smscConfig.getPassword ());
			pstmt.setString (3, smscConfig.getSmscIp ());
			pstmt.setInt (4, smscConfig.getSmscPort ());
			pstmt.setString (5, smscConfig.getSystemType ());
			pstmt.setInt (6, smscConfig.getTon ());
			pstmt.setInt (7, smscConfig.getNpi ());
			pstmt.setString (8, smscConfig.getAddressRange ());
			pstmt.setInt (9, smscConfig.getNumOfConAllow () );
			pstmt.setInt (10, smscConfig.getSpeed () );
			pstmt.setString (11, smscConfig.getClientType ());
			pstmt.setString (12, smscConfig.getSmscStatus ());

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
				logger.error ("Exception in addSMSCConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally { conPool.free(con); }
		return 0;
	}

	public int getSmscConfig (ArrayList smscConfigAl, int smscId)
	{
		logger.debug ("in function getSmscConfig for smscId= "+ smscId);
		try
		{
			con = conPool.getConnection();
			if(smscId == -1 ) // show all SMSC 
			{
					query = "SELECT SMSC_ID, SMSC_USER_ID, SMSC_PASSWORD, SMSC_IP, SMSC_PORT, SYSTEM_TYPE, TON, NPI, ADDRESS_RANGE, NO_OF_CONNECTIONS, SPEED, CLIENT_TYPE, STATUS  FROM GMAT_SMSC_CONFIG order by SMSC_USER_ID";
					pstmt = con.prepareStatement (query);
			}
		  else
			{
					query = "SELECT SMSC_ID, SMSC_USER_ID, SMSC_PASSWORD, SMSC_IP, SMSC_PORT, SYSTEM_TYPE, TON, NPI, ADDRESS_RANGE, NO_OF_CONNECTIONS, SPEED, CLIENT_TYPE, STATUS  FROM GMAT_SMSC_CONFIG where SMSC_ID=?";
					pstmt = con.prepareStatement (query);
					pstmt.setInt(1, smscId);
			}
			
			rs = pstmt.executeQuery ();
			smscConfigAl.clear ();
			while(rs.next ())
			{
				SmscConfig smscConfig = new SmscConfig ();
				smscConfig.setSmscId (rs.getInt ("SMSC_ID"));
				smscConfig.setUserId (rs.getString ("SMSC_USER_ID"));
				smscConfig.setPassword (rs.getString ("SMSC_PASSWORD"));
				smscConfig.setSmscIp (rs.getString ("SMSC_IP"));
				smscConfig.setSmscPort (rs.getInt ("SMSC_PORT"));
				smscConfig.setSystemType (rs.getString ("SYSTEM_TYPE"));
				smscConfig.setTon (rs.getInt ("TON"));
				smscConfig.setNpi (rs.getInt ("NPI"));
				smscConfig.setAddressRange (rs.getString ("ADDRESS_RANGE"));
				smscConfig.setNumOfConAllow (rs.getInt ("NO_OF_CONNECTIONS"));
				smscConfig.setSpeed (rs.getInt ("SPEED"));
				smscConfig.setClientType (rs.getString ("CLIENT_TYPE"));
				smscConfig.setSmscStatus (rs.getString ("STATUS"));
				smscConfigAl.add (smscConfig);
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
				logger.error ("Exception in getSmscConfig, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception caught "+e);
			e.printStackTrace ();
			return -1;
		}//catch
		finally{ conPool.free(con); }

		return 0;
	}//getSmscConfig
 
 public int updateSMSC (SmscConfig smscConfig)
	{
		logger.debug ("in function updateSMSC for smscId= "+ smscConfig.getSmscId() );
		try
		{
			con = conPool.getConnection();
			if (smscConfig.getPassword() == null || smscConfig.getPassword().equals(""))
			{
				 query = "update GMAT_SMSC_CONFIG set SMSC_USER_ID=?, SMSC_IP=?, SMSC_PORT=?, SYSTEM_TYPE=?, TON=?, NPI=?, NO_OF_CONNECTIONS=?, SPEED=?, CLIENT_TYPE=?, STATUS=?, ADDRESS_RANGE=? where SMSC_ID=?";
				pstmt = con.prepareStatement (query);
				pstmt.setInt (12, smscConfig.getSmscId ());
			}
			else
			{
				 query = "update GMAT_SMSC_CONFIG set SMSC_USER_ID=?, SMSC_IP=?, SMSC_PORT=?, SYSTEM_TYPE=?, TON=?, NPI=?, NO_OF_CONNECTIONS=?, SPEED=?, CLIENT_TYPE=?, STATUS=?, ADDRESS_RANGE=?, SMSC_PASSWORD = ? where SMSC_ID=?";
				pstmt = con.prepareStatement (query);
				pstmt.setString (12, smscConfig.getPassword ());
				pstmt.setInt (13, smscConfig.getSmscId ());
			}
			pstmt.setString (1, smscConfig.getUserId ());
			pstmt.setString (2, smscConfig.getSmscIp ());
			pstmt.setInt (3, smscConfig.getSmscPort ());
			pstmt.setString (4, smscConfig.getSystemType ());
			pstmt.setInt (5, smscConfig.getTon ());
			pstmt.setInt (6, smscConfig.getNpi ());
			pstmt.setInt (7, smscConfig.getNumOfConAllow ());
			pstmt.setInt (8, smscConfig.getSpeed ());
			pstmt.setString (9, smscConfig.getClientType ());
			pstmt.setString (10, smscConfig.getSmscStatus ());
			pstmt.setString (11, smscConfig.getAddressRange ());
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
				logger.error ("Exception in updateSMSC, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
		finally{ conPool.free(con) ; }
		
		return 0;
	}//UpdateSMSC
 
 public int deleteSMSC (ArrayList smscIdAl)
	{
		logger.debug ("in function deleteSMSC, smsc id is" + smscIdAl);
		try
		{
			con = conPool.getConnection();
			query = "delete from GMAT_SMSC_CONFIG WHERE SMSC_ID = ?";
			pstmt = con.prepareStatement (query);
			Iterator ite = smscIdAl.iterator ();
			while(ite.hasNext ())
			{
				int smscId = Integer.parseInt ((String)ite.next ());
				pstmt.setInt (1, smscId);
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
				logger.error ("Exception in deleteSMSCConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally { conPool.free(con); } 
		return 0;
	} //deleteSMSCConfig

}// class SmscConfigManager
