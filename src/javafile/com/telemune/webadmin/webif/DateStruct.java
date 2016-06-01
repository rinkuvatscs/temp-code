package com.telemune.webadmin.webif;
import java.sql.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Iterator;
import com.telemune.dbutilities.*;
public class DateStruct
{
    int dd;
    int mm;
    int yy;
    int hh;
    int mi;
    public void DateStruct ()
    {
        dd=0;
        mm=0;
        yy=0;
        hh=0;
        mi=0;
    }
    public void DateStruct (int dd, int mm, int yy, int hh, int mi)
    {
        this.dd=dd;
        this.mm=mm;
        this.yy=yy;
        this.hh=hh;
        this.mi=mi;
    }
    public void DateStruct (int dd, int mm, int yy)
    {
        this.dd=dd;
        this.mm=mm;
        this.yy=yy;
        this.hh=0;
        this.mi=0;
    }
}
