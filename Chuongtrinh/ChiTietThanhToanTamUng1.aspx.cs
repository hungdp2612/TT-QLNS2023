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
using System.Text;
using System.Collections.Generic;
public partial class ChiTietThanhToanTamUng1 : clsPhanQuyen
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
            if (Request.QueryString["MaDV"] != null)
            {
                if (Request.QueryString["MaDV"] == "TT.R")
                {
                    txtMaDV.Text = "TT.R&D";
                }
                else
                {

                    txtMaDV.Text = Request.QueryString["MaDV"].ToString();
                }
            }

            fLoadDonVi();
            fLoadPhuTrachDonVi();
            
            Load_RLPhieuTU();
            fLoadMSChiPhi("");           
            FLoadTextbox();
            fLoad();
            fLoadSoTienConLai();

            Load_RLPhieuTU_DaTT();
           

            Session["ReloadChungTuThanhToan"] = "";
        }
    }


    #region So tien con lai
 
    void fLoadNganSachConLai()
    {
        if (txtPhieuTU.Text == "")
        {
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@PhieuTU" };
            Obj.ValueParameter = new object[] { txtPhieuTU.Text };
            Obj.SpName = "sp_PhieuTU_LayNgayThangNam_ByPhieuTU";
            Sql.fGetData(Obj);

            int nam, thang;
            nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
            thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
            Obj.ValueParameter = new object[] { txtMaDV.Text, cbMaChiPhi.SelectedValue, nam, thang };
            //Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi2";
            Obj.SpName = "sp_NganSachConLai_ThucHien_MaChiPhi";
            //Obj = new clsObj();
            //Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi" };
            //Obj.ValueParameter = new object[] { txtMaDV.Text, txtMSChiPhi.Text };
            //Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count < 1)
            {

            }
            else
            {
                try
                {
                    rnNganSachConLaiTrongThang.Text = Obj.Dt.Rows[0]["ThieuThua"].ToString();
                    rnNganSachConLaiAn2.Text = Obj.Dt.Rows[0]["ThieuThua"].ToString();
                }
                catch { }
            }
        }

       
    }
   
    void fLoadSoTienConLai()
    {
       

        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi", "@MaNV" };
        //Obj.ValueParameter = new object[] { txtPhieuTU.Text, cbMaChiPhi.SelectedValue, Session["UserID"].ToString() };
        //// Obj.SpName = "sp_ThanhToanTamUng_SumTienPhieuTU_ByMaChiPhi2";
        //Obj.SpName = "sp_ThanhToanTamUng_SumTienPhieuTU_ByMaChiPhi";

        Obj.Parameter = new string[] { "@PhieuTU", "@MaNV" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text,  Session["UserID"].ToString() };
    
        Obj.SpName = "sp_ThanhToanTamUng_SumTienPhieuTU_ByPhieuTU";


        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                rnThanhToanTamUngConLai.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());
                rnNganSachConLaiAn.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());
               
            }
            catch { }
        }

    }
    #endregion

    #region Load thong tin
    void FLoadTextbox()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { txtSoPhieu.Text };
        Obj.SpName = "sp_ChungTuThanhToanTamUng_LoadTextBox";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            txtLoaiTien.Text = Obj.Dt.Rows[0]["LoaiTien"].ToString();
            rnTiGia.Text = Obj.Dt.Rows[0]["TiGia"].ToString();


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
            //txtMaDV2.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            //txtMaBP2.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            //txtTenDonVi2.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
              txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text };
        Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {

            txtPhuTrachDonVi.Text = Obj.Dt.Rows[0]["MaNV"].ToString();
        }
       
    }
    #endregion

    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        if (rdSoTienThanhToan.Text != "")
        {
            rnThanhToanTamUngConLai.Value = rnNganSachConLaiAn.Value - (rdSoTienThanhToan.Value * rnTiGia.Value);
        }

    }
    private static void ShowCheckedItems_Label(RadListBox listBox, Label label)
    {
        StringBuilder sb = new StringBuilder();
        IList<RadListBoxItem> collection = listBox.CheckedItems;
        foreach (RadListBoxItem item in collection)
        {
            sb.Append(item.Value + ",");
        }

        label.Text = sb.ToString();

    }  
    protected void RLPhieuTU_ItemCheck(object sender, RadListBoxItemEventArgs e)
    {
       
        rdSoTienThanhToan.Value = 0;
        lbThongBao.Text = "";
       // ShowCheckedItems_Label(RLPhieuTU, itemsClientSide);
        //fLoadTongTienTamUng();

        //fLoadMSChiPhi();

        fLoadSoTienConLai();
        fLoadNganSachConLai();
       
    }
   

    #region Phieu tam ung
    void Load_RLPhieuTU()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["UserID"].ToString() };
        // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU2";
       // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU";
        Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU3";
        
        Sql.fGetData(Obj);
        rgChiTietTU.DataSource = Obj.Dt;
        rgChiTietTU.DataBind();

    }
    protected void rgChiTietTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "chon")
        {
            rdSoTienThanhToan.Value = 0;
            rnSoLuong.Value = 0;
            rnDonGia.Value = 0;
            txtPhieuTU.Text = rgChiTietTU.Items[e.Item.ItemIndex]["PhieuTU"].Text;
            txtLoaiTienTU.Text = rgChiTietTU.Items[e.Item.ItemIndex]["LoaiTien"].Text;
            fLoad();
           
            fLoadMSChiPhi("");
            //txtMSChiPhi.Text = rgChiTietTU.Items[e.Item.ItemIndex]["MSChiPhi"].Text;
            fLoadSoTienConLai();
            fLoadNganSachConLai();
        }
    }
    protected void rgChiTietTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Load_RLPhieuTU();
    }
    protected void rgChiTietTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        Load_RLPhieuTU();
    }
    #endregion

    #region Kết thúc phiếu tạm ứng
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
        Load_RLPhieuTU();
        Load_RLPhieuTU_DaTT();

      


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

        fLoad();
        Load_RLPhieuTU();
        Load_RLPhieuTU_DaTT();

    }

    #endregion

    #region Phiếu TU đã thanh toán
    void Load_RLPhieuTU_DaTT()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["UserID"].ToString() };
        // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU2";
        // Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU";
        Obj.SpName = "sp_ThanhToanTamUng_LoadPhieuTU_DaThanhToan";

        Sql.fGetData(Obj);
        rgPhieuTUDaTT.DataSource = Obj.Dt;
        rgPhieuTUDaTT.DataBind();

    }

    protected void rgPhieuTUDaTT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Load_RLPhieuTU_DaTT();
    }
    protected void rgPhieuTUDaTT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        Load_RLPhieuTU_DaTT();
    }
    #endregion

    #region MaChiPHi
    void KiemTraSoTienConLai_ByPhieuTU_MSChiPhi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, cbMaChiPhi.SelectedValue };
        Obj.SpName = "ThanhToanTamUng_ByPhieuTU_MSChiPhi";
        Sql.fGetData(Obj);
        double tienconlai = Convert.ToDouble(Obj.Dt.Rows[0]["ConLai"].ToString());
        if (tienconlai <= 0)
        {
            cbMaChiPhi.Text = "";
        }
    }  
   
    void fLoadMSChiPhi(string macp)
    {
        cbMaChiPhi.Text = "";
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@PhieuTU", "@Key" };
        //Obj.ValueParameter = new object[] { txtPhieuTU.Text, macp };
        //Obj.SpName = "sp_ChiTietThanhToanPhieuTamUng_GetMaCP_ByPhieuTU";

        Obj.Parameter = new string[] { "@PhieuTU", "@Key" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, macp };
        Obj.SpName = "sp_ChiTietThanhToanPhieuTamUng_ByPhieuTU";

        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();

        cbMaChiPhi.SelectedIndex = 0;
        //if (cbMaChiPhi.SelectedIndex == -1)
        //{
        //    rnThanhToanTamUngConLai.Value = 0;
        //    rnNganSachConLaiTrongThang.Value = 0;
        //}
    }
    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMSChiPhi(e.Text);
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdSoTienThanhToan.Value = 0;
        lbThongBao.Text = "";

        fLoadSoTienConLai();
        fLoadNganSachConLai();
    }  

    #endregion

    #region insert thanh toán tạm ưng
    double NS_MCP, NS_MCP_TT;
    void InsertChiTiet()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text };
        Obj.SpName = "sp_PhieuTU_LayNgayThangNam_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

      

        DataTable dataCTPHIEUTU = new DataTable();

        try
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@PhieuTU" };
            Obj.ValueParameter = new object[] { txtPhieuTU.Text };
            Obj.SpName = "sp_ThanhToanTamUng_TienTU_ByPhieuTU";
            Sql.fGetData(Obj);
            dataCTPHIEUTU = Obj.Dt;

            double TienTUCONLAI = Convert.ToDouble(Obj.Dt.Rows[0]["CONLAI"].ToString());//-400.000

            double TONGTIENTAMUNG = rdSoTienThanhToan.Value.Value; // 3.800.000

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
            Obj.ValueParameter = new object[] { txtMaDV.Text, cbMaChiPhi.SelectedValue, nam, thang };           
            //Obj.SpName = "sp_NganSachConLai_ByMaDV_MSChiPhi2";
            Obj.SpName = "sp_NganSachConLai_ThucHien_MaChiPhi";
            // Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi2";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count < 1)
            {

            }
            else
            {
                try
                {
                    NS_MCP = Convert.ToDouble(Obj.Dt.Rows[0]["TongNSThang"].ToString());//5.400.000
                    NS_MCP_TT = Convert.ToDouble(Obj.Dt.Rows[0]["NSThucHien"].ToString());//3.800.000
                }
                catch { }
            }

            #region Kiểm tra vượt 5%

            if (TONGTIENTAMUNG > TienTUCONLAI )
            {
                double dungsai5 = NS_MCP + (NS_MCP * (5) / 100);

                double dungsai10 = NS_MCP + (NS_MCP * 10 / 100);

                double dungsai20 = NS_MCP + (NS_MCP * 20 / 100);
                
                if (dungsai5 < (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))) && NS_MCP > 10000000)
                {
                    lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách 5% (Ngân sách: " +
                        NS_MCP.ToString() + " ; thanh toán: " + (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                    return;
                }

                if (dungsai10 < (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))) && NS_MCP > 5000000 && NS_MCP <= 10000000)
                {
                    lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách 10% (Ngân sách: " +
                        NS_MCP.ToString() + " ; thanh toán: " + (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                    return;
                }

                if (dungsai20 < (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))) && NS_MCP <= 5000000)
                {
                    lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách 20% (Ngân sách: " +
                        NS_MCP.ToString() + " ; thanh toán: " + (NS_MCP_TT - (rnThanhToanTamUngConLai.Value > 0 ? rnThanhToanTamUngConLai.Value : 0) + ((rdSoTienThanhToan.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                    return;
                }

            }

            #endregion

            string khoa = txtSoPhieu.Text + txtPhieuTU.Text+ cbMaChiPhi.SelectedValue;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu", "@PhieuTU", "@MSChiPhi", "@TienThanhToan", "@TienConLai", "@SoLuong", "@DonGia", "@DVT", "@VAT", "@SoHoaDon", "@MaNV_TT", "@Ngay_TT", "@TenVaQuiCach", "@GhiChu", "@CTTT_ID" };
            Obj.ValueParameter = new object[] { txtSoPhieu.Text, txtPhieuTU.Text, cbMaChiPhi.SelectedValue, rdSoTienThanhToan.Value,  Convert.ToDouble(rnThanhToanTamUngConLai.Value),  Convert.ToDecimal(rnSoLuong.Value), Convert.ToDecimal(rnDonGia.Value), txtDVT.Text,Convert.ToDouble(rnVAT.Value), txtSoHoaDon.Text,
                                                    Session["UserID"].ToString() , DateTime.Now,txtQuiCach.Text,txtGhiChu.Text,khoa};

            Obj.SpName = "sp_ChiTietThanhToan_Insert";
            Sql.fNonGetData(Obj);


        }
        catch (Exception ex)
        {
            lbThongBao.Text = "<font color='red'>" + ex.Message + "</font>";
        }

    }

    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            lbThongBao.Text = "";

            if (cbMaChiPhi.Text != cbMaChiPhi.SelectedValue)
            {
                throw new Exception("Mã chi phí không đúng");
            }

            //InsertChiTiet2();
            if (txtLoaiTien.Text != txtLoaiTienTU.Text)
            {
                throw new Exception("Loại tiền thanh toán và loại tiền tạm ứng khác nhau. Bạn phải chọn đúng loại tiền mới thanh toán được");
            }

            InsertChiTiet();

            fLoad();
            Load_RLPhieuTU();
           // fLoadMSChiPhi("");
            fLoadSoTienConLai();
            fLoadNganSachConLai();
        }
        catch (Exception ex)
        {
            lbThongBao.Text = "<font color='Red'>" + ex.Message + "</font>";
        }

    }  

    #endregion

    #region RG_LoadThanhToanTamUng
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { txtSoPhieu.Text };
        Obj.SpName = "sp_ChiTietThanhToan_GetAll";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
       
    }
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string CTTT_ID = RG.Items[e.Item.ItemIndex]["CTTT_ID"].Text;
        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;
        string SoPhieu = RG.Items[e.Item.ItemIndex]["SoPhieu"].Text;
        string MSChiphi = RG.Items[e.Item.ItemIndex]["MSChiPhi"].Text;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@CTTT_ID", "@SoPhieu" };
        Obj.ValueParameter = new object[] { CTTT_ID, SoPhieu };
        Obj.SpName = "sp_ChiTietThanhToan_Delete2";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbThongBao.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            fLoad();
            //FLoadPhieuTU();
            //FLoadChiPhi();
        }
        else
        {
            lbThongBao.Text = "<font color='blue'>Xóa thành công.</font>";
            fLoad();
            //FLoadPhieuTU();
            //FLoadChiPhi();
            fLoadMSChiPhi("");
            fLoadSoTienConLai();
            Load_RLPhieuTU();
            fLoadNganSachConLai();
            //fLoadSoTienThanhToan();
           

        }


        rdSoTienThanhToan.Value = 0;

    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbThongBao.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietThanhToanTamUng_Update.ascx";
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
        lbThongBao.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtSoPhieu = userControl.FindControl("txtSoPhieu") as TextBox;
        TextBox txtPhieuTU = userControl.FindControl("txtPhieuTU") as TextBox;
        TextBox txtKhoa = userControl.FindControl("txtKhoa") as TextBox;

        TextBox txtMSChiPhi = userControl.FindControl("txtMSCHiPhi") as TextBox;


        Telerik.Web.UI.RadNumericTextBox rnSoTienThanhToan = userControl.FindControl("rnSoTienThanhToan") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnTienThanhToanAn = userControl.FindControl("rnTienThanhToanAn") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox ThanhTienAn = userControl.FindControl("rdThanhTienAn") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnSoTienConLai = userControl.FindControl("rnSoTienConLai") as Telerik.Web.UI.RadNumericTextBox;

        Telerik.Web.UI.RadNumericTextBox rnTienPhieuTU = userControl.FindControl("rnTienPhieuTU") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnTienPhieuTUAn = userControl.FindControl("rnTienPhieuTUAn") as Telerik.Web.UI.RadNumericTextBox;


        Telerik.Web.UI.RadNumericTextBox rnTongNganSach = userControl.FindControl("rnTongNganSach") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnNganSachThucHien = userControl.FindControl("rnNganSachThucHien") as Telerik.Web.UI.RadNumericTextBox;

        Telerik.Web.UI.RadNumericTextBox rnSoLuong = userControl.FindControl("rnSoLuong") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnDonGia = userControl.FindControl("rnDonGia") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnVAT = userControl.FindControl("rnVAT") as Telerik.Web.UI.RadNumericTextBox;

        TextBox txtDVT = userControl.FindControl("txtDVT") as TextBox;
        TextBox txtSoHoaDon = userControl.FindControl("txtSoHoaDon") as TextBox;


        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;
        TextBox txtTenVaQuiCach = userControl.FindControl("txtQuiCach") as TextBox;

        DataTable dataCTPHIEUTU = new DataTable();


        double? dungsai5 = rnTongNganSach.Value + ((rnTongNganSach.Value * 5) / 100);

        double? dungsai10 = rnTongNganSach.Value + (rnTongNganSach.Value * 10 / 100);

        double? dungsai20 = rnTongNganSach.Value + (rnTongNganSach.Value * 20 / 100);


        if (dungsai5 < (rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value) && rnTongNganSach.Value > 10000000)//5.250.000 < 5.300.000 - rnThanhToanTamUngConLai.Value
        {
            lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách hơn 5% (Ngân sách: " +
                rnTongNganSach.Value.ToString() + " ; thanh toán: "
                + (rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
            fLoad();
            return;

        }
        if (dungsai10 < rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value && rnTongNganSach.Value > 5000000 && rnTongNganSach.Value <= 10000000)//5.250.000 < 5.300.000 - rnThanhToanTamUngConLai.Value
        {
            lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách hơn 10% (Ngân sách: " +
                rnTongNganSach.Value.ToString() + " ; thanh toán: "
                + (rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
            fLoad();
            return;

        }
        if (dungsai20 < rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value && rnTongNganSach.Value <= 5000000)//5.250.000 < 5.300.000 - rnThanhToanTamUngConLai.Value
        {
            lbThongBao.Text = "<font color='red'>Thanh toán đã vượt ngân sách hơn 20% (Ngân sách: " +
                rnTongNganSach.Value.ToString() + " ; thanh toán: "
                + (rnNganSachThucHien.Value - (rnTienPhieuTU.Value > 0 ? rnTienPhieuTU.Value : 0) - rnTienThanhToanAn.Value + rnSoTienThanhToan.Value).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";

            fLoad(); 
            return;

        }


        #region Luu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@CTTT_ID", "@SoPhieu", "@TienThanhToan", "@TienConLai", "@TenVaQuiCach", "@GhiChu", "@SoLuong", "@DonGia", "@VAT", "@DVT", "@SoHoaDon" };
        Obj.ValueParameter = new object[] { txtKhoa.Text, txtSoPhieu.Text, decimal.Parse(rnSoTienThanhToan.Text), decimal.Parse(rnSoTienConLai.Text), txtTenVaQuiCach.Text, txtGhiChu.Text
            ,rnSoLuong.Value, rnDonGia.Value,rnVAT.Value,txtDVT.Text,txtSoHoaDon.Text };
        Obj.SpName = "sp_ChiTietThanhToan_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbThongBao.Text = "<font color='blue'>Cập nhật thành công .</font>";
        }
        else
        {
            lbThongBao.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion

        fLoad();
        Load_RLPhieuTU();
        fLoadSoTienConLai();
        fLoadNganSachConLai();



    }
    #endregion
  
}