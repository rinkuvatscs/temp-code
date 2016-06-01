/* @Jatinder Pal*/ 

package com.telemune.webadmin.webif;

public class BlackList
 {
		private String imsi;
		private String msisdn;
		private String expiryDate;
		private String remark;

	public BlackList()
	{
					imsi="";
					msisdn="";
					expiryDate="";
					remark="";
	}

	//******** set values *** 

  public void setImsi(String imsi)
	{
					this.imsi=imsi;
	}
  public void setMsisdn(String msisdn)
	{
					this.msisdn=msisdn;
	}
  public void setExDate(String expiryDate)
	{
					this.expiryDate=expiryDate;
	}
  public void setRemark(String remark)
	{
					this.remark=remark;
	}

	//******** get values ****

	public String getImsi()
	{
					return imsi;
	}
	public String getMsisdn()
	{
					return msisdn;
	}
	public String getExDate()
	{
					return expiryDate;
	}
	public String getRemark()
	{
					return remark;
	}
	
 }//class BlackList
