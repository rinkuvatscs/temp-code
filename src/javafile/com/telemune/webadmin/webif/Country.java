/*
 * This class is used for Country Management for the admin web interface for WelcomeSMS.
 * @Jatinder Pal
*/
package com.telemune.webadmin.webif;

public class Country
{
	private String code;
	private String name;
	private int cc;
	private int mcc;
	private String inbound;
	private String outbound;

	public Country()
	{
					code="";
					name="";
					cc=0;
					mcc=0;
					inbound="A";
					outbound="A";
	}

	public void setCode (String code)
	{
		this.code = code;
	}

	public void setName (String name)
	{
		this.name= name;
	}

	public void setCc (int cc)
	{
		this.cc = cc;
	}

	public void setMcc (int mcc)
	{
		this.mcc = mcc;
	}

	public void setInbound(String inbound)
	{
		this.inbound= inbound;
	}

	public void setOutbound (String outbound)
	{
		this.outbound = outbound;
	}

	public String getCode ()
	{
		return code;
	}

	public String getName ()
	{
		return name;
	}

	public int getCc ()
	{
		return cc;
	}

	public int getMcc ()
	{
		return mcc;
	}

	public String getInbound ()
	{
		return inbound;
	}

	public String getOutbound ()
	{
		return outbound;
	}

} // class Country
