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
using System.Data;


public partial class Chuongtrinh_ChiTietThanhToanKhoanMuc : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadSoPhieu_ByLoaiPhieu("");
            fLoadCTTT_ID_BySoPhieu();
            fLoadChiTietKM_ByNam("");
            fLoad();   
        }
       
    }
    void fLoad()
    {       

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@Nam","@MaNV" };
        //Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), Session["UserID"].ToString() };
        //Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_Mar_Load";
        //Sql.fGetData(Obj);
        //RG.DataSource = Obj.Dt;
        //RG.DataBind();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text) };
        Obj.SpName = "sp_Mar_ChiTietThanhToanKhoanMuc_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void fLoadMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@LoaiPhieu", "@Nam", "@Key" };
        Obj.ValueParameter = new object[] { ddlLoaiThanhToan.SelectedValue, int.Parse(rnNam.Text), Key };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_Mar_ByMaNV_MSChiPhi";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
        cbMaChiPhi.SelectedIndex = 0;
    }  
    void fLoadSoPhieu_ByLoaiPhieu(string key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@LoaiPhieu", "@MaDV", "@MaNV", "@MSChiPhi", "@Nam", "@key" };
        Obj.ValueParameter = new object[] { ddlLoaiThanhToan.SelectedValue, "P.MAR", Session["UserID"].ToString(), cbMaChiPhi.SelectedValue, int.Parse(rnNam.Text),key };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_LoadSoPhieu_ByLoaiPhieu";
        Sql.fGetData(Obj);
        cbSoPhieu.DataSource = Obj.Dt;
        cbSoPhieu.DataBind();
        cbSoPhieu.SelectedIndex = 0;
    }  
   
    void fLoadCTTT_ID_BySoPhieu()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { cbSoPhieu.SelectedValue };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_LoadCTTT_ID_BySoPhieu";
        Sql.fGetData(Obj);
        cboCTTT_ID.DataSource = Obj.Dt;
        cboCTTT_ID.DataBind();
    }  

    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {           
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            RG.MasterTableView.IsItemInserted = false;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietThanhToanKhoanMuc_Mar_Update.ascx";
            fLoad();
        }
    }

    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            string IDKhoa = RG.Items[e.Item.ItemIndex]["Khoa_CT_TT_KM"].Text;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_CT_TT_KM" };
            Obj.ValueParameter = new object[] { IDKhoa };
            Obj.SpName = "sp_ChiTietThanhToan_Mar_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }

            cboCTTT_ID.Text = "";
            fLoadCTTT_ID_BySoPhieu();
            fLoad();          

        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message.ToString() + "</font>";
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

    void fLoadChiTietKM_ByNam(string key)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MSChiPhi", "@Key" };
        Obj.ValueParameter = new object[] {int.Parse(rnNam.Text), cbMaChiPhi.SelectedValue, key  };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_LoadKhoa_ByNam";
        Sql.fGetData(Obj);
        cboChiTietKhoanMuc.DataSource = Obj.Dt;
        cboChiTietKhoanMuc.DataBind();

    }
    void fLoadKhoanMuc_ByMaCP()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@Nam", "@MaCP" };
        Obj.ValueParameter = new object[] {int.Parse(rnNam.Text), cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_DanhMucKhoanMuc_Mar_ThanhToanKhoanMuc_GetKM_ByMaCP";
        Sql.fGetData(Obj);
        rcKhoanMuc.DataSource = Obj.Dt;
        rcKhoanMuc.DataBind();

    }
    void fLoadChiTietKM_ByKhoaKhoanMuc(string key)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@KhoaKM", "@Key" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), rcKhoanMuc.SelectedValue, key };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_LoadKhoa_ByKhoaKM";
        Sql.fGetData(Obj);
        cboChiTietKhoanMuc.DataSource = Obj.Dt;
        cboChiTietKhoanMuc.DataBind();

    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        

        double ttt = double.Parse((cboCTTT_ID.SelectedItem.FindControl("TTT") as Label).Text);
        //lbLoi.Text = ttt.ToString();
       // double TienThanhToanDuong;
        //if (ttt < 0)
        //{
        //    TienThanhToanDuong = ttt * (-1);
        //}
        //else{
        //    TienThanhToanDuong = ttt;
        //}

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Khoa_Chitiet_KM", "@CTTT_ID", "@TruVAT", "@TienThanhToanDaTruVAT", "@Ghichu", "@KhoaCPKM", "@Khoa_CT_TT_KM" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), cboChiTietKhoanMuc.SelectedValue, cboCTTT_ID.SelectedValue, ddlVAT.SelectedValue, ttt / (1 + double.Parse(ddlVAT.SelectedValue) / 100), txtGhiChu.Text, rcKhoanMuc.SelectedValue, cboCTTT_ID.SelectedValue };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_Mar_Insert";

        Sql.fNonGetData(Obj);

        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'Thêm thất bại.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thành công.</font>";
            fLoad();
            cboCTTT_ID.Text = "";
            fLoadCTTT_ID_BySoPhieu();
        }     

    }
   
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {

        fLoad();

    }
  
    protected void cboKhoaKhoanMuc_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadSoPhieu_ByLoaiPhieu("");
       
    }
    protected void cbSoPhieu_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cboCTTT_ID.Text = "";
        fLoadCTTT_ID_BySoPhieu();
    }
    protected void ddlLoaiThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbSoPhieu.Text = "";
        cboCTTT_ID.Text = "";
        cbMaChiPhi.Text = "";
       
        fLoadMaCP("");
        cboChiTietKhoanMuc.Text = "";
        fLoadChiTietKM_ByNam("");
        fLoadSoPhieu_ByLoaiPhieu("");
        fLoadCTTT_ID_BySoPhieu();
    }

    protected void cbMaChiPhi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    

    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cbSoPhieu.Text = "";
        cboCTTT_ID.Text = "";
        cboChiTietKhoanMuc.Text = "";
       // fLoadChiTietKM_ByNam("");
        fLoadSoPhieu_ByLoaiPhieu("");
        fLoadCTTT_ID_BySoPhieu();
        fLoadKhoanMuc_ByMaCP();

    }
    protected void cbSoPhieu_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadSoPhieu_ByLoaiPhieu(e.Text);      
    }
    protected void cboChiTietKhoanMuc_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
       // fLoadChiTietKM_ByNam(e.Text);
        fLoadChiTietKM_ByKhoaKhoanMuc(e.Text);
    }
    protected void rcKhoanMuc_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cbSoPhieu.Text = "";
        cboCTTT_ID.Text = "";
        cboChiTietKhoanMuc.Text = "";
        fLoadChiTietKM_ByKhoaKhoanMuc("");
    }
    protected void RG_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        string txtKhoa_CT_TT_KM = (userControl.FindControl("txtKhoa_CT_TT_KM") as TextBox).Text;           
        DropDownList ddlVAT = userControl.FindControl("ddlVAT") as DropDownList;
        string txtGhiChu = (userControl.FindControl("txtGhiChu") as TextBox).Text;
        Telerik.Web.UI.RadNumericTextBox rnTienThanhToan = userControl.FindControl("rnTienThanhToan") as Telerik.Web.UI.RadNumericTextBox;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Khoa_CT_TT_KM", "@TienTT", "@TruVAT", "@GhiChu" };
        Obj.ValueParameter = new object[] { txtKhoa_CT_TT_KM, rnTienThanhToan.Value, ddlVAT.SelectedValue, txtGhiChu };
        Obj.SpName = "sp_ChiTietThanhToanKhoanMuc_Mar_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
            fLoad();
        }
        else
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }      
      
    }
}