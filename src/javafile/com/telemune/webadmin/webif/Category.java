package com.telemune.webadmin.webif;

public class Category
{
	private int catId = -1;
	private String maskName = "";
	private String description = "";
	private String ivrFilePath = "";
	private String playable = "";
	private String showweb = "";
	private String showsms = "";

	public Category()
	{
	}
	
	public Category(int cId)
	{
		this.catId = cId;
	}

	public Category(int cId, String mName)
	{
		this.catId = cId;
		this.maskName = mName;
	}

	public void setCategoryId(int cId)
	{
		this.catId = cId;
	}

	public void setMaskedName(String mName)
	{
		this.maskName = mName;
	}

	public void setDescription(String desc)
	{
		this.description = desc;
	}

	public void setIvrFilePath(String ivr)
	{
		this.ivrFilePath = ivr;
	}

	public void setPlayable(String play)
	{
		this.playable = play;
	}

	public void setShowWeb(String web)
	{
		this.showweb = web;
	}

	public void setShowSms(String sms)
	{
		this.showsms = sms;
	}

	public int getCategoryId()
	{
		return catId;
	}

	public String getMaskedName()
	{
		return maskName;
	}

	public String getDescription()
	{
		return description;
	}

	public String getIvrFilePath()
	{
		return ivrFilePath;
	}

	public String getPlayable()
	{
		return this.playable;
	}

	public String getShowWeb()
	{
		return this.showweb;
	}

	public String getShowSms()
	{
		return this.showsms;
	}
}
