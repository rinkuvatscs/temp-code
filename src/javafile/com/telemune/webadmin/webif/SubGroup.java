
/* *** for Subacriber group in MCA */ 
/*@Jatinder Pal */

package com.telemune.webadmin.webif;
public class SubGroup
{
				private String grpName;
				
				private long grpId;
				private String startMsisdn;
				private String endMsisdn;
				
				private String desc;
				private int instantAlert;
				private int periodicAlert;
				private int callAlert;
				private int charging;
			public SubGroup()
			{
              grpId=-1;
							grpName="";
							startMsisdn="";
							endMsisdn="";

							desc="";
							instantAlert=0  ;           //Default  
							periodicAlert = -5;         //Default no
							callAlert = -5;            //Default no
							charging = 1;              //Default yes
			}

	/* set Values  */		
	
	 public void setGrpId(long grpId)
	 {
					 this.grpId = grpId;
	 }
	 public void setGrpName(String grpName)
	 {
					 this.grpName = grpName;
	 }
	 public void setStartMsisdn(String startMsisdn)
	 {
					 this.startMsisdn = startMsisdn;
	 }
	 public void setEndMsisdn(String endMsisdn)
	 {
					 this.endMsisdn = endMsisdn;
	 }

   public void setDesc(String desc)
	 {
					 this.desc=desc;
	 }
	 public void setInstantAlert(int instantAlert)
	 {
					 this.instantAlert = instantAlert;
	 }
	 public void setPeriodicAlert(int periodicAlert)
	 {
					 this.periodicAlert = periodicAlert;
	 }
	 public void setCallAlert(int callAlert)
	 {
					 this.callAlert = callAlert;
	 }
	 public void setCharging(int charging)
	 {
					 this.charging = charging;
	 }
	 /* get Values  */
	 
	 public long getGrpId()
	 {
					 return grpId;
	 }
	 public String getGrpName()
	 {
					 return grpName;
	 }
	 public String getStartMsisdn()
	 {
					 return startMsisdn;
	 }
	 public String getEndMsisdn()
	 {
					 return endMsisdn;
	 }
	 
	 public String getDesc()
	 {
					 return desc;
	 }
	 public int getInstantAlert()
	 {
					 return instantAlert;
	 }
	 public int getPeriodicAlert()
	 {
					 return periodicAlert;
	 }
	 public int getCallAlert()
	 {
					 return callAlert;
	 }
	 public int getCharging()
	 {
					 return charging;
	 }

				

}//SubGroup


