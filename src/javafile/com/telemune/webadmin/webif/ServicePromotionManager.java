
/* @Jatinder Pal*/

package com.telemune.webadmin.webif;
import java.util.*;
import java.io.*;
import java.sql.SQLException;
import java.sql.ResultSet;
import com.telemune.dbutilities.*;
  import org.apache.log4j.*;
public class ServicePromotionManager
{
                                private static Logger logger=Logger.getLogger(ServicePromotionManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public ServicePromotionManager()
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


 public int isViralEnabled( )
 {
		 logger.debug("In function isViralEnabled");
			int ret = -1;
	try
		{
		  con = conPool.getConnection();
			query="select PARAM_VALUE from CRBT_APP_CONFIG_PARAMS where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "SEND_VIRAL_SMS");
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				ret = Integer.parseInt(rs.getString("PARAM_VALUE"));
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException sqle)
		{
			sqle.printStackTrace();
			return -1;
		}
		catch (Exception exp)
		{
			exp.printStackTrace();
			return -1;
	  }
		finally { conPool.free(con); }
			return ret;
	 
 } // isViralEnabled

	public int sendViralSMS (String subType, String calls)
	{
		  logger.debug("In function sendViralSMS");
		try
		{
			con = conPool.getConnection ();
			if ((calls==null) || calls.equals(""))
			{
				calls="50";
			}
			query= "update CRBT_APP_CONFIG_PARAMS set PARAM_VALUE = ? where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, subType);
			pstmt.setString(2, "SEND_VIRAL_SMS");
			pstmt.executeUpdate();          
 			pstmt.clearParameters();
			pstmt.setString(1, calls);
			pstmt.setString(2, "SEND_VIRAL_SMS_AFTER");
			pstmt.executeUpdate();          
			pstmt.close(); 
		}
		catch (SQLException sqle) 
		{//log it
			sqle.printStackTrace();
			return 0;
		}
		finally	{	conPool.free(con);	}
			return 1;
			
 } // sendViralSMS
 
 public int isRingtoneEnabled()
	{
		  logger.debug("In function isRingtoneEnabled");
			int ret = -1;
		try
		{
			con = conPool.getConnection ();
			query="select PARAM_VALUE from CRBT_APP_CONFIG_PARAMS where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "SEND_RINGTONE_SMS");
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				ret = Integer.parseInt(rs.getString("PARAM_VALUE"));
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException sqle)
		{
			sqle.printStackTrace();
			return -1;
		}
		catch (Exception exp)
		{
			exp.printStackTrace();
			return -1;
		}
		finally{ conPool.free(con); } 
			return ret;
	
	}// isRingtoneEnabled

	public int sendRingtoneSMS(String subType, String calls)
	{
		  logger.debug("In function isRingtoneEnabled");
		try 
		{
			con = conPool.getConnection();
			if ((calls==null) || calls.equals(""))
			{
				calls="50";
			}
			query= "update CRBT_APP_CONFIG_PARAMS set PARAM_VALUE = ? where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, subType);
			pstmt.setString(2, "SEND_RINGTONE_SMS");
			pstmt.executeUpdate();          
      pstmt.clearParameters();
			  
			pstmt.setString(1, calls);
			pstmt.setString(2, "SEND_RINGTONE_SMS_AFTER");
			pstmt.executeUpdate();          
			pstmt.close(); 
		}
		catch (SQLException sqle) 
		{//log it
		  	sqle.printStackTrace();
			return 0;
		}
		finally{ conPool.free(con); }
			return 1;
	
	} //sendRingtoneSMS
	
	public int isContentEnabled()
	{
		  logger.debug("In function isContentEnabled");
			int ret = -1;
		try
		{
			con = conPool.getConnection();
			query="select PARAM_VALUE from CRBT_APP_CONFIG_PARAMS where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "SEND_CONTENT_SMS");
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				ret = Integer.parseInt(rs.getString("PARAM_VALUE"));
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException sqle)
		{
			sqle.printStackTrace();
			return -1;
		}
		catch (Exception exp)
		{
			exp.printStackTrace();
			return -1;
		}
		finally { conPool.free(con); } 
			return ret;

 } //isContentEnabled
 
 public int sendContentSMS(String subType)
	{
		  logger.debug("In function sendContentSMS");
		try 
		{
			con = conPool.getConnection();
			query= "update CRBT_APP_CONFIG_PARAMS set PARAM_VALUE = ? where PARAM_TAG = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, subType);
			pstmt.setString(2, "SEND_CONTENT_SMS");
			pstmt.executeUpdate();          
			pstmt.close();  
		}
		catch (SQLException sqle) 
		{//log it
			sqle.printStackTrace();
			return 0;
		}
		finally{ conPool.free(con); }
			return 1;
	} // sendContentSMS
	
	public int sendPromotionalSMS(String startDate , String startTime , String subType , String smsType , String message)
	{
		logger.debug("In function sendPromotionalSMS");
		
		String dest = "1111";
		long responseId = 0;
		if (subType.equalsIgnoreCase("2"))
		{
			dest = "2222";
		}
		try 
		{
			con = conPool.getConnection();
		 query = "select GMAT_RESPONSE_ID_SEQ.nextval from dual";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery(); 
			if(rs.next() )
			{
				responseId = rs.getLong(1);
			}
			rs.close();
			pstmt.close(); 
			
			query= "insert into GMAT_MESSAGE_STORE (RESPONSE_ID, REQUEST_ID, ORIGINATING_NUMBER, DESTINATION_NUMBER, MESSAGE_TEXT, SUBMIT_TIME, STATUS, FORMAT) values (? , 0, ?, ?, ?, to_date(?,'DD-MM-YYYY HH24'), ?, ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setLong(1,responseId );
			pstmt.setString(2, "4444288");
			pstmt.setString(3, dest);
			pstmt.setString(4, message);
			pstmt.setString(5, startDate + "-" + startTime);
			pstmt.setString(6, "R");
			pstmt.setString(7, smsType);
			pstmt.executeUpdate();           
			pstmt.close(); 
		}
		catch (SQLException sqle) 
		{//log it
			sqle.printStackTrace();
			return 0;
		}
		finally { conPool.free(con); } 
			return 1;
	
 }// sendPromotionalSMS


}// class ServicePromotionManager
