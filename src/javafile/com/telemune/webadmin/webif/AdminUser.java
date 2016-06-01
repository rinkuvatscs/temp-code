/* * This class is used for Admin user info for the admin web interface .   */
/* @Jatinder */
package com.telemune.webadmin.webif;
import	java.util.*;
public class AdminUser
	{
	    private	String userId;
	    private	String userName;
      private	String password;
	    private	String email;	
	    private	String mobileNum;
	    private	String description;
	    private	int roleId;
	    public void AdminUser ()
	    {
	        userId = "";
	        userName = "";
	        password = "";
	        email = "";
	        mobileNum = "";
	        description = "";
	        roleId = -1 ;
	    }
	    public void setUserId (String userId)
	    {
	        this.userId = userId; 
	   }
	    public void setUserName (String userName)
	    {
	        this.userName = userName;
	    }
	    public void setPassword (String password)
	    {
	        this.password = password;
	    }
	    public void setEmail (String email)
	    {
	        this.email = email;
	    }
	    public void setMobileNum (String mobileNum)
	    {
	        this.mobileNum = mobileNum;
	    }
	    public void setDescription (String description)
	    {
	        this.description = description;
 	   }
	    public void setRoleId (int roleId)
	    {
	        this.roleId = roleId;
	    }

/* *********    get Values         ******  */
	    public String getUserId ()
	    {
	        return userId;
	    }
	    public String getUserName ()
	    {
	        return userName;
	    }
	    public String getPassword ()
	    {
	        return password;
	    }
	    public String getEmail ()
	    {
	        return email;
	    }
	    public String getMobileNum ()
	    {	
	        return mobileNum;
	    }
	    public String getDescription ()
	    {
	        return description;
	    }
	    public int getRoleId ()
	    {
	        return roleId;
	    }
 } // class AdminUser
