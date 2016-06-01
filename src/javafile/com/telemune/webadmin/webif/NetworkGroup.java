/*
 * This class is used for Network Group config for the admin web interface for WelcomeSMS.
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class NetworkGroup
{
		private String name;
		private String desc;
		private String inbound;
		private String outbound;
		private	int waitInterval_In;
		private int repInterval_In;
		private	int waitInterval_Out;
		private int repInterval_Out;
		private int maxMesg_Time;
		private int time_MaxMesg;
		private int oneTime_Mesg;
		
		private int sleep_enable;
		private int sleep_Start_hr;
		private int sleep_Start_min;
		private int sleep_End_hr;
		private int sleep_End_min;
    private long grp_id;
	  	
	public NetworkGroup()
	{
					name="";
					desc="";
					inbound="A";
					outbound="A";
					waitInterval_In=-1;
					waitInterval_Out=-1;
					repInterval_In=-1;
					repInterval_Out=-1;
					maxMesg_Time=-1;
					time_MaxMesg=-1;
					oneTime_Mesg=-1;
					
					sleep_enable= -1;
					sleep_Start_hr=-1;
					sleep_Start_min=-1;
					sleep_End_hr=-1;
					sleep_End_min=-1;
					grp_id = 0;	
	}
	
	public void setNetworkId(long grp_id)
	{
					this.grp_id=grp_id;
	}
	public void setName(String name)
	{
					this.name=name;
	}
	public void setDesc(String desc)
	{
					this.desc=desc;
	}
	public void setInbound(String inbound)
	{
					this.inbound=inbound;
	}
	public void setOutbound(String outbound)
	{
					this.outbound=outbound;
	}
	public void setWaitInterval_In(int waitInterval_In)
	{
					this.waitInterval_In = waitInterval_In;
	}
	public void setWaitInterval_Out(int waitInterval_Out)
	{
					this.waitInterval_Out = waitInterval_Out;
	}
	public void setRepInterval_In(int repInterval_In)
	{
					this.repInterval_In = repInterval_In;
	}
	public void setRepInterval_Out(int repInterval_Out)
	{
					this.repInterval_Out = repInterval_Out;
	}
	public void setMaxMesg_Time(int maxMesg_Time)
	{
					this.maxMesg_Time = maxMesg_Time;
	}
	public void setTime_MaxMesg(int time_MaxMesg)
	{
					this.time_MaxMesg = time_MaxMesg;
	}
	public void setOneTime_Mesg(int oneTime_Mesg)
	{
					this.oneTime_Mesg = oneTime_Mesg;
	}

 public void setSleep(int sleep_enable)
	{
					this.sleep_enable=sleep_enable;
	}
	public void setSleep_Start_hr(int sleep_Start_hr)
	{
				this.sleep_Start_hr = sleep_Start_hr;
	}
	public void setSleep_Start_min(int sleep_Start_min)
	{
				this.sleep_Start_min = sleep_Start_min;
	}
	public void setSleep_End_hr(int sleep_End_hr)
	{
				this.sleep_End_hr = sleep_End_hr;
	}
	public void setSleep_End_min(int sleep_End_min)
	{
				this.sleep_End_min = sleep_End_min;
	}
	
	/* *** get Values*/
	public long getNetworkId()
	{
					return grp_id;
	}
	public String getName()
	{
					return name;
	}
	public String getDesc()
	{
					return desc;
	}
	public String getInbound()
	{
					return inbound;
	}
	public String getOutbound()
	{
					return outbound;
	}
	public int getWaitInterval_In()
	{
					return	waitInterval_In;
	}
	public int getWaitInterval_Out()
	{
					return waitInterval_Out;
	}
	public int getRepInterval_In()
	{
					return repInterval_In;
	}
	public int getRepInterval_Out()
	{
					return repInterval_Out;
	}
	public int getMaxMesg_Time()
	{
					return maxMesg_Time;
	}
	public int getTime_MaxMesg()
	{
					return time_MaxMesg;
	}
	public int getOneTime_Mesg()
	{
					return oneTime_Mesg;
	}
	
	public int getSleep()
	{
					return sleep_enable;
	}
	public int getSleep_Start_hr()
	{
				return sleep_Start_hr;
	}
	public int getSleep_Start_min()
	{
				return  sleep_Start_min;
	}
	public int getSleep_End_hr()
	{
				return sleep_End_hr;
	}
	
	public int getSleep_End_min()
	{
				return sleep_End_min;
	}

	
 } //class NetworkGroup 
