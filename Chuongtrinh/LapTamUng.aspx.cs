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
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

public partial class Chuongtrinh_LapTamUng : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    ReportDocument report = new ReportDocument();
    QLNS2013DBDataContext db_ = new QLNS2013DBDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();

            //if (int.Parse(rnThang.Text) == 3 || int.Parse(rnThang.Text) == 6 || int.Parse(rnThang.Text) == 9 || int.Parse(rnThang.Text) == 12)
            //{
            //    rnThang.Enabled = true;
            //    rnNam.Enabled = true;
            //}

            fLoadDonVi();
            fLoadNguoiDuocThanhToan();
            fLoadTienTe();
            fLoadTiGia();
            fLoadPhuTrachDonVi();
            LoadTaiKhoanNganHang();

            rdHanThanhToan.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
            fLoad();

        }
        if (Session["ReloadPhieuTU"] != null)
        {
            fLoad();
            Session["ReloadPhieuTU"] = null;
            Session["ReQuestPhieuTU"] = null;
            //  Session.Remove("ReQuestPhieuTU");
        }

    }
    void fLoad()
    {
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_PhieuTU_Load_ByNam2";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        // Obj.Connectionstring = wqlvattu;
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {
            txtMaDV.Text = "Không tìm thấy";
            txtTenDonVi.Text = "Không tìm thấy";
        }
        else
        {
            txtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtTenDonVi.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
    void fLoadNguoiDuocThanhToan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_NhanVien_ByMaNV";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan.DataSource = Obj.Dt;
        ddlNguoiThanhToan.DataBind();
        // ddlNguoiThanhToan.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV" };
        //Obj.ValueParameter = new object[] { txtMaDV.Text };
        //Obj.SpName = "sp_GetGD_ByMaDV";
        Obj.Parameter = new string[] { "@MaBP" };
        Obj.ValueParameter = new object[] { txtMaBP.Text };
        Obj.SpName = "sp_PhuTrachDonVi_GetAll_ByMaBP";

        Sql.fGetData(Obj);
        ddlPhuTrachDonVi.DataSource = Obj.Dt;
        ddlPhuTrachDonVi.DataBind();
    }

    void fLoadTienTe()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_CbLoaiTien_Load";
        Sql.fGetData(Obj);
        ddlLoaiTien.DataSource = Obj.Dt;
        ddlLoaiTien.DataBind();
    }
    void fLoadTiGia()
    {
        if (ddlLoaiTien.SelectedValue == "VND")
        {
            rnTiGia.Value = 1;
        }
        else
        {
            string TiGia = gtg.ExchangeRates(ddlLoaiTien.SelectedValue);
            if (TiGia != "")
            {
                rnTiGia.Value = double.Parse(gtg.ExchangeRates(ddlLoaiTien.SelectedValue));
            }
            else
            {
                rnTiGia.Text = "";

        
            }

        }
        if (ddlLoaiTien.SelectedValue != "VND")
        {

            rnTiGia.Enabled = true;
        }
        else
        {
            rnTiGia.Enabled = false;
        }
    }
    protected void ddlLoaiTien_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadTiGia();
    }

    int ktns;
    int KiemTraNS()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_LapTamUng_KiemTraKeHoachNS_ByMaDv_Nam_Thang";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {

                ktns = int.Parse(Obj.Dt.Rows[0]["KiemTraNS"].ToString());


            }
            catch { }

        }
        else
        {

        }
        return ktns;
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";


        string IDMaCS;

        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtMaBP.Text;
            }
        }

        //if (KiemTraNS() == 0)
        //{
        //    lbLoi.Text = "<font color='red'>Ngân sách tháng <b><font color='black'>" + rnThang.Text + "/" + rnNam.Text + "</font></b> chưa được lập hoặc chưa xác nhận <br> nên không lập được tạm ứng.</font>";
        //    fLoad();
        //}
        //else
        //{
        string PhieuTU = "";

        #region Kiem tra han thanh toan
        if (rdHanThanhToan.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
        {
            lbLoi.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
            return;
        }
        #endregion

        #region Tạo phiếu tạm ứng
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtIDMaCS.Text == "100" ? "49" : txtIDMaCS.Text };
        Obj.SpName = "sp_TaoPhieuTamUng";
        Sql.fGetData(Obj);

        if (Obj.Dt.Rows.Count < 1)
        {
            lbLoi.Text = "<font color='red'>Không tạo được phiếu tạm ứng.</font>";
            return;
        }
        else
        {
            PhieuTU = Obj.Dt.Rows[0]["PhieuTU"].ToString();
        }
        #endregion

        #region Tài khoản ngân hàng
        string sotaikhoan;
        string tentaikhoan;
        string tennganhang;
        string manvtk;
        if (rdHinhThucTamUng.SelectedValue == "TM")
        {
            sotaikhoan = string.Empty;
            tentaikhoan = string.Empty;
            tennganhang = string.Empty;
            manvtk = string.Empty;
        }
        else
        {
            if (rdTaiKhoanNganHang.SelectedValue == null || rdTaiKhoanNganHang.Text == string.Empty)
            {
                lbLoi.Text = "<font color='red'>Bạn chưa chọn tài khoản ngân hàng.</font>";
                return;
            }
            else
            {
                var item = db_.TaiKhoanNganHangs.FirstOrDefault(p => p.SoTaiKhoan == rdTaiKhoanNganHang.SelectedValue);
                sotaikhoan = item.SoTaiKhoan;
                tentaikhoan = item.TenTaiKhoan;
                tennganhang = item.TenNganHang;
                manvtk = item.MANV;

            }
        }
        #endregion

        #region Luu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU","@Nam","@Thang","@MaNV", "@NgayLapPhieu","@HanThanhToan", "@LyDo",
            "@MaDV", "@TennguoiPTDV",  "@LoaiTien", "@TiGia" , "@HinhThucTamUng" , "@SoTaiKhoan" , "@TenTaiKhoan" , "@TenNganHang","@MaNVTaiKhoan" };
        Obj.ValueParameter = new object[] {PhieuTU,int.Parse(rnNam.Text), int.Parse(rnThang.Text), ddlNguoiThanhToan.SelectedValue,DateTime.Now, rdHanThanhToan.SelectedDate,
                txtNoiDung.Text, IDMaCS, ddlPhuTrachDonVi.SelectedValue,
            ddlLoaiTien.SelectedValue, rnTiGia.Value,rdHinhThucTamUng.SelectedValue,sotaikhoan,tentaikhoan,tennganhang,manvtk};

        Obj.SpName = "sp_PhieuTamUng_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Lưu thành công phiếu tạm ứng <b><font color='black'>" + PhieuTU + "</font></b>.</font>";
            fLoad();
        }
        else
        {
            lbLoi.Text = "<font color='red'>Lưu thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion
        //}
    }

    protected void btnLamMoi_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }

    bool xx;
    string countTU;

    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { PhieuTU };
        Obj.SpName = "sp_PhieuTamUng_KeToanKTByPhieuTU";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                xx = bool.Parse(Obj.Dt.Rows[0]["KTKiemTra"].ToString());

                if (xx == true)
                {
                    lbLoi.Text = "<font color='Red'>Phiếu tạm ứng <b><font color='black'>" + PhieuTU + "</font></b> kế toán đã xác nhận nên không xóa được.</font>";
                    fLoad();
                }
                else
                {
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@PhieuTU" };
                    Obj.ValueParameter = new object[] { PhieuTU };
                    Obj.SpName = "sp_PhieuTamUng_Count_Delete";
                    Sql.fGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        try
                        {
                            countTU = Obj.Dt.Rows[0]["CountTU"].ToString();

                        }
                        catch { }
                    }
                    else { }
                    if (int.Parse(countTU) == 0)
                    {
                        #region Xoá
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@PhieuTU" };
                        Obj.ValueParameter = new object[] { PhieuTU };
                        Obj.SpName = "sp_PhieuTamUng_Delete";
                        Sql.fNonGetData(Obj);
                        if (Obj.KetQua > 0)
                        {
                            lbLoi.Text = "<font color='blue'>Xoá thành công phiếu tạm ứng.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
                        }
                        #endregion
                        fLoad();

                    }
                    else
                    {
                        lbLoi.Text = "<font color='Red'>Đã có chi tiết tạm ứng nên không xóa được.</font>";
                        fLoad();
                    }
                }
            }
            catch { }
        }
        else
        {

        }

    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            RG.MasterTableView.IsItemInserted = false;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/LapTamUng_Update.ascx";
            fLoad();
        }
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                fLoad();
                break;
            case RadGrid.RebindGridCommandName:
                fLoad();
                break;
            case "PRINT":

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU" };
                Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["PhieuTU"].Text };
                Obj.SpName = "sp_PhieuTamUng_Count_Delete";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTU = Obj.Dt.Rows[0]["CountTU"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTU) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tạm ứng nên không in được.</font>";
                    fLoad();
                }
                else
                {
                    //#region khi click vào button in thì cập nhật DVKiemTra thành TRUE
                    //string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;
                    //Obj = new clsObj();
                    //Obj.Parameter = new string[] { "@PhieuTU" };
                    //Obj.ValueParameter = new object[] { PhieuTU };
                    //Obj.SpName = "sp_PhieuTamUng_UpdateDVKiemTra";
                    //Sql.fGetData(Obj);
                    //#endregion

                    lbLoi.Text = "";
                    #region Lấy report
                    report = ReportFactory.GetReport(report.GetType());
                    if ((txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.HNO")
                        || (txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.DNA")
                       
                        || (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNS") ||
                        (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNG") ||
                        (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNH"))
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptPhieuTamUng.rpt"));
                    }
                    else if (txtMaDV.Text == "THAITU")
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptPhieuTamUngTT.rpt"));
                    }
                    else
                    {
                        if ((txtMaDV.Text == "KDND") || (txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.CTO") || txtMaDV.Text == "P.MAR")
                        {
                            report.Load(Server.MapPath(@"~\reports\rptPhieuTamUngKDND_MAR.rpt"));
                            // report.Load(Server.MapPath(@"~\Reports\rptPhieuTamUng.rpt"));
                        }
                        else
                        {
                            report.Load(Server.MapPath(@"~\Reports\rptPhieuTamUng.rpt"));
                        }
                    }


                    report.SetParameterValue("@PhieuTU", RG.Items[e.Item.ItemIndex]["PhieuTU"].Text);

                    Session["report"] = report;


                    #endregion

                    #region Gọi file report
                    // Response.Redirect("~/Reports/rptBaoCao.aspx", "_blank", "");
                    DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                    DialogWindow.VisibleOnPageLoad = true;
                    fLoad();
                    #endregion

                }
                break;
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);

        string hdPhieuTamUng = (userControl.FindControl("hdPhieuTamUng") as HiddenField).Value;
        Telerik.Web.UI.RadNumericTextBox rnTiGia = userControl.FindControl("rnTiGia") as Telerik.Web.UI.RadNumericTextBox;
        DropDownList ddlLoaiTien = userControl.FindControl("ddlLoaiTien") as DropDownList;
        string tbNoiDung = (userControl.FindControl("txtNoiDung") as TextBox).Text;
        Telerik.Web.UI.RadDatePicker HanThanhToan = userControl.FindControl("rdHanThanhToan") as Telerik.Web.UI.RadDatePicker;
        RadComboBox hinhthuctamung = userControl.FindControl("rdHinhThucTamUng") as RadComboBox;
        RadComboBox tknganhang = userControl.FindControl("rdTaiKhoanNganHang") as RadComboBox;

        #region Tài khoản ngân hàng
        string sotaikhoan;
        string tentaikhoan;
        string tennganhang;
        string manvtk;
        if (hinhthuctamung.SelectedValue == "TM")
        {
            sotaikhoan = string.Empty;
            tentaikhoan = string.Empty;
            tennganhang = string.Empty;
            manvtk = string.Empty;
        }
        else
        {
            if (tknganhang.SelectedValue == null || tknganhang.Text == string.Empty)
            {
                lbLoi.Text = "<font color='red'>Bạn chưa chọn tài khoản ngân hàng.</font>";
                return;
            }
            else
            {
                var item = db_.TaiKhoanNganHangs.FirstOrDefault(p => p.SoTaiKhoan == tknganhang.SelectedValue);
                sotaikhoan = item.SoTaiKhoan;
                tentaikhoan = item.TenTaiKhoan;
                tennganhang = item.TenNganHang;
                manvtk = item.MANV;
            }
        }
        #endregion


        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { hdPhieuTamUng };
        Obj.SpName = "sp_PhieuTamUng_KeToanKTByPhieuTU";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                xx = bool.Parse(Obj.Dt.Rows[0]["KTKiemTra"].ToString());
                if (xx == true)
                {
                    lbLoi.Text = "<font color='Red'>Phiếu tạm ứng <b><font color='black'>" + hdPhieuTamUng + "</font></b> kế toán đã xác nhận nên không sửa được.</font>";
                    fLoad();
                }
                else
                {
                    #region Kiem tra han thanh toan
                    if (HanThanhToan.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                    {
                        lbLoi.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày lập phiếu.</font>";
                        fLoad();
                        return;
                    }
                    #endregion

                    #region Luu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@PhieuTU", "@TiGia", "@LoaiTien",
            "@HanThanhToan", "@LyDo" , "@HinhThucTamUng" , "@SoTaiKhoan" , "@TenTaiKhoan" , "@TenNganHang","@MaNVTaiKhoan"};
                    Obj.ValueParameter = new object[] { hdPhieuTamUng, rnTiGia.Value, ddlLoaiTien.SelectedValue,
            HanThanhToan.SelectedDate, tbNoiDung ,hinhthuctamung.SelectedValue,sotaikhoan,tentaikhoan,tennganhang,manvtk};
                    Obj.SpName = "sp_PhieuTamUng_Update";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua > 0)
                    {
                        lbLoi.Text = "<font color='blue'>Cập nhật thành công tạm ứng <b><font color='black'>" + hdPhieuTamUng + "</font></b>.</font>";
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
        fLoad();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();


    }

    void LoadTaiKhoanNganHang()
    {
        var item = db_.TaiKhoanNganHangs.ToList();
        rdTaiKhoanNganHang.DataSource = item;
        rdTaiKhoanNganHang.DataBind();
    }

    protected void rdHinhThucTamUng_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rdHinhThucTamUng.SelectedValue == "CK")
        {
            rdTaiKhoanNganHang.Enabled = true;
        }
        else
        {
            rdTaiKhoanNganHang.Text = string.Empty;
            rdTaiKhoanNganHang.SelectedValue = null;
            rdTaiKhoanNganHang.Enabled = false;
        }    
    }
}
