using System;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

namespace Data
{
    public class clsDB
    {
        public void GetData(clsObj Data)
        {
            SqlConnection Cn = new SqlConnection();
            try
            {
                Cn.ConnectionString = Data.Connectionstring;
                Cn.Open();
                try
                {
                    Data.Cm.Connection = Cn;
                  Data.Cm.CommandTimeout=120;
                    SqlDataAdapter Da = new SqlDataAdapter(Data.Cm);
                    Da.Fill(Data.Ds);
                    Da.Fill(Data.Dt);
                }
                catch
                {
                    Data.MaLoi = 2;//Lỗi Command
                }
            }
            catch
            {
                Data.MaLoi = 1;//Lỗi conn String
            }
            finally
            {
                Cn.Close();
            }
        }
        public void NonGetData(clsObj Data)
        {
            SqlConnection Cn = new SqlConnection();
            try
            {
                Cn.ConnectionString = Data.Connectionstring;
                Cn.Open();
                try
                {
                    Data.Cm.Connection = Cn;
                    Data.KetQua = Data.Cm.ExecuteNonQuery();
                }
                catch
                {
                    Data.MaLoi = 2;//Lỗi Command
                }
            }
            catch
            {
                Data.MaLoi = 1;//Lỗi conn String
            }
            finally
            {
                Cn.Close();
            }
        }
        public void AddParameters(clsObj Data)
        {
            for (int i = 0; i < Data.Parameter.Length; i++)
            {
                Data.Cm.Parameters.AddWithValue(Data.Parameter[i], Data.ValueParameter[i]);
            }
        }
        public void AddParametersOutput(clsObj Data)
        {
            for (int i = 0; i < Data.ParameterOutput.Length; i++)
            {
                SqlParameter OutputValue = new SqlParameter(Data.ParameterOutput[i], SqlDbType.VarChar, 50);                
                OutputValue.Direction = ParameterDirection.Output;
                Data.Cm.Parameters.Add(OutputValue);
            }
        }
        public void ReturnValueOutput(clsObj Data)
        {
            for (int i = 0; i < Data.ValueOutput.Length; i++)
            {
                Data.ValueOutput[i] = Data.Cm.Parameters[Data.ParameterOutput[i]].Value.ToString();
            }
        }
    
    }
}
