using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

public partial class Chuongtrinh_Kehoachngansach_Pduyet_PTGDSX : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
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
            LoadNam();
            LoadDVPheDuyet();

            LoadCPThucHien();
            LoadNganSach();
            LOAD_RadGDNganSach();

            #region Ẩn hiện Nut phe duyet va Email
            HieuLucPD();
            if (pd == true)
            {
                btLuu.Visible = false;
                hlEmail.Visible = false;
            }
            else
            {
                btLuu.Visible = true;
                hlEmail.Visible = true;
            }
            #endregion


            #region xem ngân sach



            LoadNamQui();
            LoadDVCanXem();
            FLoadButtonDonVi();
            FLoadXemNS();


            #endregion

            #region Hiệu chỉnh ns

            LoadNamCanHieuChinh();
            LoadDVCanHieuChinh();
            FLoadHieuChinhNS();
            #endregion
        }
    }

    #region Phê duyệt ngân sách


    string item3;
    string LayThangCuaQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, rnQui.Text, CboMaDV.SelectedValue, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_LayThangCuaQui";
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
    string item4;
    int DemChiTietNganSach()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.Text, CboMaDV.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_ChiTietKeHoachNganSach_Load";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item4 = Obj.Dt.Rows[0]["DemChiTietNganSach"].ToString();

            }
            catch { }
        }
        else
        {

        }
        return Convert.ToInt32(item4);
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {

            if (LayThangCuaQui() == null || LayThangCuaQui() == "")
            {
                lbLoi.Text = "<font color='red'>Ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> chưa được lập hoặc chưa xem xét nên không thể phê duyệt.</font>";
            }
            else
            {
                if (DemChiTietNganSach() == 0)
                {
                    lbLoi.Text = "<font color='red'>Ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> chưa có chi tiết nên không thể phê duyệt.</font>";
                }
                else
                {

                    if (RadCBoPD.SelectedValue == "False")
                    {
                        lbLoi.Text = "";

                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
                        Obj.ValueParameter = new object[] { rnQui.Text, CboNam.SelectedValue, CboMaDV.SelectedValue, Convert.DBNull, RadCBoPD.SelectedValue };
                        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
                        Sql.fNonGetData(Obj);
                        if (Obj.KetQua < 1)
                        {
                            lbLoi.Text = "<font color='red'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='blue'>Kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> đã chuyển sang trạng thái chưa phê duyệt.</font>";
                            //LoadDVPheDuyet();
                            LoadCPThucHien();
                            LoadNganSach();
                            LOAD_RadGDNganSach();
                            FLoadXemNS();
                            FLoadHieuChinhNS();
                        }

                    }
                    else
                    {

                        lbLoi.Text = "";

                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
                        Obj.ValueParameter = new object[] { rnQui.Text, CboNam.SelectedValue, CboMaDV.SelectedValue, DateTime.Now, RadCBoPD.SelectedValue };
                        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
                        Sql.fNonGetData(Obj);
                        if (Obj.KetQua < 1)
                        {
                            lbLoi.Text = "<font color='red'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='blue'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thành công.</font>";
                            SendEmail();
                            LoadDVPheDuyet();
                            LoadCPThucHien();
                            LoadNganSach();
                            LOAD_RadGDNganSach();
                            FLoadXemNS();
                            FLoadHieuChinhNS();
                            //Session["MaDV_Nam_Qui"] = CboMaDV.SelectedValue.Trim();
                            //GET_EMAIL();
                        }

                    }

                }
            }


        }
    }
    bool pd;
    bool HieuLucPD()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV" };
        Obj.ValueParameter = new object[] { rnQui.Text, CboNam.SelectedValue, CboMaDV.SelectedValue };
        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_GetHieuLucPD_ByQui";
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
    #region GET_EMAIL
    public void GET_EMAIL()
    {
        string Address = "";
        string CC = "";
        string Sub = "";
        string Body = "";

        try
        {
            DataTable dt = new DataTable();
            string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];

            Email mail_ = new Email();

            DataTable dtThongtinphieu = new DataTable();

            dt = mail_.GetEmail(site, CboMaDV.SelectedValue);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {

                    if (row["ToCC"].ToString().Trim() == "TO")
                    {
                        Address += row["Email"].ToString().Trim() + ";";
                    }
                    else if (row["ToCC"].ToString().Trim() == "CC")
                    {
                        CC += row["Email"].ToString().Trim() + ";";
                    }
                }
            }

            Sub += "Đã duyệt ngân sách : " + CboMaDV.SelectedValue.Trim();

            Body += "Tôi đã duyệt ngân sách của đơn vị " + CboMaDV.SelectedValue.Trim() + " quí " + rnQui.Text + "/" + CboNam.SelectedValue;

            Body += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();

            clssys clss = new clssys();
            txtAddress.Text = Address;
            txtCC.Text = CC;
            txtSub.Text = Sub;
            txtBody.Text = Body;
            clss.SendMail(Address, CC, Sub, Body);
        }
        catch (Exception ex)
        {
            lbLoi.Text = ex.Message;
            return;
        }
    }
    #endregion
    void LoadNam()
    {
        ClassLibrary lib = new ClassLibrary(ConnectionString);
        DataTable dt = lib.GetDataStore("SP_Nam_BYLOAD", new string[] { },
                    new object[] { });
        CboNam.DataSource = dt;
        CboNam.DataBind();
        CboNam.SelectedIndex = 0;
        rnQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;
    }
    void LoadDVPheDuyet()
    {
        Obj = new clsObj();

        Obj.Parameter = new string[] { "@Nam", "@BanTGD_PD", "@QUI" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, Session["UserID"].ToString(), rnQui.Text };
        Obj.SpName = "SP_NSMADV_PD_BYLOAD";

        //Obj.Parameter = new string[] { "@Nam", "@QUI" };
        //Obj.ValueParameter = new object[] { CboNam.SelectedValue, rnQui.Text };
        //Obj.SpName = "SP_NSMADV_PD_BYLOAD_Test";


        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        if (CboMaDV.SelectedIndex == -1)
        {
            CboMaDV.Text = "";
        }
    }
    void LoadCPThucHien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, int.Parse(CboNam.SelectedValue)};
        Obj.SpName = "sp_LoadKeHoachChiPhi_ByMaDV_Nam";
        Sql.fGetData(Obj);
        RadGDKHCP.DataSource = Obj.Dt;
        RadGDKHCP.DataBind();

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV" };
        //Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
        //Obj.SpName = "SP_LoadKHCP";
        //Sql.fGetData(Obj);
        //RadGDKHCP.DataSource = Obj.Dt;
        //RadGDKHCP.DataBind();

    }
    void LoadNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, CboNam.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_HieuLucPD";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                RadCBoPD.SelectedValue = Obj.Dt.Rows[0]["Hieuluc_PD"].ToString();
            }
            catch { }
        }

        if (CboMaDV.SelectedValue == "KDND")
        {
            RadGDNganSach.Columns[3].Visible = true;
            RadGDNganSach.Columns[4].Visible = false;
            RadGDNganSach.GroupingEnabled = true;
            RadGDNganSach.AllowFilteringByColumn = true;
        }
        else
        {
            RadGDNganSach.Columns[3].Visible = false;
            if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
            {
                RadGDNganSach.Columns[4].Visible = true;
                RadGDNganSach.GroupingEnabled = true;
                RadGDNganSach.AllowFilteringByColumn = true;
            }
            else
            {
                RadGDNganSach.Columns[4].Visible = false;
                RadGDNganSach.GroupingEnabled = false;
                RadGDNganSach.AllowFilteringByColumn = false;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, CboNam.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }

    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        LoadCPThucHien();
        LoadNganSach();
        LOAD_RadGDNganSach();
        #region Ẩn hiện Nut phe duyet va Email
        HieuLucPD();
        if (pd == true)
        {
            btLuu.Visible = false;
            hlEmail.Visible = false;
        }
        else
        {
            btLuu.Visible = true;
            hlEmail.Visible = true;
        }
        #endregion
    }
    string email;
    void SendEmail()
    {

        if (HieuLucPD() == false)
        {
            lbLoi.Text = "<font color='red'>Chưa phê duyệt nên không gửi được email.</font>";
        }
        else
        {

            lbEmail.Text = "";
            #region Email
            Obj = new clsObj();

            Obj.Parameter = new string[] { "@MaDv" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.Connectionstring = wqlvattu;
            Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                try
                {
                    foreach (DataRow row in Obj.Dt.Rows)
                    {
                        email += row["EmailXX"].ToString().Trim() + ";";
                    }

                    // string email = Obj.Dt.Rows[0]["EmailXX"].ToString() + ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string SB = "BAN TONG GIAM DOC PHE DUYET KE HOACH NGAN SACH QUI " + rnQui.Text + "/" + CboNam.Text;
                    string noidung = "";
                    //noidung += "Kính gửi Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                    noidung += "Ban Tổng giám đốc đã phê duyệt kế hoạch ngân sách quí " + rnQui.Text + "/" + CboNam.Text + "%0D%0A";
                    //noidung += "%0D%0ATran Trong ! %0D%0A ";
                    noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                    noidung += "";
                    clssys clss = new clssys();
                    noidung = clss.RemoveSign4VietnameseString(noidung);

                    hlEmail.NavigateUrl = "mailto:" + email + "&cc=" + cc + "?subject=" + SB + "&body=" + noidung;

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
    }
    protected void btEmail_Click(object sender, ImageClickEventArgs e)
    {
        if (HieuLucPD() == false)
        {
            lbLoi.Text = "<font color='red'>Chưa phê duyệt nên không gửi được email.</font>";
        }
        else
        {

            lbLoi.Text = "";
            #region Email
            Obj = new clsObj();

            Obj.Parameter = new string[] { "@MaDv" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.Connectionstring = wqlvattu;
            Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                try
                {

                    string email = Obj.Dt.Rows[0]["EmailXX"].ToString() + ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string cc = Obj.Dt.Rows[0]["EmailPD"].ToString();

                    string SB = "BAN TONG GIAM DOC PHE DUYET KE HOACH NGAN SACH QUI " + rnQui.Text + "/" + CboNam.Text;
                    string noidung = "";
                    //noidung += "Kính gửi Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                    noidung += "Ban Tổng giám đốc đã phê duyệt kế hoạch ngân sách quí " + rnQui.Text + "/" + CboNam.Text + "%0D%0A";
                    //noidung += "%0D%0ATran Trong ! %0D%0A ";
                    noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                    noidung += "";
                    clssys clss = new clssys();
                    noidung = clss.RemoveSign4VietnameseString(noidung);

                    clss.SendMail(email, cc, SB, noidung);

                    lbLoi.Text = "<font color='red'>Gửi email thành công.</font>";
                }
                catch { }
            }
            else
            {
                lbLoi.Text = "<font color='red'>Gửi email thất bại.</font>";
            }
            #endregion
        }
    }
    protected void CboNam_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rnQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;

    }
    #region BUOC1
    protected void RadGDKHCP_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        foreach (GridDataItem item in RadGDKHCP.MasterTableView.Items)
        {
            if (item.Selected)
            {
                Session["MSChiphi"] = item["MSChiphi"].Text.Trim();
            }
        }

        LoadCPThucHien();
    }
    protected void RadGDKHCP_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadCPThucHien();
    }
    protected void RadGDKHCP_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                LOAD_RadGDNganSach();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LoadCPThucHien();
        }
    }
    #endregion
    #region BUOC2
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "SP_LoadNS_MaCP";

            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MSChiphi", "@Nam", "@Qui", "@MaDV" };
            provider.ValueCollection = new object[] { Session["MSChiphi"].ToString().Trim(), CboNam.SelectedValue, rnQui.Text, CboMaDV.SelectedValue };

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
        LOAD_RadGDNganSach();
    }
    protected void RadGDKHCP_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
        LOAD_RadGDNganSach();
    }
    protected void RadGDNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
        LOAD_RadGDNganSach();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LOAD_RadGDNganSach();
    }
    #endregion
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LOAD_RadGDNganSach();
        }
    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {

        LoadDVPheDuyet();
        LoadCPThucHien();
        LoadNganSach();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(CboNam.Text), CboMaDV.SelectedValue, int.Parse(rnQui.Text) };
        Obj.SpName = "sp_KeHoachNganSach_Execl";
        Sql.fGetData(Obj);

        if (rnQui.Value == 1)
        {

            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {
                    ExcelQui1.Columns[5].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[5].Visible = false;
                }
                ExcelQui1.Columns[2].Visible = false;
                ExcelQui1.Columns[1].Visible = false;
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value +"_"+ CboMaDV.SelectedValue;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 2)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui2.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[5].Visible = false;
                }
                ExcelQui2.Columns[2].Visible = false;
                ExcelQui2.Columns[1].Visible = false;
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 3)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui3.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[5].Visible = false;
                }
                ExcelQui3.Columns[2].Visible = false;
                ExcelQui3.Columns[1].Visible = false;
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 4)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui4.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[5].Visible = false;
                }
                ExcelQui4.Columns[2].Visible = false;
                ExcelQui4.Columns[1].Visible = false;
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui4.MasterTableView.ExportToExcel();
        }


    }

    #endregion

    #region Xem ngân sach
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }   

    void LoadDVCanXem()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@QUI", "@MaNV" };
        Obj.ValueParameter = new object[] { rnNam_Xem.Text, rnQui_Xem.Text, Session["UserID"].ToString() };          
        Obj.SpName = "sp_PheDuyet_LoadDonVi_XemNS";
        Sql.fGetData(Obj);
        CboMaDV_XemNS.DataSource = Obj.Dt;
        CboMaDV_XemNS.DataBind();
        CboMaDV_XemNS.SelectedIndex = 0;

    }

    void FLoadXemNS()
    {
        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            RG_XemNS.Columns[5].Visible = true;
        }
        else
        {
            RG_XemNS.Columns[5].Visible = false;
        }

        Obj = new clsObj();
       

        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV_XemNS.SelectedValue, rnNam_Xem.Text, rnQui_Xem.Text };
        Obj.SpName = "sp_PheDuyet_XemNganSach";
        Sql.fGetData(Obj);
        RG_XemNS.DataSource = Obj.Dt;
        RG_XemNS.DataBind();
    }
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        FLoadXemNS();
    }

    protected void btnExcelXem_Click(object sender, ImageClickEventArgs e)
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), CboMaDV_XemNS.SelectedValue, int.Parse(rnQui_Xem.Text) };
        Obj.SpName = "sp_KeHoachNganSach_Execl2";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {

            if (CboMaDV_XemNS.SelectedValue == "KDND")
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
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
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
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 2)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
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
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
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
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 3)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
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
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
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
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 4)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;

                ExcelQui4.Columns[6].Visible = false;
                ExcelQui4.Columns[7].Visible = false;

                ExcelQui4.Columns[8].Visible = true;
                ExcelQui4.Columns[9].Visible = true;
            }
            else
            {
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
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
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui4.MasterTableView.ExportToExcel();
        }

    }
    protected void rnQui_Xem_TextChanged(object sender, EventArgs e)
    {
        LoadDVCanXem();
        FLoadXemNS();
    }
    protected void rnNam_Xem_TextChanged(object sender, EventArgs e)
    {
        CboMaDV_XemNS.Text = "";
        LoadDVCanXem();
        FLoadXemNS();
    }
    void FLoadButtonDonVi()
    {
        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            btnNSUyQuyenCacDV.Visible = false;
            btnNSUyQuyen.Visible = true;
        }
        else
        {
            btnNSUyQuyenCacDV.Visible = true;
            btnNSUyQuyen.Visible = false;
        }
    }
    protected void btnNSUyQuyen_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachDonViNhanUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", CboMaDV_XemNS.SelectedValue);
        report.SetParameterValue("@Nam", int.Parse(rnNam_Xem.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui_Xem.Text));
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void btnNSUyQuyenCacDV_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", CboMaDV_XemNS.SelectedValue);
        report.SetParameterValue("@Nam", int.Parse(rnNam_Xem.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui_Xem.Text));
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void CboMaDV_XemNS_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            btnNSUyQuyenCacDV.Visible = false;
            btnNSUyQuyen.Visible = true;
        }
        else
        {
            btnNSUyQuyenCacDV.Visible = true;
            btnNSUyQuyen.Visible = false;
        }
    }

    #endregion

    #region Hiệu chỉnh ngân sách
    void LoadNamCanHieuChinh()
    {
        ClassLibrary lib = new ClassLibrary(ConnectionString);
        DataTable dt = lib.GetDataStore("sp_PheDuyet_LoadNamXemNS", new string[] { },
                    new object[] { });
        cboNam_HieuChinh.DataSource = dt;
        cboNam_HieuChinh.DataBind();
        cboNam_HieuChinh.SelectedIndex = 0;
        rnQui_HieuChinh.Text = (cboNam_HieuChinh.SelectedItem.FindControl("hfQui_HieuChinh") as HiddenField).Value;
    }

    void LoadDVCanHieuChinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@QUI", "@MaNV" };
        Obj.ValueParameter = new object[] { cboNam_HieuChinh.SelectedValue, rnQui_HieuChinh.Text, Session["UserID"].ToString() };
     
        Obj.SpName = "sp_PheDuyet_LoadDonVi_XemNS";
        Sql.fGetData(Obj);
        CboMaDV_HieuChinh.DataSource = Obj.Dt;
        CboMaDV_HieuChinh.DataBind();
        CboMaDV_HieuChinh.SelectedIndex = 0;

    }

    void FLoadHieuChinhNS()
    {
        if (CboMaDV_HieuChinh.SelectedValue == "P.CU" || CboMaDV_HieuChinh.SelectedValue == "P.HCQT")
        {
            RG_HieuChinh.Columns[7].Visible = true;
        }
        else
        {
            RG_HieuChinh.Columns[7].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV_HieuChinh.SelectedValue, cboNam_HieuChinh.SelectedValue, rnQui_HieuChinh.Text };
        Obj.SpName = "sp_PheDuyet_HieuChinhNganSach";
        Sql.fGetData(Obj);
        RG_HieuChinh.DataSource = Obj.Dt;
        RG_HieuChinh.DataBind();

    }
    protected void CboMaDV_HieuChinh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadHieuChinhNS();
    }

    protected void RG_HieuChinh_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietKeHoachNganSachPheDuyet_Update.ascx";
            FLoadHieuChinhNS();

        }
    }
    protected void RG_HieuChinh_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_khoaCT = RG_HieuChinh.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        bool ketthuc = ((CheckBox)RG_HieuChinh.Items[e.Item.ItemIndex]["Hieuluc_PD"].FindControl("cbHieuluc")).Checked;
        if (ketthuc == true)
        {
            lbLoi.Text = "<font color='red'>Không xóa được vì đang ở trạng thái phê duyệt.</br> Phải bỏ duyệt mới xóa được.</font>";
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { ID_khoaCT };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
        }
        FLoadHieuChinhNS();
    }
    protected void RG_HieuChinh_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtIDKhoaCT = userControl.FindControl("txtIDKhoaCT") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rnChiPhi = userControl.FindControl("rnChiPhi") as Telerik.Web.UI.RadNumericTextBox;
        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;
        TextBox txtPheDuyet = userControl.FindControl("txtPheDuyet") as TextBox;

        bool pheduyet = bool.Parse(txtPheDuyet.Text);

        if (pheduyet == true)
        {
            lbLoi.Text = "<font color='red'>Không sửa được vì đang ở trạng thái phê duyệt.</br> Phải bỏ duyệt mới sửa được.</font>";
        }
        else
        {

            #region Luu
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT", "@Sotien", "@Ghichu" };
            Obj.ValueParameter = new object[] { txtIDKhoaCT.Text, rnChiPhi.Text, txtGhiChu.Text };
            Obj.SpName = "sp_PheDuyet_NganSach_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công .</font>";

            }
            else
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
        }
        FLoadHieuChinhNS();


    }
    protected void RG_HieuChinh_CancelCommand(object sender, GridCommandEventArgs e)
    {
        FLoadHieuChinhNS();
    }
    protected void rnQui_HieuChinh_TextChanged(object sender, EventArgs e)
    {
        LoadDVCanHieuChinh();
        FLoadHieuChinhNS();
    }

    protected void btnBoDuyet_Click(object sender, ImageClickEventArgs e)
    {

        if (RC_HieuChinh.SelectedValue == "False")
        {
            lbLoi.Text = "";

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
            Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, cboNam_HieuChinh.SelectedValue, CboMaDV_HieuChinh.SelectedValue, Convert.DBNull, RC_HieuChinh.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã bỏ phê duyệt.</font>";

            }
        }
        else
        {

            lbLoi.Text = "";
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
            Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, cboNam_HieuChinh.SelectedValue, CboMaDV_HieuChinh.SelectedValue, DateTime.Now, RC_HieuChinh.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Phê duyệt thành công.</font>";

            }

        }
        FLoadHieuChinhNS();
        LoadDVPheDuyet();
        LoadCPThucHien();
        LoadNganSach();
        LOAD_RadGDNganSach();
        FLoadXemNS();
    }

    protected void ExcelQui1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {

    }
    protected void ExcelQui2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {

    }
    #endregion

    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }


   
   
}
