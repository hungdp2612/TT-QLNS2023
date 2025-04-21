using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Data;

public partial class admin_PhanQuyen : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fLoadDSQuyen();
            fLoadDMSITE();
            fLoadDSSITE();
            fLoad_RGDMQuyen();
        }
    }
    void fLoadDMSITE()
    {
        Obj = new clsObj {Parameter = new string[] { }, ValueParameter = new object[] { }, SpName = "sp_DMSITE_Load"};
        Sql.fGetData(Obj);
        RGDMSITE.DataSource = Obj.Dt;
        RGDMSITE.DataBind();
    }
    void fLoadDSSITE()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { }, ValueParameter = new object[] { }, SpName = "sp_DMSITE_CoHieuLuc"
        };
        Sql.fGetData(Obj);
        RadIDSITE.DataSource = Obj.Dt;
        RadIDSITE.DataBind();
    }
    void fLoadDSQuyen()
    {
        Obj = new clsObj {Parameter = new string[] { }, ValueParameter = new object[] { }, SpName = "sp_DMQuyen_Load"};
        Sql.fGetData(Obj);
        rdDMQuyen.DataSource = Obj.Dt;
        rdDMQuyen.DataBind();
    }
    public bool fBool(object Value)
    {
        return bool.Parse(Value.ToString());
    }
    void fLoadDMSITE_DA_PHANQUYEN()
    {
        Obj = new clsObj
        {
            Parameter = new string[] {"@manv"},
            ValueParameter = new object[] {tbMANV.Text.Trim()},
            SpName = "sp_DMPhanQuyen_ByMaNV"
        };
        Sql.fGetData(Obj);
        RGPHANQUYEN.DataSource = Obj.Dt;
        RGPHANQUYEN.DataBind();
    }
    void fLoadDMQuyen_Trong_Luoi()
    {
        for (int i = 0; i < RGPHANQUYEN.Items.Count; i++)
        {
            RadioButtonList rbQuyen = (RadioButtonList)RGPHANQUYEN.Items[i].FindControl("rbQuyen");
            fLoad_DM_Quyen_Ctrl_Luoi(rbQuyen);
        }
    }
    void fLoad_DM_Quyen_Ctrl_Luoi(RadioButtonList Quyen)
    {
        Obj = new clsObj {Parameter = new string[] { }, ValueParameter = new object[] { }, SpName = "sp_DMQuyen_Load"};
        Sql.fGetData(Obj);
        Quyen.DataSource = Obj.Dt;
        Quyen.DataBind();
    }
    void fLoad_Chon_Quyen()
    {
        Obj = new clsObj
        {
            Parameter = new string[] {"@manv"},
            ValueParameter = new object[] {tbMANV.Text},
            SpName = "sp_DMPhanQuyen_ByMaNV"
        };
        Sql.fGetData(Obj);
        for (int i = 0; i < Obj.Dt.Rows.Count; i++)
        {
            for (int j = 0; j < RGPHANQUYEN.Items.Count; j++)
            {
                RadioButtonList rbQuyen = (RadioButtonList)RGPHANQUYEN.Items[j].FindControl("rbQuyen");
                HiddenField hdIDSITE = (HiddenField)RGPHANQUYEN.Items[j].FindControl("hdIDSITE");
                if (hdIDSITE.Value == Obj.Dt.Rows[i]["IDSITE"].ToString())
                {
                    rbQuyen.SelectedValue = Obj.Dt.Rows[i]["IDQuyen"].ToString();
                    break;
                }
            }
        }
    }
    void fLoad_RGDMQuyen()
    {
        Obj = new clsObj {Parameter = new string[] { }, ValueParameter = new object[] { }, SpName = "sp_DMQuyen_Load"};
        Sql.fGetData(Obj);
        RGDMQuyen.DataSource = Obj.Dt;
        RGDMQuyen.DataBind();
    }
    protected void RGDMSITE_CancelCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        fLoadDMSITE();
    }
    protected void RGDMSITE_DeleteCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        HiddenField IDSITE = (HiddenField)RGDMSITE.Items[e.Item.ItemIndex].FindControl("hfIDSITE");
        Obj = new clsObj
        {
            Parameter = new string[] {"@IDSITE"},
            ValueParameter = new object[] {IDSITE.Value},
            SpName = "sp_DMSITE_Delete"
        };
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã xoá thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Xoá thất bại do dữ liệu có tham chiếu.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoadDMSITE();
    }
    protected void RGDMSITE_InsertCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox IDSITE = userControl.FindControl("tbIDSITE") as TextBox;
        TextBox TenSite = userControl.FindControl("tbTenSite") as TextBox;
        CheckBox HieuLuc = userControl.FindControl("cbHieuLuc") as CheckBox;

        #region Kiểm tra trùng
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDSITE" };
        Obj.ValueParameter = new object[] { IDSITE.Text.ToLower() };
        Obj.SpName = "sp_DMSITE_ByID";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã có danh mục " + IDSITE.Text.ToLower() + " này.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
            fLoadDMSITE();
            return;
        }
        #endregion

        #region Thêm id mới
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDSITE", "@TENSITE", "@HIEULUC" };
        Obj.ValueParameter = new object[] { IDSITE.Text.ToLower(), TenSite.Text, HieuLuc.Checked };
        Obj.SpName = "sp_DMSITE_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã thêm thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Cập nhật thất bại. Vui lòng thử lại sau');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoadDMSITE();
        #endregion
    }
    protected void RGDMSITE_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.InitInsertCommandName)
        {
            e.Canceled = true;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/InsertDMSITE.ascx";
            e.Item.OwnerTableView.InsertItem();
            Telerik.Web.UI.GridEditableItem insertedItem = e.Item.OwnerTableView.GetInsertItem();
            RGDMSITE.MasterTableView.CurrentPageIndex = 0;
            fLoadDMSITE();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/UpdateDMSITE.ascx";
            fLoadDMSITE();
        }
        if (e.CommandName==Telerik.Web.UI.RadGrid.RebindGridCommandName)
        {
            fLoadDMSITE();
        }
    }
    protected void RGDMSITE_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoadDMSITE();
    }
    protected void RGDMSITE_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoadDMSITE();
    }
    protected void RGDMSITE_UpdateCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox IDSITE = userControl.FindControl("tbIDSITE") as TextBox;
        HiddenField IDSITECu = userControl.FindControl("hdIDSITE") as HiddenField;
        TextBox TenSite = userControl.FindControl("tbTenSite") as TextBox;
        CheckBox HieuLuc = userControl.FindControl("cbHieuLuc") as CheckBox;

        #region Kiểm tra trùng
        if (IDSITE.Text.ToLower() != IDSITECu.Value)
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@IDSITE" };
            Obj.ValueParameter = new object[] { IDSITE.Text.ToLower() };
            Obj.SpName = "sp_DMSITE_ByID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã có danh mục " + IDSITE.Text.ToLower() + " này.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
                fLoadDMSITE();
                return;
            }
        }
        #endregion

        #region Cập nhật id mới
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDSITE", "@IDSITECu", "@TENSITE", "@HIEULUC" };
        Obj.ValueParameter = new object[] { IDSITE.Text.ToLower(), IDSITECu.Value, TenSite.Text, HieuLuc.Checked };
        Obj.SpName = "sp_DMSITE_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã cập nhật thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Không thể cập nhật vì có tham chiếu.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoadDMSITE();
        #endregion
    }
    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        fLoadDMSITE();
        fLoadDSSITE();
        fLoadDMSITE_DA_PHANQUYEN();
        fLoadDMQuyen_Trong_Luoi();
        fLoad_Chon_Quyen();
        fLoad_RGDMQuyen();
    }
    protected void tbMANV_TextChanged(object sender, EventArgs e)
    {
        tbTenNV.Text = "";
        Obj = new clsObj
        {
            Parameter = new string[] {"@manv"},
            ValueParameter = new object[] {tbMANV.Text.Trim()},
            Connectionstring = wqlvattu,
            SpName = "SP_NHANVIEN_ID"
        };
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            tbTenNV.Text = Obj.Dt.Rows[0]["ten"].ToString();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Không có mã nhân viên này.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoadDMSITE_DA_PHANQUYEN();
        fLoadDMQuyen_Trong_Luoi();
        fLoad_Chon_Quyen();
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        #region Kiểm tra tồn tại nhân viên
        if (tbTenNV.Text=="")
        {
            lbLoi.Text = "<font color='red'>Không có mã nhân viên này.</font>";
            fLoadDMSITE_DA_PHANQUYEN();
            return;
        }
        #endregion

        #region Kiểm tra đã chọn phân quyền
        if (rdDMQuyen.SelectedValue=="")
        {
            lbLoi.Text = "<font color='red'>Vui lòng chọn quyền.</font>";
            return;
        }
        #endregion  

        #region Kiểm tra trùng
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@manv","@idsite" };
        Obj.ValueParameter = new object[] { tbMANV.Text.Trim(), RadIDSITE.SelectedValue };
        Obj.SpName = "SP_Lay_PhanQuyen_ID_ktp";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count>0)
        {
            lbLoi.Text = "<font color='red'>Đã có phân quyền cho chức năng này.</font>";
            return;
        }
        #endregion

        #region Lưu phân quyền

        Obj = new clsObj
        {
            Parameter = new string[] {"@manv", "@idsite", "@IDQuyen"},
            ValueParameter = new object[] {tbMANV.Text.Trim(), RadIDSITE.SelectedValue, rdDMQuyen.SelectedValue},
            SpName = "sp_DMPhanQuyen_Insert"
        };
        Sql.fNonGetData(Obj);
        if (Obj.KetQua!=0)
        {
            lbLoi.Text = "<font color='blue'>Phân quyền thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Phân quyền thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion

        fLoadDMSITE_DA_PHANQUYEN();
        fLoadDMQuyen_Trong_Luoi();
        fLoad_Chon_Quyen();
    }
    protected void rbQuyen_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        RadioButtonList rbQuyen = (RadioButtonList)sender;
        int Dem = 0;
        for (int i = 0; i < RGPHANQUYEN.Items.Count; i++)
        {
            RadioButtonList rbQuyenLuoi = (RadioButtonList)RGPHANQUYEN.Items[i].FindControl("rbQuyen");
            if (rbQuyen == rbQuyenLuoi)
            {
                break;
            }
            Dem += 1;
        }
        HiddenField hdIDSITE = (HiddenField)RGPHANQUYEN.Items[Dem].FindControl("hdIDSITE");

        Obj = new clsObj
        {
            Parameter = new string[] {"@manv", "@idsite", "@IDQuyen"},
            ValueParameter = new object[] {tbMANV.Text, hdIDSITE.Value, rbQuyen.SelectedValue},
            SpName = "sp_DMPhanQuyen_Update"
        };
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
        }
    }
    protected void RGPHANQUYEN_DeleteCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        HiddenField hdIDSITE = (HiddenField)RGPHANQUYEN.Items[e.Item.ItemIndex].FindControl("hdIDSITE");
        Obj = new clsObj
        {
            Parameter = new string[] {"@manv", "@idsite"},
            ValueParameter = new object[] {tbMANV.Text.Trim(), hdIDSITE.Value},
            SpName = "sp_DMPhanQuyen_Delete"
        };
        Sql.fNonGetData(Obj);
        if (Obj.KetQua != 0)
        {
            lbLoi.Text = "<font color='blue'>Xoá thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
        }
        fLoadDMSITE_DA_PHANQUYEN();
        fLoadDMQuyen_Trong_Luoi();
        fLoad_Chon_Quyen();
    }
    protected void RGDMQuyen_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.InitInsertCommandName)
        {
            e.Canceled = true;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/InsertDMQuyen.ascx";
            e.Item.OwnerTableView.InsertItem();
            Telerik.Web.UI.GridEditableItem insertedItem = e.Item.OwnerTableView.GetInsertItem();
            RGDMSITE.MasterTableView.CurrentPageIndex = 0;
            fLoad_RGDMQuyen();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/UpdateDMQuyen.ascx";
            fLoad_RGDMQuyen();
        }
    }
    protected void RGDMQuyen_CancelCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        fLoad_RGDMQuyen();
    }
    protected void RGDMQuyen_InsertCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox IDQuyen = userControl.FindControl("tbIDQuyen") as TextBox;
        TextBox TenQuyen = userControl.FindControl("tbTenQuyen") as TextBox;

        #region Kiểm tra trùng
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDQuyen" };
        Obj.ValueParameter = new object[] { IDQuyen.Text.ToLower() };
        Obj.SpName = "sp_DMQuyen_ById";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã có danh mục " + IDQuyen.Text.ToLower() + " này.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
            fLoadDMSITE();
            return;
        }
        #endregion

        #region Thêm id mới
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDQuyen","@Quyen" };
        Obj.ValueParameter = new object[] { IDQuyen.Text.ToUpper(), TenQuyen.Text };
        Obj.SpName = "sp_DMQuyen_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã thêm thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Cập nhật thất bại. Vui lòng thử lại sau');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }            
        fLoad_RGDMQuyen();
        fLoad_RGDMQuyen();
        #endregion
    }
    protected void RGDMQuyen_UpdateCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox IDQuyen = userControl.FindControl("tbIDQuyen") as TextBox;
        TextBox TenQuyen = userControl.FindControl("tbTenQuyen") as TextBox;
        HiddenField IDSITECu = userControl.FindControl("hdIDQuyen") as HiddenField;

        #region Kiểm tra trùng
        if (IDQuyen.Text.ToLower() != IDSITECu.Value)
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@IDSITE" };
            Obj.ValueParameter = new object[] { IDQuyen.Text.ToLower() };
            Obj.SpName = "sp_DMQuyen_ById";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã có danh mục " + IDQuyen.Text.ToLower() + " này.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
                fLoad_RGDMQuyen();
                return;
            }
        }
        #endregion

        #region Cập nhật id mới
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDQuyen", "@IDQuyenCu", "@Quyen" };
        Obj.ValueParameter = new object[] { IDQuyen.Text.ToUpper(), IDSITECu.Value, TenQuyen.Text };
        Obj.SpName = "sp_DMQuyen_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã cập nhật thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Không thể cập nhật vì có tham chiếu.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoad_RGDMQuyen();
        fLoad_RGDMQuyen();
        #endregion
    }
    protected void RGDMQuyen_DeleteCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        HiddenField IDQuyen = (HiddenField)RGDMQuyen.Items[e.Item.ItemIndex].FindControl("hfIDQuyen");
        Obj = new clsObj
        {
            Parameter = new string[] {"@IDQuyen"},
            ValueParameter = new object[] {IDQuyen.Value},
            SpName = "sp_DMQuyen_Delete"
        };
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã xoá thành công.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Xoá thất bại do dữ liệu có tham chiếu.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
        }
        fLoad_RGDMQuyen();
        fLoad_RGDMQuyen();
    }
}
