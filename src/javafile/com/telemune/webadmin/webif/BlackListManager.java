
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class BlackListManager

{
                               private static Logger logger=Logger.getLogger(BlackListManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
/* public BlackListManager()				 
 {
				 conPool = new ConnectionPool();
 }*/

 public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }
 


 public int addBlackList(BlackList blackList)
 {
				 logger.debug("webadmin: addBlackList()");
	try
	{
			con = conPool.getConnection();
			query = "select MSISDN from BLACK_LIST where MSISDN=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, blackList.getMsisdn() );
			rs = pstmt.executeQuery();
			if(rs.next() )
				{
								pstmt.close();
								rs.close();
								return -2; // this MSISDN is in BlackList, already
				}
			pstmt.close();
			rs.close();
			
			query="insert into BLACK_LIST (IMSI,MSISDN,EXPIRY_DATE,REMARKS) values	(?,?,to_date(?,'DD-MM-YYYY'),?)";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, blackList.getImsi() );
			pstmt.setString(2, blackList.getMsisdn() );
			pstmt.setString(3, blackList.getExDate() );
			pstmt.setString(4, blackList.getRemark() );
			
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
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally	{		conPool.free(con); }
    return 0;
 
 } //addBlackList


 public int viewBlackList(ArrayList blackListAl,String oldImsi, String oldMsisdn)
 {
				 logger.debug("webadmin: viewBlackList()");
	 try
		 {
						 con = conPool.getConnection();

						 if(oldImsi.equals("xx") && oldMsisdn.equals("xx") )
						 {
									 query="select IMSI,MSISDN,to_char(EXPIRY_DATE,'DD-MM-YYYY')EXPIRY_DATE,REMARKS from BLACK_LIST";
									 pstmt = con.prepareStatement(query);
						 }
						 else
						 {
									 query="select IMSI,MSISDN,to_char(EXPIRY_DATE,'DD-MM-YYYY')EXPIRY_DATE,REMARKS from BLACK_LIST where IMSI=? and MSISDN=?";
									 pstmt=con.prepareStatement(query);

										 pstmt.setString(1,oldImsi);
										 pstmt.setString(2,oldMsisdn);
						 }
						 rs = pstmt.executeQuery();
						 while(rs.next() )
						 {
										 BlackList blackList = new BlackList();
										 blackList.setImsi( rs.getString("IMSI"));
										 blackList.setMsisdn( rs.getString("MSISDN"));
										 blackList.setExDate( rs.getString("EXPIRY_DATE"));
										 blackList.setRemark( rs.getString("REMARKS"));
								blackListAl.add(blackList);
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
		{
						conPool.free(con);
		}
		return 99;

}//viewBlackList()

public int delBlackList(BlackList blackList)
	{
			logger.debug("webadmin: delBlackList()");
			try
			{
					con = conPool.getConnection();

					query="delete from BLACK_LIST where MSISDN=? and IMSI=?";
					pstmt=con.prepareStatement(query);

					pstmt.setString(1,blackList.getMsisdn());
					pstmt.setString(2,blackList.getImsi());
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
			finally	{	conPool.free(con);	}
    return 2;
 }//delMap()


public int modifyBlackList(BlackList blackList)
	{
			logger.debug("webadmin: modifyBlackList()");
			try
			{
							con = conPool.getConnection();

							query="update BLACK_LIST set IMSI=?, EXPIRY_DATE=to_date(?,'DD-MM-YYYY'),REMARKS=? where MSISDN=?";
							pstmt = con.prepareStatement(query);

							pstmt.setString(1,blackList.getImsi() );
							pstmt.setString(2,blackList.getExDate() );
							pstmt.setString(3,blackList.getRemark() );
							pstmt.setString(4,blackList.getMsisdn() );
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
					sqle.printStackTrace();
					return -1;	
      }
      e.printStackTrace ();
      return -1;
    }//catch
		finally
		{		conPool.free(con); }
    return 0;
	
	}// modifyBlackList()


} //class BlackListManager



			
			
	
