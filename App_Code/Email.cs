using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Email
/// </summary>
public class Email
{
    private string connectionString = string.Empty;

    static string ConnectDB_QLNS2013 = System.Configuration.ConfigurationManager.AppSettings["ConnectDB_QLNS2013"];

    static string connectionString_local_wqlvattu = System.Configuration.ConfigurationManager.AppSettings["ConnectDB_wqlvattu"];

    public string ConnectionString
    {
        get
        {
            return connectionString;
        }
        set
        {
            connectionString = value;
        }
    }

    private string errorMessage = null;

    public string ErrorMessage
    {
        get
        {
            return errorMessage;
        }
        set
        {
            errorMessage = value;
        }
    }

    private bool exceptionCatch = false;

    public bool ExceptionCatch
    {
        get
        {
            return exceptionCatch;
        }
        set
        {
            exceptionCatch = value;
        }
    }


	public Email()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public Email(string connectionstring_)
	{
		//
		// TODO: Add constructor logic here
		//
        connectionString = connectionstring_;
	}

    public DataTable GetEmailTCKT()
    {
       
        DataTable dt = new DataTable();

        SqlServerProvider provider = new SqlServerProvider(ConnectDB_QLNS2013);

        try
        {
            provider.CommandText = "sp_NhanVienPTCKT_GetEmail";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { };
            provider.ValueCollection = new object[] { };

            dt = provider.GetDataTable();
        }
        catch (SqlException sqlex)
        {
            errorMessage = sqlex.Message;
            exceptionCatch = true;
        }
        finally
        {
            provider.CloseConnection();
        }

        return dt;
    }

    public DataTable GetEmail(string SITE,string donvi)
    {
        //  SP_GETEMAIL_QLNS  //
        DataTable dt = new DataTable();

        SqlServerProvider provider = new SqlServerProvider(ConnectDB_QLNS2013);

        try
        {
            provider.CommandText = "SP_GETEMAIL_QLNS2013";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@SITE", "@MaDV" };
            provider.ValueCollection = new object[] { SITE, donvi };

            dt = provider.GetDataTable();
        }
        catch (SqlException sqlex)
        {
            errorMessage = sqlex.Message;
            exceptionCatch = true;
        }
        finally
        {
            provider.CloseConnection();
        }

        return dt;
    }

    public DataTable GetEmailPheDuyet(string NGUOIXEMXET, string NGUOITIEPNHAN)
    {
        DataTable dt = new DataTable();

        SqlServerProvider provider = new SqlServerProvider(connectionString_local_wqlvattu);

        try
        {
            provider.CommandText = "SP_NL_GETEMAIL_PHEDUYET_QLKHOSOI";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@NGUOIXEMXET", "@NGUOITIEPNHAN" };
            provider.ValueCollection = new object[] { NGUOIXEMXET, NGUOITIEPNHAN };

            dt = provider.GetDataTable();
        }
        catch (SqlException sqlex)
        {
            errorMessage = sqlex.Message;
            exceptionCatch = true;
        }
        finally
        {

            provider.CloseConnection();
        }
        return dt;
    }
}