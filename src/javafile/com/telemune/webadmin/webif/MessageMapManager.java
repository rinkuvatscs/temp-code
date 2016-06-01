
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class MessageMapManager

{
                               private static Logger logger=Logger.getLogger(MessageMapManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public MessageMapManager()				 
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


 public int addMap(MessageMap mesgMap)
 {
	 logger.debug("MessageMapManager: add Mapping");
		try
		{
				long messageId=0;
				con = conPool.getConnection();

				query= "select * from ROME_MESSAGE_MAP where MESSAGE_ID=? and MESSAGE_TYPE=?" ;
				pstmt = con.prepareStatement(query);
				pstmt.setLong(1, mesgMap.getMesgId());
				pstmt.setInt(2, mesgMap.getMesgType());
				rs = pstmt.executeQuery();
				if(rs.next() )
				{
						logger.info("this Mapping Already Exists");
						pstmt.close();		
						rs.close();
						return -2; 
   			}
				pstmt.close();		
				rs.close();

				query = "select message_id.nextval from dual";
				pstmt = con.prepareStatement(query);

				rs = pstmt.executeQuery();
				if( rs.next() )
				{
						messageId  = rs.getLong("NEXTVAL");
						pstmt.close();		
						rs.close();
			 	}
				else
				{
			 			logger.info("MessageMapManager: messageId not created");
						pstmt.close();		
						rs.close();
						return -1;
				}

				query = "insert into ROME_MESSAGE_MAP (MESSAGE_ID,MESSAGE_TYPE,EVENT_TYPE,VISIT_TYPE,MAP_TYPE,MAP_VALUE,START_DATE,END_DATE,SUBSCRIBER_TYPE,MESSAGE_ORDER,DELIVERY_CRITERIA,DELIVERY_CRITERIA_ORDER) values(?,?,?,?,?,?,to_date(?,'DD-MM-YYYY'),to_date(?,'DD-MM-YYYY'),?,?,?,?)";
				
				pstmt = con.prepareStatement(query);
				pstmt.setLong(1,messageId );
				pstmt.setInt(2, mesgMap.getMesgType());
				pstmt.setInt(3,mesgMap.getEventType() );
				pstmt.setInt(4, mesgMap.getVisitType() );
				pstmt.setInt(5, mesgMap.getMapType() );
				pstmt.setLong(6, mesgMap.getMapValue() );
				pstmt.setString(7, mesgMap.getStartDate() );
				pstmt.setString(8, mesgMap.getEndDate() );
				pstmt.setInt(9, mesgMap.getSubType() );
				pstmt.setInt(10, mesgMap.getMesgOrder() );
				pstmt.setString(11, mesgMap.getDeliveryCriteria() );
				pstmt.setString(12, mesgMap.getDeliveryOrder() );

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
 
	} //addMap 

	public int viewMap(ArrayList mesgConfigAl,long messageId,int mesgType)
	{
		logger.debug("to get MessageMap values");
		try
		{
			con = conPool.getConnection();
			if(messageId==0 && mesgType==-1)  			// view ALL
				{
					query="select MESSAGE_ID,MESSAGE_TYPE,EVENT_TYPE,VISIT_TYPE,MAP_TYPE,MAP_VALUE, to_char(START_DATE,'DD-MM-YYYY HH:mm:ss')START_DATE,to_char(END_DATE,'DD-MM-YYYY HH:mm:ss')END_DATE,SUBSCRIBER_TYPE,MESSAGE_ORDER,DELIVERY_CRITERIA,DELIVERY_CRITERIA_ORDER from ROME_MESSAGE_MAP order by MESSAGE_ID";
					 pstmt = con.prepareStatement(query);
				}
				else   // view values for given messageId and mesgType 
				{
					query="select MESSAGE_ID,MESSAGE_TYPE,EVENT_TYPE,VISIT_TYPE,MAP_TYPE,MAP_VALUE, to_char(START_DATE,'DD-MM-YYYY HH:mm:ss')START_DATE,to_char(END_DATE,'DD-MM-YYYY HH:mm:ss')END_DATE,SUBSCRIBER_TYPE,MESSAGE_ORDER,DELIVERY_CRITERIA,DELIVERY_CRITERIA_ORDER from ROME_MESSAGE_MAP where MESSAGE_ID=? and MESSAGE_TYPE=? order by MESSAGE_ID";
					 pstmt = con.prepareStatement(query);
					 pstmt.setLong(1,messageId);
					 pstmt.setInt(2,mesgType);
				}
			
			rs= pstmt.executeQuery();
						
			while(rs.next() )
			{
				 MessageMap mesgMap = new MessageMap();
				 mesgMap.setMesgId ( rs.getLong("MESSAGE_ID") );
				 mesgMap.setMesgType ( rs.getInt("MESSAGE_TYPE") );
				 mesgMap.setEventType ( rs.getInt("EVENT_TYPE") );
				 mesgMap.setVisitType( rs.getInt("VISIT_TYPE") );
				 mesgMap.setMapType ( rs.getInt("MAP_TYPE") );
				 mesgMap.setMapValue ( rs.getLong("MAP_VALUE") );
				 mesgMap.setStartDate ( rs.getString("START_DATE") );
				 mesgMap.setEndDate (rs.getString("END_DATE"));
				 mesgMap.setSubType ( rs.getInt("SUBSCRIBER_TYPE") );
				 mesgMap.setMesgOrder ( rs.getInt("MESSAGE_ORDER") );
				 mesgMap.setDeliveryCriteria ( rs.getString("DELIVERY_CRITERIA") );
				 mesgMap.setDeliveryOrder ( rs.getString("DELIVERY_CRITERIA_ORDER"));

				 mesgConfigAl.add(mesgMap);

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

	} //viewMap

	public int delMap(MessageMap mesgMap)
	{
			logger.debug("deleting MessageMap");
			try
			{
					con = conPool.getConnection();

					query="delete from ROME_MESSAGE_MAP where MESSAGE_ID=?";
					pstmt=con.prepareStatement(query);

					pstmt.setLong(1,mesgMap.getMesgId());

					pstmt.executeQuery();

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
							      }
							      e.printStackTrace ();
							      return -1;
				   }//catch
						finally
						{	conPool.free(con);	}
				    return 2;


 	}//delMap()

 public int modifyMap(MessageMap mesgMap)
 {			
		 logger.debug("modifying MessageMap");
			try
			{
					con = conPool.getConnection();
					query = "update ROME_MESSAGE_MAP set MESSAGE_TYPE=?,EVENT_TYPE=?,VISIT_TYPE=?,MAP_TYPE=?,MAP_VALUE=?,START_DATE=to_date(?,'DD-MM-YYYY'),END_DATE=to_date(?,'DD-MM-YYYY'),SUBSCRIBER_TYPE=?,MESSAGE_ORDER=?,DELIVERY_CRITERIA=?,DELIVERY_CRITERIA_ORDER=? where MESSAGE_ID=?";
				
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, mesgMap.getMesgType());
				pstmt.setInt(2,mesgMap.getEventType() );
				pstmt.setInt(3, mesgMap.getVisitType() );
				pstmt.setInt(4, mesgMap.getMapType() );
				pstmt.setLong(5, mesgMap.getMapValue() );
				pstmt.setString(6, mesgMap.getStartDate() );
				pstmt.setString(7, mesgMap.getEndDate() );
				pstmt.setInt(8, mesgMap.getSubType() );
				pstmt.setInt(9, mesgMap.getMesgOrder() );
			  pstmt.setString(10, mesgMap.getDeliveryCriteria() );
				pstmt.setString(11, mesgMap.getDeliveryOrder() );
				pstmt.setLong(12,mesgMap.getMesgId() );

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
		{		conPool.free(con);	}
    return 0;
				 
	 }//modifyMap()

} //MessageMapManager class

