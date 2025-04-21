using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Configuration;
using Data;
using System.Text.RegularExpressions;
using CrystalDecisions.CrystalReports.Engine;
using Telerik.Web.UI;


public partial class Chuongtrinh_ThanhToanHopDong : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    ReportDocument report = new ReportDocument();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           

            #region khong tam ung
            fLoadTienTe2();
            fLoadTiGia2();
            fLoadDonVi2();
            fLoadNguoiDuocThanhToan2();
            fLoadPhuTrachDonVi();
            rdHanThanhToan2.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
            fLoadThanhToanKhongTamUng();
            #endregion

           

        }

        if (Session["ReloadChiTietThanhToanHD"] != null)
        {
            fLoadThanhToanKhongTamUng();
            Session["ReloadChiTietThanhToanHD"] = null;
        }
      

    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV2.Text };
        Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi2.DataSource = Obj.Dt;
        ddlPhuTrachDonVi2.DataBind();
    }

    #region Chứng từ thanh toán không tạm ứng (RadPageView2)

    void fLoadDonVi2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        //Obj.Connectionstring = wqlvattu;
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {
            txtMaDV2.Text = "Không tìm thấy";
            txtTenDonVi2.Text = "Không tìm thấy";
        }
        else
        {
            txtMaDV2.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP2.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtTenDonVi2.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
            txtIDMaCS2.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
    void fLoadNguoiDuocThanhToan2()
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV" };
        //Obj.ValueParameter = new object[] { txtMaDV.Text };
        //Obj.SpName = "DropDownlist_LoadMaNVCTTToan";
        //Sql.fGetData(Obj);
        //ddlNguoiDuocThanhToan2.DataSource = Obj.Dt;
        //ddlNguoiDuocThanhToan2.DataBind();
        //ddlNguoiDuocThanhToan2.SelectedValue = Session["UserID"].ToString();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_NhanVien_ByMaNV";
        Sql.fGetData(Obj);
        ddlNguoiDuocThanhToan2.DataSource = Obj.Dt;
        ddlNguoiDuocThanhToan2.DataBind();
    }
   
    void fLoadTienTe2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_CbLoaiTien_Load";
        Sql.fGetData(Obj);
        ddlLoaiTien2.DataSource = Obj.Dt;
        ddlLoaiTien2.DataBind();
    }
    void fLoadTiGia2()
    {
        if (ddlLoaiTien2.SelectedValue == "VND")
        {
            rnTiGia2.Value = 1;
        }
        else
        {
            string TiGia = gtg.ExchangeRates(ddlLoaiTien2.SelectedValue);
            if (TiGia != "")
            {
                rnTiGia2.Value = double.Parse(gtg.ExchangeRates(ddlLoaiTien2.SelectedValue));
            }
            else
            {
                rnTiGia2.Text = "";
            }

        }
    }
    void fLoadThanhToanKhongTamUng()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiThanhToan", "@LoaiPhieu" };
        Obj.ValueParameter = new object[] { ddlNguoiDuocThanhToan2.SelectedValue, "GTTKTU" };
        Obj.SpName = "sp_ChungTuThanhToan_LoadGiayThanhToanKhongTamUng";
        Sql.fGetData(Obj);
        RGKhongTamUng.DataSource = Obj.Dt;
        RGKhongTamUng.DataBind();
    }

    protected void ddlLoaiTien2_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadTiGia2();
    }
    protected void ddlHinhThucThanhToan2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlHinhThucThanhToan2.SelectedValue == "NH")
        {
            txtTenTaiKhoan2.Enabled = true;
            txtSoTaiKhoan2.Enabled = true;
            txtNganHang2.Enabled = true;
        }
        else
        {
            txtTenTaiKhoan2.Text = "";
            txtSoTaiKhoan2.Text = "";
            txtNganHang2.Text = "";
            txtTenTaiKhoan2.Enabled = false;
            txtSoTaiKhoan2.Enabled = false;
            txtNganHang2.Enabled = false;
        }
    }
    protected void btnLuu2_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        if (rdHanThanhToan2.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
        {
            lbLoi.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
            return;
        }
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@LoaiPhieu" };
        Obj.ValueParameter = new object[] { txtIDMaCS2.Text, "GDNTT" };
        Obj.SpName = "sp_ChungTuThanhToan_TaoPhieu";
        Sql.fGetData(Obj);
        string SoPhieu = Obj.Dt.Rows[0]["SoPhieu"].ToString();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu","@MaDV","@Hanthantoan","@NguoiKT",
                "@NoiDung", "@Nguoilap", "@NguoiThanhToan", 
                "@LoaiPhieu", "@LoaiTien", "@Tigia", "@PhuongThucTT", 
                "@LaTienMat","@TenTaiKhoan","@SoTaiKhoan","@NganHang" };
        Obj.ValueParameter = new object[] { SoPhieu, txtMaBP2.Text,rdHanThanhToan2.SelectedDate ,ddlPhuTrachDonVi2.SelectedValue,
                 txtNoiDung2.Text, Session["UserID"].ToString(), ddlNguoiDuocThanhToan2.SelectedValue,
                "GTTKTU", ddlLoaiTien2.SelectedValue,decimal.Parse(rnTiGia2.Text), ddlPhuongThucThanhToan2.SelectedValue,
                ddlHinhThucThanhToan2.SelectedValue,txtTenTaiKhoan2.Text, txtSoTaiKhoan2.Text,txtNganHang2.Text
                };
        Obj.SpName = "sp_ChungTuThanhToan_Insert";
        Sql.fGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='Red'>Thêm giấy đề nghị thanh toán  <b><font color='black'>" + SoPhieu + "</font></b> thất bại.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='Blue'>Thêm giấy đề nghị thanh toán <b><font color='black'>" + SoPhieu + "</font></b> thành công.</font>";
        }

        fLoadThanhToanKhongTamUng();
    }

    int count;
    bool xx;
    protected void RGKhongTamUng_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        string SoPhieu = RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { SoPhieu };
        Obj.SpName = "sp_ChiTietThanhToan_Count";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                count = int.Parse(Obj.Dt.Rows[0]["CountCTTT"].ToString());

            }
            catch { }
        }
        else { }

          Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { SoPhieu };
        Obj.SpName = "sp_ChiTietThanhToan_GetXX";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
               
                xx = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["KiemTra"].ToString());

            }
            catch { }
        }
        else { }


        if (xx == true)
        {
            lbLoi.Text = "<font color='red'>Phiếu này đã kiểm tra nên không xóa được.</font>";
            fLoadThanhToanKhongTamUng();
        }
        else
        {
            if (count == 0)
            {
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoPhieu" };
                Obj.ValueParameter = new object[] { SoPhieu };
                Obj.SpName = "sp_ChungTuThanhToan_Delete";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua > 0)
                {
                    lbLoi.Text = "<font color='blue'>Xoá thành công giấy đề nghị thanh toán.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
                }

                fLoadThanhToanKhongTamUng();
            }
            else
            {
                lbLoi.Text = "<font color='red'>Đã có chi tiết nên không xóa được.</font>";
                fLoadThanhToanKhongTamUng();
            }
        }


    }
    protected void RGKhongTamUng_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoadThanhToanKhongTamUng();
    }
    protected void RGKhongTamUng_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoadThanhToanKhongTamUng();
    }
    string countTU;
    protected void RGKhongTamUng_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadThanhToanKhongTamUng();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            RGKhongTamUng.MasterTableView.IsItemInserted = false;

            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/GiayDeNghiThanhToan_Update.ascx";
            fLoadThanhToanKhongTamUng();
        }
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                fLoadThanhToanKhongTamUng();
                break;
            case RadGrid.RebindGridCommandName:
                fLoadThanhToanKhongTamUng();
                break;
            case "PRINT":

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoPhieu" };
                Obj.ValueParameter = new object[] { RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text };
                Obj.SpName = "sp_ChungTuThanhToan_KhongTamUng_Count";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTU = Obj.Dt.Rows[0]["CountSoPhieu"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTU) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết nên không in được.</font>";
                    fLoadThanhToanKhongTamUng();
                }
                else
                {

                    lbLoi.Text = "";
                    #region Lấy report
                    report = ReportFactory.GetReport(report.GetType());                   

                    if ((txtMaDV2.Text == "KDND") || txtMaDV2.Text == "P.MAR")
                    {
                        //report.Load(Server.MapPath(@"~\reports\rptDeNghiThanhToan_KDND_MAR.rpt"));
                        report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUng.rpt"));
                    }
                    else
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUng.rpt"));
                    }

                    report.SetParameterValue("@SoPhieu", RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text);

                    Session["report"] = report;


                    #endregion

                    #region Gọi file report
                    //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
                    DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                    DialogWindow.VisibleOnPageLoad = true;
                    fLoadThanhToanKhongTamUng();
                    #endregion

                }
                break;
        }

    }

    protected void RGKhongTamUng_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);

        string hdSoPhieu_ct = (userControl.FindControl("hdSoPhieuDeNghiThanhToan") as HiddenField).Value;
        Telerik.Web.UI.RadNumericTextBox rnTiGia_ct = userControl.FindControl("rnTiGia") as Telerik.Web.UI.RadNumericTextBox;
        DropDownList ddlLoaiTien_ct = userControl.FindControl("ddlLoaiTien") as DropDownList;
        string txtNoiDung_ct = (userControl.FindControl("txtNoiDung") as TextBox).Text;
        Telerik.Web.UI.RadDatePicker HanThanhToan_ct = userControl.FindControl("rdHanThanhToan") as Telerik.Web.UI.RadDatePicker;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { hdSoPhieu_ct };
        Obj.SpName = "sp_ChungTuThanhToanTamUng_KeToanKTBySoPhieu";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                xx = bool.Parse(Obj.Dt.Rows[0]["BPTCKTKiemtra"].ToString());
                if (xx == true)
                {
                    lbLoi.Text = "<font color='Red'>Số phiếu <b><font color='black'>" + hdSoPhieu_ct + "</font></b> kế toán đã xác nhận nên không sữa được.</font>";
                    fLoadThanhToanKhongTamUng();
                }
                else
                {
                    #region Kiem tra han thanh toan
                    if (HanThanhToan_ct.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                    {
                        lbLoi.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                        fLoadThanhToanKhongTamUng();
                        return;
                    }
                    #endregion

                    #region Luu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoPhieu", "@TiGia", "@LoaiTien", 
            "@HanThanhToan", "@NoiDung" };
                    Obj.ValueParameter = new object[] { hdSoPhieu_ct, rnTiGia_ct.Value, ddlLoaiTien_ct.SelectedValue,
            HanThanhToan_ct.SelectedDate, txtNoiDung_ct };
                    Obj.SpName = "sp_ChungTuThanhToanTamUng_Update";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua > 0)
                    {
                        lbLoi.Text = "<font color='blue'>Cập nhật thành công giấy đề nghị thanh toán <b><font color='black'>" + hdSoPhieu_ct + "</font></b>.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                    }
                    #endregion
                }
            }
            catch { }
        }
        fLoadThanhToanKhongTamUng();
    }
    protected void RGKhongTamUng_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoadThanhToanKhongTamUng();
    }
    #endregion



   
}