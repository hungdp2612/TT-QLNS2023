using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

public partial class Chuongtrinh_KeHoachNganSach_XemXet : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    clssys clss = new clssys();
    ReportDocument report;
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["MSChiphi"] = String.Empty;
           
            fLoadDonVi();
            LoadNamQui();
            //rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            //rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            TxtNguoiLap.Text = Session["UserID"].ToString();
            LoadNguoiPheDuyetTheoPhongBan();          
            HieuLucXX();
            HieuLucPD();
            Split(DateTime.Now.ToString());
            fLoadThoiGianXemXet();
            LoadCPThucHien();
            fLoadXX();
            FLoadChiTietNS();
            fLoadXemXetByQui();
            FloadButton();
           
           
         }
        if (Session["ReloadKHNS"] != null)
        {           
            Session["ReloadKHNS"] = null;
        }
    }
    void FloadButton()
    {
        if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
        {
            btnReportPCU.Visible = true;
            btnReport.Visible = false;
        }
        else
        {
               btnReportPCU.Visible = false;
               btnReport.Visible = true;
        }
    }
    void fLoadXX()
    {     

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
        Obj.SpName = "sp_KeHoachNganSach_GetHieuLucPD_ByQui";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                cbXemXet.Text = Obj.Dt.Rows[0]["Hieuluc_XX"].ToString();
                cbXemXet.SelectedValue = Obj.Dt.Rows[0]["Hieuluc_XX"].ToString();
            }
            catch { }
        }
    }
    public string ConvertDatedmy(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + "/" + thang + "/" + ngay;
        return strbao;
    }
    public string ConvertDatedmy2(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = ngay + "/" + thang + "/" + nam;
        return strbao;
    }
    void fLoadThoiGianXemXet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnQui.Text, TxtMaDV.Text };
        Obj.SpName = "sp_MacDinhLapNS_XemxetByQui";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                lbThoiGianLapNganSach.Text = "Thời gian xem xét ngân sách quí " + rnQui.Text + " trước ngày:" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Day + "/"+Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Month +"/"+Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Year;

            }
            catch { }
        }
        else
        {
            lbThoiGianLapNganSach.Text = "";
        }
    }
    void fLoadXemXetByQui()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RadGDNganSach.Columns[2].Visible = true;
            RadGDNganSach.Columns[3].Visible = false;
            RadGDNganSach.GroupingEnabled = true;
        }
        else
        {
            RadGDNganSach.Columns[2].Visible = false;
            if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
            {
                RadGDNganSach.Columns[3].Visible = true;
                RadGDNganSach.GroupingEnabled = true;
            }
            else
            {
                RadGDNganSach.Columns[3].Visible = false;
                RadGDNganSach.GroupingEnabled = false;
                RadGDNganSach.AllowFilteringByColumn = false;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
        Obj.SpName = "sp_KeHoachNganSach_LoadXemXet_ByQui";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }
    bool xx;
    public bool HieuLucXX()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
        Obj.SpName = "sp_KeHoachNganSach_GetHieuLucPD_ByQui";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                xx = bool.Parse(Obj.Dt.Rows[0]["Hieuluc_XX"].ToString());
            }
            catch { }
        }
        else
        {

        }
        return xx;
    }
    bool pd;
    public bool HieuLucPD()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
        Obj.SpName = "sp_KeHoachNganSach_GetHieuLucPD_ByQui";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                pd = bool.Parse(Obj.Dt.Rows[0]["Hieuluc_PD"].ToString());
            }
            catch { }
        }
        else
        {

        }
        return pd;
    }
    private void Split(string s)
    {
        string pattern = "/";
        Regex myRegex = new Regex(pattern);
        string[] ketqua = myRegex.Split(s);

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        //Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                txtTenDV.Text = Obj.Dt.Rows[0]["HienThi"].ToString();
                TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            }
            catch { }
        }
        else
        {
            txtTenDV.Text = "Không tìm thấy";
        }

    }
  
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] {  };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }

    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text };
        Obj.Connectionstring = wqlvattu;
        Obj.SpName = "sp_NguoiPheDuye_ByMaDV";
        Sql.fGetData(Obj);

        cbNguoiPheDuyet.DataSource = Obj.Dt;
        cbNguoiPheDuyet.DataBind();
    }
    int SoNgayHienTai()
    {

        string mm, dd;
        if (DateTime.Now.Month < 10)
        {
            mm = "0" + DateTime.Now.Month.ToString();
        }
        else
        {
            mm = DateTime.Now.Month.ToString();
        }


        if (DateTime.Now.Day < 10)
        {
            dd = "0" + DateTime.Now.Day.ToString();
        }
        else
        {
            dd = DateTime.Now.Day.ToString();
        }
        string result = DateTime.Now.Year.ToString() + mm + dd;

       // string result = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString();
        return Convert.ToInt32(result);
    }
    string item1;
    int SoNgayTuDB()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnQui.Text, TxtMaDV.Text };
        Obj.SpName = "sp_MacDinhLapNS_XemxetByQui";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                string mm, dd;
                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                {
                    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }
                else
                {
                    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }


                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                {
                    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }
                else
                {
                    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }

                item1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + mm + dd;

               // item1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                //item1 = ConvertDatedmy(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());
                //item1 = item1.ToString().Replace("/", "");

            }
            catch { }

        }
        else
        {

        }
        return Convert.ToInt32(item1);

    }
    string item3;
    string LayThangCuaQui()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnQui.Text, TxtMaDV.Text };
        Obj.SpName = "sp_KeHoachNganSach_GetHieuLucPD_ByQui";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {

                item3 = Obj.Dt.Rows[0]["Thang"].ToString();

            }
            catch { }

        }
        else
        {

        }
        return item3;

    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbEmail.Text = "";
        string nam = rnNam.Text;
        //string thang = rnThang.Text;
        // string ID_Khoa = nam + thang + "-" + madv;
        string madv = TxtMaDV.Text;
        string nguoilap = Session["UserID"].ToString();
        DateTime ngayxx = DateTime.Now;
      
        if (LayThangCuaQui() == null || LayThangCuaQui() == "")
        {
            lbLoi.Text = "<font color='red'>Ngân sách của quí <b><font color='black'>" + rnQui.Text + "</font></b> chưa được lập nên không thể xem xét.</font>";
        }
        else
        {
            lbLoi.Text = "";

            //if (SoNgayHienTai() >= SoNgayTuDB())
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã hết thời gian xem xét ngân sách của quí.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
            //}
            //else
            //{
            #region Kiểm tra hiệu lực xem xét của giám đốc đơn vị
            if (HieuLucPD() == true)
            {
                lbLoi.Text = "<font color='red'>Quí này đã được phê duyệt, không thể xem xét được nửa</font>";
                fLoadXemXetByQui();
                return;
            }

            #endregion
            if (cbXemXet.SelectedValue == "false")
            {
                #region xem xet theo quí
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Hieuluc_XX", "@NgayXX", "@MaNVDonvi_XX", "@BanTGD_PD" };
                Obj.ValueParameter = new object[] { rnQui.Text, nam, madv, cbXemXet.SelectedValue, Convert.DBNull, Convert.DBNull, Convert.DBNull };
                Obj.SpName = "sp_KeHoachNganSach_XemXet_ByQui";

                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Xem xét kế hoạch ngân sách của quí <b><font color='black'>" + rnQui.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Quí <b><font color='black'>" + rnQui.Text + "</font></b> đã chuyển sang trạng thái chưa xem xét.</font>";
                }
                fLoadXemXetByQui();
                #endregion
            }
            else
            {

                #region xem xet theo quí
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Hieuluc_XX", "@NgayXX", "@MaNVDonvi_XX", "@BanTGD_PD" };
                Obj.ValueParameter = new object[] { rnQui.Text, nam, madv, cbXemXet.SelectedValue, ngayxx, Session["UserID"].ToString(), cbNguoiPheDuyet.SelectedValue };
                Obj.SpName = "sp_KeHoachNganSach_XemXet_ByQui";

                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Xem xét kế hoạch ngân sách của quí <b><font color='black'>" + rnQui.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Xem xét kế hoạch ngân sách của quí <b><font color='black'>" + rnQui.Text + "</font></b> thành công.</font>";
                    SendEmail();
                }
                fLoadXemXetByQui();
                #endregion
            }
            //}
        }

    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {

        //fLoad();
        LoadCPThucHien();
        FLoadChiTietNS();

    }
    string emailthuky;
    void SendEmail()
    {

        lbEmail.Text = "";
        #region Email
        Obj = new clsObj();
        Obj.Connectionstring = wqlvattu;
        Obj.Parameter = new string[] { "@manv" };
        Obj.ValueParameter = new object[] { cbNguoiPheDuyet.SelectedValue };
        Obj.SpName = "Sp_GuiEmailDenBanTGD";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                foreach (DataRow row in Obj.Dt.Rows)
                {
                    emailthuky += row["EMAILTHUKY"].ToString().Trim() + ";";
                }

                // string email = Obj.Dt.Rows[0]["Email"].ToString() + ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                string email = Obj.Dt.Rows[0]["Email"].ToString();

                string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET NGAN SACH QUI " + rnQui.Text + "/" + rnNam.Text;
                string noidung = "";
                noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt kê hoạch ngân sách quí " + rnQui.Text + "/" + rnNam.Text + " cua "+ TxtMaDV.Text + "%0D%0A";
                noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/Kehoachngansach_Pduyet.aspx";
                noidung += "%0D%0ATran Trong ! %0D%0A ";
                noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                noidung += "";
                clssys clss = new clssys();
                noidung = clss.RemoveSign4VietnameseString(noidung);

                hlEmail.NavigateUrl = "mailto:" + email + "&cc=" + emailthuky + "?subject=" + SB + "&body=" + noidung;

                lbEmail.Text = "<font color='blue'>Vui lòng click nút gửi mail.</font>";

                //clss.SendMail(email, cc, SB, noidung);

                //lbLoi.Text = "<font color='red'>Gửi email thành công.</font>";
            }
            catch { }
        }
        else
        {
            lbEmail.Text = "<font color='red'>Gửi email thất bại.</font>";
        }
        #endregion

    }
  
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {

        if (LayThangCuaQui() == null || LayThangCuaQui() == "")
        {
            lbLoi.Text = "<font color='red'>Ngân sách của quí <b><font color='black'>" + rnQui.Text + "</font></b> chưa được lập.</font>";
            FLoadChiTietNS();
        }

        else
        {
            lbLoi.Text = "";
            HieuLucXX();
            HieuLucPD();
            //Obj = new clsObj();
            //Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
            //Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
            //Obj.SpName = "sp_KeHoachNganSach_LoadXemXet_ByQui";
            //Sql.fGetData(Obj);
            //RD.DataSource = Obj.Dt;
            //RD.DataBind();
          

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
            Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Text };
            Obj.SpName = "sp_KeHoachNganSach_GetHieuLucPD_ByQui";
            Sql.fGetData(Obj);

            if (Obj.KetQua < 1)
            {
                try
                {
                    cbXemXet.Text = Obj.Dt.Rows[0]["Hieuluc_XX"].ToString();
                    cbXemXet.SelectedValue = Obj.Dt.Rows[0]["Hieuluc_XX"].ToString();
                }
                catch { }
            }
            fLoadThoiGianXemXet();
            FLoadChiTietNS();
        }     
        
        
    }
    void LoadCPThucHien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@Nam" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text) };
        Obj.SpName = "sp_LoadKeHoachChiPhi_ByMaDV_Nam";
        Sql.fGetData(Obj);
        RD.DataSource = Obj.Dt;
        RD.DataBind();

    }
    #region BUOC1
    protected void RD_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        foreach (GridDataItem item in RD.MasterTableView.Items)
        {
            if (item.Selected)
            {
                Session["MSChiphi"] = item["MSChiphi"].Text.Trim();
            }
        }

        LoadCPThucHien();
    }
    protected void RD_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadCPThucHien();
    }
    protected void RD_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        Session["MSChiphi"] = RD.SelectedValue == null ? "" : RD.SelectedValue;

        FLoadChiTietNS();



    }
    protected void RD_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                FLoadChiTietNS();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LoadCPThucHien();
        }
    }
 
    #endregion
    #region BUOC2
    void FLoadChiTietNS()
    {

        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "SP_KeHoachNS_MaCP";

            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MSChiphi", "@Nam", "@MaDV", "@Qui" };
            provider.ValueCollection = new object[] { Session["MSChiphi"].ToString().Trim(), rnNam.Text, TxtMaDV.Text, rnQui.Text };

            dt = provider.GetDataTable();

        }
        catch (SqlException sqlex)
        {
            lbLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
            RadGDNganSach.DataSource = dt;
            RadGDNganSach.DataBind();
        }
    }
    protected void RadGDNganSach_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        FLoadChiTietNS();
    }
    protected void RadGDNganSach_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        lbLoi.Text = "";
        Session["MSChiphi"] = RD.SelectedValue == null ? "" : RD.SelectedValue;
        FLoadChiTietNS();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        lbLoi.Text = "";
        FLoadChiTietNS();
    }
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadChiTietNS();
        }
    }
    #endregion   
    
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), TxtMaDV.Text, int.Parse(rnQui.Text) };
        //Obj.SpName = "sp_KeHoachNganSach_Execl";
        Obj.SpName = "sp_KeHoachNganSach_Execl2";
        Sql.fGetData(Obj);

        if (rnQui.Value == 1)
        {

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[5].Visible = false;

                ExcelQui1.Columns[6].Visible = false;
                ExcelQui1.Columns[7].Visible = false;

                ExcelQui1.Columns[8].Visible = true;
                ExcelQui1.Columns[9].Visible = true;

            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    ExcelQui1.Columns[5].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[5].Visible = false;
                }
                ExcelQui1.Columns[2].Visible = false;
                ExcelQui1.Columns[1].Visible = false;

                ExcelQui1.Columns[6].Visible = true;
                ExcelQui1.Columns[7].Visible = true;

                ExcelQui1.Columns[8].Visible = false;
                ExcelQui1.Columns[9].Visible = false;
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 2)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[5].Visible = false;

                ExcelQui2.Columns[6].Visible = false;
                ExcelQui2.Columns[7].Visible = false;

                ExcelQui2.Columns[8].Visible = true;
                ExcelQui2.Columns[9].Visible = true;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    
                    ExcelQui2.Columns[5].Visible = true;
                }
                else
                {
                   
                    ExcelQui2.Columns[5].Visible = false;
                }
                ExcelQui2.Columns[2].Visible = false;
                ExcelQui2.Columns[1].Visible = false;


                ExcelQui2.Columns[6].Visible = true;
                ExcelQui2.Columns[7].Visible = true;

                ExcelQui2.Columns[8].Visible = false;
                ExcelQui2.Columns[9].Visible = false;

            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 3)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[5].Visible = false;

                ExcelQui3.Columns[6].Visible = false;
                ExcelQui3.Columns[7].Visible = false;

                ExcelQui3.Columns[8].Visible = true;
                ExcelQui3.Columns[9].Visible = true;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                   
                    ExcelQui3.Columns[5].Visible = true;
                }
                else
                {
                   
                    ExcelQui3.Columns[5].Visible = false;
                }
                ExcelQui3.Columns[2].Visible = false;
                ExcelQui3.Columns[1].Visible = false;

                ExcelQui3.Columns[6].Visible = true;
                ExcelQui3.Columns[7].Visible = true;

                ExcelQui3.Columns[8].Visible = false;
                ExcelQui3.Columns[9].Visible = false;
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 4)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;
               
                ExcelQui4.Columns[6].Visible = false;
                ExcelQui4.Columns[7].Visible = false;

                ExcelQui4.Columns[8].Visible = true ;
                ExcelQui4.Columns[9].Visible = true;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                  
                    ExcelQui4.Columns[5].Visible = true;
                }
                else
                {
                    
                    ExcelQui4.Columns[5].Visible = false;
                }
                ExcelQui4.Columns[2].Visible = false;
                ExcelQui4.Columns[1].Visible = false;

                ExcelQui4.Columns[6].Visible = true;
                ExcelQui4.Columns[7].Visible = true;

                ExcelQui4.Columns[8].Visible = false;
                ExcelQui4.Columns[9].Visible = false;
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui4.MasterTableView.ExportToExcel();
        }

    }
    protected void btnReport_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", TxtMaDV.Text);
        report.SetParameterValue("@Nam",int.Parse(rnNam.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui.Text));       
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void btnReportPCU_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachDonViNhanUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", TxtMaDV.Text);
        report.SetParameterValue("@Nam", int.Parse(rnNam.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui.Text));
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
}