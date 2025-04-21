using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Security.Cryptography;

namespace GiaThanhSanPhamMay
{
    public class Users
    {
        public Users()
        {
        }

        private string connectionstring = "";
        public string ConnectionString
        {
            set
            {
                connectionstring = value;
            }
        }
        private int errornumber = 0;
        public int ErrorNumber
        {
            get { return errornumber; }
            set { errornumber = value; }
        }

        private string errormessage = "";
        public string ErrorMessage
        {
            get { return errormessage; }
            set { errormessage = value; }
        }

        public Users(string connection)
        {
            if (connection == "")
                errormessage = GiaThanhSanPhamMay.ErrorMessage.NoConnectionString;
            else
                connectionstring = connection;
        }

        /// <summary>
        /// User login authentication to the system
        /// </summary>

        public bool LoginAuthentication(string uid, string pwd)
        {
            SecurityProvider secure = new SecurityProvider();
            string pass = secure.EncryptPass(pwd);
            DataTable table = new DataTable();
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_spLogin";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@uid", "@pwd" };
            pro.ValueCollection = new object[] { uid, pass };
            table = pro.GetDataTable();
            pro.CloseConnection();

            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public string[] getAccountInfomation(string uid)
        {
            string[] tam = new string[1];
            
            try
            {
                SqlServerProvider pro = new SqlServerProvider(connectionstring);
                pro.CommandText = "nd_spSelectUser";
                pro.CommandType = CommandType.StoredProcedure;
                pro.ParameterCollection = new string[] { "@manv" };
                pro.ValueCollection = new object[] { uid };
                string[] value = pro.GetStrings();
                pro.CloseConnection();
                return value;
            }
            catch (Exception ex)
            {
                return tam;
            }
        }
                
        public bool InsertUser(object[] values)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_spInsertUser";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv", "@pwd", "@tennv", "@mapb", "@macn", "@chuky","@kiemtra", "@xemxet", "@pheduyet" };
            pro.ValueCollection = values;
            bool retval = (pro.ExecuteNonQuery() != 0);
            pro.CloseConnection();
            return retval;
        }

        public bool IsExistUser(string MaNV)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_spSelectUser";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv" };
            pro.ValueCollection = new object[] { MaNV };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }
      
        public bool UpdatePassword(string uid, string NewPwd)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            SecurityProvider secure = new SecurityProvider();
            NewPwd = secure.EncryptPass(NewPwd);
            pro.CommandText = "nd_updatepwd";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv", "@pwd" };
            pro.ValueCollection = new object[] { uid, NewPwd };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public bool IsAdmin(string uid)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_sppermission";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv" };
            pro.ValueCollection = new object[] { uid };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public bool IsKiemTra(string MaNV,string flat)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_IsKiemTra";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv","@flat" };
            pro.ValueCollection = new object[] { MaNV,flat };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public bool IsLapPhieu(string MaNV)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_IsLapPhieu";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv"};
            pro.ValueCollection = new object[] { MaNV };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public bool IsCloseDH(string MaNV)
        {
            SqlServerProvider pro = new SqlServerProvider(connectionstring);
            pro.CommandText = "nd_IsQuyenCloseDH";
            pro.CommandType = CommandType.StoredProcedure;
            pro.ParameterCollection = new string[] { "@manv" };
            pro.ValueCollection = new object[] { MaNV };
            DataTable table = new DataTable();
            table = pro.GetDataTable();
            pro.CloseConnection();
            if (table.Rows.Count != 0)
                return true;
            return false;
        }

        public string mahoaS(string input)
        {
            MD5 md5Hasher = MD5.Create();
            //binary

            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x0"));
            }
            return sBuilder.ToString();
        }
    }
}