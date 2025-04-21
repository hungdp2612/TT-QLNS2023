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

public partial class Danhmuc_NhomNganSach : clsPhanQuyenCaoCap
{

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
        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_NhomNganSach_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNhomNS", "@DienGiai", "@MANV" };
        Obj.ValueParameter = new object[] { txtMaNhom.Text, txtDienGiai.Text, Session["UserID"].ToString() };

        Obj.SpName = "sp_NhomNganSach_Insert";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {

            lbLoi.Text = "<font color='red'>Thêm mã <b><font color='black'>" + txtMaNhom.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";

        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm mã <b><font color='black'>" + txtMaNhom.Text + "</font></b> thành công.</font>";
        }

        fLoad();

    }
  
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {                 

        lbLoi.Text = "";
        string manhomns = RG.Items[e.Item.ItemIndex]["MaNhomNS"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNhomNS", "@MANV" };
        Obj.ValueParameter = new object[] { manhomns, Session["UserID"].ToString() };
        Obj.SpName = "sp_NhomNganSach_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
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
        TextBox txtMaNhom = userControl.FindControl("txtMaNhom") as TextBox;
        TextBox txtDienGiai = userControl.FindControl("txtDienGiai") as TextBox;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNhomNS", "@DienGian", "@MANV" };
        Obj.ValueParameter = new object[] { txtMaNhom.Text, txtDienGiai.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_NhomNganSach_Update";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Cập nhật nhóm ngân sách thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Cập nhật nhóm ngân sách thành công.</font>";
        }

        fLoad();

    }
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            
            EditCommandColumn e1 = new EditCommandColumn();
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/NhomNganSach_Update.ascx";
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