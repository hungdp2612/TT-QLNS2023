 using System;
using System.Data;
 using System.Web;
 using System.Web.Configuration;
using GiaThanhSanPhamMay;


public partial class Controls_Login : System.Web.UI.UserControl
{
    string ConnectDB_wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtuser.Focus();

        if (!IsPostBack)
        {
            fTuDangNhap();
        }
    }

    void fDangNhap(string pass)
    {
        try
        {
            //mycls cls = new mycls();
            string passw = pass;
            string us = txtuser.Text.Trim();

            SqlServerProvider provider = new SqlServerProvider(ConnectDB_wqlvattu);
            DataTable dr = new DataTable();
            //string[] strname = new string[1] { "@MaNV" };
            //string[] strvalue = new string[1] { us };

            //SqlDataReader dr = cls.SP_Read(strname, strvalue, "SP_NVDV");

            try
            {
                //provider.CommandText = "SP_NVDV";
                provider.CommandText = "SP_QLHOSO_Get_MaBP_By_MaNV";
                provider.CommandType = CommandType.StoredProcedure;

                provider.ParameterCollection = new string[] { "@MaNV" };
                provider.ValueCollection = new object[] { us };

                dr = provider.GetDataTable();
            }
            catch
            {
                lblLoi.Text = provider.ErrorMessage;
            }
            finally
            {
                provider.CloseConnection();
            }

            SqlServerProvider provider2 = new SqlServerProvider(ConnectDB_wqlvattu);
            DataTable DrNV = new DataTable();  //SqlDataReader DrNV = cls.SP_Read(strname, strvalue, "SP_ESearchDMNhanVien");
            try
            {
                provider2.CommandText = "SP_ESearchDMNhanVien";
                provider2.CommandType = CommandType.StoredProcedure;

                provider2.ParameterCollection = new string[] { "@MaNV" };
                provider2.ValueCollection = new object[] { us };

                DrNV = provider2.GetDataTable();
            }
            catch
            {
                lblLoi.Text = provider2.ErrorMessage;
            }
            finally
            {
                provider2.CloseConnection();
            }
            
            //string[] strname1 = new string[2] { "@manv", "@pass" };
            //string[] strvalue1 = new string[2] { us, passw };
            //bool kt = cls.SP_KT(strname1, strvalue1, "SP_KTUser");
            
            SqlServerProvider provider3 = new SqlServerProvider(ConnectDB_wqlvattu);

            provider3.CommandText = "SP_KTUser";
            provider3.CommandType = CommandType.StoredProcedure;

            provider3.ParameterCollection = new string[] { "@manv", "@pass" };
            provider3.ValueCollection = new object[] { us, passw };

            int kt = 0;
            DataTable dt = new DataTable();
            
            dt = provider3.GetDataTable(); // 0 : sai , 1 dung

            kt = Convert.ToInt16(dt.Rows[0][0].ToString().Trim());

            if (kt == 1 )
            {
                Session["UserID"] = us;
                
                //while (dr.Read())   //dr da bi close
                //{
                //    Session["KiHieu"] = dr.GetValue(1).ToString();
                //    Session["KH"] = dr.GetValue(2).ToString();
                //}
                
                //while (DrNV.Read())
                //{
                //    Session["Name"] = DrNV.GetValue(1).ToString();
                //}

                Session["KiHieu"] = dr.Rows[0]["kihieu"].ToString().Trim(); //Kihieu
                Session["KH"] = dr.Rows[0]["KihieuBP"].ToString().Trim();   //KihieuBP
                Session["MaBP"] = dr.Rows[0]["MaBP"].ToString().Trim();   //KihieuBP
                Session["MaDV"] = dr.Rows[0]["MaDV"].ToString().Trim();  
                Session["Name"] = DrNV.Rows[0]["Hoten"].ToString().Trim();
              

                //ClassLibrary.Users clsu = new ClassLibrary.Users(connectionString);
                //string[] getttuser = clsu.getAccountInfomation(us); //Lay thong tin nhan vien

                Users user_ = new Users(ConnectDB_wqlvattu);
                string[] getttuser = user_.getAccountInfomation(us); //Lay thong tin nhan vien

                string macn = getttuser[12].ToString();
                string tennvdn = getttuser[1].ToString();
                string emaildn = getttuser[4].ToString();

                Session.Contents.Add("macn", macn);
                Session.Contents.Add("tennv", tennvdn);
                Session.Contents.Add("email", emaildn);
                if (Session["WebID"] == null)
                {
                    Session["WebID"] = "~/sites/TrangChu.aspx";
                }

                #region Ghi nho cookies
                if (cbGhiNho.Checked)
                {
                    HttpCookie ckThaiTuan = new HttpCookie("aefdcgtbfuights");
                    ckThaiTuan["Us"] = us;
                    ckThaiTuan["Pw"] = passw;
                    ckThaiTuan.Expires = DateTime.Now.AddDays(365);
                    Response.Cookies.Add(ckThaiTuan);
                }
                #endregion

                string urlweb = Session["WebID"].ToString();
                Response.Redirect(urlweb);
            }
            else
            {
                lblLoi.Text = "Tên hoặc mật khẩu không đúng";
            }
        }
        catch(Exception ex)
        {
            lblLoi.Text = ex.Message;
        }
    }

    void fTuDangNhap()
    {
        HttpCookie ckThaiTuan = Request.Cookies["aefdcgtbfuights"];
        try
        {
            string passw;
            if (ckThaiTuan != null)
            {
                txtuser.Text = ckThaiTuan["Us"];
                passw = ckThaiTuan["Pw"];
            }
            else
            {
                return;
            }

            fDangNhap(passw);
        }
        catch(Exception ex)
        {

        }
    }

    protected void btnDangnhap_Click(object sender, EventArgs e)
    {
        try
        {
            //mycls cls = new mycls();
            //string passw = cls.mahoaS(txtpassword.Text.Trim());

            Users user_ = new Users(ConnectDB_wqlvattu);
            string passw = user_.mahoaS(txtpassword.Text.Trim());

            fDangNhap(passw);
        }
        catch
        {

        }
    }
}