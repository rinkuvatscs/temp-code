package com.telemune.webadmin.webif;

import java.util.*;

public class Rbt
{
	private int rbtId = -1;
	private String rbtMaskName = "";
	private String ivrFileName = "";  
	private String musicPath = "";
	private String nickname = "";
	private String nokia = "";
	private String others = "";
	private String playable = "";
	private String showweb = "";
	private String showsms = "";
	private int score = 0;
	private int catId = -1;
	private int contentProviderCode = -1;

	public Rbt()
	{
	}

	public Rbt(int rId)
	{
		this.rbtId = rId;
	}

	public Rbt(int rId, String mName, int catId)
	{
		this.rbtId = rId;
		this.rbtMaskName = mName;
		this.catId = catId;
	}

	public String getShowWeb()
	{
		return this.showweb;
	}

	public String getShowSms()
	{
		return this.showsms;
	}

	public void setShowWeb(String showweb)
	{
		this.showweb = showweb;
	}

	public void setShowSms(String showsms)
	{
		this.showsms = showsms;
	}

	public int getContentProviderCode()
	{
		return this.contentProviderCode;
	}

	public void setContentProviderCode(int contentProviderCode)
	{
		this.contentProviderCode = contentProviderCode;
	}

	public int getCategoryId()
	{
		return this.catId;
	}

	public void setCategoryId(int catId)
	{
		this.catId = catId;
	}

	public String getPlayable()
	{
		return this.playable;
	}

	public void setPlayable(String playable)
	{
		this.playable = playable;
	}

	public int getRbtId()
	{
		return rbtId;
	}

	public void setRbtId(int rbtId)
	{
		this.rbtId = rbtId;
	}

	public String getRbtMaskedName()
	{
		return rbtMaskName;
	}

	public void setRbtMaskedName(String rbtMaskName)
	{
		this.rbtMaskName = rbtMaskName;
	}

	public String getIvrFileName()
	{
		return ivrFileName;
	}

	public void setIvrFileName(String ivrFileName)
	{
		this.ivrFileName = ivrFileName;
	}	

	public String getMusicPath()
	{
		return musicPath;
	}

	public void setMusicPath(String musicPath)
	{
		this.musicPath = musicPath;
	}

	public String getNickName()
	{
		return nickname;
	}

	public void setNickName(String nickname)
	{
		this.nickname = nickname;
	}

	public String getNokia()
	{
		return nokia;
	}

	public void setNokia(String nokia)
	{
		this.nokia = nokia;
	}

	public String getOthers()
	{
		return others;
	}

	public void setOthers(String others)
	{
		this.others = others;
	}

	public int getScore()
	{
		return score;
	}        

	public void setScore(int score)
	{
		this.score = score;
	}	
}
