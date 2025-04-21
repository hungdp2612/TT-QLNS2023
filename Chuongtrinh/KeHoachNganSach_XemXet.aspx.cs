using System;
using System.Web.UI;
using Data;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
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
            LOAD_COBOBOX_THANG_XEMXET_THEODV();

            LoadNguoiPheDuyetTheoPhongBan();

            fLoadXemXetByThang();

            FloadButton();

            fLoadXemXetByQui();
            //SendEmail();
        }
    }

    #region TAB1

    protected void cboThang_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadXemXetByThang();
        lbLoi.Text = "";
        lbEmail.Text = "";
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


    void fLoadXemXetByThang()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RadGDNganSach.Columns[2].Visible = true;
            RadGDNganSach.Columns[3].Visible = true;
            RadGDNganSach.Columns[4].Visible = true;
            RadGDNganSach.GroupingEnabled = true;
        }
        else
        {
            RadGDNganSach.Columns[4].Visible = true;
            if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
            {
                RadGDNganSach.Columns[3].Visible = false;
                RadGDNganSach.Columns[4].Visible = true;
                RadGDNganSach.GroupingEnabled = true;
            }
            else
            {
                RadGDNganSach.Columns[3].Visible = false;
                RadGDNganSach.GroupingEnabled = false;
                RadGDNganSach.AllowFilteringByColumn = false;
            }
        }

        Obj = new clsObj
        {
            Parameter = new string[] { "@Nam", "@MaDV", "@Thang" },
            ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, cboThang.SelectedValue },
            SpName = "sp_KeHoachNganSach_LoadXemXet_ByThang"
        };

        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }


    void fLoadDonVi()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaNV" },
            ValueParameter = new object[] { Session["UserID"].ToString() },
            SpName = "SP_LoadNVIDMaDV"
        };

        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {

                TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            }
            catch { }
        }
        else
        {

        }

    }

    void LOAD_COBOBOX_THANG_XEMXET_THEODV()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@NAM", "@MADV" },
            ValueParameter = new object[] { rnNam.Value, TxtMaDV.Text },
            SpName = "SP_DMTHANG_KEHOACHNGANSACH"
        };
        Sql.fGetData(Obj);
        cboThang.DataSource = Obj.Dt;
        cboThang.DataBind();
        cboThang.SelectedIndex = 0;
    }

    void LoadNamQui()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { },
            ValueParameter = new object[] { },
            SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui"
        };
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnNam2.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }

    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaDv" },
            ValueParameter = new object[] { TxtMaDV.Text },
            SpName = "sp_NguoiPheDuye_ByMaDV"
        };

        Sql.fGetData(Obj);

        cbNguoiPheDuyet.DataSource = Obj.Dt;
        cbNguoiPheDuyet.DataBind();
    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbEmail.Text = "";

        string madv = TxtMaDV.Text;
        DateTime ngayxx = DateTime.Now;


        lbLoi.Text = "";

        try
        {

            //#region KIEM TRA THOI GIAN XEM XET NGAN SACH CUA THANG 

            //Obj = new clsObj
            //{
            //    Parameter = new string[] { "@NAM", "@THANG", "@MADV" },
            //    ValueParameter = new object[] { int.Parse(rnNam.Text), int.Parse(cboThang.SelectedValue), madv },
            //    SpName = "SP_HIEUCHINH_NGAY_XEMXET_KHNS_BY_NAM_THANG"
            //};
            //Sql.fGetData(Obj);
            //int hethan = int.Parse(Obj.Dt.Rows[0]["HETHAN"].ToString());
            //#endregion

            //if (hethan == 1)
            //{
            //    throw new Exception("Đã hết hạn xem xét ngân sách tháng " + cboThang.SelectedValue + "/" + rnNam.Value + " </br> Xin vui lòng liên hệ P.TCKT");
            //}
            //else
            {

                if (cbXemXet.SelectedValue == "false")
                {
                    #region xem xet theo quí
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@Thang", "@Nam", "@MaDV", "@Hieuluc_XX", "@NgayXX", "@MaNVDonvi_XX", "@BanTGD_PD" };
                    Obj.ValueParameter = new object[] { cboThang.SelectedValue, rnNam.Value, madv, cbXemXet.SelectedValue, Convert.DBNull, Convert.DBNull, Convert.DBNull };
                    Obj.SpName = "sp_KeHoachNganSach_XemXet_ByThang";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xem xét kế hoạch ngân sách của tháng <b><font color='black'>" + cboThang.SelectedValue + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Tháng <b><font color='black'>" + cboThang.SelectedValue + "</font></b> đã chuyển sang trạng thái chưa xem xét.</font>";
                    }
                    fLoadXemXetByThang();
                    #endregion
                }
                else
                {

                    #region xem xet theo quí
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@Thang", "@Nam", "@MaDV", "@Hieuluc_XX", "@NgayXX", "@MaNVDonvi_XX", "@BanTGD_PD" };
                    Obj.ValueParameter = new object[] { cboThang.SelectedValue, rnNam.Value, madv, cbXemXet.SelectedValue, ngayxx, Session["UserID"].ToString(), cbNguoiPheDuyet.SelectedValue };
                    Obj.SpName = "sp_KeHoachNganSach_XemXet_ByThang";

                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xem xét kế hoạch ngân sách của tháng <b><font color='black'>" + cboThang.SelectedValue + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Xem xét kế hoạch ngân sách của tháng <b><font color='black'>" + cboThang.SelectedValue + "</font></b> thành công.</font>";
                        SendEmail();
                    }
                    fLoadXemXetByThang();
                    #endregion
                }
            }
        }
        catch (Exception ex)
        {

            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }



    }

    string emailthuky;
    void SendEmail()
    {

        lbEmail.Text = "";
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaNV" },
            ValueParameter = new object[] { Session["UserID"].ToString() },
            SpName = "SP_LoadNVIDMaDV"
        };
        Sql.fGetData(Obj);
        string kyHieuDonVi = Obj.Dt.Rows[0]["KiHieuDonVi"].ToString();

        #region Email

        Obj = new clsObj
        {
            Connectionstring = wqlvattu,
            Parameter = new string[] { "@manv", "@kyHieuDonVi" },
            ValueParameter = new object[] { cbNguoiPheDuyet.SelectedValue, kyHieuDonVi },
            SpName = "Sp_GuiEmailDenBanTGD"
        };
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

                string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET NGAN SACH THANG " + cboThang.SelectedValue + "/" + rnNam.Text;
                string noidung = "";
                noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt kê hoạch ngân sách tháng " + cboThang.SelectedValue + "/" + rnNam.Text + " cua " + TxtMaDV.Text + "%0D%0A";
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
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoadXemXetByThang();
        lbLoi.Text = "";
        lbEmail.Text = "";
    }

    protected void RadGDNganSach_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        lbLoi.Text = "";
        fLoadXemXetByThang();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        lbLoi.Text = "";
        fLoadXemXetByThang();
    }
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadXemXetByThang();
        }
    }

    #endregion

    #region TAB2

    void fLoadXemXetByQui()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RG2.Columns[2].Visible = true;
            RG2.Columns[3].Visible = true;
            RG2.Columns[4].Visible = true;
            RG2.GroupingEnabled = true;
        }
        else
        {
            RG2.Columns[4].Visible = true;
            if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
            {
                RG2.Columns[3].Visible = false;
                RG2.Columns[4].Visible = true;
                RG2.GroupingEnabled = true;
            }
            else
            {
                RG2.Columns[3].Visible = false;
                RG2.GroupingEnabled = false;
                RG2.AllowFilteringByColumn = false;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text, rnQui.Value };
        Obj.SpName = "sp_KeHoachNganSach_LoadXemXet_ByQui";
        Sql.fGetData(Obj);
        RG2.DataSource = Obj.Dt;
        RG2.DataBind();
    }

    protected void rnNam2_TextChanged(object sender, EventArgs e)
    {

        fLoadXemXetByThang();

    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {
        fLoadXemXetByQui();
    }

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

                ExcelQui4.Columns[8].Visible = true;
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

    #endregion

}