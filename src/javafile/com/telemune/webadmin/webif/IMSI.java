/*
 * This class is used for VLR config for the admin web interface for CRBT.
 *
 *
 * 
 */
package com.telemune.webadmin.webif;

public class IMSI
{
	private String rangeId;
	private String startAt;
	private String endsAt;
	private String subType;
	public IMSI()
	{
	}

	public void setRangeId (String rangeId)
	{
		this.rangeId = rangeId;
	}

	public void setStartAt (String startAt)
	{
		this.startAt = startAt;
	}

	public void setEndsAt (String endsAt)
	{
		this.endsAt = endsAt;
	}

	public void setSubscriberType (String subType)
	{
		this.subType = subType;
	}

	public String getRangeId ()
	{
		return rangeId;
	}

	public String getStartAt ()
	{
		return startAt;
	}

	public String getEndsAt ()
	{
		return endsAt;
	}

	public String getSubscriberType()
	{
		return subType;
	}

}
