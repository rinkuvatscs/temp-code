/*
 * This class is used for VLR config for the admin web interface for CRBT.
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class HLR
{
	private int hlrId;
	private String hlrName;
	private String hlrIp;
	private int hlrPort;
	private String login;
	private String password;
	private String description;
	private int conn;

	public HLR()
	{
					
	}

	public void setHLRId (int hlrId)
	{
		this.hlrId = hlrId;
	}

	public void setHLRName (String hlrName)
	{
		this.hlrName = hlrName;
	}

	public void setHLRIp (String hlrIp)
	{
		this.hlrIp = hlrIp;
	}

	public void setHLRPort (int hlrPort)
	{
		this.hlrPort = hlrPort;
	}

	public void setLogin(String login)
	{
		this.login = login;
	}

	public void setPassword (String password)
	{
		this.password = password;
	}

	public void setDescription (String description)
	{
		this.description = description;
	}

	public void setConnection (int conn)
	{
		this.conn = conn;
	}

	public int getHLRId ()
	{
		return hlrId;
	}

	public String getHLRName ()
	{
		return hlrName;
	}

	public String getHLRIp ()
	{
		return hlrIp;
	}

	public int getHLRPort ()
	{
		return hlrPort;
	}

	public String getLogin ()
	{
		return login;
	}

	public String getPassword ()
	{
		return password;
	}

	public String getDescription ()
	{
		return description;
	}

	public int getConnection ()
	{
		return conn;
	}

} // class HLR
