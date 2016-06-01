/*@Jatinder*/

package com.telemune.webadmin.webif;

public class Advertise
{
         private long catId;
				 private String catName;
				 private int catFrequency;
         
				 private long adId;
				 private String adName;
				 private long adCat;
				 private int adFrequency;
				 private String startDate;
				 private String endDate;
				 private int adMax;
				 private int adSent;

			public Advertise()
			{
			  catId=0;
				catName="";
				catFrequency=-1;	
	
				adId=0;
				adName="";
				adCat=0;
				adFrequency=-1;
				startDate="";
				endDate="";
				adMax=-1;
				adSent=-1;

							
			}

	// ********* set values ***
  public void setCatId(long catId)
	{
					this.catId =catId;
	}
	public void setCatName(String catName)
	{
					this.catName =catName;
	}
	public void setCatFrequency(int  catFrequency)
	{
					this.catFrequency = catFrequency;
	}

	// ********* get values ***

	public long getCatId()
	{
					return catId;
	}
	public String getCatName()
	{
					return catName;
	}
	public int getCatFrequency()
	{
					return catFrequency;
	}


	// ********* set values ***
	public void setAdId(long adId)
	{
					this.adId=adId;
	}
  public void setAdName(String adName)
  {
	        this.adName=adName;
	}
	public void setAdCategory(long adCat)
	{
					this.adCat=adCat;
	}
	public void setAdFrequency(int adFrequency)
	{
					this.adFrequency=adFrequency;
	}
	public void setStartDate(String startDate)
	{
					this.startDate=startDate;
	}
	public void setEndDate(String endDate)
	{
					this.endDate=endDate;
	}
	public void setAdMax(int adMax)
	{
					this.adMax=adMax;
	}
	public void setAdSent(int adSent)
	{
					this.adSent=adSent;
	}

	// ********* get values ***
  
	public long getAdId()
	{
					return adId;
	}
	public String getAdName()
	{
					return adName;
	}
	public long getAdCat()
	{
					return adCat;
	}
	public int getAdFrequency()
	{
					return adFrequency;
	}
	public String getStartDate()
	{
					return startDate;
	}
	public String getEndDate()
	{
					return endDate;
	}
	public int getAdMax()
	{
					return adMax;
	}
	public int getAdSent()
	{
					return adSent;
	}
	
	
} //class Advertise


