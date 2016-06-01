package com.telemune.webadmin.webif;
import java.util.*;
public class PrePost
{

				private int rangeid;
				private int starts_at;
				private int  ends_at;
				private String sub_type="";
				public void PrePost ()
				{
								rangeid=0;
								starts_at=0;
								ends_at=0;
								sub_type="";
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
				public void setsub_type(String sub_type)
				{
								this.sub_type = sub_type;
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

				public String getsub_type ()
				{
								return this.sub_type;
				}
}
