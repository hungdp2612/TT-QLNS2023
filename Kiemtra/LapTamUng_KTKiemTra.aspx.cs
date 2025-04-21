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

public partial class Kiemtra_LapTamUng_KTKiemTra : clsPhanQuyenCaoCap
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
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            
            txtKeToan.Text = Session["Name"].ToString();

            Session["PhieuTU"] = String.Empty;
            fLoadDonVi();         
           
            fLoadPhieuTU();
            fLoadChiTietPhieuTU();

            fLoadNganSach();
        }

    }
    #region ngân sách
    void fLoadNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_NganSachConLai_GetAll";
        Sql.fGetData(Obj);
        RGNganSach.DataSource = Obj.Dt;
        RGNganSach.DataBind();
    }
    protected void RGNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadNganSach();
    }
    protected void RGNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadNganSach();

    }
    protected void RGNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadNganSach();
        }
    }
    #endregion
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam","@Thang" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_PhieuTamUng_LoadDV_KTKiemTra";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        
       
    }


    #region chi tiết phiếu tạm ứng

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
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_PhieuTamUng_KTKiemTra_Load";
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
        Obj.Parameter = new string[] {  "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_ChiTietPhieuTU_ByMaNV_KTKiemTra";
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
                LOAD_RadGDNganSach();
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
        LOAD_RadGDNganSach();       
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
    #endregion


  
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "sp_ChiTietTamUng_ByPhieuTU";

            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@PhieuTU",  "@MaDV", "@Nam", "@Thang" };

            provider.ValueCollection = new object[] { Session["PhieuTU"].ToString().Trim(),CboMaDV.Text, rnNam.Text, rnThang.Text };

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
       
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
       
       
    }
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
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
                fLoadDonVi();
                fLoadPhieuTU();
                fLoadChiTietPhieuTU();
                
            }
        }
        
    }
 
}