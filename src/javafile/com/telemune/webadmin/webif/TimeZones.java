/*
 * This class is used for Time Zone config for the admin web interface for WelcomeSMS.
 *
 *
 * 
 */
package com.telemune.webadmin.webif;

public class TimeZones
{
	private int timeZone;
	private String zoneName;
	private int diffHour;
	private int diffMinute;
	
	public TimeZones()
	{
		timeZone = -1;
		zoneName = "";
		diffHour = -1;
		diffMinute = -1;
	}

	public void setTimeZone(int timeZone)
	{
					this.timeZone = timeZone;
	}
	public void setZoneName(String zoneName)
	{
					this.zoneName=zoneName;
	}
	public void setDiffHour(int diffHour)
	{
					this.diffHour = diffHour;
	}
	public void setDiffMinute(int diffMinute)
	{
					this.diffMinute = diffMinute;
	}

// ********get values  ********* 

 public int getTimeZone()
 {
				 return timeZone;
 }
 public String getZoneName()
 {
				 return zoneName;
 }
 public int getDiffHour()
 {
				 return diffHour;
 }
 public int getDiffMinute()
 {
				 return diffMinute;
 }


}//class TimeZone
