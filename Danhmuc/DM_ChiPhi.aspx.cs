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
using Telerik.Web.UI.Skins;
using Telerik.Web.UI;
using System.Configuration;

public partial class Danhmuc_DM_ChiPhi : clsPhanQuyenCaoCap
{
    QLNS2013DBDataContext db_ = new QLNS2013DBDataContext();
    clsObj Obj;
    clsSql Sql = new clsSql();
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fLoad();
            fLoadMaNS();


        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_ChiPhi_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    void fLoadMaNS()
    {
        var ngansach = db_.DMNganSaches.Select(p => new { p.MaNganSach, p.DienGiai, Tengoi = p.MaNganSach + " || " + p.DienGiai });
        cbMaNS.DataSource = ngansach;
        cbMaNS.DataBind();
    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {

        var ngansach = db_.DMNganSaches.FirstOrDefault(p => p.MaNganSach == cbMaNS.SelectedValue); 
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MACP", "@DienGiai" ,"@MaNganSach", "@DienGiaiNS", "@MANV" };
        Obj.ValueParameter = new object[] { txtmacp.Text, txtDienGiai.Text,cbMaNS.SelectedValue,ngansach.DienGiai,Session["UserID"].ToString() };

        Obj.SpName = "sp_ChiPhi_Insert";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {

            lbLoi.Text = "<font color='red'>Thêm mã <b><font color='black'>" + txtmacp.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";

        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm mã <b><font color='black'>" + txtmacp.Text + "</font></b> thành công.</font>";
        }

        fLoad();

    }  
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {                 

        lbLoi.Text = "";
        string manhomns = RG.Items[e.Item.ItemIndex]["MaNganSach"].Text;
        string macp = RG.Items[e.Item.ItemIndex]["MSChiPhi"].Text;
        try
        {
            var chiphi = db_.DmChiPhis.FirstOrDefault(p => p.MSChiPhi == macp && p.MaNganSach == manhomns);
            db_.DmChiPhis.DeleteOnSubmit(chiphi);
            db_.SubmitChanges();
            var log = db_.sp_ChiPhi_DELETE_LOG(macp, manhomns, Session["UserID"].ToString());
            lbLoi.Text = "<font color='blue'>Xoá mã <b><font color='black'>" + macp + "</font></b> thành công.</font>";

        }
        catch(Exception ex)
        {
            lbLoi.Text = "<font color='Red'>" + ex.Message + "</font>";
        }
        fLoad();       
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
    protected void txtNam_TextChanged(object sender, EventArgs e)
    {
       
        fLoad();
    }


    protected void RG_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtMaCP = userControl.FindControl("txtMaCP") as TextBox;
        TextBox txtDienGiai = userControl.FindControl("txtDienGiai") as TextBox;
        TextBox txtMaNS = userControl.FindControl("txtMaNS") as TextBox;
        TextBox txtDienGiaiNS = userControl.FindControl("txtDienGiaiNS") as TextBox;  

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP", "@DienGiai", "@MaNganSach", "@DienGiaiNS","@MANV" };
        Obj.ValueParameter = new object[] { txtMaCP.Text,txtDienGiai.Text,txtMaNS.Text, txtDienGiaiNS.Text,Session["UserID"].ToString() };
        Obj.SpName = "sp_ChiPhi_Update";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Cập nhật chi phí thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Cập nhật chi phí thành công.</font>";
        }

        fLoad();

    }
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            
            EditCommandColumn e1 = new EditCommandColumn();
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiPhi_Update.ascx";
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoad();
        }
        
    }
    protected void RG_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }
}