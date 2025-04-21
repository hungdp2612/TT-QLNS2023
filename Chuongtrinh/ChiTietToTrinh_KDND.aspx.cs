using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Data;
public partial class ChiTietToTrinh_KDND : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["SoToTrinh"] != null )
            {
                txtKHCP_ID.Text = Request.QueryString["SoToTrinh"].ToString();
                
            }         
            if (Request.QueryString["Nam"] != null)
            {
                txtNam.Text = Request.QueryString["Nam"].ToString();
            }
            if (Request.QueryString["Thang"] != null)
            {
                txtThang.Text = Request.QueryString["Thang"].ToString();
            }
            if (Request.QueryString["MaDV"] != null)
            {

                txtMaDV.Text = Request.QueryString["MaDV"].ToString();

                if (txtMaDV.Text == "KDND")
                {
                    cboMaBP.Visible = true;
                    txtMaDV.Visible = false;
                }
                else
                {
                    cboMaBP.Visible = false;
                    txtMaDV.Visible = true;
                }
            }
          
            GetMaDVByMaBP();        
            fLoad();
            fLoadChiPhi("");
            fLoadByID();
            Session["ReloadChiTietToTrinh"] = "";

        }
    }

    void fLoad()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_ChiTietToTrinh_load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }   
    string madv;

    void  GetMaDVByMaBP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text };
        Obj.SpName = "sp_ChiTietToTrinh_KDND_GetIDMaCS";
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

    void fLoadByID()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_ToTrinh_ByID_ChiTiet";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
          
            //rnTiGia.Value = float.Parse(Obj.Dt.Rows[0]["TiGia"].ToString());
            tbLoaiTien.Text = Obj.Dt.Rows[0]["LoaiTien"].ToString();
        }
    }

    protected void RG_InsertCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {        
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietToTrinh_Update.ascx";
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
    protected void RG_EditCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            lbLoi.Text = "";

            if (cbMaSoChiPhi.Text != cbMaSoChiPhi.SelectedValue)
            {
                throw new Exception("Mã chi phí không đúng.....");
            }
            else
            {

                if (rnChiPhi.Value.Value == 0)
                {
                    throw new Exception("SỐ TIỀN PHẢI LỚN HƠN 0.....");
                }

                decimal Chiphi = decimal.Parse(rnChiPhi.Text);
                string ghichu = txtGhichu.Text;
                string SoToTrinh = txtKHCP_ID.Text;
                string mabp;
                if (txtMaDV.Text == "KDND")
                {
                    mabp = cboMaBP.SelectedValue;
                }
                else
                {
                    mabp = txtMaDV.Text;
                }
                #region Insert
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@MSChiphi", "@MaDV", "@Nam", "@Thang", "@Sotien", "@Ghichu" };
                Obj.ValueParameter = new object[] { SoToTrinh, cbMaSoChiPhi.SelectedValue, mabp, int.Parse(txtNam.Text), int.Parse(txtThang.Text), Chiphi, ghichu };

                Obj.SpName = "sp_ChiTietToTrinh_insert";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Đã có chi phí tờ trình <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Thêm chi phí tờ trình <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> thành công.</font>";
                }

                #endregion

                fLoad();
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }
    }
    protected void btnLamMoi_Click(object sender, ImageClickEventArgs e)
    {
       
        rnChiPhi.Text = "0";
        cbMaSoChiPhi.Text = "";
        cbMaSoChiPhi.SelectedValue = null;
        txtGhichu.Text = "";
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }


    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }

    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
   
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        
            string ID_Khoa = RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
            string MSChiphi = RG.Items[e.Item.ItemIndex]["MSChiphi"].Text;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh","@MSChiPhi"};
            Obj.ValueParameter = new object[] { ID_Khoa , MSChiphi};
            Obj.SpName = "sp_ChiTietToTrinh_KeToan_Delete";
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

    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox UCtxtSoToTrinh = userControl.FindControl("UCtxtSoToTrinh") as TextBox;
        TextBox UCtxtMSChiPhi = userControl.FindControl("UCtxtMSChiPhi") as TextBox;

        Telerik.Web.UI.RadNumericTextBox ucChiphi = userControl.FindControl("UCrnChiPhi") as Telerik.Web.UI.RadNumericTextBox;
        TextBox UCtxtGhiChu = userControl.FindControl("UCtxtGhiChu") as TextBox;

        #region Luu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", "@MSChiphi", "@Sotien", "@Ghichu" };
        Obj.ValueParameter = new object[] { UCtxtSoToTrinh.Text, UCtxtMSChiPhi.Text, ucChiphi.Text, UCtxtGhiChu.Text };
        Obj.SpName = "sp_chitiettotrinh_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công chi tiết tờ trình <b><font color='black'>" + UCtxtSoToTrinh.Text + "-" + UCtxtMSChiPhi.Text + "</font></b>.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion  
        fLoad();
    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
  
    void fLoadChiPhi(string key)
    {
      
        GetMaDVByMaBP();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@Key" };
        Obj.ValueParameter = new object[] { madv, key };
        Obj.SpName = "sp_ChiTietToTrinh_KeToan_GetMaCPByMaDV";
        Sql.fGetData(Obj);
        cbMaSoChiPhi.DataSource = Obj.Dt;
        cbMaSoChiPhi.DataBind();
    }

    protected void cboMaBP_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbMaSoChiPhi.Text = "";
        fLoadChiPhi("");
    }
    protected void cbMaSoChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }
    protected void cbMaSoChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadChiPhi(e.Text);
    }
}