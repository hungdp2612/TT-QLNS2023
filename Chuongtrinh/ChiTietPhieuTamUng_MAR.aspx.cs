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
public partial class ChiTietPhieuTamUng_MAR : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["PhieuTamUng"] != null)
            {
                tbPTU.Text = Request.QueryString["PhieuTamUng"].ToString();
                fLoadNganSachConLai();

            }
            if (Request.QueryString["nam"] != null)
            {
                txtNam.Text = Request.QueryString["nam"].ToString();
            }
            if (Request.QueryString["thang"] != null)
            {
                txtThang.Text = Request.QueryString["thang"].ToString();
            }
            fLoadDonVi();
            fLoad_byID();
            fLoad();

           // fLoadCbChiPhi();          
           // fLoadNganSachConLai();

            Session["ReloadPhieuTU"] = "";
        }
    }
    private void Split(string s)
    {
        string pattern = "&";
        Regex myRegex = new Regex(pattern);
        string[] ketqua = myRegex.Split(s);
        

    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_ChiPhieuTamUng_GetAllByPhieuTU";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();


    }   

    void fLoad_byID()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_PhieuTamUng_ByID";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
               // rdNgayLap.SelectedDate = DateTime.Parse(Obj.Dt.Rows[0]["NgayLapPhieu"].ToString());
               // tbMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
                rnTiGia.Value = float.Parse(Obj.Dt.Rows[0]["TiGia"].ToString());
                tbLoaiTien.Text = Obj.Dt.Rows[0]["LoaiTien"].ToString();
            }
            catch { }
        }
        
    }

    #region test
    //int countphieuTU;
    //int countNganSachConLai()
    //{
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { "@MaDV", "@MSChiPHi","@PhieuTU" };
    //    Obj.ValueParameter = new object[] { tbMaDV.Text, cbMaChiPhi.SelectedValue, tbPTU.Text };
    //    Obj.SpName = "sp_ChiTietPhieuTamUng_Count";
    //    Sql.fGetData(Obj);
    //    if (Obj.Dt.Rows.Count >= 0)
    //    {
    //        try
    //        {
    //            countphieuTU = int.Parse(Obj.Dt.Rows[0]["CountTU"].ToString());
    //        }
    //        catch { }
    //    }
    //    return countphieuTU;
    //}
    //int countphieuTU3;
    //int countNganSachConLai3()
    //{
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] {"@MSChiPhi", "@MaDV" };
    //    Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, txtMaBP.Text };
    //    Obj.SpName = "sp_ChiTietPhieuTamUng_Count3";
    //    Sql.fGetData(Obj);
    //    if (Obj.Dt.Rows.Count >= 0)
    //    {
    //        try
    //        {
    //            countphieuTU3 = int.Parse(Obj.Dt.Rows[0]["CountTU"].ToString());
    //        }
    //        catch { }
    //    }
    //    return countphieuTU3;
    //}
    //void fLoadChiPhi()
    //{
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
    //    Obj.ValueParameter = new object[] { txtMaBP.Text,cbMaChiPhi.SelectedValue, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
    //    Obj.SpName = "sp_MaSoChiPhi_ByMaDV_MaNV";
    //    Sql.fGetData(Obj);
    //    if (Obj.Dt.Rows.Count > 0)
    //    {
    //        try
    //        {
    //            //cbMaChiPhi.DataSource = Obj.Dt;
    //            //cbMaChiPhi.DataBind();
    //            rnNganSachConLai.Value = float.Parse(Obj.Dt.Rows[0]["Sotien"].ToString());
    //            rnNganSachConLaiAn.Value = rnNganSachConLai.Value;

    //        }
    //        catch { }
    //    }       

    //}
    #endregion

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
            tbMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();          
            
        }
    } 

    void fLoadNganSachConLai()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_ChiTietPhieuTU_GetNamThang_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { nsphongban30(), cbMaChiPhi.SelectedValue, nam, thang };
        Obj.SpName = "sp_ChiTietPhieuTamUng_NganSachConLai";
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

    void FLoadNganSachChiTietConLai()
    {
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_ChiTietPhieuTU_GetNamThang_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaCP_CT", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { IDMaCS, cboMSChiPhi_CT.SelectedValue, nam, thang };
        Obj.SpName = "sp_GiayDeNghiThanhToan_NganSachChiTietConLai";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnTienChiTietConLai.Text = Obj.Dt.Rows[0]["STCON"].ToString();
                rnTienChiTietConLaiAn.Text = Obj.Dt.Rows[0]["STCON"].ToString();

            }
            catch { }
        }
    }


    string nsphongban30()
    {
        string mabp;
        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            mabp = txtIDMaCS.Text;
        }
        else
        {
            mabp = txtMaBP.Text;
        }
        return mabp;
    }
    //void fLoadCbChiPhi()
    //{

    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { "@PhieuTU" };
    //    Obj.ValueParameter = new object[] { tbPTU.Text };
    //    Obj.SpName = "sp_ChiTietPhieuTU_GetNamThang_ByPhieuTU";
    //    Sql.fGetData(Obj);

    //    int nam, thang;
    //    nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
    //    thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
      
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { "@MaDV",  "@Nam", "@Thang" };
    //    Obj.ValueParameter = new object[] { nsphongban30(), nam, thang };
    //    Obj.SpName = "sp_MaSoChiPhi_ByMaDV";
    //    Sql.fGetData(Obj);
    //    if (Obj.Dt.Rows.Count > 0)
    //    {
    //        try
    //        {
    //            cbMaChiPhi.DataSource = Obj.Dt;
    //            cbMaChiPhi.DataBind();
    //            cbMaChiPhi.SelectedIndex = 0;
              
    //        }
    //        catch { }
    //    }        

    //}

    void fLoadMaCP(string Key)
    {
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_ChiTietPhieuTU_GetNamThang_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang","@Key" };
        Obj.ValueParameter = new object[] { IDMaCS, nam, thang, Key };
        Obj.SpName = "sp_ChiTietPhieuTU_MaSoChiPhi_ByMaDV";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }
      
   
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;
        double idchitiet = Convert.ToDouble(RG.Items[e.Item.ItemIndex]["id_chitiet"].Text);
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@Id_ChiTiet" };
        Obj.ValueParameter = new object[] { PhieuTU, idchitiet };
        Obj.SpName = "sp_ChiTietPhieuTamUng_Delete";
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
        fLoadNganSachConLai();
        rdThanhTien.Value = 0;
        if (cboMSChiPhi_CT.SelectedValue == cboMSChiPhi_CT.Text && cboMSChiPhi_CT.Text != "")
        {
            FLoadNganSachChiTietConLai();
        }

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

            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietPhieuTamUng_Mar_Update.ascx";

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
        TextBox UCtxtPhieuTU = userControl.FindControl("UCtxtPhieuTU") as TextBox;
        TextBox UCtxtMSChiPhi = userControl.FindControl("UCtxtMSChiPhi") as TextBox;
        TextBox txtIdChiTiet = userControl.FindControl("txtId_ChiTiet") as TextBox;

        Telerik.Web.UI.RadNumericTextBox UCrdSoTien = userControl.FindControl("UCrdSoTien") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox ThanhTienAn = userControl.FindControl("rdThanhTienAn") as Telerik.Web.UI.RadNumericTextBox;
        Telerik.Web.UI.RadNumericTextBox rnNganSachConLai = userControl.FindControl("rnNganSachConLai") as Telerik.Web.UI.RadNumericTextBox;
        TextBox UCtxtLyDo = userControl.FindControl("UCtxtLyDo") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rnTiGia = userControl.FindControl("rnTiGia") as Telerik.Web.UI.RadNumericTextBox;

        rnNganSachConLai.Value = rnNganSachConLai.Value + (ThanhTienAn.Value - UCrdSoTien.Value) * rnTiGia.Value;

        if (rnNganSachConLai.Value < 0)
        {
            lbLoi.Text = "<font color='red'>Tạm ứng không thể vượt ngân sách.</font>";
            fLoad();
        }
        else
        {

            #region Luu
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@PhieuTU", "@Id_ChiTiet", "@SoTien", "@LyDo"};
            Obj.ValueParameter = new object[] { UCtxtPhieuTU.Text, txtIdChiTiet.Text, double.Parse(UCrdSoTien.Text), UCtxtLyDo.Text   };
            Obj.SpName = "sp_ChiTietPhieuTamUng_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công chi phí tạm ứng <b><font color='black'>" + UCtxtMSChiPhi.Text + "</font></b>.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
            fLoad();
            fLoadNganSachConLai();
        }
    }
  
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        rdThanhTien.Value = 0;

        fLoadNganSachConLai();
        cboMSChiPhi_CT.Text = "";
        fLoadMaCPChiTiet("");
        rnTienChiTietConLai.Value = 0;
        rnTienChiTietConLaiAn.Value = 0;
        FLoadNganSachChiTietConLai();

      
    }
    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        if (rdThanhTien.Text != "")
        {
            rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value * rnTiGia.Value);
        }
        
    }

    int ktTU;
    int KTPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MSChiPHi", "@PhieuTU" };
        Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, tbPTU.Text };
        Obj.SpName = "sp_ChiTietPhieuTamUng_KiemTra";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count >= 0)
        {
            try
            {
                ktTU = int.Parse(Obj.Dt.Rows[0]["KiemTra"].ToString());
            }
            catch { }
        }
        return ktTU;
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        try
        {

            if (cbMaChiPhi.Text != cbMaChiPhi.SelectedValue)
            {
                throw new Exception("Mã số chi phí không đúng.....");
            }
            else
            {

                int dungsai = 5;

                //rnNganSachConLai.Value = rnNganSachConLai.Value - (rdThanhTien.Value * rnTiGia.Value);
                double TinhDungSai = Convert.ToDouble(rnNganSachConLai.Value + (rnNganSachConLai.Value * dungsai) / 100);
                if (rdThanhTien.Value.Value <= 0)
                {
                    lbLoi.Text = "<font color='red'>Số tiền tạm ứng phải lớn hơn 0.</font>";
                    fLoad();
                }
                else
                {
                    if (rdThanhTien.Value.Value > rnNganSachConLai.Value)
                    {
                        lbLoi.Text = "<font color='red'>Tạm ứng không thể vượt ngân sách.</font>";
                        fLoad();
                    }
                    else
                    {
                        //if (KTPhieuTU() == 1)
                        //{
                        //    lbLoi.Text = "<font color='red'>Đã có chi phí tạm ứng <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                        //    fLoad();
                        //    fLoadNganSachConLai();
                        //}
                        //else
                        //{
                        #region Insert
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi", "@MaCP_CT", "@MaDV", "@Nam", "@Thang", "@SoTien", "@DienGiai", "@LyDo", "@SoTienTinh" };
                        Obj.ValueParameter = new object[] { tbPTU.Text, cbMaChiPhi.SelectedValue, cboMSChiPhi_CT.SelectedValue == "" ? Convert.DBNull : cboMSChiPhi_CT.SelectedValue, txtMaBP.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text),
                    rdThanhTien.Value, cbMaChiPhi.Text, tbGhiChu.Text, rnNganSachConLai.Value };

                        Obj.SpName = "sp_ChiTietPhieuTamUng_MAR_Insert";
                        Sql.fNonGetData(Obj);
                        if (Obj.KetQua < 1)
                        {
                            lbLoi.Text = "<font color='red'>Đã có chi phí tạm ứng <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='blue'>Thêm chi phí tạm ứng <b><font color='black'>" + cbMaChiPhi.SelectedValue + "</font></b> thành công.</font>";
                            fLoad();
                            fLoadNganSachConLai();
                            FLoadNganSachChiTietConLai();
                        }
                        #endregion
                       
                    }
                }
            }
        }
        catch(Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }
    }

    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {

        fLoadMaCP(e.Text);
    }
    void fLoadMaCPChiTiet(string key)
    {
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { tbPTU.Text };
        Obj.SpName = "sp_ChiTietPhieuTU_GetNamThang_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MaCP", "@MaCP_CT" };
        Obj.ValueParameter = new object[] { IDMaCS, nam, thang, cbMaChiPhi.SelectedValue,key };
        Obj.SpName = "sp_KeHoachNganSach_ChiTiet_GetMaCPCT_ByMaCP";
        Sql.fGetData(Obj);
        cboMSChiPhi_CT.DataSource = Obj.Dt;
        cboMSChiPhi_CT.DataBind();
        cboMSChiPhi_CT.SelectedIndex = 0;
    }
    protected void cboMSChiPhi_CT_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCPChiTiet(e.Text);
      
    }
    protected void cboMSChiPhi_CT_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rnTienChiTietConLai.Value = 0;
        rnTienChiTietConLaiAn.Value = 0;
        rdThanhTien.Value = 0;
        FLoadNganSachChiTietConLai();
    }
}