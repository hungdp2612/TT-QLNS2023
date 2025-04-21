using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Telerik.Web.UI;

public partial class Danhmuc_ThongTinCtyKH : System.Web.UI.Page
{
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

        }
    }
    protected void RDThongTinCtyKH_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        {
            try
            {
                int index = e.Item.ItemIndex;
                string MaCongtyKH = RDThongTinCtyKH.Items[index]["MaCongtyKH"].Text.Trim();

                ClassLibrary lib = new ClassLibrary(ConnectionString);
                lib.GetDataStore("sp_MaCongtyKH_Delete", new string[] { "@MaCongtyKH" }, new object[] { MaCongtyKH });

                lblLoi.Text = "Bạn đã xóa thành công: " + MaCongtyKH;
            }
            catch (Exception ex)
            {
                lblLoi.Text = ex.Message;
            }
        }
    }
    protected void RDThongTinCtyKH_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Telerik.Web.UI.GridEditableItem insertedItem = e.Item as Telerik.Web.UI.GridEditableItem;
        UserControl userControl =
            (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

        ClassLibrary lib = new ClassLibrary(ConnectionString);
        try
        {
            string MaCongtyKH = (userControl.FindControl("RadTxtMaCongtyKH") as RadTextBox).Text.ToUpper().Trim();
            string TenCty = (userControl.FindControl("RadTxtTenCty") as RadTextBox).Text;
            string DiaChi = (userControl.FindControl("RadTxtDiaChi") as RadTextBox).Text;
            string Tel = (userControl.FindControl("RadTxtTel") as RadTextBox).Text;
            string TeleFax = (userControl.FindControl("RadTxtTeleFax") as RadTextBox).Text;
            string Email = (userControl.FindControl("RadTxtEmail") as RadTextBox).Text;
            CheckBox ChkHieuLuc = (userControl.FindControl("ChkHieuLuc") as CheckBox); //Hieu luc la CheckBox
            
            bool hieuluc = false;
            if (ChkHieuLuc.Checked)
            {
                hieuluc = true;
            }
            else
            {
                hieuluc = false;
            }

            try
            {
                lib.IUDStore("sp_MaCongtyKH_Insert", new string[] { "@MaCongtyKH", "@TenCty", "@DiaChi", "@Tel", "@TeleFax", "@Email", "@HieuLuc" },
                    new object[] { MaCongtyKH, TenCty, DiaChi, Tel, TeleFax, Email, hieuluc });

                RDThongTinCtyKH.DataBind();
            }
            catch (Exception ex)
            {
                lblLoi.Text = ex.Message;
            }

            //Insert thanh cong, thong bao
            lblLoi.Text = "Thêm mới danh muc  thanh cong";

        }
        catch (Exception ex)
        {
            lblLoi.Text = ex.Message;
        }
    }
    protected void RDThongTinCtyKH_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            e.Canceled = true;

            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ThongTinCtyKH_insert.ascx";
            e.Item.OwnerTableView.InsertItem();

            Telerik.Web.UI.GridEditableItem insertedItem = e.Item.OwnerTableView.GetInsertItem();
        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ThongTinCtyKH_update.ascx";
        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {

        }
    }
   
    protected void RDThongTinCtyKH_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Telerik.Web.UI.GridEditableItem insertedItem = e.Item as Telerik.Web.UI.GridEditableItem;
        UserControl userControl =
            (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

        ClassLibrary lib = new ClassLibrary(ConnectionString);
        try
        {
            string MaCongtyKH = (userControl.FindControl("RadTxtMaCongtyKH") as RadTextBox).Text.ToUpper().Trim();
            string TenCty = (userControl.FindControl("RadTxtTenCty") as RadTextBox).Text;
            string DiaChi = (userControl.FindControl("RadTxtDiaChi") as RadTextBox).Text;
            string Tel = (userControl.FindControl("RadTxtTel") as RadTextBox).Text;
            string TeleFax = (userControl.FindControl("RadTxtTeleFax") as RadTextBox).Text;
            string Email = (userControl.FindControl("RadTxtEmail") as RadTextBox).Text;
            CheckBox ChkHieuLuc = (userControl.FindControl("ChkHieuLuc") as CheckBox); //Hieu luc la CheckBox
            
            int hieuluc = 0;
            if (ChkHieuLuc.Checked)
            {
                hieuluc = 1;
            }
            else
            {
                hieuluc = 0;
            }

            lib.IUDStore("sp_MaCongtyKH_Update", new string[] { "@MaCongtyKH", "@TenCty", "@DiaChi", "@Tel", "@TeleFax", "@Email", "@HieuLuc" },
                  new object[] { MaCongtyKH, TenCty, DiaChi, Tel, TeleFax, Email, hieuluc });

            RDThongTinCtyKH.DataBind();

        }
        catch
        {

        }
    }
    protected void RDThongTinCtyKH_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {

    }
    protected void RDThongTinCtyKH_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {

    }
}