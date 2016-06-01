
// modified on 12-01-2006
//@author Jatinder Pal

package com.telemune.webadmin.webif;

import java.util.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import com.telemune.dbutilities.*;
 import org.apache.log4j.*;
public class AdminUserManager
{
   private static Logger logger=Logger.getLogger(AdminUserManager.class);
   private ConnectionPool conPool = null;
	 private ResultSet rs = null;
	 private PreparedStatement pstmt = null;
	 private Connection con = null;
	 private String query = null;
	 
    /*  public AdminUserManager()
       {
				 conPool = new ConnectionPool();
       }*/

     //Added by manoj
      public void setConnectionPool(ConnectionPool conPool)
        {
                this.conPool = conPool;
        }

        public ConnectionPool getConnectionPool()
        {
                return conPool;
        }




	public int addUser (AdminUser adminUser)
	{
		logger.debug("webadmin: addUser");
		try
		{
			con = conPool.getConnection();
			query = "SELECT USER_NAME FROM CRBT_ADMINUSER WHERE USER_NAME = ?";
			pstmt = con.prepareStatement (query);
			pstmt.setString (1, adminUser.getUserName ());
			rs = pstmt.executeQuery ();
			while(rs.next ())
			{
				rs.close ();
				pstmt.close ();
				return -2; //Record already exists
			}
			rs.close ();
			pstmt.close ();

			//query = "INSERT INTO CRBT_ADMINUSER (USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID) VALUES (?, ?, ?, ?, ?)";
			query = "INSERT INTO CRBT_ADMINUSER (USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID, FIRST_LOGIN) VALUES (?, ?, ?, ?, ?,0)";
			pstmt = con.prepareStatement (query);

			pstmt.setString (1, adminUser.getUserName ());
			pstmt.setString (2, adminUser.getPassword ());
			pstmt.setString (3, adminUser.getEmail ());
			pstmt.setString (4, adminUser.getMobileNum ());
			pstmt.setInt (5, adminUser.getRoleId ());

			pstmt.executeUpdate ();
			pstmt.close ();
		
			if(adminUser.getRoleId() != 1) //if User is not in Admin Role
			{
				logger.debug("webadmin-AddUser: :added is not in ADMIN role");
				int pwd_number=1;
				query ="select max(PASSWORD_NUM) AA from ADMINUSER_PASSWORD_CHECK where USER_NAME=?";
				pstmt = con.prepareStatement (query);
				pstmt.setString (1, adminUser.getUserName ());
				rs = pstmt.executeQuery ();
				if(rs.next ())
				{
					pwd_number = rs.getInt("AA")+1;
				}
				logger.info("webadmin-AddUser: password number= "+pwd_number);
				rs.close ();
				pstmt.close ();

				query = "INSERT INTO ADMINUSER_PASSWORD_CHECK (USER_NAME, PASSWORD, ROLE_ID, LAST_UPDATE,PASSWORD_NUM) VALUES (?, ?, ?, sysdate, ?)";
				pstmt = con.prepareStatement (query);

				pstmt.setString (1, adminUser.getUserName ());
				pstmt.setString (2, adminUser.getPassword ());
				pstmt.setInt (3, adminUser.getRoleId ());
				pstmt.setInt (4, pwd_number);

				pstmt.executeUpdate ();
				pstmt.close ();
			}
		}//try
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("webadmin-AddUser: Exception in addUser, Exception is : " + sqle.getMessage ());
			}

			e.printStackTrace ();
			return -1;
		}
		finally  { conPool.free(con); } 
		return 0;

	}// addUser
	
	public int getUserData (ArrayList adminUserAl, AdminUser adminUser)
	{
				logger.debug("in function getUserData");
		try
		{
				con = conPool.getConnection();
				int roleId = adminUser.getRoleId() ;
				String action = adminUser.getUserId();
				String userName = adminUser.getUserName().trim();
				logger.info("roleId= "+roleId +" & userName= " +  userName);
				logger.info("action= "+action);
 
	if( ( userName.equalsIgnoreCase("") || userName == null ) && roleId == 0) // search for all data .
	{
	query = "select USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID from CRBT_ADMINUSER";
		pstmt = con.prepareStatement (query);
	}
	else if( ( userName.equalsIgnoreCase("") || userName == null ) && roleId != 0) // get this specific User data,
	// acc. to roleId/roleType given
	{
		query = "select USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID from CRBT_ADMINUSER where ROLE_ID = ?";
		pstmt = con.prepareStatement (query);
			pstmt.setInt(1, roleId);
       }
		else if(roleId == 0 && action == "view")  //get data for User Name, to view/modify
				{
						query = "select USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID from CRBT_ADMINUSER where USER_NAME = ?";
								pstmt = con.prepareStatement (query);
								pstmt.setString(1, userName );
				}
				else if(action == "user" && roleId != 0 )  //get data for User Name,and Role Id given
				{
								query = "select USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID from CRBT_ADMINUSER where ROLE_ID = ? and USER_NAME like ?";
								pstmt = con.prepareStatement (query);
								pstmt.setInt(1, roleId);
								pstmt.setString(2, "%"+userName+"%" );
				}
				else if(action == "user" && roleId == 0 )  //get data for User Name,and Role Id given
				{
								query = "select USER_NAME, PASSWORD, EMAIL, MOBILE_NUM, ROLE_ID from CRBT_ADMINUSER where USER_NAME like ?";
								pstmt = con.prepareStatement (query);
								pstmt.setString(1, "%"+userName+"%" );
				}	
			rs = pstmt.executeQuery ();
			logger.debug(query);

		  
					while(rs.next ())
						{
								adminUser = new AdminUser ();
								adminUser.setUserName (rs.getString ("USER_NAME"));
								adminUser.setPassword (rs.getString ("PASSWORD"));
								adminUser.setEmail (rs.getString ("EMAIL"));
								adminUser.setMobileNum (rs.getString ("MOBILE_NUM"));
								adminUser.setRoleId (rs.getInt ("ROLE_ID"));
								adminUserAl.add (adminUser);
						}
			 		rs.close ();
		      pstmt.close ();
		} //try
		catch (Exception e)
		{
			try
			{
				if(rs != null) rs.close ();
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error("Exception in listUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con); }
		return 1;

	}//getUserData

	public int updateUser (AdminUser adminUser)
	{
			logger.debug("in function updateUser");
			logger.info("updating user type= "+ adminUser.getRoleId()+"& user name= "+ adminUser.getUserName() );
					
		try
		{
				con = conPool.getConnection();
			if (adminUser.getPassword() == null || adminUser.getPassword().equals("")) 
			{

				 query = "UPDATE CRBT_ADMINUSER SET EMAIL = ?, MOBILE_NUM = ?, ROLE_ID = ? WHERE USER_NAME = ?";
				pstmt = con.prepareStatement (query);
				
				pstmt.setString (1, adminUser.getEmail ());
				pstmt.setString (2, adminUser.getMobileNum ());
				pstmt.setInt (3, adminUser.getRoleId ());
				pstmt.setString (4, adminUser.getUserName ());
				pstmt.executeUpdate ();
				pstmt.close ();
			}

			else
			{

			 query = "UPDATE CRBT_ADMINUSER SET PASSWORD = ?, EMAIL = ?, MOBILE_NUM = ?, ROLE_ID = ?,FIRST_LOGIN=0 WHERE USER_NAME = ?";
				pstmt = con.prepareStatement (query);
				
				pstmt.setString (1, adminUser.getPassword ());
				pstmt.setString (2, adminUser.getEmail ());
				pstmt.setString (3, adminUser.getMobileNum ());
				pstmt.setInt (4, adminUser.getRoleId ());
				pstmt.setString (5, adminUser.getUserName ());
				pstmt.executeUpdate ();
				pstmt.close ();
				
				if(adminUser.getRoleId() != 1) //if User is not in Admin Role
				{
					logger.debug("user to be added is not in ADMIN role");
					int pwd_number=1;
					query ="select max(PASSWORD_NUM) AA from ADMINUSER_PASSWORD_CHECK where USER_NAME=?";
					pstmt = con.prepareStatement (query);
					pstmt.setString (1, adminUser.getUserName ());
					rs = pstmt.executeQuery ();
					if(rs.next ())
					{
						pwd_number = rs.getInt("AA")+1;
					}
					logger.info("password number= "+pwd_number);
					rs.close ();
					pstmt.close ();

					query = "INSERT INTO ADMINUSER_PASSWORD_CHECK (USER_NAME, PASSWORD, ROLE_ID, LAST_UPDATE,PASSWORD_NUM) VALUES (?, ?, ?, sysdate, ?)";
					pstmt = con.prepareStatement (query);

					pstmt.setString (1, adminUser.getUserName ());
					pstmt.setString (2, adminUser.getPassword ());
					pstmt.setInt (3, adminUser.getRoleId ());
					pstmt.setInt (4, pwd_number);

					pstmt.executeUpdate ();
					pstmt.close ();
				}

			}

		}
		catch (Exception e)
		{
			try
			{
				if(pstmt != null) pstmt.close ();
			}catch(SQLException sqle)
			{
				logger.error ("Exception in updateUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{conPool.free(con); }
		return 0;
	} // updateUser
	
	public int deleteUser (ArrayList userNameAl)
	{
		logger.debug("in function deleteUser");
		try
		{
		String userName="";
		con = conPool.getConnection();
			 query = " delete from CRBT_ADMINUSER WHERE USER_NAME = ?";
			pstmt = con.prepareStatement (query);
			
			Iterator ite = userNameAl.iterator ();
			while(ite.hasNext ())
			{
				 userName = (String)ite.next ();
				pstmt.setString (1, userName);
				pstmt.executeUpdate();
			}
			pstmt.close ();
			 
			 query = "delete from ADMINUSER_PASSWORD_CHECK WHERE USER_NAME = ?";
			pstmt = con.prepareStatement (query);
			
			Iterator ite1 = userNameAl.iterator ();
			while(ite1.hasNext ())
			{
				userName = (String)ite1.next ();
				pstmt.setString (1, userName);
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
				logger.error ("Exception in deleteUser, Exception is : " + sqle.getMessage ());
			}
			e.printStackTrace ();
			return -1;
		}
		finally{ conPool.free(con);  }
		return 0;
	}//deleteUser


} //class AdminUserManager
