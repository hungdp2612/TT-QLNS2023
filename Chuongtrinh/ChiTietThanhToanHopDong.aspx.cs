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
public partial class ChiTietThanhToanHopDong : clsPhanQuyen
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

            fLoad();
            fLoadDonVi();
           // fLoadChiPhiTheoMaDV();
            countPhieuTU();
            FLoadNganSachConLai();
            Session["ReloadChiTietThanhToanHD"] = "";

           
        }
    }  
   
    
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] {txtSoPhieu.Text };
        Obj.SpName = "sp_ChiTietThanhToan_GetAll";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
      
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
            txtMaDV.Text = "Không tìm thấy";
           
        }
        else
        {
            txtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
          
        }
    }
    void fLoadChiPhiTheoMaDV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaBP.Text };
        Obj.SpName = "sp_KeHoachNganSach_MaChiPhi_ByMaDV";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
       // cbMaChiPhi.SelectedIndex = 0;
    }

    int countphieuTU;
    int countPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPHi" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_PhieuTamUng_Count_ByMaChiPhi_MaDV";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count >= 0)
        {
            try
            {
                countphieuTU = int.Parse(Obj.Dt.Rows[0]["CountPhieuTU"].ToString());
            }
            catch { }
        }
        return countphieuTU;
    }

    void FLoadNganSachConLai()
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_NganSachConLai_ByMaDV_MSChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnNganSachConLai.Text = Obj.Dt.Rows[0]["STCON"].ToString();
                rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["STCON"].ToString();
            }
            catch { }
        }
    }


    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        //fLoad();
    }
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {


        string CTTT_ID = RG.Items[e.Item.ItemIndex]["CTTT_ID"].Text;     
        string SoPhieu = RG.Items[e.Item.ItemIndex]["SoPhieu"].Text;
        string MSChiPhi = RG.Items[e.Item.ItemIndex]["MSChiPhi"].Text;
        double TienThanhToan;
        if (RG.Items[e.Item.ItemIndex]["TienThanhToan"].Text == "&nbsp;")
        {
            TienThanhToan = 0;
        }
        else
        {
            TienThanhToan = double.Parse(RG.Items[e.Item.ItemIndex]["TienThanhToan"].Text);
        }
        double TienConLai;

        if ((RG.Items[e.Item.ItemIndex]["TienConLai"].Text) == "&nbsp;")
        {
            TienConLai = 0;
        }
        else
        {
            TienConLai = double.Parse(RG.Items[e.Item.ItemIndex]["TienConLai"].Text);
        }
     
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@CTTT_ID", "@SoPhieu", "@MSChiPhi", "@TienThanhToan", "@TienConLai", "@MaDV" };
        Obj.ValueParameter = new object[] { CTTT_ID,SoPhieu, MSChiPhi,TienThanhToan,TienConLai,txtMaDV.Text };
        Obj.SpName = "sp_ChiTietThanhToan_KhongTamUng_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            fLoad();
            FLoadNganSachConLai();
            if (cboSoHopDong.Text != "")
            {
                fLoadSoTienConLaiCuaHD();
            }
          
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
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtSoPhieu = userControl.FindControl("txtSoPhieu") as TextBox;
        TextBox txtKhoa = userControl.FindControl("txtKhoa") as TextBox;

        TextBox txtMSCHiPhi = userControl.FindControl("txtMSCHiPhi") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rdThanhTien = userControl.FindControl("rdThanhTien") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox ThanhTienAn = userControl.FindControl("rdThanhTienAn") as Telerik.Web.UI.RadNumericTextBox;

        Telerik.Web.UI.RadNumericTextBox rnNganSachConLai = userControl.FindControl("rnNganSachConLai") as Telerik.Web.UI.RadNumericTextBox;
        
        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;
        TextBox txtTenVaQuiCach = userControl.FindControl("txtQuiCach") as TextBox;

        Telerik.Web.UI.RadNumericTextBox rnTiGia = userControl.FindControl("rnTiGia") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnSoLuong = userControl.FindControl("rnSoLuong") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnDonGia = userControl.FindControl("rnDonGia") as Telerik.Web.UI.RadNumericTextBox;
        TextBox txtDVT = userControl.FindControl("txtDVT") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rnVAT = userControl.FindControl("rnVAT") as Telerik.Web.UI.RadNumericTextBox;
        TextBox txtSoHoaDon = userControl.FindControl("txtSoHoaDon") as TextBox;
      
        rnNganSachConLai.Value = rnNganSachConLai.Value + (ThanhTienAn.Value - rdThanhTien.Value) * rnTiGia.Value;

        if (rdThanhTien.Value == 0)
        {
            lbLoi.Text = "<font color='red'>Số tiền phải lớn hơn 0.</font>";
            fLoad();
            FLoadNganSachConLai();
        }
        else
        {
            if (rnNganSachConLai.Value < 0)
            {
                lbLoi.Text = "<font color='red'>Số tiền không thể vượt ngân sách.</font>";
                fLoad();
                FLoadNganSachConLai();
            }
            else
            {

                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@CTTT_ID", "@SoPhieu", "@TienThanhToan", "@TienConLai", "@SoLuong", "@DonGia", "@DVT", "@VAT", "@SoHoaDon", "@MSChiPhi", "@MaDV", "@TenVaQuiCach", "@GhiChu" };
                Obj.ValueParameter = new object[] { txtKhoa.Text, txtSoPhieu.Text, decimal.Parse(rdThanhTien.Text), decimal.Parse(rnNganSachConLai.Text), Convert.ToDecimal(rnSoLuong.Value), Convert.ToDecimal(rnDonGia.Value), txtDVT.Text, rnVAT.Value.Value, txtSoHoaDon.Text, txtMSCHiPhi.Text, txtMaBP.Text, txtTenVaQuiCach.Text, txtGhiChu.Text };
                Obj.SpName = "sp_ChiTietThanhToan_KhongTamUng_Update";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua > 0)
                {
                    lbLoi.Text = "<font color='blue'>Cập nhật thành công chi phí đề nghị thanh toán.</font>";
                    fLoad();
                    FLoadNganSachConLai();
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                    fLoad();
                    FLoadNganSachConLai();
                }
                #endregion

            }

        }


    }
  
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        rdThanhTien.Value = 0;
        rnDonGia.Value = 0;
        rnSoLuong.Value = 0;
        rnVAT.Value = 0;
      
    }
    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        //if (rdThanhTien.Text != "")
        //{
        //    rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value * rnTiGia.Value);
        //}
        
    }


    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            lbLoi.Text = "";
            if (cbMaChiPhi.Text != cbMaChiPhi.SelectedValue)
            {
                throw new Exception("Mã số chi phí không đúng.....");
            }
            else
            {
                //if (rdThanhTien.Value.Value <= 0)
                //{
                //    lbLoi.Text = "<font color='red'>Số tiền thanh toán phải lớn hơn 0.</font>";
                //    fLoad();
                //}
                //else
                //{

                    rnNganSachConLai.Value = rnNganSachConLai.Value - (rdThanhTien.Value * rnTiGia.Value);
                    if (rnNganSachConLai.Value < 0)
                    {
                        lbLoi.Text = "<font color='red'>Số tiền không thể vượt ngân sách.</font>";
                        fLoad();
                        FLoadNganSachConLai();
                        rdThanhTien.Value = 0;

                        rnDonGia.Value = 0;
                        rnSoLuong.Value = 0;
                        rnVAT.Value = 0;
                        txtSoHoaDon.Text = "";
                    }
                    else
                    {
                        rnSoTienHopDong.Value = rnTienHDConLaiAn.Value + (rdThanhTien.Value * rnTiGia.Value);
                        if (rnSoTienHopDong.Value < 0 && cboSoHopDong.Text != "" )
                        {
                            fLoad();
                            FLoadNganSachConLai();
                            fLoadSoTienConLaiCuaHD();
                            rdThanhTien.Value = 0;

                            rnDonGia.Value = 0;
                            rnSoLuong.Value = 0;
                            rnVAT.Value = 0;
                            txtSoHoaDon.Text = "";
                            throw new Exception("Số tiền thanh toán vượt quá hợp đồng.....");
                        }
                        else
                        {
                            string sohd;
                            if (cboSoHopDong.SelectedValue == null || cboSoHopDong.SelectedValue == "")
                            {
                                sohd = "";
                            }
                            else
                            {
                                sohd = cboSoHopDong.SelectedValue;
                            }

                            string khoa = txtSoPhieu.Text + cbMaChiPhi.SelectedValue;
                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@SoPhieu", "@MSChiPhi", "@SoHopDong", "@TienThanhToan", "@TienConLai", "@SoLuong", "@DonGia", "@DVT", "@VAT", "@SoHoaDon", "@MaDV", "@MaNV_TT", "@TenVaQuiCach", "@GhiChu", "@CTTT_ID" };
                            Obj.ValueParameter = new object[] { txtSoPhieu.Text, cbMaChiPhi.SelectedValue, sohd, decimal.Parse(rdThanhTien.Text),decimal.Parse(rnNganSachConLai.Text), Convert.ToDecimal(rnSoLuong.Value), Convert.ToDecimal(rnDonGia.Value), txtDVT.Text,Convert.ToDouble(rnVAT.Value), txtSoHoaDon.Text , txtMaDV.Text,
                Session["UserID"].ToString() , txtQuiCach.Text,txtGhiChu.Text,khoa};

                            Obj.SpName = "sp_HopDong_InsertChiTietThanhToan";
                            Sql.fNonGetData(Obj);
                            if (Obj.KetQua < 1)
                            {
                                lbLoi.Text = "<font color='red'>Đã có chi phí chi tiết đề nghị thanh toán <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                            }
                            else
                            {
                                lbLoi.Text = "<font color='blue'>Thêm chi phí chi tiết đề nghị thanh toán <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> thành công.</font>";

                                fLoad();
                                rdThanhTien.Value = 0;

                                rnDonGia.Value = 0;
                                rnSoLuong.Value = 0;
                                rnVAT.Value = 0;
                                txtSoHoaDon.Text = "";
                                fLoadSoTienConLaiCuaHD();
                                FLoadNganSachConLai();

                            }
                        }
                   // }
                }

            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }

    }
    protected void cbPhieuTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdThanhTien.Value = 0;
        lbLoi.Text = "";
       
    }
    protected void cbMaChiPhi_SelectedIndexChanged1(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdThanhTien.Value = 0;
        lbLoi.Text = "";

        FLoadNganSachConLai();

        cboSoHopDong.Text = "";
        cboSoHopDong.SelectedValue = null;
        rnSoTienHopDong.Value = 0;
      
    }
    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    void fLoadMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Key" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, Key };
        Obj.SpName = "sp_GiayDeNghiThanhToan_MaChiPhi_ByMaDV";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }

    void fLoadSoHopDong(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@Key","@MaDV","@MaNV" };
        Obj.ValueParameter = new object[] {  Key, txtMaDV.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_HopDong_DeNghiThanhToan";
        Sql.fGetData(Obj);
        cboSoHopDong.DataSource = Obj.Dt;
        cboSoHopDong.DataBind();
    }
    void fLoadSoTienConLaiCuaHD()
    {
        if (cboSoHopDong.Text == cboSoHopDong.SelectedValue)
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoHopDong" };
            Obj.ValueParameter = new object[] { cboSoHopDong.SelectedValue };
            Obj.SpName = "sp_HopDong_SoTienConLai";
            Sql.fGetData(Obj);
            rnSoTienHopDong.Value = Convert.ToDouble(Obj.Dt.Rows[0]["TienConLai"].ToString());
            rnTienHDConLaiAn.Value = Convert.ToDouble(Obj.Dt.Rows[0]["TienConLai"].ToString());
        }
        else
        {
            lbLoi.Text = "<font color='red'> Số hợp đồng không đúng.</font>";
        }

    }

    void fLoadChiPhiBySoHD()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoHopDong" };
        Obj.ValueParameter = new object[] { cboSoHopDong.SelectedValue };
        Obj.SpName = "sp_HopDong_MaCP_BySoHD";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
        cbMaChiPhi.SelectedIndex = 0;
    }
    protected void cboSoHopDong_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadSoHopDong(e.Text);
    }
    protected void cboSoHopDong_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        rdThanhTien.Value = 0;
        if (cboSoHopDong.Text == "" || cboSoHopDong.Text == null)
        {
            rnSoTienHopDong.Value = 0;
        }
        else
        {
            rnSoTienHopDong.Value = 0;
            fLoadSoTienConLaiCuaHD();
            fLoadChiPhiBySoHD();
            FLoadNganSachConLai();
        }
            
    }
}