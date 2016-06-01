/* * This class is used for Admin user info for the admin web interface .   */
/* @Jatinder */
package com.telemune.webadmin.webif;
import	java.util.*;
public class CorpUser
	{
	    private	String corpName;
	    private	String chargingMsisdn;
	    private	String userName;
      private	String password;
	    private	String dateRegisted;
			private	long corpId;
			private	int planIndicator;
			private	String days="";
			private	String remarks="";
			private  String starttime="";
			private  String endtime="";
      private  int dayParamId=-1, stParamId=-1, endParamId=-1;
																								
	    public void CorpUser ()
	    {
	        corpName = "";
	        chargingMsisdn = "";
	        password = "";
	        userName = "";
					dateRegisted = "";
					corpId=0;
					planIndicator=0;
	    }
	    public void setCorpName (String corpName)
	    {
	        this.corpName = corpName.trim();
	    }
	    public void setChargingMsisdn (String msisdn)
	    {
			 this.chargingMsisdn = msisdn.trim();
			 }
	    public void setUserName (String userName)
	    {
	        this.userName = userName.trim();
	    }
	    public void setPassword (String password)
	    {
	        this.password = password.trim();
	    }
	    public void setDateRegistered (String dateRegisted)
	    {
	        this.dateRegisted = dateRegisted.trim();
	    }
	    public void setCorpId(long corpId)
	    {
	        this.corpId = corpId;
	    }

	    public void setPlanIndicator(int planIndicator)
	    {
	        this.planIndicator = planIndicator;
	    }


	    public void setDays (String days)
	    {
	        this.days = days.trim();
	    }
	    public void setStartTime (String starttime)
	    {
	        this.starttime = starttime.trim();
	    }
	    public void setEndTime (String endtime)
	    {
	        this.endtime = endtime.trim();
	    }

	    public void setDayParamId (int dayParamId)
	    {
	        this.dayParamId = dayParamId;
	    }
	    public void setStParamId (int stParamId)
	    {
	        this.stParamId = stParamId;
	    }
	    public void setEndParamId (int endParamId)
	    {
	        this.endParamId = endParamId;
	    }
					public void setPlanRemarks(String remarks)
	    {
	        this.remarks = remarks.trim();
	    }

	    

/* *********    get Values         ******  */
	    public String getCorpName ()
	    {
	        return corpName;
	    }
				public String getPlanRemarks ()
	    {
	        return remarks;
	    }
	    public String getChargingMsisdn ()
	    {
	        return chargingMsisdn;
	    }
	    public String getUserName ()
	    {
	        return userName;
	    }
	    public String getPassword ()
	    {
	        return password;
	    }
	    public String getDateRegistered ()
	    {
	        return dateRegisted;
	    }
	    public long getCorpId ()
	    {
	        return corpId;
	    }
	    public int getPlanIndicator ()
	    {
	        return planIndicator;
	    }
	   
		  public int getStParamId()
			{
			 return stParamId;
			}
		  public int getEndParamId()
			{
			 return endParamId;
			}
		  public int getDayParamId()
			{
			 return dayParamId;
			}
		  public String getDays()
			{
			 return days;
			}
		  public String getStartTime()
			{
			 return starttime;
			}
		  public String getEndTime()
			{
			 return endtime;
			}
	   
 } // class
