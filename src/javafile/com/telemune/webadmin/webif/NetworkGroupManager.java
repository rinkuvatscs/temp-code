
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
  import org.apache.log4j.*;
public class NetworkGroupManager

{
                                 private static Logger logger=Logger.getLogger(NetworkGroupManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				private long group_id = 0;
				
 public NetworkGroupManager()				 
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

 public int addNetworkGrp(NetworkGroup networkgrp)
 {
		 logger.debug("Adding NetworkGroup");
	try
	{
			con = conPool.getConnection();
			query = "select NETWORK_GROUP_NAME from ROME_NETWORK_GROUP_MASTER where NETWORK_GROUP_NAME=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, networkgrp.getName() );
			rs = pstmt.executeQuery();
			if(rs.next() )
				{
								rs.close();
								pstmt.close();
								return -2;
				}
			rs.close();
			pstmt.close();	
			
			query = "select networkgrp_id.nextval from dual";
		  pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if( rs.next() )
			{
				 group_id = rs.getLong("NEXTVAL");
				 rs.close();
		  		pstmt.close();	
			}
			else
			{
				 logger.info("NetworkGroupManager: group_id not created");
				 rs.close();
    		 pstmt.close();	
			   return -1;
			}
			if(networkgrp.getSleep() == 0  ) //sleep disabled
			{
					query = "insert into ROME_NETWORK_GROUP_MASTER (NETWORK_GROUP_ID,NETWORK_GROUP_NAME,NETWORK_GROUP_DESCRIPTION,NEW_VISIT_INTERVAL_IN,REPETITION_INTERVAL_IN,NEW_VISIT_INTERVAL_OUT,REPETITION_INTERVAL_OUT,TIME_PERIOD_MAX_MESSAGES,MAX_MESSAGES_IN_TIME,MAX_MESSAGES_IN_ONE_TIME,INROAM_FLAG,OUTROAM_FLAG,SLEEP_PERIOD_ENABLE) values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			 pstmt = con.prepareStatement(query);
			}
			else
			{
					query = "insert into ROME_NETWORK_GROUP_MASTER (NETWORK_GROUP_ID,NETWORK_GROUP_NAME,NETWORK_GROUP_DESCRIPTION,NEW_VISIT_INTERVAL_IN,REPETITION_INTERVAL_IN,NEW_VISIT_INTERVAL_OUT,REPETITION_INTERVAL_OUT,TIME_PERIOD_MAX_MESSAGES,MAX_MESSAGES_IN_TIME,MAX_MESSAGES_IN_ONE_TIME,INROAM_FLAG,OUTROAM_FLAG,SLEEP_PERIOD_ENABLE,SLEEP_START_HOUR,SLEEP_START_MINUTE,SLEEP_END_HOUR,SLEEP_END_MINUTE) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			 pstmt = con.prepareStatement(query);
				
			pstmt.setInt(14, networkgrp.getSleep_Start_hr() );	
			pstmt.setInt(15, networkgrp.getSleep_Start_min() );	
			pstmt.setInt(16, networkgrp.getSleep_End_hr() );	
			pstmt.setInt(17, networkgrp.getSleep_End_min() );	
			}
			pstmt.setLong(1, group_id);
			pstmt.setString(2, networkgrp.getName() );	
			pstmt.setString(3, networkgrp.getDesc() );	
			pstmt.setInt(4, networkgrp.getWaitInterval_In() );	
			pstmt.setInt(5, networkgrp.getRepInterval_In() );	
			pstmt.setInt(6, networkgrp.getWaitInterval_Out() );	
			pstmt.setInt(7, networkgrp.getRepInterval_Out() );	
			pstmt.setInt(8, networkgrp.getTime_MaxMesg() );	
			pstmt.setInt(9, networkgrp.getMaxMesg_Time() );	
			pstmt.setInt(10, networkgrp.getOneTime_Mesg() );	
			pstmt.setString(11, networkgrp.getInbound() );	
			pstmt.setString(12, networkgrp.getOutbound() );	
			pstmt.setInt(13, networkgrp.getSleep() );	
			
		   pstmt.executeUpdate();
		 	
			  pstmt.close();	

	}//try	
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
		{	conPool.free(con);	}
    return 0;
 
 } //addNetworkGrp

 public int viewNetworkGrp(ArrayList networkGrpAl,String name,long grpId)
 {
				 logger.debug("Viewing NetworkGroup");
				 int z = -1;
		try
		{
				con = conPool.getConnection();
				if( name.equals("x") && grpId == -99 ) //view all NetworkGroups, called from home.jsp
					{
						query = "select * from ROME_NETWORK_GROUP_MASTER";
						pstmt = con.prepareStatement(query);
					}
				else //view a particular NetworkGroup, called from networkGrp_modify.jsp 
					{
						query = "select * from ROME_NETWORK_GROUP_MASTER where NETWORK_GROUP_ID=? and NETWORK_GROUP_NAME=?";
						pstmt = con.prepareStatement(query);
						pstmt.setLong(1,grpId);
						pstmt.setString(2,name);
					}
					rs = pstmt.executeQuery();
				while(rs.next() )
					{
									z++;
									NetworkGroup networkgrp = new NetworkGroup();
									networkgrp.setNetworkId( rs.getLong("NETWORK_GROUP_ID") );
									networkgrp.setName( rs.getString("NETWORK_GROUP_NAME") );	
									networkgrp.setDesc( rs.getString("NETWORK_GROUP_DESCRIPTION"));	
									networkgrp.setWaitInterval_In( rs.getInt("NEW_VISIT_INTERVAL_IN")) ;	
									networkgrp.setRepInterval_In( rs.getInt("REPETITION_INTERVAL_IN") );	
									networkgrp.setWaitInterval_Out( rs.getInt("NEW_VISIT_INTERVAL_OUT")) ;	
									networkgrp.setRepInterval_Out( rs.getInt("REPETITION_INTERVAL_OUT")) ;	
									networkgrp.setTime_MaxMesg( rs.getInt("TIME_PERIOD_MAX_MESSAGES")) ;	
									networkgrp.setMaxMesg_Time( rs.getInt("MAX_MESSAGES_IN_TIME") );	
									networkgrp.setOneTime_Mesg( rs.getInt("MAX_MESSAGES_IN_ONE_TIME")) ;	
									networkgrp.setInbound( rs.getString("INROAM_FLAG") );	
									networkgrp.setOutbound( rs.getString("OUTROAM_FLAG")) ;
									networkgrp.setSleep( rs.getInt("SLEEP_PERIOD_ENABLE") );	
									networkgrp.setSleep_Start_hr( rs.getInt("SLEEP_START_HOUR") );	
									networkgrp.setSleep_Start_min( rs.getInt("SLEEP_START_MINUTE") );	
									networkgrp.setSleep_End_hr( rs.getInt("SLEEP_END_HOUR") );	
									networkgrp.setSleep_End_min( rs.getInt("SLEEP_END_MINUTE") );	
									networkGrpAl.add(networkgrp);			

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
   		}//try
      catch (SQLException sqle)
      {
      }
      e.printStackTrace ();
      return -1;
		}//catch
		finally
		{		conPool.free(con);	}
		return 99;
 } //viewNetworkGrp

	public int modifyNetworkGrp(NetworkGroup networkgrp)
	{
				 logger.debug("Modifying NetworkGroup");
		try
		{
				con = conPool.getConnection();
				if(networkgrp.getSleep() == 0 )  //sleep disabled
				{
						query = "update ROME_NETWORK_GROUP_MASTER set NETWORK_GROUP_DESCRIPTION = ?,NEW_VISIT_INTERVAL_IN=?,REPETITION_INTERVAL_IN=?,NEW_VISIT_INTERVAL_OUT=?,REPETITION_INTERVAL_OUT=?,TIME_PERIOD_MAX_MESSAGES=?,MAX_MESSAGES_IN_TIME=?,MAX_MESSAGES_IN_ONE_TIME=?,INROAM_FLAG=?,OUTROAM_FLAG=?,SLEEP_PERIOD_ENABLE=? where NETWORK_GROUP_ID=? and NETWORK_GROUP_NAME=?";
					 pstmt = con.prepareStatement(query);
						pstmt.setLong(12, networkgrp.getNetworkId() );
						pstmt.setString(13, networkgrp.getName() );	
				}
        else
				{
						query = "update ROME_NETWORK_GROUP_MASTER set NETWORK_GROUP_DESCRIPTION = ?,NEW_VISIT_INTERVAL_IN=?,REPETITION_INTERVAL_IN=?,NEW_VISIT_INTERVAL_OUT=?,REPETITION_INTERVAL_OUT=?,TIME_PERIOD_MAX_MESSAGES=?,MAX_MESSAGES_IN_TIME=?,MAX_MESSAGES_IN_ONE_TIME=?,INROAM_FLAG=?,OUTROAM_FLAG=?,SLEEP_PERIOD_ENABLE=?,SLEEP_START_HOUR=?,SLEEP_START_MINUTE=?,SLEEP_END_HOUR=?,SLEEP_END_MINUTE=? where NETWORK_GROUP_ID=? and NETWORK_GROUP_NAME=?";
				 pstmt = con.prepareStatement(query);
					pstmt.setInt(12, networkgrp.getSleep_Start_hr() );	
					pstmt.setInt(13, networkgrp.getSleep_Start_min() );	
					pstmt.setInt(14, networkgrp.getSleep_End_hr() );	
					pstmt.setInt(15, networkgrp.getSleep_End_min() );	
					pstmt.setLong(16, networkgrp.getNetworkId() );
					pstmt.setString(17, networkgrp.getName() );	
		 	}
			
			pstmt.setString(1, networkgrp.getDesc() );	
			pstmt.setInt(2, networkgrp.getWaitInterval_In() );	
			pstmt.setInt(3, networkgrp.getRepInterval_In() );	
			pstmt.setInt(4, networkgrp.getWaitInterval_Out() );	
			pstmt.setInt(5, networkgrp.getRepInterval_Out() );	
			pstmt.setInt(6, networkgrp.getTime_MaxMesg() );	
			pstmt.setInt(7, networkgrp.getMaxMesg_Time() );	
			pstmt.setInt(8, networkgrp.getOneTime_Mesg() );	
			pstmt.setString(9, networkgrp.getInbound() );	
		  pstmt.setString(10, networkgrp.getOutbound() );	
			pstmt.setInt(11, networkgrp.getSleep() );	
		
		  pstmt.executeUpdate();
		  pstmt.close();	

			logger.info("network id sent= "+ networkgrp.getNetworkId() );

	}//try	
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
		{		conPool.free(con);}
    return 0;
			
	}//modifyNetworkGrp

 public int delNetworkGrp(NetworkGroup networkgrp)
 {
				 logger.debug("deleting NetworkGroup");
				 try
				 {
							 con = conPool.getConnection();
							 query = "delete from ROME_NETWORK_GROUP_MASTER where NETWORK_GROUP_ID=? and NETWORK_GROUP_NAME=?";
							 pstmt = con.prepareStatement(query);

								pstmt.setLong(1, networkgrp.getNetworkId() );
								pstmt.setString(2, networkgrp.getName() );

								pstmt.executeQuery();
							  pstmt.close ();
				  }//try
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
				   }//catch
						finally
						{	conPool.free(con);	}
				    return 2;

 }//delNetworkgrp


} // class NetworkGroupManager
