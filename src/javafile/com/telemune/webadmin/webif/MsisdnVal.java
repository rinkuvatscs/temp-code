package com.telemune.webadmin.webif;

import java.sql.*;
import java.io.*;
import java.util.*;
import java.lang.Short;


class MsisdnVal
{

				public String countrycode;
				public String st_msisdn;
				public String ed_msisdn;
				public int port;
				public String getstmsisdn()
				{
								return st_msisdn;
				}
				public String getedmsisdn()
				{
								return ed_msisdn;
				}
				public String getcountrycode()
				{
								return countrycode;
				}
				public int getport()
				{
								return port;
				}
}

