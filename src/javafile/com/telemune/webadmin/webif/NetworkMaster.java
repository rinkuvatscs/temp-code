/*
 * This class is used for Network Management  config for the admin web interface for WelcomeSMS.
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class NetworkMaster

{
			private long networkId;
			private String networkName;
			private String brandName;
			private int mnc;
			private int mcc;
			private String networkType;
			private int timeZone;
			private String defaultLang;
			private int enableTest;
			private int visitInterval_in;
			private int repInterval_in;
			private int visitInterval_out;
			private int repInterval_out	;
			private int timeMaxMesg;
			private int maxMesgTime;
			private int maxMesgOneTime;
			private String inbound;
			private String outbound;
			private int sleepEnable;
			private int sleepStartHr;
			private int sleepStartMin;
			private int sleepEndHr;
			private int sleepEndMin;

	public NetworkMaster()
	{
					networkId = 0;
					networkName ="";
					brandName ="";
					mnc=-1;
					mcc=-1;
					networkType="";
					timeZone=-1;
					defaultLang="";
					enableTest=-1;
					visitInterval_in=-1;
					repInterval_in=-1;
					visitInterval_out=-1;
					repInterval_out=-1;
					timeMaxMesg=-1;
					maxMesgTime=-1;
					maxMesgOneTime=-1;
					inbound="";
					outbound="";
					sleepEnable=-1;
					sleepStartHr=-1;
					sleepStartMin=-1;
					sleepEndHr=-1;
					sleepEndMin=-1;
	}
					
// ******* set  values  ************* //

	public void setNetworkId(long networkId)
	{
					this.networkId = networkId;
	}
	public void setNetworkName(String networkName)
	{
					this.networkName = networkName;
	}
	public void setBrandName(String brandName)
	{
					this.brandName = brandName;
	}
	public void setMnc(int mnc)
	{
					this.mnc = mnc;
	}
	public void setMcc(int mcc)
	{
					this.mcc = mcc;
	}
	public void setNetworkType(String networkType)
	{
					this.networkType = networkType;
	}
	public void setTimeZone(int timeZone)
	{
				this.timeZone = timeZone;
	}
	public void setDefaultLang(String defaultLang)
	{
					this.defaultLang = defaultLang;
	}
	public void setEnableTest(int enableTest)
	{
					this.enableTest = enableTest;
	}
	public void setVisitInterval_in(int visitInterval_in)
	{
					this.visitInterval_in = visitInterval_in;
	}
	public void setRepInterval_in(int repInterval_in)
	{
					this.repInterval_in = repInterval_in;
	}
	public void setVisitInterval_out(int visitInterval_out)
	{
					this.visitInterval_out = visitInterval_out;
	}
	public void setRepInterval_out(int repInterval_out)
	{
					this.repInterval_out = repInterval_out;
	}
 public void setTimeMaxMesg(int timeMaxMesg)
 {
				 this.timeMaxMesg=timeMaxMesg;
 }
 public void setMaxMesgTime(int maxMesgTime)
 {
				 this.maxMesgTime=maxMesgTime;
 }
 public void setMaxMesgOneTime(int maxMesgOneTime)
 {
				 this.maxMesgOneTime=maxMesgOneTime;
 }
 public void setInbound(String inbound)
 {
				 this.inbound = inbound;
 }
 public void setOutbound(String outbound)
 {
				 this.outbound = outbound;
 }
 public void setSleepEnable(int sleepEnable)
 {
				 this.sleepEnable = sleepEnable;
 }
 public void setSleepStartHr(int sleepStartHr)
 {
				 this.sleepStartHr = sleepStartHr;
 }
 public void setSleepStartMin(int sleepStartMin)
 {
				 this.sleepStartMin = sleepStartMin;
 }
 public void setSleepEndHr(int sleepEndHr)
 {
				 this.sleepEndHr = sleepEndHr;
 }
 public void setSleepEndMin(int sleepEndMin)
 {
				 this.sleepEndMin = sleepEndMin;
 }


// ******* return values  ************* //
 
	public long getNetworkId()
	{
				return  networkId;
	}
	public String  getNetworkName()
	{
					return  networkName;
	}
	public String  getBrandName()
	{
				return   brandName;
	}
	public int  getMnc()
	{
					return mnc ;
	}
	public int  getMcc()
	{
					return mcc ;
	}
	public String getNetworkType()
	{
					return  networkType;
	}
	public int  getTimeZone()
	{
					return   timeZone;
	}
	public String  getDefaultLang()
	{
					return  	 defaultLang;
	}
	public int  getEnableTest()
	{
					return  enableTest;
	}
	public int getVisitInterval_in()
	{
					return  visitInterval_in;
	}
	public int getRepInterval_in()
	{
					return   repInterval_in;
	}
	public int getVisitInterval_out()
	{
					return  visitInterval_out;
	}
	public int getRepInterval_out()
	{
					return   repInterval_out;
	}
 public int getTimeMaxMesg()
 {
				 return timeMaxMesg;
 }
 public int getMaxMesgTime()
 {
				 return  maxMesgTime;
 }
 public int getMaxMesgOneTime()
 {
					return  maxMesgOneTime;
 }
 public String getInbound()
 {
					return  inbound;
 }
 public String  getOutbound()
 {
					return  outbound;
 }
 public int getSleepEnable()
 {
				 return  sleepEnable;
 }
 public int getSleepStartHr()
 {
				 return   sleepStartHr;
 }
 public int getSleepStartMin()
 {
				 return   sleepStartMin;
 }
 public int getSleepEndHr()
 {
				 return  sleepEndHr;
 }
 public int getSleepEndMin()
 {
				 return  sleepEndMin;
 }

				 	

}//NetworkMaster
