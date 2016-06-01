
/* * This class is used for system app config for the admin web interface. * *
@Jatinder Pal
 * */
package com.telemune.webadmin.webif;
import	java.util.*;

 public class SmscConfig
  {    
				private String userId;    
				private String password;    
				private String smscIP;    
				private int smscPort;    
				private String systemType;    
				private int    ton;    
				private int    npi;    
				private String addressRange;    
				private int    numOfConAllow;    
				private int    speed;    
				private int    smscId;    
				private String smscStatus;    
				private String clientType;    

				public void SmscConfig () 
				{  
								this.userId = "";  
								this.password = "";
								this.smscIP = "";
								this.smscPort = 0;  
								this.systemType= "";  
								this.ton = 0; 
								this.npi = 0; 
								this.addressRange = "";  
								this.numOfConAllow = 0;  
								this.speed = 10;  
								this.smscId=0; 
								this.smscStatus=""; 
								this.clientType="";  
				}    
				public void setUserId (String userId)  
				  {   
						     this.userId = userId;  
					 }    
				public void setPassword (String password) 
				   { 
								 this.password = password;
					  }    
				public void setSmscIp (String smscIP)
				    {
								  this.smscIP = smscIP;
					   }    
				public void setSmscPort (int smscPort)
				    { 
								  this.smscPort = smscPort;
				    }    
				public void setSystemType (String systemType) 
				   {
								 this.systemType = systemType; 
					 }    
				public void setTon (int ton)
				    {  
							    this.ton = ton; 
					  }    
				public void setNpi (int npi) 
				   	{ 
									 this.npi = npi; 
		  	    }    
				public void setAddressRange (String addressRange)    {        this.addressRange = addressRange;    }    
				public void setNumOfConAllow (int numOfConAllow)    {        this.numOfConAllow = numOfConAllow;    }    
				public void setSpeed (int speed)    {        this.speed = speed;    }    
				public void setSmscId (int smscId)    {        this.smscId = smscId;    }    
				public void setClientType (String clientType)    {        this.clientType = clientType;    }    
				public void setSmscStatus (String smscStatus)    {        this.smscStatus = smscStatus;    }    
		
			
				public String getUserId ()    {        return userId;    }    
				public String getPassword ()    {        return password;    }    
				public String getSmscIp ()    {        return smscIP;    }    
				public int getSmscPort ()    {        return smscPort;    }    
				public String getSystemType ()    {        return systemType;    }    
				public int getTon ()    {        return ton;    }    
				public int getNpi ()    {        return npi;    }    
				public String getAddressRange ()    {        return addressRange;    }    
				public int getNumOfConAllow ()    {        return numOfConAllow;    }    
				public int getSpeed ()    {        return speed;    }    
				public int getSmscId ()    {        return smscId;    }    
				public String getClientType ()    {        return clientType;    }    
				public String getSmscStatus ()    {        return smscStatus;    }
				
	}//class 
