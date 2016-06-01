
/*@Jatinder Pal*/

package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class TimeZoneManager

{
                             private static Logger logger=Logger.getLogger(TimeZoneManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public TimeZoneManager()				 
 {
//				 conPool = new ConnectionPool();
 }

  public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }


  
 public int addTimeZone(TimeZones timeZone)
 {
		return 99;
 }//addTimeZone

 public int viewTimeZone(ArrayList timeZoneAl)
 {
		 logger.debug("for getting Time Zones");
	 try
	 {
			con = conPool.getConnection();
			 query = "select * from ROME_TIME_ZONES";
			 pstmt = con.prepareStatement(query);
			 rs = pstmt.executeQuery();
			 while(rs.next() )
			 {
							 	TimeZones timeZone = new TimeZones();
								timeZone.setTimeZone ( rs.getInt("TIME_ZONE") );
								timeZone.setZoneName ( rs.getString("ZONE_NAME") );
								timeZone.setDiffHour ( rs.getInt("DIFF_HOUR") );
								timeZone.setDiffMinute ( rs.getInt("DIFF_MINUTE") );
					timeZoneAl.add(timeZone);			
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
		{		conPool.free(con);}
		return 99;
	
 }//viewTimeZone

 public int viewTimeZone(ArrayList timeZoneAl, int timeZone)
 {
				 logger.info("for getting Time Zones"+timeZone);
	 try
	 {
		   con = conPool.getConnection();
			 query = "select * from ROME_TIME_ZONES where TIME_ZONE=?";
			 pstmt = con.prepareStatement(query);
		   pstmt.setInt(1,timeZone);
			 rs = pstmt.executeQuery();
			 while(rs.next() )
			 {
							 	TimeZones time_Zone = new TimeZones();
								time_Zone.setTimeZone ( rs.getInt("TIME_ZONE") );
								time_Zone.setZoneName ( rs.getString("ZONE_NAME") );
								time_Zone.setDiffHour ( rs.getInt("DIFF_HOUR") );
								time_Zone.setDiffMinute ( rs.getInt("DIFF_MINUTE") );
					timeZoneAl.add(time_Zone);			
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
		{	conPool.free(con);	}
		return 99;

}//viewTimeZone


}// class TimeZoneManager


