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

public partial class Tracuu_LapTamUng_XemXet : clsPhanQuyenCaoCap
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
            Session["MSChiphi"] = String.Empty;
            Session["PhieuTU"] = String.Empty;
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
           
            fLoadDonVi();
            fLoadChiPhiTamUngXemXet();
            fLoadPhuTrachDonVi();        
          
            fLoadNguoiDuocThanhToan();  
            fLoadPhieuTU();
            fLoadChiTietPhieuTU();

            fLoadNganSach();
        }      

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
            txtTenDonVi.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
        }
    }
    void fLoadNguoiDuocThanhToan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {"@MaDV"  };
        Obj.ValueParameter = new object[] { txtMaDV.Text};
        Obj.SpName = "sp_PhieuTamUng_LoadNV";
        Sql.fGetData(Obj);
        ddlNguoiThanhToan.DataSource = Obj.Dt;
        ddlNguoiThanhToan.DataBind();
        ddlNguoiThanhToan.SelectedIndex = 0;
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
    void fLoadChiPhiTamUngXemXet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_KeHoachNS_LoadMaCP";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
        //cbMaChiPhi.SelectedIndex = 0;
    }
    void fLoadNganSach()
    {
        Obj = new clsObj();
        //Obj.Parameter = new string[] {"@MSChiPhi", "@MaDV","@Nam","@Thang" };
        //Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text,rnThang.Text };
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_KeHoachNS_CTKHNS_ByMaChiPhi";
        Sql.fGetData(Obj);
        RGNganSach.DataSource = Obj.Dt;
        RGNganSach.DataBind();
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
    protected void ddlNguoiThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {  
        fLoadChiTietPhieuTU();      
        fLoadPhieuTU();
        lbLoi.Text = "";     
       
    }
    protected void cbXemXet1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox cb = (RadComboBox)sender;       

        if (Session["PhieuTU"].ToString() == "")
        {
            lbLoi.Text = "<font color='Red'>Chưa chọn phiếu tạm ứng nên không thể xem xét</font>";
            fLoadPhieuTU();
        }
        else
        {          

            if (cb.SelectedValue == "false")
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU", "@DVKiemTra", "@NgayPTKT" };
                Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), cb.SelectedValue, Convert.DBNull };
                Obj.SpName = "sp_PhieuTamUng_XemXet";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='blue'>Phiếu tạm ứng <b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> đã chuyển sang trạng thái chưa xem xét.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='Red'>Xem xét <b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> thất bại.</font>";
                }


            }
            else
            {
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU", "@DVKiemTra", "@NgayPTKT" };
                Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), cb.SelectedValue, DateTime.Now };
                Obj.SpName = "sp_PhieuTamUng_XemXet";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='blue'>Xem xét phiếu tạm ứng<b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> thành công.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='Red'>Xem xét phiếu tạm ứng <b><font color='black'>" + Session["PhieuTU"].ToString() + "</font></b> thất bại.</font>";
                }


            }
        }
    }
    #region Load Phieu tam ưng
    void fLoadPhieuTU()
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        //Obj.ValueParameter = new object[] { txtMaDV.Text, ddlNguoiThanhToan.SelectedValue };
        //Obj.SpName = "sp_PhieuTamUng_LoadCbPhieuTU";
        //Sql.fGetData(Obj);
        //if (Obj.KetQua < 1)
        //{
        //    try
        //    {
        //        RDPhieuTU.DataSource = Obj.Dt;
        //        RDPhieuTU.DataBind();
        //    }
        //    catch { }
        //}
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };
        //Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] {  txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_TamUng_CTPTU_ByMaChiPhi";
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
    void fLoadChiTietPhieuTU()
    {
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };
        //Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text, rnThang.Text };

        Obj.Parameter = new string[] {  "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, rnNam.Text, rnThang.Text };

        Obj.SpName = "sp_ChiTietPhieuTU_ByMaNV";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    protected void RDPhieuTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            lbLoi.Text = "";
            if (e.Item.Selected == false)
            {
                Session["PhieuTU"] = String.Empty;
                //LOAD_RadGDNganSach();
                FLoadChiPhieuTUBySessionMCP();
            }

        }
    }
    protected void RDPhieuTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadPhieuTU();
        lbLoi.Text = "";
        //foreach (GridDataItem item in RDPhieuTU.MasterTableView.Items)
        //{
        //    if (item.Selected)
        //    {
        //        Session["PhieuTU"] = item["PhieuTU"].Text.Trim();
        //    }
        //}
        //LOAD_RadGDNganSach();
    }
    protected void RDPhieuTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["PhieuTU"] = RDPhieuTU.SelectedValue == null ? "" : RDPhieuTU.SelectedValue;



        if (Session["MSChiphi"].ToString() != "" && Session["PhieuTU"].ToString() != "")
        {
            FLoadChiPhieuTUBySessionMCP_PhieuTU();

        }
        if (Session["MSChiphi"].ToString() != "" && Session["PhieuTU"].ToString() == "")
        {
           FLoadChiPhieuTUBySessionMCP();
        
        }
        if (Session["MSChiphi"].ToString() == "" && Session["PhieuTU"].ToString() != "")
        {
           
            LOAD_RadGDNganSach();
        }

    }
    #endregion
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "sp_ChiTietTamUng_ByPhieuTU";

            provider.CommandType = CommandType.StoredProcedure;

            //provider.ParameterCollection = new string[] { "@PhieuTU", "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };

            //provider.ValueCollection = new object[] { Session["PhieuTU"].ToString().Trim(), cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text, rnThang.Text };

            provider.ParameterCollection = new string[] { "@PhieuTU",  "@MaDV", "@Nam", "@Thang" };

            provider.ValueCollection = new object[] { Session["PhieuTU"].ToString().Trim(),  txtMaDV.Text, rnNam.Text, rnThang.Text };

            dt = provider.GetDataTable();

        }
        catch (SqlException sqlex)
        {
            lbLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
            RG.DataSource = dt;
            RG.DataBind();
        }


    }
    protected void RDPhieuTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //foreach (GridDataItem item in RDPhieuTU.Items)
        //{
        //    (item["DVKiemTra"].FindControl("cbXemXet1") as RadComboBox).Text = (item["DVKiemTra"].FindControl("hfXemXet") as HiddenField).Value;
        //    (item["DVKiemTra"].FindControl("cbXemXet1") as RadComboBox).SelectedValue = (item["DVKiemTra"].FindControl("hfXemXet") as HiddenField).Value;
        //}
    }
    protected void RDPhieuTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadPhieuTU();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
       fLoadNganSach();
       fLoadPhieuTU();
       fLoadChiTietPhieuTU();
       lbLoi.Text = "";
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
       
        lbLoi.Text = "";
    }
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        fLoadChiPhiTamUngXemXet();
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
       
       
    }
    void FLoadPhieuTUBySession()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["MSChiphi"].ToString(),int.Parse(rnNam.Text),int.Parse(rnThang.Text) };
        Obj.SpName = "sp_PhieuTamUng_ByMaCP_TraCuu";
        Sql.fGetData(Obj);
        RDPhieuTU.DataSource = Obj.Dt;
        RDPhieuTU.DataBind();
    }
    void FLoadChiPhieuTUBySessionMCP_PhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi","@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), Session["MSChiphi"].ToString(), txtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_NganSach_PhieuTU_ChiTietTU";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void FLoadChiPhieuTUBySessionMCP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { Session["MSChiphi"].ToString(), txtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_PhieuTU_ChiTietTU_ByMSChiPhi";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    protected void RGNganSach_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        Session["MSChiphi"] = RGNganSach.SelectedValue == null ? "" : RGNganSach.SelectedValue;
        lbLoi.Text = Session["MSChiphi"].ToString();
       
        FLoadPhieuTUBySession();
        FLoadChiPhieuTUBySessionMCP();
       
    }
    protected void RGNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                FLoadPhieuTUBySession();
                FLoadChiPhieuTUBySessionMCP();
                //lbLoi.Text = Session["MSChiphi"].ToString();
            }

        }
    }
    protected void RGNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadNganSach();
    }
    protected void RGNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadNganSach();
        //FLoadChiTietNS();
    }
}