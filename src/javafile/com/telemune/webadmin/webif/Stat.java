package com.telemune.webadmin.webif;

import java.util.*;

public class Stat
{
	private String date;
	private long column1;
	private long column2;
	private long column3;
	private long column4;
	private long column5;
	private long column6;
	private long column7;
	private long column8;

	public void Stat()
	{
		date = "";
		column1 = 0;
		column2 = 0;
		column3 = 0;
		column4 = 0;
		column5 = 0;
		column6 = 0;
		column7 = 0;
		column8 = 0;
	}
	public void setDate (String date)
	{
		this.date = date;
	}
	public void setColumn1(long column1)
	{
		this.column1 = column1;
	}
	public void setColumn2(long column2)
	{
		this.column2 = column2;
	}
	public void setColumn3(long column3)
	{
		this.column3 = column3;
	}
	public void setColumn4(long column4)
	{
		this.column4 = column4;
	}
	public void setColumn5(long column5)
	{
		this.column5 = column5;
	}
	public void setColumn6(long column6)
	{
		this.column6 = column6;
	}
	public void setColumn7(long column7)
	{
		this.column7 = column7;
	}
	public void setColumn8(long column8)
	{
		this.column8 = column8;
	}
	public String getDate()
	{
		return date;
	}
	public long getColumn1()
	{
		return column1;
	}
	public long getColumn2()
	{
		return column2;
	}
	public long getColumn3()
	{
		return column3;
	}
	public long getColumn4()
	{
		return column4;
	}
	public long getColumn5()
	{
		return column5;
	}
	public long getColumn6()
	{
		return column6;
	}
	public long getColumn7()
	{
		return column7;
	}
	public long getColumn8()
	{
		return column8;
	}
	public long getColumn(int i)
	{
		if (i == 1)
		{
			return column1;
		}
		 if (i == 2)
		{
			return column2;
		}
		else if (i == 3)
		{
			return column3;
		}
		else
		{
			return 0;
		}
	}//getColumn
}//Stat
