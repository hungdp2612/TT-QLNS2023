using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.Configuration;
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;
using System.Text.RegularExpressions;
public partial class ChiTietChungTu_KiemTra : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["sophieu"] != null)
            {
                tbSoPhieu.Text = Request.QueryString["sophieu"].ToString();
            }


            fLoad();
            Session["KTKiemTraGDNTT"] = "";
        }
    }  
    
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { tbSoPhieu.Text };
        Obj.SpName = "sp_ChiTietThanhToan_GetAll";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();             
    }  
  

   
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        //fLoad();
    }
  
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietThanhToanKhongTamUng_Update.ascx";
            fLoad();

        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
           fLoad();
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




    protected void btKiemTra_Click(object sender, ImageClickEventArgs e)
    {
        #region Lưu chứng từ
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@NhanVienBPTCKT" };
        Obj.ValueParameter = new object[] { tbSoPhieu.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_ChungTuThanhToan_KTKiemTra_PhieuDeNghiThanhToan";
        Sql.fNonGetData(Obj);
        #endregion

        lbLoi.Text = "<font color='blue'>Đã kiểm tra.</font>";
    }
}