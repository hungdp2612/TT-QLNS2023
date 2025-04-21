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


public partial class Chuongtrinh_ChungTuThanhToan_KTKiemTra : clsPhanQuyenCaoCap
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
            fLoadDonVi();           

            string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@manv", "@idsite" };
            Obj.ValueParameter = new object[] { Session["USerID"].ToString(), site };
            Obj.SpName = "SP_Lay_PhanQuyen_ID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows[0]["IDQuyen"].ToString() != "NH_TM")
            {
                ddlLoaiThanhToan1.SelectedValue = Obj.Dt.Rows[0]["IDQuyen"].ToString();
                ddlLoaiThanhToan1.Enabled = false;
            }

          
            fLoadMaDV();
            FLoadMaBPByIDCS();
            fLoadNguoiDuocThanhToan();
            fLoadPhuTrachDonVi();
            FLoadThanhToanTamUng();



            /*Trả phieu thanh toán tạm ứng*/

            string siteGTTTU = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@manv", "@idsite" };
            Obj.ValueParameter = new object[] { Session["USerID"].ToString(), siteGTTTU };
            Obj.SpName = "SP_Lay_PhanQuyen_ID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows[0]["IDQuyen"].ToString() != "NH_TM")
            {
                ddlLoaiThanhToan_TraPhieuGTTTU.SelectedValue = Obj.Dt.Rows[0]["IDQuyen"].ToString();
                ddlLoaiThanhToan_TraPhieuGTTTU.Enabled = false;
            }

            fLoadMaDVTraPhieuGTTTU();
            FLoadMaBPByIDTraPhieuGTTTU();
            fLoadNguoiDuocThanhToanTraPhieuGTTTU();
            fLoadPhuTrachDonVi_TraPhieuGTTTU();
            FLoadTraPhieuThanhToanTamUng();
            /* End Tra phieu thanh toán tạm ứng*/
            
            #endregion

            #region khong tam ung          

            string site2 = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@manv", "@idsite" };
            Obj.ValueParameter = new object[] { Session["USerID"].ToString(), site2 };
            Obj.SpName = "SP_Lay_PhanQuyen_ID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows[0]["IDQuyen"].ToString() != "NH_TM")
            {
                ddlLoaiThanhToan2.SelectedValue = Obj.Dt.Rows[0]["IDQuyen"].ToString();
                ddlLoaiThanhToan2.Enabled = false;
            }

           
            fLoadMaDV2();
            FLoadMaBPByIDCS2();          
            fLoadNguoiDuocThanhToan2();
            fLoadPhuTrachDonVi2();           
           
            FLoadThanhToanKhongTamUng();

            /*Trả phieu đề nghị thanh toán*/

            string siteGDNTU = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@manv", "@idsite" };
            Obj.ValueParameter = new object[] { Session["USerID"].ToString(), siteGDNTU };
            Obj.SpName = "SP_Lay_PhanQuyen_ID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows[0]["IDQuyen"].ToString() != "NH_TM")
            {
                ddlLoaiThanhToan_TraPhieuGDNTT.SelectedValue = Obj.Dt.Rows[0]["IDQuyen"].ToString();
                ddlLoaiThanhToan_TraPhieuGDNTT.Enabled = false;
            }

            fLoadMaDVTraPhieuDNTT();
            FLoadMaBPByIDTraPhieuGDNTT();
            fLoadNguoiDuocThanhToanTraPhieuDNTT();
            fLoadPhuTrachDonVi_TraPhieuDNTT();
            FLoadTraPhieuDeNghiThanhToan();
            /* End Tra phieu dntt*/
         
            #endregion

            #region Giấy nộp tiền
            Session["SoPhieuNopTien"] = String.Empty;
            rdNgayXemXet3.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);

            fLoadDonVi3(); 
            FLoadMaBPByIDCS3();
            fLoadNguoiNopTien();
            fLoadPhuTrachDonVi3();
            
            FLoadChiTietNopTienBySession_SoPhieu();
            FLoadChungTuNopTien();
            #endregion

            #region tra phieu nop tien

            Session["SoPhieuNopTien_TraPhieu"] = String.Empty;

            fLoadDonViTraPhieu();
         
            FLoadMaBPByIDCS4();
            fLoadNguoiNopTien_TraPhieu();
            FLoadChungTuNopTien_TraPhieu();
            FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
            #endregion

        }
        if (Session["KTKiemTraGDNTT"] != null)
        {
            FLoadThanhToanKhongTamUng();
            FLoadThanhToanTamUng();
            Session["KTKiemTraGDNTT"] = null;

        }
       

    }
    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }

    protected void RadTabStripXLCK_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }

   

    protected void RadTabStripGTTTU_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }


    string madv;
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        // Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {

            madv = Obj.Dt.Rows[0]["MaDV"].ToString();

        }
        else
        {

        }
    }
    #region xem xét Chứng từ thanh toán tạm ứng (RadPageView1)

   
    
    void fLoadMaDV()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString()};
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;

        //if (madv == "KDND")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV1";
        //    Sql.fGetData(Obj);
        //    CboMaDV.DataSource = Obj.Dt;
        //    CboMaDV.DataBind();
        //    CboMaDV.SelectedIndex = 0;

        //}
        //else
        //{
        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV2";
        //    Sql.fGetData(Obj);
        //    CboMaDV.DataSource = Obj.Dt;
        //    CboMaDV.DataBind();
        //    CboMaDV.SelectedIndex = 0;

        //}


    }
    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };

        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
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
   
    void fLoadNguoiDuocThanhToan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@TienMat"  };
        Obj.ValueParameter = new object[] { txtMaBP.Text, ddlLoaiThanhToan1.SelectedValue };
        //Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_ByMaBP";
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_ByMaBP2";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan.DataSource = Obj.Dt;
        ddlNguoiThanhToan.DataBind();       
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_PhuTrachDonViByMaCS";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi.DataSource = Obj.Dt;
        ddlPhuTrachDonVi.DataBind();
    }
    void FLoadThanhToanTamUng()
    {

        if (ddlLoaiThanhToan1.SelectedValue == "TM")
        {
            RGTTTU.Columns[5].Visible = false;
            RGTTTU.Columns[6].Visible = false;
            RGTTTU.Columns[7].Visible = false;
        }
        else
        {
            RGTTTU.Columns[5].Visible = true;
            RGTTTU.Columns[6].Visible = true;
            RGTTTU.Columns[7].Visible = true;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap","@TienMat" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan.SelectedValue, ddlLoaiThanhToan1.SelectedValue };
        //Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_Load";
        Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_Load2";
        Sql.fGetData(Obj);
        RGTTTU.DataSource = Obj.Dt;
        RGTTTU.DataBind();
    }
    //void FLoadChiTietThanhToanTamUngBySession_SoPhieu()
    //{
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { "@SoPhieu","@MaNV","@TienMat" };
    //    Obj.ValueParameter = new object[] { Session["SoPhieuTTTU"].ToString(), ddlNguoiThanhToan.SelectedValue, ddlLoaiThanhToan1.SelectedValue };
    //    //Obj.SpName = "sp_ChiTietThanhToan_KTKiemTra_LoadBySessionSoPhieu";
    //    Obj.SpName = "sp_ChiTietThanhToan_KTKiemTra_LoadBySessionSoPhieu2";
    //    Sql.fGetData(Obj);
    //    RGCTTTTU.DataSource = Obj.Dt;
    //    RGCTTTTU.DataBind();
    //}
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Session["SoPhieuTTTU"] = String.Empty;
        FLoadMaBPByIDCS();
        fLoadNguoiDuocThanhToan();
        FLoadThanhToanTamUng();
        fLoadPhuTrachDonVi();
        //FLoadChiTietThanhToanTamUngBySession_SoPhieu();
      
    }


    protected void ddlLoaiThanhToan1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuTTTU"] = String.Empty;
        fLoadNguoiDuocThanhToan();
        FLoadThanhToanTamUng();       
       // FLoadChiTietThanhToanTamUngBySession_SoPhieu();
    }
    protected void ddlNguoiThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuTTTU"] = String.Empty;
        FLoadThanhToanTamUng();       
       // FLoadChiTietThanhToanTamUngBySession_SoPhieu();
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
                //FLoadChiTietThanhToanTamUngBySession_SoPhieu();
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
       
    }
    //protected void RGTTTU_ItemDataBound(object sender, GridItemEventArgs e)
    //{
    //    foreach (GridDataItem item in RGTTTU.Items)
    //    {
    //        (item["BPTCKTKiemtra"].FindControl("cbKTKiemTra") as RadComboBox).Text = (item["BPTCKTKiemtra"].FindControl("hfKTKiemTra") as HiddenField).Value;
    //        (item["BPTCKTKiemtra"].FindControl("cbKTKiemTra") as RadComboBox).SelectedValue = (item["BPTCKTKiemtra"].FindControl("hfKTKiemTra") as HiddenField).Value;
    //    }
    //}
    //protected void cbKTKiemTra_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    if (Session["SoPhieuTTTU"].ToString() == "" || Session["SoPhieuTTTU"].ToString() == null)
    //    {
    //        lbLoi.Text = "<font color='red'>Chưa chọn số phiếu.</font>";
    //        FLoadThanhToanTamUng();
    //    }
    //    else
    //    {
    //        RadComboBox cbKiemTra = (RadComboBox)sender;
    //        Obj = new clsObj();
    //        Obj.Parameter = new string[] { "@SoPhieu", "@NhanVienBPTCKT", "@BPTCKTKiemtra" };
    //        Obj.ValueParameter = new object[] { Session["SoPhieuTTTU"].ToString(),Session["UserID"].ToString(), cbKiemTra.SelectedValue };
    //        Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_Update";
    //        Sql.fNonGetData(Obj);
    //        if (Obj.KetQua < 1)
    //        {
    //            lbLoi.Text = "<font color='red'>Xác nhận số phiếu <b><font color='black'>" + Session["SoPhieuTTTU"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
    //        }
    //        else
    //        {
    //            lbLoi.Text = "<font color='blue'>Đã xác nhận số phiếu<b><font color='black'>" + Session["SoPhieuTTTU"].ToString() + "</font></b> thành công.</font>";
    //           // fLoadDonVi();
    //            //fLoadPhuTrachDonVi();
    //            //fLoadNguoiDuocThanhToan();
    //            FLoadThanhToanTamUng();
    //            Session["SoPhieuTTTU"] = String.Empty;
    //           // FLoadChiTietThanhToanTamUngBySession_SoPhieu();
               
    //        }
    //    }

    //}

    protected void RGCTTTTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadThanhToanTamUng();   
    }
    protected void RGCTTTTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadThanhToanTamUng();   
    }
    #endregion

    #region Kiểm tra giấy thanh toán tạm ứng
    protected void btnKTGTTTU_Click(object sender, ImageClickEventArgs e)
    {
        for (int i = 0; i < RGTTTU.Items.Count; i++)
        {
            CheckBox chkSelect = RGTTTU.Items[i].FindControl("chkSelect") as CheckBox;
            if (chkSelect.Checked)
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoPhieu", "@NhanVienBPTCKT" };
                Obj.ValueParameter = new object[] { RGTTTU.Items[i]["SoPhieu"].Text, Session["UserID"].ToString() };
                Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_PhieuDeNghiThanhToan";
                Sql.fNonGetData(Obj);
              
            }
        }
        
        FLoadThanhToanTamUng();
        fLoadMaDVTraPhieuGTTTU();
        fLoadNguoiDuocThanhToanTraPhieuGTTTU();
        FLoadTraPhieuThanhToanTamUng();


      
    }
    #endregion

    #region Trả phiếu thanh toán tạm ứng

    void fLoadMaDVTraPhieuGTTTU()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        RC_TraPhieuGTTTU.DataSource = Obj.Dt;
        RC_TraPhieuGTTTU.DataBind();
        RC_TraPhieuGTTTU.SelectedIndex = 0;

        //if (madv == "KDND")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV1";
        //    Sql.fGetData(Obj);
        //    RC_TraPhieuGTTTU.DataSource = Obj.Dt;
        //    RC_TraPhieuGTTTU.DataBind();
        //    RC_TraPhieuGTTTU.SelectedIndex = 0;

        //}
        //else
        //{
        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV2";
        //    Sql.fGetData(Obj);
        //    RC_TraPhieuGTTTU.DataSource = Obj.Dt;
        //    RC_TraPhieuGTTTU.DataBind();
        //    RC_TraPhieuGTTTU.SelectedIndex = 0;

        //}

    }
    void FLoadMaBPByIDTraPhieuGTTTU()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { RC_TraPhieuGTTTU.SelectedValue };

        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBPGTTTU.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }
        }
    }


    void fLoadNguoiDuocThanhToanTraPhieuGTTTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@TienMat" };
        Obj.ValueParameter = new object[] { txtMaBPGTTTU.Text, ddlLoaiThanhToan_TraPhieuGTTTU.SelectedValue };
        Obj.SpName = "sp_ChungTuThanhToanTamUng_KeToanTraPhieu_GetMaNV";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan_TraPhieuGTTTU.DataSource = Obj.Dt;
        ddlNguoiThanhToan_TraPhieuGTTTU.DataBind();
        //ddlNguoiThanhToan2.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi_TraPhieuGTTTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { RC_TraPhieuGTTTU.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_PhuTrachDonViByMaCS";

        Sql.fGetData(Obj);
        ddlPhuTrachDonVi_TraPhieuGTTTU.DataSource = Obj.Dt;
        ddlPhuTrachDonVi_TraPhieuGTTTU.DataBind();
    }
    void FLoadTraPhieuThanhToanTamUng()
    {

        if (ddlLoaiThanhToan_TraPhieuGTTTU.SelectedValue == "TM")
        {
            RGTraPhieuGTTTU.Columns[4].Visible = false;
            RGTraPhieuGTTTU.Columns[5].Visible = false;
            RGTraPhieuGTTTU.Columns[6].Visible = false;
        }
        else
        {
            RGTraPhieuGTTTU.Columns[4].Visible = true;
            RGTraPhieuGTTTU.Columns[5].Visible = true;
            RGTraPhieuGTTTU.Columns[6].Visible = true;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap", "@TienMat" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan_TraPhieuGTTTU.SelectedValue, ddlLoaiThanhToan_TraPhieuGTTTU.SelectedValue };
        Obj.SpName = "sp_GiayThanhToanTamung_KTTraPhieu_Load";
        Sql.fGetData(Obj);
        RGTraPhieuGTTTU.DataSource = Obj.Dt;
        RGTraPhieuGTTTU.DataBind();
    }
    protected void RC_TraPhieuGTTTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDTraPhieuGTTTU();
        fLoadPhuTrachDonVi_TraPhieuGTTTU();
        fLoadNguoiDuocThanhToanTraPhieuGTTTU();
        FLoadTraPhieuThanhToanTamUng();
    }
    protected void ddlNguoiThanhToan_TraPhieuGTTTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadTraPhieuThanhToanTamUng();
    }
    protected void ddlLoaiThanhToan_TraPhieuGTTTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadNguoiDuocThanhToanTraPhieuGTTTU();
        FLoadTraPhieuThanhToanTamUng();
    }


    protected void RGTraPhieuGTTTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadTraPhieuThanhToanTamUng();
    }
    protected void RGTraPhieuGTTTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadTraPhieuThanhToanTamUng();
    }
    protected void RGTraPhieuGTTTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateTraPhieu(commandArgsAccept[0].ToString());

            FLoadTraPhieuThanhToanTamUng();
            fLoadMaDV();
            fLoadNguoiDuocThanhToan();
            FLoadThanhToanTamUng();
           
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadTraPhieuThanhToanTamUng();
        }
    }

    #endregion

    #region Xem xét Chứng từ thanh toán không tạm ứng (RadPageView2)

    void fLoadMaDV2()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        CboMaDV2.DataSource = Obj.Dt;
        CboMaDV2.DataBind();
        CboMaDV2.SelectedIndex = 0;

        //if (madv == "KDND")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV1";
        //    Sql.fGetData(Obj);
        //    CboMaDV2.DataSource = Obj.Dt;
        //    CboMaDV2.DataBind();
        //    CboMaDV2.SelectedIndex = 0;

        //}
        //else
        //{
        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV2";
        //    Sql.fGetData(Obj);
        //    CboMaDV2.DataSource = Obj.Dt;
        //    CboMaDV2.DataBind();
        //    CboMaDV2.SelectedIndex = 0;

        //}

    }
    void FLoadMaBPByIDCS2()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV2.SelectedValue };

        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
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

    
    void fLoadNguoiDuocThanhToan2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@TienMat" };
        Obj.ValueParameter = new object[] { txtMaBP2.Text, ddlLoaiThanhToan2.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_GetNguoiDcThanhToanByMaBP2";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan2.DataSource = Obj.Dt;
        ddlNguoiThanhToan2.DataBind();
        //ddlNguoiThanhToan2.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV2.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_PhuTrachDonViByMaCS";
        //Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi2.DataSource = Obj.Dt;
        ddlPhuTrachDonVi2.DataBind();
    }
    void FLoadThanhToanKhongTamUng()
    {
        if (ddlLoaiThanhToan2.SelectedValue == "TM")
        {
            RGTTKTU.Columns[5].Visible = false;
            RGTTKTU.Columns[6].Visible = false;
            RGTTKTU.Columns[7].Visible = false;
        }
        else
        {
            RGTTKTU.Columns[5].Visible = true;
            RGTTKTU.Columns[6].Visible = true;
            RGTTKTU.Columns[7].Visible = true;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap", "@TienMat" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan2.SelectedValue, ddlLoaiThanhToan2.SelectedValue };
      //  Obj.SpName = "sp_ChungTuThanhToanKhongTamUng_KTKiemTra_Load";
        Obj.SpName = "sp_GiayDeNghiThanhToan_KTKiemTra_Load";
        Sql.fGetData(Obj);
        RGTTKTU.DataSource = Obj.Dt;
        RGTTKTU.DataBind();
    }
   

    protected void CboMaDV2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Session["SoPhieuTTKTU"] = String.Empty;
        FLoadMaBPByIDCS2();
        fLoadNguoiDuocThanhToan2();
        FLoadThanhToanKhongTamUng();
        fLoadPhuTrachDonVi2();
    
    }
    protected void ddlLoaiThanhToan2_SelectedIndexChanged(object sender, EventArgs e)
    {

        Session["SoPhieuTTKTU"] = String.Empty;

       
       
        fLoadNguoiDuocThanhToan2();
        FLoadThanhToanKhongTamUng();       
      
    }
    protected void ddlNguoiThanhToan2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuTTKTU"] = String.Empty;
        FLoadThanhToanKhongTamUng();
      
    }

    protected void RGTTKTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadThanhToanKhongTamUng();
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
      
       
    }
    protected void RGTTKTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //foreach (GridDataItem item in RGTTKTU.Items)
        //{
        //    (item["BPTCKTKiemtra"].FindControl("cbKTKiemTraKTU") as RadComboBox).Text = (item["BPTCKTKiemtra"].FindControl("hfKTKiemTraKTU") as HiddenField).Value;
        //    (item["BPTCKTKiemtra"].FindControl("cbKTKiemTraKTU") as RadComboBox).SelectedValue = (item["BPTCKTKiemtra"].FindControl("hfKTKiemTraKTU") as HiddenField).Value;
        //}
    }

    protected void RGCTTTKTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadThanhToanKhongTamUng();
    }
    protected void RGCTTTKTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadThanhToanKhongTamUng();
    }

    protected void btnKiemTra_Click(object sender, ImageClickEventArgs e)
    {
        for (int i = 0; i < RGTTKTU.Items.Count; i++)
        {
            CheckBox chkSelect = RGTTKTU.Items[i].FindControl("chkSelect") as CheckBox;
            if (chkSelect.Checked)
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoPhieu", "@NhanVienBPTCKT" };
                Obj.ValueParameter = new object[] { RGTTKTU.Items[i]["SoPhieu"].Text, Session["UserID"].ToString() };
                Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_PhieuDeNghiThanhToan";
                Sql.fNonGetData(Obj);          

               
            }
        }
        FLoadThanhToanKhongTamUng();
    
        fLoadMaDVTraPhieuDNTT();
        fLoadNguoiDuocThanhToanTraPhieuDNTT();
        FLoadTraPhieuDeNghiThanhToan();
      

    }

    #endregion

    #region trả phiếu đề nghị thanh toán
   
    void fLoadMaDVTraPhieuDNTT()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        RC_TraPhieuDNTT.DataSource = Obj.Dt;
        RC_TraPhieuDNTT.DataBind();
        RC_TraPhieuDNTT.SelectedIndex = 0;

        //if (madv == "KDND")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV1";
        //    Sql.fGetData(Obj);
        //    RC_TraPhieuDNTT.DataSource = Obj.Dt;
        //    RC_TraPhieuDNTT.DataBind();
        //    RC_TraPhieuDNTT.SelectedIndex = 0;

        //}
        //else
        //{
        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_KeToanTraPhieuTU_LoadDV2";
        //    Sql.fGetData(Obj);
        //    RC_TraPhieuDNTT.DataSource = Obj.Dt;
        //    RC_TraPhieuDNTT.DataBind();
        //    RC_TraPhieuDNTT.SelectedIndex = 0;

        //}

    }
    void FLoadMaBPByIDTraPhieuGDNTT()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { RC_TraPhieuDNTT.SelectedValue };

        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBPDNTT.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }
        }
    }


    void fLoadNguoiDuocThanhToanTraPhieuDNTT()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@TienMat" };
        Obj.ValueParameter = new object[] { txtMaBPDNTT.Text, ddlLoaiThanhToan_TraPhieuGDNTT.SelectedValue };
        Obj.SpName = "sp_ChungTuThanhToan_KeToanTraPhieu_GetMaNV";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan_TraPhieuGDNTT.DataSource = Obj.Dt;
        ddlNguoiThanhToan_TraPhieuGDNTT.DataBind();
        //ddlNguoiThanhToan2.SelectedValue = Session["UserID"].ToString();
    }
    void fLoadPhuTrachDonVi_TraPhieuDNTT()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { RC_TraPhieuDNTT.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_PhuTrachDonViByMaCS";
     
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi_TraPhieuGDNTT.DataSource = Obj.Dt;
        ddlPhuTrachDonVi_TraPhieuGDNTT.DataBind();
    }
    protected void RC_TraPhieuDNTT_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDTraPhieuGDNTT();
        fLoadPhuTrachDonVi_TraPhieuDNTT();
        fLoadNguoiDuocThanhToanTraPhieuDNTT();       
        FLoadTraPhieuDeNghiThanhToan();
    }
    protected void ddlNguoiThanhToan_TraPhieuGDNTT_SelectedIndexChanged(object sender, EventArgs e)
    {     
       
        FLoadTraPhieuDeNghiThanhToan();
    }
    protected void ddlLoaiThanhToan_TraPhieuGDNTT_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        fLoadNguoiDuocThanhToanTraPhieuDNTT();      
        FLoadTraPhieuDeNghiThanhToan();
    }  
   

    void FLoadTraPhieuDeNghiThanhToan()
    {

        if (ddlLoaiThanhToan_TraPhieuGDNTT.SelectedValue == "TM")
        {
            RGTraPhieuDNTT.Columns[4].Visible = false;
            RGTraPhieuDNTT.Columns[5].Visible = false;
            RGTraPhieuDNTT.Columns[6].Visible = false;
        }
        else
        {
            RGTraPhieuDNTT.Columns[4].Visible = true;
            RGTraPhieuDNTT.Columns[5].Visible = true;
            RGTraPhieuDNTT.Columns[6].Visible = true;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap", "@TienMat" };
        Obj.ValueParameter = new object[] { ddlNguoiThanhToan_TraPhieuGDNTT.SelectedValue, ddlLoaiThanhToan_TraPhieuGDNTT.SelectedValue };       
        Obj.SpName = "sp_GiayDeNghiThanhToan_KTTraPhieu_Load";
        Sql.fGetData(Obj);
        RGTraPhieuDNTT.DataSource = Obj.Dt;
        RGTraPhieuDNTT.DataBind();
    }
    void UpdateTraPhieu(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "SP_UpdateTraPhieuThanhToan";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='blue'>Trả phiếu thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Trả phiếu thất bại.</font>";
        }


    }
    protected void RGTraPhieuDNTT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadTraPhieuDeNghiThanhToan();
    }
    protected void RGTraPhieuDNTT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadTraPhieuDeNghiThanhToan();
    }
    protected void RGTraPhieuDNTT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateTraPhieu(commandArgsAccept[0].ToString());  
          
            FLoadTraPhieuDeNghiThanhToan();      
            fLoadMaDV2();
            fLoadNguoiDuocThanhToan2();
            FLoadThanhToanKhongTamUng();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadTraPhieuDeNghiThanhToan();
        }
    }

    #endregion

    #region Xem xét Giấy nộp tiền (RadPageView3)

    void fLoadDonVi3()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        CboMaDV3.DataSource = Obj.Dt;
        CboMaDV3.DataBind();
        CboMaDV3.SelectedIndex = 0;

        //if (madv == "KDND")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_ChungTuNopTien_KTKiemTra_LoadDV1";
        //    Sql.fGetData(Obj);
        //    CboMaDV3.DataSource = Obj.Dt;
        //    CboMaDV3.DataBind();
        //    CboMaDV3.SelectedIndex = 0;

        //}
        //else
        //{
        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { };
        //    Obj.ValueParameter = new object[] { };
        //    Obj.SpName = "sp_ChungTuNopTien_KTKiemTra_LoadDV2";
        //    Sql.fGetData(Obj);
        //    CboMaDV3.DataSource = Obj.Dt;
        //    CboMaDV3.DataBind();
        //    CboMaDV3.SelectedIndex = 0;

        //}
    }

    void FLoadMaBPByIDCS3()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV3.SelectedValue };

        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP3.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }

    void fLoadNguoiNopTien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP3.Text };
        //Obj.SpName = "LoadNhanVienTheoPhongBan_PhieuNopTien";
        Obj.SpName = "sp_KeToanKiemTraChungTuNopTien_GetNguoiNopTien";
        Sql.fGetData(Obj);
        ddlNguoiNopTien.DataSource = Obj.Dt;
        ddlNguoiNopTien.DataBind();      
    }
    void fLoadPhuTrachDonVi3()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { CboMaDV3.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraThanhToanTamUng_PhuTrachDonViByMaCS";
        //Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi3.DataSource = Obj.Dt;
        ddlPhuTrachDonVi3.DataBind();

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV" };
        //Obj.ValueParameter = new object[] { CboMaDV3.SelectedValue };
        //Obj.SpName = "sp_GetGD_ByMaDV";
        //Sql.fGetData(Obj);
        //ddlPhuTrachDonVi3.DataSource = Obj.Dt;
        //ddlPhuTrachDonVi3.DataBind();
    }

    protected void CboMaDV3_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        Session["SoPhieuNopTien"] = String.Empty;
        FLoadMaBPByIDCS3();
        fLoadNguoiNopTien();
        FLoadChungTuNopTien();      
        fLoadPhuTrachDonVi3();
        FLoadChiTietNopTienBySession_SoPhieu();
    }

    void FLoadChungTuNopTien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap" };
        Obj.ValueParameter = new object[] { ddlNguoiNopTien.SelectedValue };
        Obj.SpName = "sp_ChungTuNopTienKTKiemTra_Load";
        Sql.fGetData(Obj);
        RGPNT.DataSource = Obj.Dt;
        RGPNT.DataBind();

    }
    void FLoadChiTietNopTienBySession_SoPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@MaNV" };
        Obj.ValueParameter = new object[] { Session["SoPhieuNopTien"].ToString(), ddlNguoiNopTien.SelectedValue };
        Obj.SpName = "sp_ChiTietNopTien_KTKiemTra_LoadBySessionSoPhieu";
        Sql.fGetData(Obj);
        RGCTPNT.DataSource = Obj.Dt;
        RGCTPNT.DataBind();
    }
    protected void ddlNguoiNopTien_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuNopTien"] = String.Empty;
        FLoadChungTuNopTien();
        FLoadChiTietNopTienBySession_SoPhieu();
    }
    protected void RGCTPNT_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RGCTPNT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadChiTietNopTienBySession_SoPhieu();
    }
    protected void RGCTPNT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadChiTietNopTienBySession_SoPhieu();
    }
    protected void RGPNT_ItemCommand(object sender, GridCommandEventArgs e)
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
                Session["SoPhieuNopTien"] = String.Empty;
                FLoadChiTietNopTienBySession_SoPhieu();
            }

        }
    }
    protected void RGPNT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadChungTuNopTien();
    }
    protected void RGPNT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadChungTuNopTien();
    }
    protected void RGPNT_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuNopTien"] = RGPNT.SelectedValue == null ? "" : RGPNT.SelectedValue;
        FLoadChiTietNopTienBySession_SoPhieu();
    }
    protected void RGPNT_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }

    protected void cbKiemTraPNT_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (Session["SoPhieuNopTien"].ToString() == "" || Session["SoPhieuNopTien"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn số phiếu.</font>";          
        }
        else
        {
            RadComboBox cbKiemTra = (RadComboBox)sender;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu", "@NguoiKT", "@KiemTra" };
            Obj.ValueParameter = new object[] { Session["SoPhieuNopTien"].ToString(), Session["UserID"].ToString(), cbKiemTra.SelectedValue };
            Obj.SpName = "sp_ChungTuNopTien_KTKiemTra_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xác nhận chứng từ nộp tiền <b><font color='black'>" + Session["SoPhieuNopTien"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã xác nhận chứng từ nộp tiền <b><font color='black'>" + Session["SoPhieuNopTien"].ToString() + "</font></b> thành công.</font>";
              
              
            }
        }
        Session["SoPhieuNopTien"] = String.Empty;
        FLoadChungTuNopTien();       
        FLoadChiTietNopTienBySession_SoPhieu();
        #region Load trả phiếu nộp tiền
        fLoadDonViTraPhieu();
        fLoadNguoiNopTien_TraPhieu();
        FLoadChungTuNopTien_TraPhieu();
        FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
        #endregion
    }

    #endregion

    #region Tra phieu nop tien

    void fLoadDonViTraPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        ddlDonViNopTien_TraPhieu.DataSource = Obj.Dt;
        ddlDonViNopTien_TraPhieu.DataBind();
        ddlDonViNopTien_TraPhieu.SelectedIndex = 0;
    }
  
    void FLoadMaBPByIDCS4()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonViNopTien_TraPhieu.SelectedValue };
        Obj.SpName = "sp_KeToanKiemTraPhieuTU_GetMaBPByIDMaCS";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP4.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }
    void fLoadNguoiNopTien_TraPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP4.Text };
        //Obj.SpName = "LoadNhanVienTheoPhongBan_PhieuNopTien";
        Obj.SpName = "sp_KeToanKiemTraChungTuNopTien_GetNguoiNopTien_TraPhieu";
        Sql.fGetData(Obj);
        ddlNguoiNopTien_TraPhieu.DataSource = Obj.Dt;
        ddlNguoiNopTien_TraPhieu.DataBind();
    }
    protected void ddlDonViNopTien_TraPhieu_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDCS4();
        fLoadNguoiNopTien_TraPhieu();
        FLoadChungTuNopTien_TraPhieu();
        FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
       
    }
    protected void ddlNguoiNopTien_TraPhieu_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuNopTien_TraPhieu"] = String.Empty;
        FLoadChungTuNopTien_TraPhieu();
        FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
    }

    void FLoadChungTuNopTien_TraPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NguoiLap" };
        Obj.ValueParameter = new object[] { ddlNguoiNopTien_TraPhieu.SelectedValue };
        Obj.SpName = "sp_ChungTuNopTienKTTraPhieu_Load";
        Sql.fGetData(Obj);
        RG_NopTien_TraPhieu.DataSource = Obj.Dt;
        RG_NopTien_TraPhieu.DataBind();

    }
    void FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@MaNV" };
        Obj.ValueParameter = new object[] { Session["SoPhieuNopTien_TraPhieu"].ToString(), ddlNguoiNopTien_TraPhieu.SelectedValue };
        Obj.SpName = "sp_ChiTietNopTien_KTTraPhieu_LoadBySessionSoPhieu";
        Sql.fGetData(Obj);
        RGChiTietNopTien_TraPhieu.DataSource = Obj.Dt;
        RGChiTietNopTien_TraPhieu.DataBind();
    }
    void UpdateNopTien_TraPhieu(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "sp_UpdateNopTien_TraPhieu";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='blue'>Trả phiếu thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Trả phiếu thất bại.</font>";
        }


    }
    protected void RG_NopTien_TraPhieu_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoPhieuNopTien_TraPhieu"] = RG_NopTien_TraPhieu.SelectedValue == null ? "" : RG_NopTien_TraPhieu.SelectedValue;
        FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
    }
    protected void RG_NopTien_TraPhieu_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";



        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadChungTuNopTien_TraPhieu();
        }
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["SoPhieuNopTien_TraPhieu"] = String.Empty;
                FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();
            }

        }

        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateNopTien_TraPhieu(commandArgsAccept[0].ToString());

            Session["SoPhieuNopTien_TraPhieu"] = String.Empty;
            FLoadChungTuNopTien_TraPhieu();
            FLoadChiTietNopTien_TraPhieu_BySession_SoPhieu();

            fLoadDonVi3();
            FLoadMaBPByIDCS3();
            
            fLoadNguoiNopTien();
            FLoadChungTuNopTien();
            FLoadChiTietNopTienBySession_SoPhieu();
        
        }

    }

    #endregion

   
}