
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class lbsManager

{
                                 private static Logger logger=Logger.getLogger(lbsManager.class);
				private ConnectionPool conPool = null;
				private PreparedStatement pstmt = null;
				private Connection con = null;
				private ResultSet rs =null;
				private String query = null;
				
 public lbsManager()				 
 {
			//	 conPool = new ConnectionPool();
 }


   public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }

	public int getLBSConfig (ArrayList lbsConfigAl, String name)
	{
		logger.debug ("in function getLBSConfig: "+name);
		try
		{
			con = conPool.getConnection();
			if( name.equals("X") )			// show all data
			{
				query = "select PROCESS_NAME, PACKAGE_NAME, MIN_ARGUMENTS,MAX_ARGUMENTS,CREATED_BY,to_char(CREATION_DATE,'DD-MM-YYYY')CREATION_DATE,UPDATED_BY,SYNTAX_MESSAGE,to_char(UPDATE_DATE,'DD-MM-YYYY')UPDATE_DATE,PROCESS_ID FROM LBS_PROCESS_MASTER order by PROCESS_NAME";
			pstmt = con.prepareStatement (query);
			}
			else
			{
				query = "select PROCESS_NAME, PACKAGE_NAME, MIN_ARGUMENTS,MAX_ARGUMENTS,CREATED_BY,to_char(CREATION_DATE,'DD-MM-YYYY')CREATION_DATE,UPDATED_BY,SYNTAX_MESSAGE,to_char(UPDATE_DATE,'DD-MM-YYYY')UPDATE_DATE,PROCESS_ID FROM LBS_PROCESS_MASTER where PROCESS_NAME=?";
			pstmt = con.prepareStatement (query);
			pstmt.setString(1,name);
			}
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				lbs  hlr = new lbs();
				hlr.setProcessName (rs.getString ("PROCESS_NAME"));
				hlr.setPackageName (rs.getString ("PACKAGE_NAME"));
				hlr.setMinArg ( rs.getInt ("MIN_ARGUMENTS") );
				hlr.setMaxArg ( rs.getInt ("MAX_ARGUMENTS") );
				hlr.setCreatedBy (rs.getString ("CREATED_BY"));
				hlr.setCreationDate (rs.getString ("CREATION_DATE"));
				hlr.setUpdatedBy (rs.getString ("UPDATED_BY"));
				hlr.setSyntax (rs.getString ("SYNTAX_MESSAGE"));
				hlr.setUpdateDate (rs.getString ("UPDATE_DATE"));
				hlr.setProcessId ( rs.getInt ("PROCESS_ID") );
				lbsConfigAl.add (hlr);
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
				logger.error ("Exception in getLBSConfig, Exception is : " + sqle.getMessage ());
			}
			logger.error ("Exception caught "+e);
			e.printStackTrace ();
			return -1;
		}//catch
		finally{ conPool.free(con); }
		
		return 0;
	}//selectHLRConfig
 
 public int updateLBSConfig (lbs hlr)
	{
		logger.debug ("in function updateLBSConfig");
		try
		{
			con = conPool.getConnection();
			query = "update LBS_PROCESS_MASTER set MIN_ARGUMENTS=?,MAX_ARGUMENTS=?,SYNTAX_MESSAGE=? where PROCESS_NAME=? and PACKAGE_NAME=?";
			pstmt = con.prepareStatement (query);
			pstmt.setInt (1, hlr.getMinArg ());
			pstmt.setInt (2, hlr.getMaxArg ());
			pstmt.setString (3, hlr.getSyntax ());
			pstmt.setString (4, hlr.getProcessName ());
			pstmt.setString (5, hlr.getPackageName ());
			
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
				logger.error ("Exception in updateLBSConfig, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}//catch
		finally { conPool.free(con); }
		return 0;
	}//updateHLRConfig
  

} //class HLRManager
