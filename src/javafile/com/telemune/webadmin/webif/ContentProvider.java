package com.telemune.webadmin.webif;

public class ContentProvider
{

	private String name = "";
	private String description = "";
	private String userName = "";
	private String password = "";
	private String contact = "";
	private String email = "";
	private int code = -1;
	private int cnt = -1;

	public ContentProvider()
	{
	}

	public ContentProvider(int code)
	{
		this.code = code;
	}

	public int getCode()
	{
		return this.code;
	}

	public void setcount(int cnt)
	{
		this.cnt=cnt;
	}
	public int getcount()
	{
		return this.cnt;
	}

	public void setCode(int code)
	{
		this.code=code;
	}


	public String getName()
	{
		return this.name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getDescription()
	{
		return this.description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}
	
	public void setUserName(String userName)
	{
		this.userName = userName;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public void setContact(String contact)
	{
		this.contact = contact;
	}
	public void setEmail(String email)
	{
		this.email = email;
	}
	public String getUserName()
	{
		return this.userName;
	}
	public String getPassword()
	{
		return this.password;
	}
	public String getContact()
	{
		return this.contact;
	}
	public String getEmail()
	{
		return this.email;
	}
}
