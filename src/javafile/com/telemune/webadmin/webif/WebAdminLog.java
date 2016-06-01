package com.telemune.webadmin.webif;
import java.util.*;
public class WebAdminLog
{

				private String table_name;
				private String table_Col;
				private String current_value;
				private String previous_value;
				private String link_modify;
				private String update_by;
				private String indicator_value;
				private String Date_value;

								public void RbtRatePlan ()
								{
												table_name = "";
												table_Col="";
												current_value="";
												previous_value="";
												link_modify="";
												update_by="";
												indicator_value="";
								}

				/* set Values */	
				public void setTableName (String table)
				{
								this.table_name = table.trim().toUpperCase();
				}
				public void setColName (String table_col)
				{
								this.table_Col= table_col.trim().toUpperCase();
				}
				public void setCurrentvalue(String value)
				{
								this.current_value= value;
				}
				public void setPreviousvalue(String value)
				{
								this.previous_value = value;
				}
				public void setlink(String link)
				{
								this.link_modify=link;
				}
				public void setuser(String user)
				{
								this.update_by = user;
				}
				public void setIndicator(String indi)
				{
								this.indicator_value= indi;
				}
				public void setDate (String value)
				{
								this.Date_value = value;
				}
				/* get Values */	

				public String getTableName ()
				{
								return this.table_name;
				}
				public String getColName ()
				{
								return this.table_Col;
				}
				public String getCurrentvalue()
				{
								return this.current_value;
				}
				public String getPreviousvalue()
				{
								return this.previous_value;
				}
				public String getlink()
				{
								return this.link_modify;
				}
				public String getuser()
				{
								return this.update_by;
				}
				public String getIndicator()
				{
							return	this.indicator_value;
				}
				public String getDate ()
				{
								return this.Date_value;
				}

}
