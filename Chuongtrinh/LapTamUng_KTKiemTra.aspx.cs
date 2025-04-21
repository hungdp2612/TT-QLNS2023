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
using System.Data.SqlClient;
using System.Configuration;

public partial class Chuongtrinh_LapTamUng_KTKiemTra : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
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
            fLoadDonVi();
            Session["PhieuTU"] = String.Empty;
            fLoadMaDV();
            FLoadMaBPByIDCS();
            fLoadPhieuTU();
            fLoadChiTietPhieuTU();


           
            Session["PhieuTU2"] = String.Empty;
            fLoadMaDV2();
            FLoadMaBPByIDCS2();
            fLoadPhieuTU2();
            fLoadChiTietPhieuTU2();



        }

    }
    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }


    #region Load và xử lý đơn vị
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

    void fLoadMaDV()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["USerID"].ToString() };
        Obj.SpName = "sp_KeToanKiemTraChungTuThanhToan_LoadDV_ByMaNVKeToan";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;     

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
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDCS();
        Session["PhieuTU"] = String.Empty;
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
    }
    #endregion

    #region chi tiết phiếu tạm ứng
    void fLoadChiTietPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MaDV" };
        Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), txtMaBP.Text };
        Obj.SpName = "sp_KeToanKiemTraPhieuTU_LoadChiTietPhieuTU_BySession";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }

    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }


    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {

        fLoadChiTietPhieuTU();
    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChiTietPhieuTU();
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }

    #endregion

    #region Phieu tam ưng và xác nhận phiếu tạm ứng

    void fLoadPhieuTU()
    {
        if (CboMaDV.SelectedValue == "30")
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.SpName = "sp_KeToanKiemTraPhieuTamUng_LoadPhieuTU";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {
                    RDPhieuTU.DataSource = Obj.Dt;
                    RDPhieuTU.DataBind();
                }
                catch { }
            }
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV" };
            Obj.ValueParameter = new object[] { txtMaBP.Text };
            Obj.SpName = "sp_KeToanKiemTraPhieuTamUng_LoadPhieuTU";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {
                    RDPhieuTU.DataSource = Obj.Dt;
                    RDPhieuTU.DataBind();
                }
                catch { }
            }
        }
    }
    protected void RDPhieuTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            lbLoi.Text = "";
            if (e.Item.Selected == false)
            {
                Session["PhieuTU"] = String.Empty;
                fLoadChiTietPhieuTU();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadPhieuTU();
        }
    }
    protected void RDPhieuTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadPhieuTU();
        lbLoi.Text = "";

    }
    protected void RDPhieuTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["PhieuTU"] = RDPhieuTU.SelectedValue == null ? "" : RDPhieuTU.SelectedValue;
        fLoadChiTietPhieuTU();
    }
    protected void RDPhieuTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        foreach (GridDataItem item in RDPhieuTU.Items)
        {
            (item["KTKiemTra"].FindControl("cbKTKiemTra") as RadComboBox).Text = (item["KTKiemTra"].FindControl("hfKiemTra") as HiddenField).Value;
            (item["KTKiemTra"].FindControl("cbKTKiemTra") as RadComboBox).SelectedValue = (item["KTKiemTra"].FindControl("hfKiemTra") as HiddenField).Value;
        }
    }
    protected void RDPhieuTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadPhieuTU();
    }

    protected void cbKTKiemTra_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (Session["PhieuTU"].ToString() == "" || Session["PhieuTU"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn phiếu tạm ứng.</font>";
            fLoadPhieuTU();
        }
        else
        {

            RadComboBox cbKiemTra = (RadComboBox)sender;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@PhieuTU", "@MaNVKT", "@KTKiemTra" };
            Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), Session["UserID"].ToString(), cbKiemTra.SelectedValue };
            Obj.SpName = "sp_PhieuTamUng_KTKiemTra";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xác nhận phiếu tạm ứng <b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã xác nhận phiếu tạm ứng <b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> thành công.</font>";
                Session["PhieuTU"] = String.Empty;
                fLoadPhieuTU();
                fLoadChiTietPhieuTU();

                #region reload tra phieu tam ung
                fLoadMaDV2();
                fLoadPhieuTU2();
                fLoadChiTietPhieuTU2();
                #endregion

            }
        }

    }


    #endregion




    #region đơn vị 2    

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

        Obj.SpName = "sp_KeToanTraPhieuTU_GetMaBPByIDMaCS";
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
    protected void CboMaDV2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDCS2();
        Session["PhieuTU2"] = String.Empty;
        fLoadPhieuTU2();
        fLoadChiTietPhieuTU2();
    }
    #endregion

    #region Phieu tạm ứng 2

    void fLoadPhieuTU2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP2.Text };
        Obj.SpName = "sp_KeToanTraPhieuTamUng_LoadPhieuTU";

        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                RGPhieuTU2.DataSource = Obj.Dt;
                RGPhieuTU2.DataBind();
            }
            catch { }
        }

    }

    void UpdateTraPhieu(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "sp_KeToanTraPhieuTamUng";
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

    protected void RGPhieuTU2_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadPhieuTU2();
    }
    protected void RGPhieuTU2_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadPhieuTU2();
    }
    protected void RGPhieuTU2_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            Session["PhieuTU2"] = RGPhieuTU2.Items[e.Item.ItemIndex]["PhieuTU"].Text;
            fLoadChiTietPhieuTU2();
        }

        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateTraPhieu(commandArgsAccept[0].ToString());
            Session["PhieuTU2"] = String.Empty;
            fLoadPhieuTU2();
            fLoadChiTietPhieuTU2();

            #region reload Phieu tam ung
            fLoadMaDV();
            FLoadMaBPByIDCS();
            fLoadPhieuTU();
            fLoadChiTietPhieuTU();
            #endregion

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadPhieuTU2();
        }
    }

    #endregion


    #region chi tiet phieu tam ung
    void fLoadChiTietPhieuTU2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MaDV" };
        Obj.ValueParameter = new object[] { Session["PhieuTU2"].ToString(), txtMaBP2.Text };
        Obj.SpName = "sp_KeToanTraPhieuTU_LoadChiTietPhieuTU_BySession";
        Sql.fGetData(Obj);
        RGChiTietPhieuTU2.DataSource = Obj.Dt;
        RGChiTietPhieuTU2.DataBind();

    }

    protected void RGChiTietPhieuTU2_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChiTietPhieuTU2();
        }
    }
    protected void RGChiTietPhieuTU2_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadChiTietPhieuTU2();
    }
    protected void RGChiTietPhieuTU2_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadChiTietPhieuTU2();
    }
    #endregion
}





