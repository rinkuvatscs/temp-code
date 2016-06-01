/* * Maintains every user's session history * * * */
package com.telemune.webadmin.webif;

import com.telemune.dbutilities.*;
import java.util.*;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.io.Serializable;
 import org.apache.log4j.*;
public class SessionHistory implements java.io.Serializable
{    
                 private static Logger logger=Logger.getLogger(SessionHistory.class);
				private String userId;
//				private String error;
//				private Exception exception;
//				private ConnectionPool conPool;
				private transient Connection con;
				private ArrayList links = null;
				public SessionHistory ()
				{
								this.userId = "0";
				}
				public void setUser(String user)
				{
								this.userId = user;
				}
				public String  getUser()
				{
								return userId;
				}
				public boolean isAllowed (int linkId)
				{
								return links.contains (new Integer (linkId));
				}
				public void getLinks (int userType) 
				{
								links = new ArrayList ();
								PreparedStatement pstmt = null;
								ResultSet rs = null;
								try
								{
												String query = "select LINK_ID from CRBT_ACCESS where ROLE_ID = ?";
												pstmt = con.prepareStatement (query);
												pstmt.setInt (1, userType);
												rs = pstmt.executeQuery ();
												while(rs.next ())
												{
																links.add (new Integer (rs.getInt ("LINK_ID")));
												}
												rs.close ();
												pstmt.close ();

								}
								catch (Exception e)
								{
												try 
												{
																if(rs != null) rs.close ();                
																if(pstmt != null) pstmt.close ();            
												}catch(SQLException sqle)            
												{                
																logger.error ("In getLinks, SQLException is : " + sqle.getMessage ());            
												}
												logger.error (e);        
								}    
				}    
				public void setConnection (Connection con)
				{
								this.con = con;
				}
				public Connection getConnection ()
				{
								return con;
				}
}
