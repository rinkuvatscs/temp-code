/*
 * This class is used for user authentication for the web interface for CRBT. 
 *
 *
 *
 */
package com.telemune.webadmin.webif;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.telemune.dbutilities.*;
import org.apache.log4j.*;

public class AuthAdmin
{

	private	String userId = "";
	private	String password = "";
	private Connection con = null;
	private	ConnectionPool conPool = null;
	private Logger logger = Logger.getLogger("com.telemune.webadmin.webif.AuthAdmin");

	private SessionHistory sessionHistory =  null;
	
	/*public AuthAdmin()
	{
		conPool = new ConnectionPool();
	}	*/


       public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }


	public  SessionHistory getSessionHistory()
	{
		return sessionHistory;
	}

	public	void setUserId(String userId)
	{	
		this.userId = userId;
	}
		
	public	void setPassword(String password)
	{
		this.password = password;			
	}
	
	public String  getUserId()
	{
		return userId;
	}
		
	public String getPassword()
	{
		return password;
	}

	public int authenticate()
	{
		if(userId.equals("") || password.equals(""))
		{
			return CrbtAdminAppCode.USERID_PASSWORD_MISSING;
		}

		try
		{	
			con = conPool.getConnection();

			String query = "select ROLE_ID from CRBT_ADMINUSER where USER_NAME = ? and PASSWORD = ?"; 
			logger.debug("Query is:- " + query);
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, password);
			logger.debug("userId:- " + userId);
			logger.debug("pass is:- " + password);
			ResultSet results = pstmt.executeQuery();
		
			if (results.next())
			{//check for passwd match		
				int userType = results.getInt("ROLE_ID");

				sessionHistory = new SessionHistory();
                               
				sessionHistory.setConnection(con);	
				sessionHistory.getLinks(userType);
				sessionHistory.setUser(userId);
         
				results.close();
				pstmt.close();
				 
				return CrbtAdminAppCode.AUTHENTICATED_USER;
			}
			else//some other kind of error. 
			{
				return CrbtAdminAppCode.INVALID_PASSWORD;
			}
		}
		catch (Exception e)
		{//log it 
			e.printStackTrace();
			return CrbtAdminAppCode.UNKNOWN_EXCEPTION;
		}
		finally
		{
			conPool.free(con);
		}	
	}

	public int changePassword(String user, String oldPass, String newPass)
	{
		try 
		{
			con = conPool.getConnection();

			String query = "select USER_NAME from CRBT_ADMINUSER where USER_NAME = ? and PASSWORD = ?"; 
			logger.debug("Query is:- " + query);
	
			PreparedStatement pstmt = con.prepareStatement(query);

			pstmt.setString(1, user);
			pstmt.setString(2, oldPass);

			ResultSet results = pstmt.executeQuery();
                 
			if(results.next())
			{
				query = "update CRBT_ADMINUSER set PASSWORD = ? where USER_NAME = ?";
				pstmt = con.prepareStatement(query);
	
				pstmt.setString(1, newPass);
				pstmt.setString(2, user);	
				
				pstmt.executeUpdate();
				pstmt.close();
			}
			else
			{
				pstmt.close();
				return CrbtAdminAppCode.INVALID_PASSWORD;
				
			}
			results.close();


		}
		catch(Exception e)
		{
			e.printStackTrace();
			return CrbtAdminAppCode.UNKNOWN_EXCEPTION;
		}
		finally
		{
			conPool.free(con);
		}
		return 1;
	} //changePassword
	
} // class AuthAdmin
