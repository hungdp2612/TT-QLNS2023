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
public partial class ChiTietChungTuNopTien : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["sophieu"] != null)
            {
                txtSoPhieu.Text = Request.QueryString["sophieu"].ToString();
                // tbPTU.Text = Session["ReQuestPhieuTU"].ToString();

            }
            if (Request.QueryString["LoaiTien"] != null)
            {

                txtLoaiTien.Text = Request.QueryString["LoaiTien"].ToString();
            }
            if (Request.QueryString["TiGia"] != null)
            {

                rnTiGia.Text = Request.QueryString["TiGia"].ToString();
            }
            fLoadDonVi();
            FLoadPhieuTU("");
            FLoadChiPhi();
            Load_RLPhieuTU_DaNopTien();
            fLoad();
            SoTienConLai();
            fLoadLoaiTienByPhieuTU();

            Session["ReloadChungTuNopTien"] = "";
        }
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";       
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {
          
        }
        else
        {
            txtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            //txtTenDV3.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
   
    void FLoadPhieuTU(string PhieuTU)
    {

        string IDMaCS;
        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtMaBP.Text;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv", "@MaNV","@key"};
        Obj.ValueParameter = new object[] { IDMaCS, Session["UserID"].ToString(), PhieuTU };
        //Obj.SpName = "sp_ChungTuNopTien_LoadPhieuTU";
        Obj.SpName = "sp_ChungTuNopTien_LoadPhieuTU2";
        Sql.fGetData(Obj);
        cbPhieuTU.DataSource = Obj.Dt;
        cbPhieuTU.DataBind();
        cbPhieuTU.SelectedIndex = 0;
    }

    void FLoadChiPhi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU"};
        Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue };
        Obj.SpName = "sp_ChiTietNopTien_ByPhieuTU";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
        cbMaChiPhi.SelectedIndex = 0;
    }   
    
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] {txtSoPhieu.Text };
        Obj.SpName = "sp_ChiTietNopTien_GetAll";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();      
    }
    void fLoadLoaiTienByPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue };
        Obj.SpName = "sp_ChungTuNopTien_GetLoaiTien_ByPhieuTU";
        Sql.fGetData(Obj);
        txtLoaiTienPhieuTU.Text = Obj.Dt.Rows[0]["LoaiTien"].ToString();
       
    }

    void SoTienConLai()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue, cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_ChungTuNopTien_ByMaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            rnNganSachConLai.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();
            rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();

        }
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@PhieuTU" };
        //Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue };
        //Obj.SpName = "sp_ChungTuNopTien_ByMaChiPhiTEST";
        //Sql.fGetData(Obj);
        //if (Obj.Dt.Rows.Count < 1)
        //{

        //}
        //else
        //{
        //    rnNganSachConLai.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();
        //    rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();

        //}
    }
   
   
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        //fLoad();
    }
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
            
        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;
        string SoPhieu = RG.Items[e.Item.ItemIndex]["SoPhieu"].Text;
        string MSChiphi = RG.Items[e.Item.ItemIndex]["MSChiPhi"].Text;
        int lanthu =int.Parse(RG.Items[e.Item.ItemIndex]["Lanthu"].Text);
        
        Obj = new clsObj();     
        Obj.Parameter = new string[] { "@SoPhieu", "@PhieuTU", "@MSChiPhi", "@LanThu"};
        Obj.ValueParameter = new object[] { SoPhieu, PhieuTU, MSChiphi, lanthu };

        Obj.SpName = "sp_ChiTietNopTien_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            fLoad();           
            FLoadPhieuTU("");
            FLoadChiPhi();
            SoTienConLai();
          
            //fLoadSoTienThanhToan();
           
        }    

       
        rdThanhTien.Value = 0;

    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietNopTien_Update.ascx";
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
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";       
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtSoPhieu = userControl.FindControl("txtSoPhieu") as TextBox;
        TextBox txtMSCHiPhi = userControl.FindControl("txtMSCHiPhi") as TextBox;
        TextBox txtPhieuTU = userControl.FindControl("txtPhieuTU") as TextBox;
        TextBox txtLanThu = userControl.FindControl("txtLanThu") as TextBox;

        Telerik.Web.UI.RadNumericTextBox rnSoTienThanhToan = userControl.FindControl("rnSoTienThanhToan") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox ThanhTienAn = userControl.FindControl("rdThanhTienAn") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnSoTienConLai = userControl.FindControl("rnSoTienConLai") as Telerik.Web.UI.RadNumericTextBox;
        
        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;
        

        rnSoTienConLai.Value = rnSoTienConLai.Value + (ThanhTienAn.Value - rnSoTienThanhToan.Value);
        if (rnSoTienConLai.Value < 0)
        {
            lbLoi.Text = "<font color='red'>Tiền nộp không thể vượt tạm ứng.</font>";
            fLoad();
            FLoadPhieuTU("");
        }
        else
        {
            #region Luu
            Obj = new clsObj();
            //Obj.Parameter = new string[] { "@SoPhieu","@PhieuTU","@MSChiPhi","@LanThu", "@TienThanhToan", "@TienConLai", "@GhiChu" };
            //Obj.ValueParameter = new object[] { txtSoPhieu.Text, txtPhieuTU.Text, txtMSCHiPhi.Text, int.Parse(txtLanThu.Text), decimal.Parse(rnSoTienThanhToan.Text), decimal.Parse(rnSoTienConLai.Text),  txtGhiChu.Text };

            Obj.Parameter = new string[] { "@SoPhieu", "@PhieuTU", "@MSChiPhi", "@LanThu", "@TienThanhToan", "@GhiChu" };
            Obj.ValueParameter = new object[] { txtSoPhieu.Text, txtPhieuTU.Text, txtMSCHiPhi.Text, int.Parse(txtLanThu.Text), decimal.Parse(rnSoTienThanhToan.Text), txtGhiChu.Text };
            Obj.SpName = "sp_ChiTietNopTien_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công chi phí nộp tiền.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
            fLoad();
           
            FLoadPhieuTU("");
            FLoadChiPhi();
            SoTienConLai();
            //fLoadSoTienThanhToan();
        }


    }
  
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        rdThanhTien.Value = 0;

       

       
      
    }
    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        if (rdThanhTien.Text != "")
        {
            rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value * rnTiGia.Value);
        }
        
    }

   
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (rdThanhTien.Value.Value == 0)
            {
                throw new Exception("SỐ TIỀN NỘP PHẢI KHÁC 0.....");
            }

            if (cbPhieuTU.SelectedValue != cbPhieuTU.Text)
            {
                throw new Exception("PHIẾU TẠM ỨNG KHÔNG CÓ");
            }

            if (txtLoaiTien.Text != txtLoaiTienPhieuTU.Text)
            {
                throw new Exception("LOẠI TIỀN TẠM ỨNG KHÁC VỚI LOẠI TIỀN NỘP TIỀN. XIN CHỌN ĐÚNG LOẠI TIỀN");
            }


            lbLoi.Text = "";
            rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value);

            if (rnNganSachConLai.Value < 0)
            {
                lbLoi.Text = "<font color='red'>Nộp tiền không thể vượt tạm ứng.</font>";
                fLoad();
                SoTienConLai();
                //FLoadPhieuTU("");
                rdThanhTien.Value = 0;

            }
            else
            {
                string khoa = txtSoPhieu.Text + cbPhieuTU.SelectedValue + cbMaChiPhi.SelectedValue;
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoPhieu", "@PhieuTU", "@MSChiPhi",  "@TienThanhToan",  "@GhiChu" };
                Obj.ValueParameter = new object[] { txtSoPhieu.Text, cbPhieuTU.SelectedValue, cbMaChiPhi.SelectedValue,  decimal.Parse(rdThanhTien.Text), txtGhiChu.Text };

                Obj.SpName = "sp_ChiTietNopTien_Insert";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Thất bại.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Thêm chi tiết nộp tiền <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> thành công.</font>";
                    fLoad();

                    FLoadPhieuTU("");
                    FLoadChiPhi();
                    SoTienConLai();
                    rdThanhTien.Value = 0;

                }
            }
        }
        catch (Exception ex) { lbLoi.Text = "<font color='red'>" + ex.Message + "</font>"; }
           
       
        
    }
    protected void cbPhieuTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdThanhTien.Value = 0;
        lbLoi.Text = "";
        FLoadChiPhi();
        SoTienConLai();
        fLoadLoaiTienByPhieuTU();
      
    }
    protected void cbMaChiPhi_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdThanhTien.Value = 0;      
        lbLoi.Text = "";
        SoTienConLai();     
      
    }
    protected void cbPhieuTU_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        FLoadPhieuTU(e.Text);
    }

    #region  Tab2
    void Load_RLPhieuTU_DaNopTien()
    {

        string IDMaCS;
        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtMaBP.Text;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        Obj.ValueParameter = new object[] { IDMaCS, Session["UserID"].ToString() };
        // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU2";
        // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU";
        Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU_DaNopTien";

        Sql.fGetData(Obj);
        rgPhieuTUDaTT.DataSource = Obj.Dt;
        rgPhieuTUDaTT.DataBind();

    }

    protected void cbketThucTT_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cbketThucTT = sender as CheckBox;
        GridDataItem item = (GridDataItem)cbketThucTT.NamingContainer;
        string PhieuTU = item.GetDataKeyValue("PhieuTU").ToString();

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@KetThucThanhToan" };
        Obj.ValueParameter = new object[] { PhieuTU, cbketThucTT.Checked };
        Obj.SpName = "sp_PhieuTamUng_KetThucThanhToan";
        Sql.fNonGetData(Obj);

        fLoad();
        Load_RLPhieuTU_DaNopTien();
    }

    protected void KetThucNopTien_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox KetThucNopTien = sender as CheckBox;
        GridDataItem item = (GridDataItem)KetThucNopTien.NamingContainer;
        string PhieuTU = item.GetDataKeyValue("PhieuTU").ToString();

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@KetThucNopTien" };
        Obj.ValueParameter = new object[] { PhieuTU, KetThucNopTien.Checked };
        Obj.SpName = "sp_PhieuTamUng_KetThucNopTien";
        Sql.fNonGetData(Obj);

        fLoadDonVi();
        FLoadPhieuTU("");
        FLoadChiPhi();
        Load_RLPhieuTU_DaNopTien();
        fLoad();
        SoTienConLai();
    }
    protected void rgPhieuTUDaTT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Load_RLPhieuTU_DaNopTien();
    }
    protected void rgPhieuTUDaTT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        Load_RLPhieuTU_DaNopTien();
    }
    #endregion
   
}