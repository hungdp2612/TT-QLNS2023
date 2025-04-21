using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;

public partial class Chuongtrinh_XemKeHoachKhoanMuc_Mar : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadDonVi();
            fLoadMaDV();
            FLoadMaBPByIDCS();

            #region tab2
            rnNam2.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadDonVi2();
            fLoadMaDV2();
            FLoadMaBPByIDCS2();

            fLoadMaCP("");
            #endregion

            #region tab3
            rnNam3.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadDanhMucCHuongTrinh();
            fLoadDonVi3();
            fLoadMaDV3();

            #endregion
            #region tab4
            rnNam_TongKM.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadMaCP_TongKM("");
            fLoadKhoanMuc_ByMaCP_TongKM("");
            fLoadDanhMucCHuongTrinh_TongKM();

            #endregion

        }
    }

    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {

            txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();

        }
        else
        {

        }
    }

    void fLoadMaDV()
    {
        if (txtMaBP.Text != "P.TCKT")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP" };
            Obj.ValueParameter = new object[] { txtMaBP.Text };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
            Sql.fGetData(Obj);
            ddlMaDV.DataSource = Obj.Dt;
            ddlMaDV.DataBind();
            // ddlMaDV.Enabled = false;
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { };
            Obj.ValueParameter = new object[] { };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
            Sql.fGetData(Obj);
            ddlMaDV.DataSource = Obj.Dt;
            ddlMaDV.DataBind();
        }

    }
    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };

        Obj.SpName = "sp_TraCuuKeHoachNSQui_MaBPByIDCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text) };
        Obj.SpName = "sp_XemKeHoachKhoanMuc_Mar_ByNam";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }


    public bool fBool(object Value)
    {
        return bool.Parse(Value.ToString());
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {

        RG.Columns[4].Visible = true;
        RG.Columns[5].Visible = false;
        RG.Columns[6].Visible = false;
        RG.Columns[7].Visible = false;
        RG.Columns[8].Visible = false;

        RG.GridLines = GridLines.Both;
        fLoad();
        ConfigureExport();
        RG.MasterTableView.ExportToExcel();
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        RG.Columns[4].Visible = false;
        fLoad();
    }
    public void ConfigureExport()
    {
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "Ke Hoach Khoản Mục " + rnNam.Text;

    }
    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
  
    
    #region tab2 (xem kế hoạch chi phí)

    void fLoadDonVi3()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {

            txtMaBP3.Text = Obj.Dt.Rows[0]["MABP"].ToString();

        }
        else
        {

        }
    }

    void fLoadMaDV3()
    {
        if (txtMaBP.Text != "P.TCKT")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP" };
            Obj.ValueParameter = new object[] { txtMaBP3.Text };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
            Sql.fGetData(Obj);
            cboDonVi3.DataSource = Obj.Dt;
            cboDonVi3.DataBind();
            // ddlMaDV.Enabled = false;
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { };
            Obj.ValueParameter = new object[] { };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
            Sql.fGetData(Obj);
            cboDonVi3.DataSource = Obj.Dt;
            cboDonVi3.DataBind();
        }

    }

    void fLoad3()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam3.Text), txtMaBP3.Text };
        Obj.SpName = "sp_XemKeHoachChiPhi_Mar";
        Sql.fGetData(Obj);
        RG3.DataSource = Obj.Dt;
        RG3.DataBind();
    }

    public void ConfigureExport_XemChiPhi()
    {
        RG3.ExportSettings.ExportOnlyData = true;
        RG3.ExportSettings.IgnorePaging = true;
        RG3.ExportSettings.OpenInNewWindow = true;
        RG3.ExportSettings.FileName = "Kế hoạch chi phí năm " + rnNam3.Text;
    }

    protected void btXem3_Click(object sender, ImageClickEventArgs e)
    {
        fLoad3();
    }
    protected void btExcel3_Click(object sender, ImageClickEventArgs e)
    {

        fLoad3();
        ConfigureExport_XemChiPhi();
        RG3.MasterTableView.ExportToExcel();
    }
    #endregion


    #region tab3(Xem chi tiết thanh toán khoản mục)
    void fLoad2()
    {
        if (cbKhoanMuc.SelectedValue == "")
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), cbMaChiPhi.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhongCoKhoanMuc_Mar";
            Sql.fGetData(Obj);
            rgChungTu.DataSource = Obj.Dt;
            rgChungTu.DataBind();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@KhoaKM" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), cbMaChiPhi.SelectedValue, cbKhoanMuc.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar";
            Sql.fGetData(Obj);
            rgChungTu.DataSource = Obj.Dt;
            rgChungTu.DataBind();
        }
    }
    void fLoadMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Key" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), Key };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_GetMaCPBy_TableKHChiTietKhoanMuc";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }

    void fLoadKhoanMuc_ByMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@Key" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), cbMaChiPhi.SelectedValue, Key };
        Obj.SpName = "sp_XemChiTietThanhToanKhoanMuc_GetKhoanMuc_ByMaSoCP";
        Sql.fGetData(Obj);
        cbKhoanMuc.DataSource = Obj.Dt;
        cbKhoanMuc.DataBind();
    }

    void fLoadDonVi2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {

            txtMaBP2.Text = Obj.Dt.Rows[0]["MABP"].ToString();

        }
        else
        {

        }
    }
    void fLoadDanhMucCHuongTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_DanhMucChuongTrinh_Mar";
        Sql.fGetData(Obj);
        cboChuongTrinh.DataSource = Obj.Dt;
        cboChuongTrinh.DataBind();
    }
    void fLoadMaDV2()
    {
        if (txtMaBP2.Text != "P.TCKT")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP" };
            Obj.ValueParameter = new object[] { txtMaBP2.Text };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
            Sql.fGetData(Obj);
            cboDonVi2.DataSource = Obj.Dt;
            cboDonVi2.DataBind();
            // ddlMaDV.Enabled = false;
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { };
            Obj.ValueParameter = new object[] { };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
            Sql.fGetData(Obj);
            cboDonVi2.DataSource = Obj.Dt;
            cboDonVi2.DataBind();
        }

    }
    void FLoadMaBPByIDCS2()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { cboDonVi2.SelectedValue };

        Obj.SpName = "sp_TraCuuKeHoachNSQui_MaBPByIDCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP2.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }

    protected void btnXemChungTu_Click(object sender, ImageClickEventArgs e)
    {
        if (cboChuongTrinh.SelectedValue == "TC")
        {
            fLoad2();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@ChuongTrinh" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), cbMaChiPhi.SelectedValue, cboChuongTrinh.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar_By_ChuongTrinh";
            Sql.fGetData(Obj);
            rgChungTu.DataSource = Obj.Dt;
            rgChungTu.DataBind();
        }
    }
    protected void btnExcellChungTu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS2();
        rgChungTu.GridLines = GridLines.Both;

        if (cboChuongTrinh.SelectedValue == "TC")
        {
            fLoad2();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@ChuongTrinh" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam2.Text), cbMaChiPhi.SelectedValue, cboChuongTrinh.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar_By_ChuongTrinh";
            Sql.fGetData(Obj);
            rgChungTu.DataSource = Obj.Dt;
            rgChungTu.DataBind();
        }
        ConfigureExport_Chitiet();
        rgChungTu.MasterTableView.ExportToExcel();
    }


    public void ConfigureExport_Chitiet()
    {
        rgChungTu.ExportSettings.ExportOnlyData = true;
        rgChungTu.ExportSettings.IgnorePaging = true;
        rgChungTu.ExportSettings.OpenInNewWindow = true;
        rgChungTu.ExportSettings.FileName = "Chi tiet thanh toán " + cbMaChiPhi.SelectedValue;
    }


    protected void rgChungTu_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad2();
    }
    protected void rgChungTu_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad2();
    }

    protected void cbMaChiPhi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cbKhoanMuc.Text = "";
        fLoadKhoanMuc_ByMaCP(e.Text);
    }
    #endregion

  


    #region tab4(Xem tổng thanh toán khoản mục)

    void fLoadTongKM()
    {
        if (cbKhoanMuc_TongKM.SelectedValue == "")
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), cbMaCP_TongKM.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhongCoKhoanMuc_Mar_TongKM";
            Sql.fGetData(Obj);
            RG_TongKM.DataSource = Obj.Dt;
            RG_TongKM.DataBind();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@KhoaKM" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), cbMaCP_TongKM.SelectedValue, cbKhoanMuc_TongKM.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar";
            Sql.fGetData(Obj);
            RG_TongKM.DataSource = Obj.Dt;
            RG_TongKM.DataBind();
        }
    }
    void fLoadMaCP_TongKM(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Key" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), Key };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_GetMaCPBy_TableKHChiTietKhoanMuc";
        Sql.fGetData(Obj);
        cbMaCP_TongKM.DataSource = Obj.Dt;
        cbMaCP_TongKM.DataBind();
    }

    void fLoadKhoanMuc_ByMaCP_TongKM(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@Key" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), cbMaCP_TongKM.SelectedValue, Key };
        Obj.SpName = "sp_XemChiTietThanhToanKhoanMuc_GetKhoanMuc_ByMaSoCP";
        Sql.fGetData(Obj);
        cbKhoanMuc_TongKM.DataSource = Obj.Dt;
        cbKhoanMuc_TongKM.DataBind();
    }

    void fLoadDanhMucCHuongTrinh_TongKM()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_DanhMucChuongTrinh_Mar";
        Sql.fGetData(Obj);
        cbChuongTrinh_TongKM.DataSource = Obj.Dt;
        cbChuongTrinh_TongKM.DataBind();
    }
    protected void cbMaCP_TongKM_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP_TongKM(e.Text);
    }
    protected void cbMaCP_TongKM_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cbKhoanMuc_TongKM.Text = "";
        fLoadKhoanMuc_ByMaCP_TongKM(e.Text);
    }
    protected void btnXemTongKM_Click(object sender, ImageClickEventArgs e)
    {
        if (cbChuongTrinh_TongKM.SelectedValue == "TC")
        {
            fLoadTongKM();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@ChuongTrinh" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), cbMaCP_TongKM.SelectedValue, cbChuongTrinh_TongKM.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar_By_ChuongTrinh_TongKM";
            Sql.fGetData(Obj);
            RG_TongKM.DataSource = Obj.Dt;
            RG_TongKM.DataBind();
        }
    }
    protected void btnExcellTongKM_Click(object sender, ImageClickEventArgs e)
    {

        RG_TongKM.GridLines = GridLines.Both;

        if (cbChuongTrinh_TongKM.SelectedValue == "TC")
        {
            fLoadTongKM();
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@ChuongTrinh" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam_TongKM.Text), cbMaCP_TongKM.SelectedValue, cbChuongTrinh_TongKM.SelectedValue };
            Obj.SpName = "sp_ChiTietThanhToan_KhoanMuc_Mar_By_ChuongTrinh_TongKM";
            Sql.fGetData(Obj);
            RG_TongKM.DataSource = Obj.Dt;
            RG_TongKM.DataBind();
        }
        
        RG_TongKM.ExportSettings.ExportOnlyData = true;
        RG_TongKM.ExportSettings.IgnorePaging = true;
        RG_TongKM.ExportSettings.OpenInNewWindow = true;
        RG_TongKM.ExportSettings.FileName = "Thanh toan tong hop " + rnNam_TongKM.Text + "-" + cbMaCP_TongKM.SelectedValue;
        RG_TongKM.MasterTableView.ExportToExcel();
    }
    #endregion


}