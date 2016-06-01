/*
 * This class is used for VLR config for the admin web interface for WelcomeSMS.
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class VLR
{
	private String vlrId;
	private String desc;
	private String enabled;

	public VLR ()
	{
		vlrId = "";
		desc = "";
		enabled = "A";
	}
	public void setVlrId (String vlrId)
	{
		this.vlrId = vlrId;
	}
	public void setDescription(String desc)
	{
		this.desc = desc;
	}
	public String getVlrId()
	{
		return vlrId;
	}
	public String getDescription()
	{
		return desc;
	}
	public String getEnabled()
	{
		return enabled;
	}
	public void setEnabled(String enabled)
	{
		this.enabled = enabled;
	}

} // class VLR
