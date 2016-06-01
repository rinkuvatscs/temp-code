/*
 * Maintains every user's session history
 *
 *
 *
 */

package com.telemune.webadmin.webif;

import java.util.ArrayList;
import java.sql.ResultSet;
import com.telemune.dbutilities.*;

public class SubscriberProfile
{
				private Connection con;
				//private ArrayList links = null;
				private String userName=""; //this is access user name to web 
				private int cpCode=-1; // unique code for content provider

				public void SubscriberProfile()
				{
				}	
				public void setUserName(String userName)
				{
								this.userName=userName;  
				}
				public void setCpCode(int cpcode)
				{
								this.cpCode=cpcode; 
				}

				public String getUserName()
				{
								return this.userName;
				}
				public int getCpCode()
				{
								return this.cpCode;
				}


				/*	public boolean isAllowed(int linkId)
						{
						return links.contains(new Integer(linkId));
						}
				 */
				/*public int getLinks(int roleId)
					{
					links = new ArrayList();
					try
					{
					String query = "select LINK_ID from CRBT_ACCESS where ROLE_ID = ?";
					PreparedStatement pstmt = con.prepareStatement(query);

					pstmt.setInt(1, roleId);

					ResultSet rs = pstmt.executeQuery();

					while(rs.next())
					{
					links.add(new Integer(rs.getInt(1)));
					}
					rs.close();         
					pstmt.close();
					}
					catch (Exception e)
					{
					e.printStackTrace();
					return CrbtErrorCodes.FAILURE;
					}
					return CrbtErrorCodes.SUCCESS;
					}
				 */
				public void setConnection(Connection con)
				{
								this.con = con;
				}

				public Connection getConnection()
				{
								return this.con;
				}
}
