package com.telemune.webadmin.webif;

import java.util.*;

public class Statele
{
	private int numrows;
	private int numcols;
  private int counter;
	long[][] arr;
	public Statele(int row, int col)
	{
	 this.counter=0;
	 this.numrows=row;
	 this.numcols=col;
		arr = new long[row][col];
/*		for (int i=0;i<row;i++)
		{
		arr[i]=new long[col];
		}*/
	}
	public void Statele()
	{
	}
	public int setData(int row,int col,long data)
	{
		if (numrows>=row && numcols>=col)
		this.arr[row][col]=data;
		return 0;
	}
	public long getData(int row,int col)
	{
		if (numrows>=row && numcols>=col)
		return (this.arr[row][col]);
	return 0;
	}
	public int getRows()
	{
	return this.numrows;
	}
	public int getCols()
	{
	return this.numcols;
	}
}
