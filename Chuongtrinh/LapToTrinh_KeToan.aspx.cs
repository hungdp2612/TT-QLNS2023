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
using System.Data;

public partial class Chuongtrinh_LapToTrinh_KeToan : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    
    ReportDocument report = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["SoToTrinh"] = String.Empty;
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            fLoadMaDV();
            FLoadMaBPByIDCS();
            fLoadPhuTrachDonVi();
       
            fLoadDonVi();
            LoadNguoiPheDuyetTheoPhongBan();      
         
            fLoad();

            #region Hiệu chỉnh tờ trình

            rnNamHieuChinhToTrinh.Value = DateTime.Now.Year;
            rnThangHieuChinhToTrinh.Value = DateTime.Now.Month;

            fLoadMaDVHieuChinh();
            FLoadMaBPByIDCSHieuChinh();


            fLoadSoToTrinh();
            fLoadToTrinh();         
            
            fLoadChiPhi("");
            #endregion


        }
        if (Session["ReloadChiTietToTrinh"] != null)
        {
            FLoadMaBPByIDCS();
            fLoad();
            Session["ReloadChiTietToTrinh"] = null;
        }
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }

    #region Tao To Trinh   

    void fLoad()
    {
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@NguoiGoi" };
        //Obj.ValueParameter = new object[] { mabp, Session["UserID"].ToString() };
        //Obj.SpName = "sp_ToTrinh_KeToan_Load";

        Obj.Parameter = new string[] { "@MaDV", "@Nam","@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_ToTrinh_KeToan_LoadBy_MaDV_Nam_Thang";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    void fLoadMaDV()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] {  };
       // Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV";
        //Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV_AndMaBP";
        Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV_AndMaBP2";
        Sql.fGetData(Obj);
        ddlMaDV.DataSource = Obj.Dt;
        ddlMaDV.DataBind();
        // ddlMaDV.Items.RemoveAt(0);
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
            try
            {
              

                txtChucVuNguoiGui.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
                txtNguoiGui.Text = Obj.Dt.Rows[0]["Hoten"].ToString();               
                Session["MaDV"] = TxtMaDV.Text;
            }
            catch { }

        }
        else
        {
           
        }

    }
  

    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.SpName = "sp_ToTrinh_KeToan_GetNguoiXemXetTheoDV2";
        Sql.fGetData(Obj);
        cbXemXet.DataSource = Obj.Dt;
        cbXemXet.DataBind();
    }

    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.Connectionstring = wqlvattu;
        //Obj.SpName = "sp_ToTrinh_KeToan_GetNguoiPheDuyetTheoDV";
      
        //Obj.SpName = "sp_ToTrinh_KeToan_GetThongTinNguoiPheDuyet";
        //Obj.SpName = "sp_ToTrinh_KeToan_GetThongTinNguoiPheDuyet2";
        Obj.SpName = "sp_ToTrinh_KeToan_GetThongTinNguoiPheDuyet3";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                cbNguoiPheDuyet.DataSource = Obj.Dt;
                cbNguoiPheDuyet.DataBind();
                txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();        
              
                txtBoPhanNhan.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            }
            catch { }
        }
        else
        {

        }


    }
    void fLoadChiTietToTrinh_BySoToTrinh_CapNhatNSBoSung()
    {
        DataTable dataCTToTrinh = new DataTable();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString() };
        Obj.SpName = "sp_ChiTietToTrinh_KeToan_GetAll_BySoToTrinh";
        Sql.fGetData(Obj);
        dataCTToTrinh = Obj.Dt;
        for (int i = 0; i < dataCTToTrinh.Rows.Count; i++)
        {

            string Madv = Convert.ToString(dataCTToTrinh.Rows[i]["MaDV"]);
            int nam = Convert.ToInt32(dataCTToTrinh.Rows[i]["Nam"]);
            int thang = Convert.ToInt32(dataCTToTrinh.Rows[i]["Thang"]);
            string mschiphi = Convert.ToString(dataCTToTrinh.Rows[i]["MSChiPhi"]);
            double sotien = Convert.ToDouble(dataCTToTrinh.Rows[i]["SoTien"]);
            double tigia = Convert.ToDouble(dataCTToTrinh.Rows[i]["TiGia"]);
            string idkhoa = ddlMaDV.SelectedValue + "-" + nam + thang;
            string idkhoact = ddlMaDV.SelectedValue + "-" + nam + thang + mschiphi + Session["SoToTrinh"];
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_Khoa", "@MaBP", "@MaNV", "@MaNVXX", "@MaNVPD", "@MSChiPhi", "@Nam", "@Thang", "@SoTien", "@SoToTrinh", "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { idkhoa, Madv, Session["UserID"].ToString(), cbXemXet.SelectedValue,cbNguoiPheDuyet.SelectedValue, mschiphi, nam, thang, sotien*tigia, Session["SoToTrinh"].ToString(), idkhoact };
            Obj.SpName = "sp_BoSungNganSach_Insert_KeToan";          
            Sql.fNonGetData(Obj);
        }
    }
    string countTT;
    protected void cbXacNhan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            if (Session["SoToTrinh"].ToString() == "" || Session["SoToTrinh"].ToString() == null)
            {
                FLoadMaBPByIDCS();
                fLoad();
                throw new Exception("Chưa chọn tờ trình...");
            }
            else
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh" };
                Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString() };
                Obj.SpName = "sp_ToTrinh_ChiTietToTrinh_Count";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTT = Obj.Dt.Rows[0]["CountToTrinh"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTT) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tờ trình nên không được xác nhận.</font>";
                    FLoadMaBPByIDCS();
                    fLoad();
                    fLoadChiTietToTrinh_BySoToTrinh_CapNhatNSBoSung();
                    Session["SoToTrinh"] = String.Empty;
                }
                else
                {
                    RadComboBox cbPD = (RadComboBox)sender;
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh", "@HieuLucPD", "@GhiChuCuaLanhDao" };
                    Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString(), cbPD.SelectedValue, "Đồng ý" };
                    Obj.SpName = "sp_ToTrinh_KeToan_XacNhan";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xác nhận tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Đã xác nhận tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thành công.</font>";
                        FLoadMaBPByIDCS();
                        fLoad();
                        fLoadChiTietToTrinh_BySoToTrinh_CapNhatNSBoSung();
                        Session["SoToTrinh"] = String.Empty;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }

    }
    protected void cbNguoiPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
    }
   // string mabp;
    void FLoadMaBPByIDCS()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };

        Obj.SpName = "sp_ToTrinh_KeToan_GetIDCoSo2";
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
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();
        string sototrinh;
        string veviec = txtVeViec.Text;
       
     
        string nguoigui = Session["UserID"].ToString();    
     
        string chucvunguoigui = txtChucVuNguoiGui.Text;     
       

       // string tigia = rnTyGia.Text;
        
       



        #region Tạo to trinh

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.SpName = "sp_TaoToTrinh";
        Sql.fGetData(Obj);

        if (Obj.Dt.Rows.Count < 1)
        {
            lbLoi.Text = "<font color='red'>Không tạo được tờ trình.</font>";
            return;
        }
        else
        {
            sototrinh = Obj.Dt.Rows[0]["ToTrinh"].ToString();
        }
        #endregion



        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", "@Nam", "@Thang", "@VeViec", "@NguoiGoi", "@ChucVuNG", "@MaDV", "@MaNVXemXet", "@NguoiNhan", "@BoPhanNhan", "@ChucVuNN", "@LoaiTien", "@TiGia" };
        Obj.ValueParameter = new object[] { sototrinh, int.Parse(rnNam.Text), int.Parse(rnThang.Text), veviec, nguoigui, chucvunguoigui, txtMaBP.Text, cbXemXet.SelectedValue, cbNguoiPheDuyet.SelectedValue, txtBoPhanNhan.Text, txtChucVuNguoiNhan.Text, "VND", 1 };



        Obj.SpName = "sp_ToTrinh_KeToan_Insert";

            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Đã có tờ trình <b><font color='black'>" + sototrinh + "</font></b> trong danh sách.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thêm tờ trình <b><font color='black'>" + sototrinh + "</font></b> thành công.</font>";
            }

      
        #endregion
        fLoad();
    }
   
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            RG.MasterTableView.IsItemInserted = false;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/LapToTrinh_Update.ascx";
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

        }

        if (e.Item.Selected == false)
        {
            Session["SoToTrinh"] = String.Empty;          
          
        }

    }
  
    int demtotrinh;
    string manv;
    bool ktkiemtra;
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };

        Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                manv = Obj.Dt.Rows[0]["NguoiGoi"].ToString();

            }
            catch { }
        }
        else
        {

        }       
            //if (clsConvertHelper.Tobool(RG.Items[e.Item.ItemIndex]["KiemTra"].Text) == true)
            //{
            //    lbLoi.Text = "<font color='red'>Tờ trình  <b><font color='black'> " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text + "</font></b> đã được phê duyệt nên không xóa được.</font>";
            //    fLoad();
            //}
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh" };
            Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };

            Obj.SpName = "sp_ToTrinh_KeToan_LayThongTinPheDuyetBySoToTrinh";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {
                    ktkiemtra = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["HieuLucPD"].ToString());

                }
                catch { }
            }
            else
            {

            }
            if (ktkiemtra == true)
            {
                lbLoi.Text = "<font color='red'>Tờ trình  <b><font color='black'> " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text + "</font></b> đã được xác nhận nên không xóa được.</font>";
                FLoadMaBPByIDCS();
                fLoad();
            }

            else
            {

                string SoToTrinh = RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
                string MaDV = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@MaDV" };
                Obj.ValueParameter = new object[] { SoToTrinh, MaDV };
                Obj.SpName = "sp_ToTrinh_DemChiTietToTrinh";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        demtotrinh = int.Parse(Obj.Dt.Rows[0]["DemChiTietToTrinh"].ToString());

                    }
                    catch { }
                }
                else
                {

                }
                if (demtotrinh == 0)
                {
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { SoToTrinh };
                    Obj.SpName = "sp_ToTrinh_Delete";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
                    }
                    FLoadMaBPByIDCS();
                    fLoad();
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Đã có chi tiết tờ trình nên không xóa được.</font>";
                    FLoadMaBPByIDCS();
                    fLoad();
                }
            }
       


    }
    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        fLoad();
    } 


    protected void cbLoaiTien_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
       // fLoadTiGia();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }
   
    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbXemXet.Text = "";
        cbNguoiPheDuyet.Text = "";
        txtBoPhanNhan.Text = "";
        txtChucVuNguoiNhan.Text = "";      
        FLoadMaBPByIDCS();
        fLoadPhuTrachDonVi();
      
        LoadNguoiPheDuyetTheoPhongBan();
        fLoad();
    }


    protected void RG_ItemDataBound(object sender, GridItemEventArgs e)
    {
        foreach (GridDataItem item in RG.Items)
        {
            (item["HieuLucPD"].FindControl("cbXacNhan") as RadComboBox).Text = (item["HieuLucPD"].FindControl("hfPheDuyet") as HiddenField).Value;
            (item["HieuLucPD"].FindControl("cbXacNhan") as RadComboBox).SelectedValue = (item["HieuLucPD"].FindControl("hfPheDuyet") as HiddenField).Value;
        }
    }
    protected void RG_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoToTrinh"] = RG.SelectedValue == null ? "" : RG.SelectedValue;

    }

    #endregion


    #region Hiệu chỉnh tờ trinh
    void fLoadMaDVHieuChinh()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };       
        Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV_AndMaBP2";
        Sql.fGetData(Obj);
        ddlDonViHieuChinhToTrinh.DataSource = Obj.Dt;
        ddlDonViHieuChinhToTrinh.DataBind();
        // ddlMaDV.Items.RemoveAt(0);
    }
    string mabpHC;
    void FLoadMaBPByIDCSHieuChinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonViHieuChinhToTrinh.SelectedValue };

        Obj.SpName = "sp_ToTrinh_KeToan_GetIDCoSo2";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                mabpHC = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }

    void fLoadSoToTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam",
                                        "@MaDV"};
        Obj.ValueParameter = new object[] { int.Parse(rnThangHieuChinhToTrinh.Value.ToString()),int.Parse(rnNamHieuChinhToTrinh.Value.ToString()), 
                                        mabpHC };
        Obj.SpName = "sp_ToTrinh_Load_HieuChinh";
        Sql.fGetData(Obj);
        ddlToTrinh.DataSource = Obj.Dt;
        ddlToTrinh.DataBind();
        
        //ddlToTrinh.SelectedIndex = 0;


    }

    void fLoadToTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { ddlToTrinh.SelectedValue };
        Obj.SpName = "sp_ToTrinh_ChiTiet_HieuChinh";
        Sql.fGetData(Obj);
        RGTraCuu.DataSource = Obj.Dt;
        RGTraCuu.DataBind();
    }
    public double fInt(object Value)
    {
        return Convert.ToDouble(Value.ToString());
    }


    protected void ddlDonViHieuChinhToTrinh_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        FLoadMaBPByIDCSHieuChinh();
        cbMaSoChiPhi.Text = "";
        cbMaSoChiPhi.SelectedValue = null;
        fLoadChiPhi("");

        //ddlToTrinh.Text = "";
        fLoadSoToTrinh();
        fLoadToTrinh();

    }
    protected void ddlToTrinh_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        FLoadMaBPByIDCSHieuChinh();
       // fLoadSoToTrinh();
        fLoadToTrinh();
    }

    string madv;

    void GetMaDVByMaBP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { mabpHC };
        Obj.SpName = "sp_ChiTietToTrinh_KeToan_GetIDCoSoAndMaDVCuBoPhan";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                madv = Obj.Dt.Rows[0]["MaDonVi"].ToString();
            }
            catch { }

        }

    }
    void fLoadChiPhi(string key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP" };
        Obj.ValueParameter = new object[] { key };
        //Obj.SpName = "sp_DmChiPhi_KeHoachNganSach";
        Obj.SpName = "sp_DmChiPhi_KeHoachNganSach_040515";
        Sql.fGetData(Obj);
        cbMaSoChiPhi.DataSource = Obj.Dt;
        cbMaSoChiPhi.DataBind();
        //FLoadMaBPByIDCSHieuChinh();
        //GetMaDVByMaBP();
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@Key" };
        //Obj.ValueParameter = new object[] { madv, key };
        //Obj.SpName = "sp_ChiTietToTrinh_KeToan_GetMaCPByMaDV";
        //Sql.fGetData(Obj);
        //cbMaSoChiPhi.DataSource = Obj.Dt;
        //cbMaSoChiPhi.DataBind();
    }

    protected void cbMaSoChiPhi_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {

    }
    protected void cbMaSoChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
    }
    protected void cbMaSoChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
       
        fLoadChiPhi(e.Text);
    }
  


    protected void RGTraCuu_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        string MSChiPhi = RGTraCuu.Items[e.Item.ItemIndex]["MSChiPhi"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", 
            "@MSChiPhi" };
        Obj.ValueParameter = new object[] { ddlToTrinh.SelectedValue,
            MSChiPhi };
        Obj.SpName = "sp_ToTrinh_HieuChinh_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Xoá thành công.</font>";

            FLoadMaBPByIDCSHieuChinh();
            fLoadToTrinh();
           
        }
        else
        {
            lbLoi.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
        }

        //#region Cập nhật tổng số tiền BS
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@Nam", 
        //    "@Thang", "@MaDV" };
        //Obj.ValueParameter = new object[] { rnNam.Value, 
        //    rnThang.Value, mabpHC };
        //Obj.SpName = "spCapNhatTongBoSung";
        //Sql.fNonGetData(Obj);
        //#endregion

       // string SoToTrinh = ddlToTrinh.SelectedValue;

       // fLoadSoToTrinh();

        //if (ddlToTrinh.Items.FindByValue(SoToTrinh) != null)
        //{
        //    ddlToTrinh.SelectedValue = SoToTrinh;
        //}       
      
    }

    protected void rnSoTienRGTraCuu_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";

        Telerik.Web.UI.RadNumericTextBox rnSoTien = (Telerik.Web.UI.RadNumericTextBox)sender;

        if (rnSoTien.Text == "")
        {
            rnSoTien.Text = "0";
        }

        int Dem = 0;

        for (int i = 0; i < RGTraCuu.Items.Count; i++)
        {
            Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGTraCuu.Items[i].FindControl("rnSoTienRGTraCuu");
            if (rnSoTien == rnSoTienRG)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RGTraCuu.Items[Dem]["MSChiPhi"].Text;
        TextBox tbGhiChuTam = (TextBox)RGTraCuu.Items[Dem].FindControl("tbGhiChuTamTraCuu");

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", 
            "@MSChiPhi", "@SoTien", "@GhiChu" };
        Obj.ValueParameter = new object[] { ddlToTrinh.SelectedValue,
            MSChiPhi, rnSoTien.Value, tbGhiChuTam.Text };
        Obj.SpName = "sp_ToTrinh_HieuChinh_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        //#region Cập nhật tổng số tiền BS
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@Nam", 
        //    "@Thang", "@MaDV" };
        //Obj.ValueParameter = new object[] { rnNam.Value, 
        //    rnThang.Value, mabpHC};
        //Obj.SpName = "spCapNhatTongBoSung";
        //Sql.fNonGetData(Obj);
        //#endregion

        //fLoadNganSach();
        fLoadToTrinh();
    }
    protected void tbGhiChuTamTraCuu_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";

        TextBox tbGhiChu = (TextBox)sender;

       
        int Dem = 0;

        for (int i = 0; i < RGTraCuu.Items.Count; i++)
        {
            TextBox tbGhiChuTam = (TextBox)RGTraCuu.Items[i].FindControl("tbGhiChuTamTraCuu");
            if (tbGhiChu == tbGhiChuTam)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RGTraCuu.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGTraCuu.Items[Dem].FindControl("rnSoTienRGTraCuu");

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", 
            "@MSChiPhi", "@SoTien", "@GhiChu" };
        Obj.ValueParameter = new object[] { ddlToTrinh.SelectedValue,
            MSChiPhi,Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "sp_ToTrinh_HieuChinh_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        #region Cập nhật tổng số tiền BS
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", 
            "@Thang", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam.Value, 
            rnThang.Value, mabpHC };
        Obj.SpName = "spCapNhatTongBoSung";
        Sql.fNonGetData(Obj);
        #endregion
        
        fLoadToTrinh();

    }




    protected void tbXemTraCuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        #region Kiểm tra trùng
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", 
            "@MSChiPhi" };
        Obj.ValueParameter = new object[] { ddlToTrinh.SelectedValue,
            cbMaSoChiPhi.SelectedValue };
        Obj.SpName = "sp_ToTrinh_HieuChinh_KiemTraTrung";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có MaNS này trong tờ trình. Vui lòng dùng cập nhật.</font>";
            return;
        }
        #endregion

        FLoadMaBPByIDCSHieuChinh();

        #region Bổ sung
        string idchitiet = ddlDonViHieuChinhToTrinh.SelectedValue + "-" + rnNam.Value.ToString() + rnThang.Value.ToString() + cbMaSoChiPhi.SelectedValue + ddlDonViHieuChinhToTrinh.SelectedValue+ ddlToTrinh.SelectedValue;
        string idKhoa = ddlDonViHieuChinhToTrinh.SelectedValue + "-" + rnNam.Value.ToString() + rnThang.Value.ToString();
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@Thang", 
                    "@Nam", "@MaDV", 
                    "@MSChiPhi", "@SoToTrinh", 
                    "@NguoiLap", "@SoTien",
                    "@GhiChu","@IdKhoa_CT","@IDKhoa" };
        Obj.ValueParameter = new object[] { rnThang.Value,
                    rnNam.Value, mabpHC,
                    cbMaSoChiPhi.SelectedValue, ddlToTrinh.SelectedValue,
                    Session["UserID"].ToString(), rnSoTien.Value,
                    txtGhichuHieuChinh.Text, idchitiet, idKhoa };
        Obj.SpName = "sp_ToTrinh_HieuChinh_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Lưu thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Lưu thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion

        //#region Cập nhật tổng số tiền BS
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@Nam", 
        //    "@Thang", "@MaDV" };
        //Obj.ValueParameter = new object[] { rnNam.Value, 
        //    rnThang.Value, ddlDonViHieuChinhToTrinh.SelectedValue };
        //Obj.SpName = "spCapNhatTongBoSung";
        //Sql.fNonGetData(Obj);
        //#endregion

       
        fLoadToTrinh();
    }
    protected void rnThangHieuChinhToTrinh_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        FLoadMaBPByIDCSHieuChinh();
       
        fLoadSoToTrinh();
        fLoadToTrinh();
    }
    protected void rnNamHieuChinhToTrinh_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        FLoadMaBPByIDCSHieuChinh();

        fLoadSoToTrinh();
        fLoadToTrinh();
    }
    protected void RGTraCuu_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadToTrinh();
    }
    protected void RGTraCuu_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadToTrinh();
    }
    #endregion
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }
}