
/*
 * This class is used for MesssageMap Management for the admin web interface for WelcomeSMS.
 *@Jatinder Pal
 *
 * 
 */
package com.telemune.webadmin.webif;

public class MessageMap
{
		
			private long mesg_id;
			private int mesg_type;
			private int event_type;
			private int visit_type;
			private int map_type;
			private long	map_value;
			private String start_date;
			private String end_date;
			private int sub_type;
			private int mesg_order;
			private String delivery_criteria;
			private String delivery_order;

	public MessageMap()
	{
		mesg_id =0 ;				
		mesg_type = -1;				
		event_type = -1;				
		visit_type = -1;				
		map_type = -1;				
		map_value = 0;				
		start_date = "";				
		end_date = "";
		sub_type=-1;				
		mesg_order = -1;				
		delivery_criteria="";
		delivery_order="";
	} //MesssageMap
		
 /* ******** set values ******* */
 
 public void setMesgId(long mesg_id)
 {
				 this.mesg_id = mesg_id;
 }
 public void setMesgType(int mesg_type)
 {
				 this.mesg_type=mesg_type;
 }
 public void setEventType(int event_type)
 {
				 this.event_type=event_type;
 }
 public void setVisitType(int visit_type)
 {
				 this.visit_type=visit_type;
 }
 public void setMapType(int map_type)
 {
				 this.map_type=map_type;
 }
 public void setMapValue(long map_value)
 {
				 this.map_value=map_value;
 }
 public void setStartDate(String start_date)
 {
				 this.start_date  = start_date;
 }
 public void setEndDate(String end_date)
 {
				 this.end_date  = end_date;
 }
 public void setSubType(int sub_type)
 {
				 this.sub_type= sub_type;
 }

 public void setMesgOrder(int mesg_order)
 {
				 this.mesg_order=mesg_order;
 }
 public void setDeliveryCriteria(String delivery_criteria)
 {
				 this.delivery_criteria=delivery_criteria;
 }
 public void setDeliveryOrder(String delivery_order)
 {
				 this.delivery_order=delivery_order;
 }

/* *************** get values ************* */
 
public long getMesgId()
{
				return mesg_id;
}
public int getMesgType()
{
				return mesg_type;
}
public int getEventType()
{
				return event_type;
}
public int getVisitType()
{
				return visit_type;
}
public int getMapType()
{
				return map_type;
}
public long getMapValue()
{
				return map_value;
}
public String getStartDate()
{
				return start_date;
}
public String getEndDate()
{
				return end_date;
}
public int getSubType()
{
				return sub_type;
}
public int getMesgOrder()
{
				return mesg_order;
}
public String getDeliveryCriteria()
{
				return delivery_criteria;
}
public String getDeliveryOrder()
{
				return delivery_order;
}

	
} //class MesssageMap
