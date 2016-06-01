/**
 *
 * Created on October 13, 2004, 12:35 PM
 */

package com.telemune.webadmin.webif;

public interface CrbtAdminAppCode {

    public static final int AUTHENTICATED_USER = 10;
    public static final int INVALID_USER = 11;
    public static final int INVALID_PASSWORD = 12;
    public static final int USERID_PASSWORD_MISSING = 13;
    
    public static final int DB_CONNECTION_NULL = 100;
    public static final int SQL_EXCEPTION = 101;
    public static final int PREPARED_STMT_PARAM_ERROR = 102;
    public static final int PREPARED_STMT_PARAM_NULL = 103;
    
    public static final int SESSION_EXPIRED = 110;

    public static final int SESSION_HISTORY_NULL = 120;
    
    public static final int URL_ACCESS_NOT_ALLOWED = 130;
    
    public static final int FORM_PARAMETER_VALUE_NULL = 140;
    public static final int FORM_PARAMETER_VALUE_ERROR = 141;
    
    public static final int MSISDN_INCLUDE_OUT_OF_RANGE = 150;
    public static final int MSISDN_EXCLUDE_IN_RANGE = 151;
    public static final int MSISDN_INVALID = 152;
    
    public static final int UNKNOWN_EXCEPTION = 160;
    
} //class CrbtAdminAppCode
