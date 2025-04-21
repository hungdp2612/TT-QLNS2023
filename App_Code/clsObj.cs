using System;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

namespace Data
{
    public partial class clsObj
    {
        int ketQua = 0;
        public int KetQua
        {
            get { return ketQua; }
            set { ketQua = value; }
        }

        int maLoi = 0;
        public int MaLoi
        {
            get { return maLoi; }
            set { maLoi = value; }
        }

        public string connectionstring;
        public string Connectionstring
        {
            get
            {
                return connectionstring;
            }
            set
            {
                connectionstring = value;
            }
        }

        string cnnString = ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ToString();

        public clsObj(string connection)
        {
            connectionstring = connection;
        }

        public clsObj()
        {
            connectionstring = cnnString;
        }

        //public string CnnString
        //{
        //    get { return cnnString; }
        //    set { cnnString = value; }
        //}

        SqlCommand cm = new SqlCommand();
        public SqlCommand Cm
        {
            get { return cm; }
            set { cm = value; }
        }

        DataSet ds = new DataSet();
        public DataSet Ds
        {
            get { return ds; }
            set { ds = value; }
        }

        DataTable dt = new DataTable();
        public DataTable Dt
        {
            get { return dt; }
            set { dt = value; }
        }

        string spName;
        public string SpName
        {
            get { return spName; }
            set { spName = value; }
        }

        string[] parameter = null;
        public string[] Parameter
        {
            set { parameter = value; }
            get { return parameter; }
        }

        object[] valueParameter;
        public object[] ValueParameter
        {
            set { valueParameter = value; }
            get { return valueParameter; }
        }

        string[] parameterOutput = null;
        public string[] ParameterOutput
        {
            set { parameterOutput = value; }
            get { return parameterOutput; }
        }

        object[] valueOutput;
        public object[] ValueOutput
        {
            set { valueOutput = value; }
            get { return valueOutput; }
        }
        public int SP_Count2(string[] StrName, string[] StrValue, string SPName)
        {
            int count = 0;
            SqlConnection cnn = new SqlConnection(connectionstring);
            SqlCommand mycmd = new SqlCommand();
            mycmd.Connection = cnn;
            mycmd.CommandText = SPName;
            mycmd.CommandType = CommandType.StoredProcedure;
            SqlParameter pt;
            for (int i = 0; i < StrName.Length; i++)
            {
                pt = new SqlParameter();
                pt.ParameterName = StrName[i];
                pt.Value = StrValue[i];
                mycmd.Parameters.Add(pt);
            }
            try
            {
                cnn.Open();
                count = Convert.ToInt32(mycmd.ExecuteScalar());
            }
            catch (Exception)
            {
                // ErrorXml.WriteLogError.WriteLogErrorFile(ex.Message, ex.Source, ex.StackTrace, "D:/QLVATTUFORWEB/Log/" + DateTime.Now.ToString("dd-mm-yyyy-hh-mm-ss") + ".xml");
            }
            finally
            {
                mycmd.Dispose();
                mycmd = null;
                cnn.Dispose();
                cnn.Close();
                cnn = null;
            }
            return count;
        }
    }
}
