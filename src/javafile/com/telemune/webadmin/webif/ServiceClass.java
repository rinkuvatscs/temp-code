package com.telemune.webadmin.webif;
import java.util.*;
public class ServiceClass
{

				private int rangeid;
				private int starts_at;
				private int  ends_at;
				private int rate_plan;
				public void ServiceClass ()
				{
								rangeid=0;
								starts_at=0;
								ends_at=0;
								rate_plan=0;
				}

				/* set Values */	

				public void setRangeId(int rangeid)
				{
								this.rangeid = rangeid;
				}
				public void setStartsAt(int starts_at)
				{
								this.starts_at = starts_at;
				}
				public void setEndsAt(int ends_at)
				{
								this.ends_at = ends_at;
				}
				public void setRatePlan(int rate_plan)
				{
								this.rate_plan = rate_plan;
				}
				/* get Values */	


				public int getRangeId ()
				{
								return this.rangeid;
				}

				public int getStartsAt ()
				{
								return this.starts_at;
				}
				public int getEndsAt ()
				{
								return this.ends_at;
				}

				public int getRatePlan ()
				{
								return this.rate_plan;
				}
}
