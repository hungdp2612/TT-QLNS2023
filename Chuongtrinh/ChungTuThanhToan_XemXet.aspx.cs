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


public partial class Chuongtrinh_ChungTuThanhToan_XemXet : clsPhanQuyenCaoCap
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
            #region thanh toán tạm ứng
            Session["SoPhieuTTTU"] = String.Empty;
            rdNgayXemXet.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
            fLoadDonVi();
            fLoadNguoiDuocThanhToan();
            fLoadPhuTrachDonVi();
            FLoadThanhToanTamUng();
            FLoadChiTietThanhToanTamUngBySession_SoPhieu();
         
            
            #endregion

            #region khong tam ung
            Session["SoPhieuTTKTU"] = String.Empty;
            rdNgayXemXet2.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);         
            fLoadDonVi2();
            fLoadNguoiDuocThanhToan2();
            fLoadPhuTrachDonVi2();
            
            FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu();
            FLoadThanhToanKhongTamUng();
           
         
            #endregion         

        }
       

    }
    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }


    #region xem xét Chứng từ thanh toán tạm ứng (RadPageView1)
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        //Obj.Connectionstring = wqlvattu;
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
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP.Text };
        Obj.SpName = "LoadNhanVienTheoPhongBan";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan.DataSource = Obj.Dt;
        ddlNguoiThanhToan.DataBind();
        //ddlNguoiThanhToan.SelectedIndex = 0;
        //ddlNguoiThanhToan.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text };
        Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi.DataSource = Obj.Dt;
        ddlPhuTrachDonVi.DataBind();
    }
    void FLoadThanhToanTamUng()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan.SelectedValue };
        Obj.SpName = "sp_ChungTuThanhToan_XemXet_Load";
        Sql.fGetData(Obj);
        RGTTTU.DataSource = Obj.Dt;
        RGTTTU.DataBind();
    }
    void FLoadChiTietThanhToanTamUngBySession_SoPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu","@MaNV" };
        Obj.ValueParameter = new object[] { Session["SoPhieuTTTU"].ToString(), ddlNguoiThanhToan.SelectedValue };
        Obj.SpName = "sp_ChiTietThanhToan_XemXet_LoadBySessionSoPhieu";
        Sql.fGetData(Obj);
        RGCTTTTU.DataSource = Obj.Dt;
        RGCTTTTU.DataBind();
    }
    
    protected void ddlNguoiThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        FLoadThanhToanTamUng();       
        FLoadChiTietThanhToanTamUngBySession_SoPhieu();
    }
    protected void RGTTTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadThanhToanTamUng();
        }
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["SoPhieuTTTU"] = String.Empty;
                FLoadChiTietThanhToanTamUngBySession_SoPhieu();
            }

        }
    }
    protected void RGTTTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadThanhToanTamUng();
    }
    protected void RGTTTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadThanhToanTamUng();
    }
    protected void RGTTTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuTTTU"] = RGTTTU.SelectedValue == null ? "" : RGTTTU.SelectedValue;
        FLoadChiTietThanhToanTamUngBySession_SoPhieu();
    }
    protected void RGTTTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        foreach (GridDataItem item in RGTTTU.Items)
        {
            (item["KiemTra"].FindControl("cbKiemTra") as RadComboBox).Text = (item["KiemTra"].FindControl("hfKiemTra") as HiddenField).Value;
            (item["KiemTra"].FindControl("cbKiemTra") as RadComboBox).SelectedValue = (item["KiemTra"].FindControl("hfKiemTra") as HiddenField).Value;
        }
    }
    protected void cbKiemTra_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (Session["SoPhieuTTTU"].ToString() == "" || Session["SoPhieuTTTU"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn số phiếu.</font>";
            FLoadThanhToanTamUng();
        }
        else
        {
            RadComboBox cbKiemTra = (RadComboBox)sender;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu", "@KiemTra" };
            Obj.ValueParameter = new object[] { Session["SoPhieuTTTU"].ToString(), cbKiemTra.SelectedValue };
            Obj.SpName = "sp_ChungTuThanhToan_XemXet_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xem xét số phiếu <b><font color='black'>" + Session["SoPhieuTTTU"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã xem xét số phiếu<b><font color='black'>" + Session["SoPhieuTTTU"].ToString() + "</font></b> thành công.</font>";
                fLoadDonVi();
                fLoadNguoiDuocThanhToan();
                FLoadThanhToanTamUng();
                Session["SoPhieuTTTU"] = String.Empty;
                FLoadChiTietThanhToanTamUngBySession_SoPhieu();
               
            }
        }

    }
    #endregion


    #region Xem xét Chứng từ thanh toán không tạm ứng (RadPageView2)

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
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP2.Text };
        Obj.SpName = "LoadNhanVienTheoPhongBan_ChungTuThanhToanKhongTU";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan2.DataSource = Obj.Dt;
        ddlNguoiThanhToan2.DataBind();
        //ddlNguoiThanhToan2.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text };
        Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi2.DataSource = Obj.Dt;
        ddlPhuTrachDonVi2.DataBind();
    }
    void FLoadThanhToanKhongTamUng()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan2.SelectedValue };
        Obj.SpName = "sp_ChungTuThanhToanKhongTamUng_XemXet_Load";
        Sql.fGetData(Obj);
        RGTTKTU.DataSource = Obj.Dt;
        RGTTKTU.DataBind();
    }

    void FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@MaNV" };
        Obj.ValueParameter = new object[] { Session["SoPhieuTTKTU"].ToString() , ddlNguoiThanhToan2.SelectedValue};
        Obj.SpName = "sp_ChiTietThanhToanKhongTamUng_KiemTra_LoadBySessionSoPhieu";
        Sql.fGetData(Obj);
        RGCTTTKTU.DataSource = Obj.Dt;
        RGCTTTKTU.DataBind();
    }

    protected void ddlNguoiThanhToan2_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadThanhToanKhongTamUng();
        FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu();
    }

    protected void RGTTKTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadThanhToanKhongTamUng();
        }
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["SoPhieuTTKTU"] = String.Empty;
                FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu();
            }

        }
    }
    protected void RGTTKTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadThanhToanKhongTamUng();
    }
    protected void RGTTKTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadThanhToanKhongTamUng();
    }
    protected void RGTTKTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuTTKTU"] = RGTTKTU.SelectedValue == null ? "" : RGTTKTU.SelectedValue;
        FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu();
    }
    protected void RGTTKTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        foreach (GridDataItem item in RGTTKTU.Items)
        {
            (item["KiemTra"].FindControl("cbKiemTraKTU") as RadComboBox).Text = (item["KiemTra"].FindControl("hfKiemTraKTU") as HiddenField).Value;
            (item["KiemTra"].FindControl("cbKiemTraKTU") as RadComboBox).SelectedValue = (item["KiemTra"].FindControl("hfKiemTraKTU") as HiddenField).Value;
        }
    }
    protected void cbKiemTraKTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (Session["SoPhieuTTKTU"].ToString() == "" || Session["SoPhieuTTKTU"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn số phiếu.</font>";
            FLoadThanhToanKhongTamUng();
        }
        else
        {
            RadComboBox cbKiemTra = (RadComboBox)sender;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu", "@KiemTra" };
            Obj.ValueParameter = new object[] { Session["SoPhieuTTKTU"].ToString(), cbKiemTra.SelectedValue };
            Obj.SpName = "sp_ChungTuThanhToan_XemXet_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xem xét số phiếu <b><font color='black'>" + Session["SoPhieuTTKTU"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã xem xét số phiếu<b><font color='black'>" + Session["SoPhieuTTKTU"].ToString() + "</font></b> thành công.</font>";
                fLoadDonVi2();
                fLoadNguoiDuocThanhToan2();
                FLoadThanhToanKhongTamUng();
                Session["SoPhieuTTKTU"] = String.Empty;
                FLoadChiTietThanhToanKhongTamUngBySession_SoPhieu();

            }
        }
    }
    #endregion



   
}