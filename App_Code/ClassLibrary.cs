using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

//namespace ClassLibrary
//{
public partial class ClassLibrary
{
        string connectionString = string.Empty;

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

        private bool exeptioncatch = false;
        public bool Exeptioncatch
        {
            get
            {
                return exeptioncatch;
            }
            set
            {
                exeptioncatch = value;
            }
        }

        public ClassLibrary()
        {
        }

        /// <summary>
        /// Constructor, set connection string for this class
        /// </summary>
        /// <param name="strconnection"></param>
        public ClassLibrary(string strconnection)
        {
            connectionString = strconnection;
        }

        /// <summary>
        /// Insert, Update, Delete data using store procedure and return boolean value
        /// </summary>
        /// <param name="storename"></param>
        /// <param name="param"></param>
        /// <param name="values"></param>
        /// <returns></returns>
        
        public bool IUDStore(string storename, string[] param, object[] values)
        {
            bool result = false;
            try
            {
                SqlServerProvider provider = new SqlServerProvider(ConnectionString);
                provider.ConnectionString = connectionString;
                provider.CommandText = storename;
                provider.CommandType = CommandType.StoredProcedure;
                provider.ParameterCollection = param;
                provider.ValueCollection = values;
                result = (provider.ExecuteNonQuery() != 0);
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// Insert, Update, Delete data using store procedure and return boolean value
        /// </summary>
        /// <param name="sqlquery"></param>
        /// <param name="param"></param>
        /// <param name="values"></param>
        /// <returns></returns>
        public bool IUDSQL(string sqlquery)
        {
            bool result = false;
            try
            {
                SqlServerProvider provider = new SqlServerProvider(ConnectionString);
                provider.ConnectionString = connectionString;
                provider.CommandText = sqlquery;
                provider.CommandType = CommandType.Text;
                result = (provider.ExecuteNonQuery() > 0);
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// Get data then fill to datatable using store procedure
        /// </summary>
        /// <param name="storename"></param>
        /// <param name="param"></param>
        /// <param name="values"></param>
        /// <returns></returns>
        public DataTable GetDataStore(string storename, string[] param, object[] values)
        {
            DataTable table = new DataTable();
            SqlServerProvider provider = new SqlServerProvider(ConnectionString);

            try
            {
                provider.ConnectionString = connectionString;
                provider.CommandText = storename;
                provider.CommandType = CommandType.StoredProcedure;
                provider.ParameterCollection = param;
                provider.ValueCollection = values;
                table = provider.GetDataTable();
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
                exeptioncatch = true;
            }
            return table;
        }

        /// <summary>
        /// Get data then fill to datatable using store sql query string
        /// </summary>
        /// <param name="storename"></param>
        /// <param name="param"></param>
        /// <param name="values"></param>
        /// <returns></returns>
        public DataTable GetDataSQL(string sqlquery)
        {
            DataTable table = new DataTable();
            SqlServerProvider provider = new SqlServerProvider(ConnectionString);

            try
            {
                provider.ConnectionString = connectionString;
                provider.CommandText = sqlquery;
                provider.CommandType = CommandType.Text;
                table = provider.GetDataTable();
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }
            return table;
        }

        public string[] GetStringStore(string storename, string[] param, object[] values)
        {
            string[] result = null;
            SqlServerProvider provider = new SqlServerProvider(ConnectionString);

            try
            {
                provider.ConnectionString = connectionString;
                provider.CommandText = storename;
                provider.CommandType = CommandType.StoredProcedure;
                provider.ParameterCollection = param;
                provider.ValueCollection = values;
                result = provider.GetStrings();
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }
            return result;
        }

        public string[] GetStringSQL(string sqlquery)
        {
            string[] result = null;
            SqlServerProvider provider = new SqlServerProvider(ConnectionString);
            try
            {
                provider.ConnectionString = connectionString;
                provider.CommandText = sqlquery;
                provider.CommandType = CommandType.Text;
                result = provider.GetStrings();
                provider.CloseConnection();
            }
            catch (Exception ex)
            {
                errorMessage = ex.Message;
            }
            return result;
        }
        public int SPCount(string sp, string[] para, object[] values)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionString);
            pro.CommandText = sp;
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = para;
            pro.ValueCollection = values;
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
//}
