

package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import com.telemune.dbutilities.*;
import java.text.*;
  import org.apache.log4j.*;
public class NetworkMasterManager

{
                                private static Logger logger=Logger.getLogger(NetworkMasterManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public NetworkMasterManager()				 
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


 public int addNetwork(NetworkMaster networkMaster)
 {
			logger.debug("Adding Network");
   try
	 {
	    con = conPool.getConnection();
  	  long networkId = 0;
			query = "select * from ROME_NETWORK_MASTER where NETWORK_NAME = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, networkMaster.getNetworkName() );
			rs = pstmt.executeQuery();
			if(rs.next() )
				{
								pstmt.close();
								rs.close();
								return -2;
				}
			pstmt.close();
			rs.close();
				
			query = "select networkmaster_id.nextval from dual";
		  pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if( rs.next() )
			{
				 networkId = rs.getLong(1);
					pstmt.close();
					rs.close();
			}
			else
			{
					pstmt.close();
					rs.close();
				 logger.info("NetworkMasterManager: networkId not created");
					return -1;
			}

			if(networkMaster.getSleepEnable() == 0 )
			{
					query = "insert into ROME_NETWORK_MASTER (NETWORK_ID,NETWORK_NAME,BRAND_NAME,MNC,MCC,NETWORK_TYPE,TIME_ZONE,DEFAULT_LANGUAGE,ENABLE_TEST,NEW_VISIT_INTERVAL_IN,REPETITION_INTERVAL_IN,NEW_VISIT_INTERVAL_OUT, REPETITION_INTERVAL_OUT,TIME_PERIOD_MAX_MESSAGES,MAX_MESSAGES_IN_TIME,MAX_MESSAGES_IN_ONE_TIME,INROAM_FLAG,OUTROAM_FLAG,SLEEP_PERIOD_ENABLE) values (?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?)";
					pstmt = con.prepareStatement(query);

			}
			else
			{
					query = "insert into ROME_NETWORK_MASTER (NETWORK_ID,NETWORK_NAME,BRAND_NAME,MNC,MCC,NETWORK_TYPE,TIME_ZONE,DEFAULT_LANGUAGE,ENABLE_TEST,NEW_VISIT_INTERVAL_IN,REPETITION_INTERVAL_IN,NEW_VISIT_INTERVAL_OUT, REPETITION_INTERVAL_OUT,TIME_PERIOD_MAX_MESSAGES,MAX_MESSAGES_IN_TIME,MAX_MESSAGES_IN_ONE_TIME,INROAM_FLAG,OUTROAM_FLAG,SLEEP_PERIOD_ENABLE,SLEEP_PERIOD_START_HOUR,SLEEP_PERIOD_START_MINUTE, SLEEP_PERIOD_END_HOUR,SLEEP_PERIOD_END_MINUTE) values (?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?)";
				pstmt = con.prepareStatement(query);
				pstmt.setInt(20, networkMaster.getSleepStartHr() );
				pstmt.setInt(21, networkMaster.getSleepStartMin() );
				pstmt.setInt(22, networkMaster.getSleepEndHr() );
				pstmt.setInt(23, networkMaster.getSleepEndMin() );
			}
				pstmt.setLong(1, networkId );
				pstmt.setString(2, networkMaster.getNetworkName() );
				pstmt.setString(3, networkMaster.getBrandName() );
				pstmt.setInt(4, networkMaster.getMnc() );
				pstmt.setInt(5, networkMaster.getMcc() );
				pstmt.setString(6, networkMaster.getNetworkType() );
				pstmt.setInt(7, networkMaster.getTimeZone() );
				pstmt.setString(8, networkMaster.getDefaultLang() );
				pstmt.setInt(9, networkMaster.getEnableTest() );
				pstmt.setInt(10, networkMaster.getVisitInterval_in() );
				pstmt.setInt(11, networkMaster.getRepInterval_in() );
				pstmt.setInt(12, networkMaster.getVisitInterval_out() );
				pstmt.setInt(13, networkMaster.getRepInterval_out() );
				pstmt.setInt(14, networkMaster.getTimeMaxMesg() );
				pstmt.setInt(15, networkMaster.getMaxMesgTime() );
				pstmt.setInt(16, networkMaster.getMaxMesgOneTime() );
				pstmt.setString(17, networkMaster.getInbound() );
				pstmt.setString(18, networkMaster.getOutbound() );
				pstmt.setInt(19, networkMaster.getSleepEnable() );
	
				pstmt.executeUpdate();
			pstmt.close();	
			
	 } //try
	  catch (Exception e)
  	 {
      try
      {
				if (pstmt != null)
				  pstmt.close ();
      }
      catch (SQLException sqle)
      {
					logger.error("SQl Error");
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{		conPool.free(con);	}
    return 0;

} //addNetwork

 public int viewNetwork(ArrayList networkMasterAl,String name, long networkId)
 {
		logger.debug("for Viewing NetworkMaster");
   try
	 {
    con = conPool.getConnection();
	  if( name.equals("x") && networkId == -99 ) //view all NetworkGroups, called from home.jsp
			{
				query = "select * from ROME_NETWORK_MASTER order by NETWORK_NAME";
				pstmt = con.prepareStatement(query);
			}
		else
			{
				query = "select * from ROME_NETWORK_MASTER where NETWORK_ID=? and NETWORK_NAME=? order by NETWORK_NAME";
				pstmt = con.prepareStatement(query);
				pstmt.setLong(1,networkId);
				pstmt.setString(2,name);
			}
		rs = pstmt.executeQuery();
     int z = -1; 
		 while( rs.next() )
		 {
				z++;
				NetworkMaster networkMaster = new NetworkMaster();
				networkMaster.setNetworkId( rs.getLong("NETWORK_ID") );
				networkMaster.setNetworkName( rs.getString("NETWORK_NAME") );
				networkMaster.setBrandName( rs.getString("BRAND_NAME") );
				networkMaster.setMnc( rs.getInt("MNC") );
				networkMaster.setMcc( rs.getInt("MCC") );
				networkMaster.setNetworkType( rs.getString("NETWORK_TYPE") );
				networkMaster.setTimeZone( rs.getInt("TIME_ZONE") );
				networkMaster.setDefaultLang( rs.getString("DEFAULT_LANGUAGE") );
				networkMaster.setEnableTest( rs.getInt("ENABLE_TEST") );
				networkMaster.setVisitInterval_in( rs.getInt("NEW_VISIT_INTERVAL_IN") );
				networkMaster.setRepInterval_in( rs.getInt("REPETITION_INTERVAL_IN") );
				networkMaster.setVisitInterval_out( rs.getInt("NEW_VISIT_INTERVAL_OUT") );
				networkMaster.setRepInterval_out( rs.getInt("REPETITION_INTERVAL_OUT") );
				networkMaster.setTimeMaxMesg( rs.getInt("TIME_PERIOD_MAX_MESSAGES") );
				networkMaster.setMaxMesgTime( rs.getInt("MAX_MESSAGES_IN_TIME") );
				networkMaster.setMaxMesgOneTime( rs.getInt("MAX_MESSAGES_IN_ONE_TIME") );
				networkMaster.setInbound( rs.getString("INROAM_FLAG") );
				networkMaster.setOutbound( rs.getString("OUTROAM_FLAG") );
				networkMaster.setSleepEnable( rs.getInt("SLEEP_PERIOD_ENABLE") );
				networkMaster.setSleepStartHr( rs.getInt("SLEEP_PERIOD_START_HOUR") );
				networkMaster.setSleepStartMin( rs.getInt("SLEEP_PERIOD_START_MINUTE") );
				networkMaster.setSleepEndHr( rs.getInt("SLEEP_PERIOD_END_HOUR") );
				networkMaster.setSleepEndMin( rs.getInt("SLEEP_PERIOD_END_MINUTE") );

			networkMasterAl.add(networkMaster);
				
		 }//while
			pstmt.close();
			rs.close();	
	}//try
		catch(Exception e)
		{
			try
			{
				if( pstmt != null || rs != null ) 
				{
									pstmt.close();
									rs.close();
				}//if
   		}
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
		}//catch
		finally
		{		conPool.free(con);	}
		return 99;
 
 } //viewNetworkMaster

 public int modifyNetwork(NetworkMaster networkMaster)
 {
				 logger.debug("for Modifying NetworkMaster");
	try
	{
					con =	conPool.getConnection();
					if(networkMaster.getSleepEnable() == 0) //sleep disbled
					{
							query = "update ROME_NETWORK_MASTER set BRAND_NAME=?,MNC=?,MCC=?,NETWORK_TYPE=?,TIME_ZONE=?,DEFAULT_LANGUAGE=?,ENABLE_TEST=?,NEW_VISIT_INTERVAL_IN=?,REPETITION_INTERVAL_IN=?,NEW_VISIT_INTERVAL_OUT=?, REPETITION_INTERVAL_OUT=?,TIME_PERIOD_MAX_MESSAGES=?,MAX_MESSAGES_IN_TIME=?,MAX_MESSAGES_IN_ONE_TIME=?,INROAM_FLAG=?,OUTROAM_FLAG=?,SLEEP_PERIOD_ENABLE=? where NETWORK_ID=? and NETWORK_NAME=?";
							pstmt = con.prepareStatement(query);
							pstmt.setLong(18, networkMaster.getNetworkId() );
							pstmt.setString(19, networkMaster.getNetworkName() );
					}
					else
	        {
							query = "update ROME_NETWORK_MASTER set BRAND_NAME=?,MNC=?,MCC=?,NETWORK_TYPE=?,TIME_ZONE=?,DEFAULT_LANGUAGE=?,ENABLE_TEST=?,NEW_VISIT_INTERVAL_IN=?,REPETITION_INTERVAL_IN=?,NEW_VISIT_INTERVAL_OUT=?, REPETITION_INTERVAL_OUT=?,TIME_PERIOD_MAX_MESSAGES=?,MAX_MESSAGES_IN_TIME=?,MAX_MESSAGES_IN_ONE_TIME=?,INROAM_FLAG=?,OUTROAM_FLAG=?,SLEEP_PERIOD_ENABLE=?,SLEEP_PERIOD_START_HOUR=?,SLEEP_PERIOD_START_MINUTE=?, SLEEP_PERIOD_END_HOUR=?,SLEEP_PERIOD_END_MINUTE=? where NETWORK_ID=? and NETWORK_NAME=?";
							pstmt = con.prepareStatement(query);
							pstmt.setInt(18, networkMaster.getSleepStartHr() );
							pstmt.setInt(19, networkMaster.getSleepStartMin() );
							pstmt.setInt(20, networkMaster.getSleepEndHr() );
							pstmt.setInt(21, networkMaster.getSleepEndMin() );
							pstmt.setLong(22,networkMaster.getNetworkId() );
							pstmt.setString(23, networkMaster.getNetworkName() );
					}	//else
					
							pstmt.setString(1, networkMaster.getBrandName() );
							pstmt.setInt(2, networkMaster.getMnc() );
							pstmt.setInt(3, networkMaster.getMcc() );
							pstmt.setString(4, networkMaster.getNetworkType() );
							pstmt.setInt(5, networkMaster.getTimeZone() );
							pstmt.setString(6, networkMaster.getDefaultLang() );
							pstmt.setInt(7, networkMaster.getEnableTest() );
							pstmt.setInt(8, networkMaster.getVisitInterval_in() );
							pstmt.setInt(9, networkMaster.getRepInterval_in() );
							pstmt.setInt(10, networkMaster.getVisitInterval_out() );
							pstmt.setInt(11, networkMaster.getRepInterval_out() );
							pstmt.setInt(12, networkMaster.getTimeMaxMesg() );
							pstmt.setInt(13, networkMaster.getMaxMesgTime() );
							pstmt.setInt(14, networkMaster.getMaxMesgOneTime() );
							pstmt.setString(15, networkMaster.getInbound() );
							pstmt.setString(16, networkMaster.getOutbound() );
							pstmt.setInt(17, networkMaster.getSleepEnable() );
						
					pstmt.executeUpdate();
					pstmt.close();	
	
	 } //try
	 catch (Exception e)
   {
      try
      {
				if (pstmt != null)
	 			 pstmt.close ();
      }
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
   }
		finally
		{	conPool.free(con);}
    return 0;

 }//modifyNetwork

 public int delNetwork(NetworkMaster networkMaster)
 {
   try
	 {
		logger.debug("for deleting NetworkMaster: "+ networkMaster.getNetworkName()+ " & "+ networkMaster.getNetworkId() );
    con = conPool.getConnection();
		query = "delete from ROME_NETWORK_MASTER where NETWORK_ID=? and NETWORK_NAME=?";
		pstmt = con.prepareStatement(query);
		pstmt.setLong(1, networkMaster.getNetworkId() );	
		pstmt.setString(2, networkMaster.getNetworkName() );	
				
		pstmt.executeUpdate();
    pstmt.close ();
  }
  catch (Exception e)
  {
      try
      {
				if (pstmt != null)
	 			 pstmt.close ();
      }
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
  }
		finally
		{	conPool.free(con);}
    return 2;
  }//delNetwork

} // NetworkMaster class

