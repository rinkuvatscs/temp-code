package com.telemune.webadmin.webif;

import java.sql.*; 
import java.io.*;
import java.util.*; 
import java.lang.Short;
import org.apache.log4j.*;
import java.util.Date;
public class TSSJavaUtil
{
	private static TSSJavaUtil instance_ = null;
	private static String countryCode = "994";
	private static Properties properties = null;
	private static Hashtable  app_params = null;
	private static Hashtable  category_params = null;
	private static Hashtable  rbt_params = null;
	private static ArrayList  categorylist = null;
	//private static String propfilePath="/home/tomcat/apache-tomcat-7.0.30/bin/";
	private static String propfilePath="/home/tomcat/.config/language/";
	private static int multicountry = 0;
	private static ArrayList alMsisdnRange=new ArrayList();
	//private String propfileName="";
	private  static long lTimeMS;
	private static long TimeMS;
	private static Logger logger=Logger.getLogger(TSSJavaUtil.class);
	private static int langCount=3;
	private static Properties[] propFile = null;
	private static Properties defPropFile =null;
	private int defLangId=1;
	


	public synchronized static  TSSJavaUtil instance()
	{
		long fTimeMS = new Date().getTime();
		long calTime=fTimeMS-lTimeMS;
                 logger.debug("curr time ["+fTimeMS+"] old cache time [" + lTimeMS+"] Reload time in msec ["+ TimeMS+"] elapsed time ["+calTime+"]");
		if (instance_ == null)
		{
			instance_ = new TSSJavaUtil();
			lTimeMS = new Date().getTime();
		}

	       else if(calTime>TimeMS)
		{
			instance_ = new TSSJavaUtil();;
			lTimeMS = new Date().getTime();
		}

		return instance_;

	}

	public synchronized static TSSJavaUtil reload()
	{
		logger.info("Reload TSSJavaUtil instance.........");
		instance_ = new TSSJavaUtil();
		return instance_;
	}





	public int getDefaultLang()	
	{
	return defLangId;
	}

	private void setLanguageFile(int index,String lang)
	{
		try
		{
			logger.debug("using language file=" + propfilePath+lang);
			propFile[index] = new Properties();
			FileInputStream fis= new FileInputStream(propfilePath+lang);
			propFile[index].load(fis);
			fis.close();
			logger.debug("+++++++++++=" + propFile[index].getProperty("home1"));
		}
		catch(IOException ioE)
		{
			ioE.printStackTrace();
		}
	}
	//defPropFile
	 private void setDefaultLanguageFile(String lang)
        {
                try
                {
                        logger.debug("Default language file=" + propfilePath+lang);
                        defPropFile = new Properties();
                        FileInputStream fis= new FileInputStream(propfilePath+lang);
                       	defPropFile.load(fis);
                        fis.close();
                        logger.debug("+++++++++++=" + defPropFile.getProperty("home1"));
                }
                catch(IOException ioE)
                {
                        ioE.printStackTrace();
                }
        }


	private TSSJavaUtil()
	{        
		Connection con=null;
		Statement stmt=null;
		ResultSet rs = null;
		String driver =  "oracle.jdbc.driver.OracleDriver";
		properties = new Properties();
		try
		{
			FileInputStream fis1 = new FileInputStream("/home/tomcat/.config/property/telemune_webadmin.properties");																						properties.load(fis1);
			fis1.close();

		}
		catch(IOException e)
		{
			e.printStackTrace();
			return;
		}

		String strUser = properties.getProperty("USER");
		String strPass = properties.getProperty("PASS");
		String strUrl = properties.getProperty("URL");
		driver = properties.getProperty("DRIVER");
		multicountry = Integer.parseInt(properties.getProperty("MULTI.COUNTRY"));
		TimeMS=Integer.parseInt(properties.getProperty("CACHE_RELOAD_MILSEC"));
		langCount=Integer.parseInt(properties.getProperty("LANGUAGE_COUNT"));
		
		propFile=new Properties[langCount];
	
		for(int x=0;x<langCount;x++)
		{
		//propFile[x]=new Properties();
		setLanguageFile(x,properties.getProperty("LANGUAGE_FILE"+x));
		 logger.debug("LANGUAGE_FILE"+x+"   -->"+properties.getProperty("LANGUAGE_FILE"+x));
		}
		defLangId=Integer.parseInt(properties.getProperty("DEFAULT_LANGUAGE_ID"));
		setDefaultLanguageFile(properties.getProperty("LANGUAGE_FILE"+defLangId));
		logger.debug("langCount [" +langCount+"]  Default Id ["+defLangId+"]");			

		try
		{
			// Load database driver if not already loaded
			Class.forName(driver);
			// Establish network connection to database
			con = DriverManager.getConnection(strUrl,strUser,strPass);
		}
		catch(ClassNotFoundException cnfe)
		{
			// Simplify try/catch blocks of people using this by
			// throwing only one exception type.
			logger.error("Can t find class for driver: " + driver);
			return;
		}
		catch(SQLException ex)
		{
			ex.printStackTrace();
			logger.error("SQLException");
			return;
		}
		try
		{
			stmt = con.createStatement();
			String query = "select PARAM_TAG, PARAM_VALUE from CRBT_APP_CONFIG_PARAMS"; 
			rs = stmt.executeQuery(query);
			app_params = new Hashtable();
			while (rs.next())
			{
				app_params.put((rs.getString("PARAM_TAG")).toUpperCase(), rs.getString("PARAM_VALUE"));
			}
			rs.close();
			stmt.close();
			if(multicountry==1)
			{
				stmt = con.createStatement();
				query = "select STARTS_AT,ENDS_AT,COUNTRY_CODE from operator_subscriber";
				logger.info(query);
				rs = stmt.executeQuery(query);
				int ccode=-1;
				while (rs.next())
				{
					MsisdnVal msval=new MsisdnVal();
					msval.st_msisdn=rs.getString("STARTS_AT");
					msval.ed_msisdn=rs.getString("ENDS_AT");
					ccode=rs.getInt("COUNTRY_CODE");
					msval.countrycode=Integer.toString(ccode);
					alMsisdnRange.add(msval);
					logger.info("Country Code: " + ccode);
				}
				rs.close();
				stmt.close();
			}


			//////***************collect CATEGORYS ************/////////
			stmt = con.createStatement();
			//      query = "select a.cat_id, a.masked_name from CRBT_CATEGORY_MASTER a, CRBT_CATEGORY_ORDERING bwhere a.cat_id = b.cat_id order by b.position";
			query = "select cat_id, masked_name from CRBT_CATEGORY_MASTER";
			rs = stmt.executeQuery(query);
			category_params = new Hashtable();
			while (rs.next())
			{
				category_params.put((rs.getString("CAT_ID")).toUpperCase(), rs.getString("MASKED_NAME"));
			}

			stmt.close();
			rs.close();


			/////////******************* collect RBT name ***********/
			stmt = con.createStatement();
			query = "select rbt_code, masked_name from CRBT_RBT";
			rs = stmt.executeQuery(query);

			rbt_params = new Hashtable();
			while (rs.next())
			{
				rbt_params.put((rs.getString("RBT_CODE")).toUpperCase(), rs.getString("MASKED_NAME"));
			}

			stmt.close();
			rs.close();

			//////***************collect CATEGORYS with ordering ************/////////

		}
		catch (SQLException exp)
		{
			exp.printStackTrace();
		}

		countryCode = app_params.get("LOCAL_COUNTRY").toString();        

		try
		{
			if(rs != null) rs.close();
			stmt.close();
			con.close();
		}
		catch (Exception exp)
		{
			exp.printStackTrace();
		}
	}

	/**
	 *
	 * This function takes 1 parameters 
	 * @param 1 Parameter whose value is tobe returned. Possible type(crbt_recorded_category_id)
	 * @return value of the parameter from crbt_app_config_params
	 **/
	public String getInternationalNumber(String number)
	{
		String retVal="";
		if(multicountry==1)
		{
			boolean a=true;
			if(number.startsWith("00"))
			{
				number = number.substring(2);
			}
			if(number.startsWith("0") || number.startsWith("+"))
			{
				//remove the zero and add countryCode
				number = number.substring(1);
			}
			for(int k = 0; k < alMsisdnRange.size(); k++)
			{
				MsisdnVal msvals=(MsisdnVal) alMsisdnRange.get(k);
				if(Double.parseDouble(number)>Double.parseDouble(msvals.getstmsisdn()) && Double.parseDouble(number)<Double.parseDouble(msvals.getedmsisdn()))
				{
					if(number.startsWith(msvals.getcountrycode()))
					{
						retVal=number;
						a=false;
					}
					else
					{
						retVal=msvals.getcountrycode()+number;
						a=false;
					}

					break;
				}

			}
			if(a)
			{
				retVal=number;
			}

		}
		else
		{
			if(number.startsWith("00") || number.startsWith(countryCode))
			{
				retVal = number;
			}
			else if(number.startsWith("0"))
			{
				//remove the zero and add countryCode
				//remove the zero and add countryCode
				retVal = countryCode + number.substring(1);
			}
			else
			{
				retVal = countryCode + number;
			}
		}
		return retVal;
	}

	public String getAppConfigParam(String paramName)
	{
		String retVal = "";
		String param = paramName.toUpperCase();
		retVal = (String) app_params.get(param);
		return retVal;
	}


	/**
	 *
	 * This function takes 1 parameters 
	 * @param 1 number to be formated. possible type(9818899000, 09818899000.919818899000)
	 * @return 9818899000 will be 919818899000, 09818899000 will be 919818899000, and 91981....no change
	 **/

	public String getCategoryName(String paramName)
	{
		String retVal = "";
		String param = paramName.toUpperCase();
		retVal = (String) category_params.get(param);
		return retVal;
	}

	public String getRbtName(String paramName)
	{
		String retVal = "";
		String param = paramName.toUpperCase();
		retVal = (String) rbt_params.get(param);
		return retVal;
	}

	public String getNationalNumber(String number)
	{
		String retVal="";
		if(number.startsWith("00") || number.startsWith(countryCode))
		{
			retVal = number.substring(2);
		}
		else if(number.startsWith("0"))
		{
			retVal = number.substring(1);
		}
		else
		{
			retVal = number;
		}            
		return retVal;
	}

	public int isChargingEnabled()
	{
		try
		{      
			int i = Integer.parseInt(properties.getProperty("DOCHARGING"));
			return i;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return -1;
		}
	}

	public String getSSFServer()
	{	
		try
		{
			String strSSFServer = properties.getProperty("SSF_SERVER_HOST");
			return strSSFServer;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return "";
		}
	}

	public short getSSFPort()
	{
		try
		{ 
			short shSSFPort = Short.parseShort(properties.getProperty("SSF_SERVER_PORT"));
			return shSSFPort;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return -1;
		}
	}
	public String getKeyValue(String key)
	{
		return defPropFile.getProperty(key);
	}
	
	public String getKeyValue(String key,int langId)
        {
		return propFile[langId].getProperty(key);
        }

	public int getTotalServer()
	{
		int server=Integer.parseInt(properties.getProperty("SERVER.COUNT"));
		return server;
	}
	public String getMrtgPath()
	{
		return properties.getProperty("MRTG_URL");
	}
	public String getServerName(String Server)
	{
		return properties.getProperty(Server);
	}
}
