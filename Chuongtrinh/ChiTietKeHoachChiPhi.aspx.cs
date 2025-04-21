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
public partial class ChiTietKeHoachChiPhi : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();
     string MaNV;
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            if (Request.QueryString["khoa_chiphi"] != null)
            {
                txtKHCP_ID.Text = Request.QueryString["khoa_chiphi"].ToString();
            }
            //if (Request.QueryString["Nam"] != null)
            //{
            //    txtNam.Text = Request.QueryString["Nam"].ToString();
            //}
            fLoadDonVi();
            fLoad();
            fLoadNganSachConLai();
            Session["Reload"] = "";
          
         
        }
    }

    void fLoad()
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_ChiTiet_ChiPhiKeHoach_Load";
        //Obj.SpName = "sp_ChiTiet_ChiPhiKeHoach_Load_040515";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();             

    }

    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        //Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
        Obj.SpName = "sp_ChiPhiKeHoach_LoadDVUyQuyen";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();
    }
    void fLoadNganSachConLai()
    {    

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Khoa_ChiPhi" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_ChiPhiKeHoach_GetChiPhiDuocDuyet_ByKhoaChiPhi";
        //Obj.SpName = "sp_ChiPhiKeHoach_GetChiPhiDuocDuyet_ByKhoaChiPhi_040515";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnChiPhiConLai.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();
                rnChiPhiConLaiAn.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();

            }
            catch { }
        }
    }
   
    protected void RG_InsertCommand(object sender, GridCommandEventArgs e)
    {

    }
  
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //switch (e.CommandName)
        //{
        //    case RadGrid.FilterCommandName:
        //        fLoad();
        //        break;
        //    case RadGrid.RebindGridCommandName:
        //        fLoad();
        //        break;
        //    case "SUA":
        //        DropDownListThang.Text = RG.Items[e.Item.ItemIndex]["Thang"].Text;
        //        rnChiPhi.Text = RG.Items[e.Item.ItemIndex]["Chiphi"].Text;
        //        //button = 1;
        //        //lbLoi.Text ="bb" + button;
        //        Session["sukienbt"] = "";
        //        break;
        //}

        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietKeHoachChiPhi_Update.ascx";
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
        lbLoi.Text = "";

        try
        {
            rnChiPhiConLai.Value = rnChiPhiConLaiAn.Value - rnChiPhi.Value;
            //if (rnChiPhiConLai.Value < 0)
            //{
            //    throw new Exception("Chi phí không được lớn hơn chi phí được duyệt");
            //}
            //else
            //{

                if (rnChiPhi.Value == 0)
                {
                    throw new Exception("Chi phí kế hoạch phải lớn hơn 0");

                }
                else if (rnTiLeDV.Value < 100 && ddlDonVi.SelectedValue=="")
                {
                    throw new Exception("Tỉ lệ đv < 100 thì phải chọn đơn vị nhận ủy quyền");
                }
                else
                {

                    string Khoa_chiphi = txtKHCP_ID.Text;
                    string Thang = DropDownListThang.SelectedValue;
                    string IDkhoa_chitietKH = (Khoa_chiphi + "-" + Thang).ToUpper().Trim();

                    MaNV = Session["UserID"].ToString();

                    #region Insert
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@IDkhoa_chitietKH", "@Khoa_chiphi", "@Thang", "@Chiphi", "@MaNV", "@MaDVDuocUyQuyen", "@TiLeDV", "@TiLeUyQuyen", "@GHICHU" };
                    Obj.ValueParameter = new object[] { IDkhoa_chitietKH, Khoa_chiphi, Thang, rnChiPhi.Value, MaNV, ddlDonVi.SelectedValue == "" ? Convert.DBNull : ddlDonVi.SelectedValue, rnTiLeDV.Value, 100 - rnTiLeDV.Value, txtGhiChu.Text };

                    Obj.SpName = "sp_ChiTiet_ChiPhiKeHoach_Insert";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='Red'>Đã có chi phí kế hoạch tháng <b><font color='black'>" + DropDownListThang.SelectedValue + "</font></b> trong danh sách.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Thêm  chi phí kế hoạch tháng <b><font color='black'>" + DropDownListThang.SelectedValue + "</font></b> thành công.</font>";
                        fLoad();
                        fLoadNganSachConLai();
                    }

                }
            

        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }

        
        #endregion
       
       
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
        string MaNV = RG.Items[e.Item.ItemIndex]["ManvCN"].Text;

        if (MaNV != Session["UserID"].ToString())
        {
            lbLoi.Text = "<font color='red'>Không xóa được thông tin của người khác.</font>";
        }
        else
        {

            string IDkhoa_chitietKH = RG.Items[e.Item.ItemIndex]["IDkhoa_chitietKH"].Text;
            string ID_Khoachiphi = RG.Items[e.Item.ItemIndex]["Khoa_chiphi"].Text;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@IDkhoa_chitietKH", "@khoa_chiphi" };
            Obj.ValueParameter = new object[] { IDkhoa_chitietKH, ID_Khoachiphi };
            Obj.SpName = "sp_ChiTiet_ChiphikeHoach_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
        }
        fLoad();
        fLoadNganSachConLai();
    }

    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

        lbLoi.Text = "";        

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox UCtxtIDKhoa = userControl.FindControl("UCtxtIDKhoa") as TextBox;
        TextBox UCtxtKhoaCP = userControl.FindControl("UCtxtKhoaCP") as TextBox;
        TextBox UCtxtThang = userControl.FindControl("UCtxtThang") as TextBox;
        Telerik.Web.UI.RadNumericTextBox ucChiphi = userControl.FindControl("UCrnChiPhi") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox TiLeDV = userControl.FindControl("rnTiLeDV") as Telerik.Web.UI.RadNumericTextBox;

       // Telerik.Web.UI.RadDatePicker NgayLap = userControl.FindControl("rdNgayLap") as Telerik.Web.UI.RadDatePicker;

        Telerik.Web.UI.RadNumericTextBox rnChiPhiConLai = userControl.FindControl("rnChiPhiConLai") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnNganSachConLai = userControl.FindControl("rnNganSachConLaiAn") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox ThanhTienAn = userControl.FindControl("rdThanhTienAn") as Telerik.Web.UI.RadNumericTextBox;

        Telerik.Web.UI.RadNumericTextBox rnTiLeDV = userControl.FindControl("rnTiLeDV") as Telerik.Web.UI.RadNumericTextBox;

        RadComboBox ddlDonVi = userControl.FindControl("ddlDonVi") as RadComboBox;

        TextBox txtMaNV = userControl.FindControl("txtMaNV") as TextBox;

        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;

      

        rnChiPhiConLai.Value = rnNganSachConLai.Value + (ThanhTienAn.Value - ucChiphi.Value);
        try
        {
            //if (txtMaNV.Text != Session["UserID"].ToString())
            //{
            //    fLoad();
            //    fLoadNganSachConLai();
            //    throw new Exception("Không sửa được nội dung của người khác!!");
            //}

            //if (rnChiPhiConLai.Value < 0)
            //{
            //    fLoad();
            //    fLoadNganSachConLai();
            //    throw new Exception("Chi phí không được lớn hơn chi phí được duyệt");
            //}

            if (rnTiLeDV.Value > 100)
            {
                fLoad();
                fLoadNganSachConLai();
                throw new Exception("Tỉ lệ không vượt quá 100%");

            }
            if (rnTiLeDV.Value < 100 && ddlDonVi.SelectedValue == "")
            {
                throw new Exception("Tỉ lệ đv < 100 thì phải chọn đơn vị nhận ủy quyền");
            }
            #region Luu
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@IDkhoa_chitietKH", "@Khoa_chiphi", "@Chiphi", "@MaNVCN", "@TiLeDV", "@DVUyQuyen", "@GHICHU" };
            Obj.ValueParameter = new object[] { UCtxtIDKhoa.Text, UCtxtKhoaCP.Text, ucChiphi.Value.Value, Session["UserID"].ToString(), TiLeDV.Value.Value, ddlDonVi.SelectedValue, txtGhiChu.Text };
            Obj.SpName = "sp_ChiTiet_ChiPhiKeHoach_Update2";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
               
            }
            else
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }

        finally
        {
            fLoad();
            fLoadNganSachConLai();
        }
      

        
    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
  
}