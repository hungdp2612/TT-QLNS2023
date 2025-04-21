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
public partial class ChiTietPhieuTamUng : clsPhanQuyen
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
            if (Request.QueryString["MaDV"] != null)
            {
                if (Request.QueryString["MaDV"] == "TT.R")
                {
                    tbMaDV.Text = "TT.R&D";
                }
                else
                {
                    tbMaDV.Text = Request.QueryString["MaDV"].ToString();
                }
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
            //tbMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
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
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { IDMaCS, cbMaChiPhi.SelectedValue, nam, thang };
        //Obj.SpName = "sp_ChiTietPhieuTamUng_NganSachConLai";
        Obj.SpName = "sp_ChiTietPhieuTamUng_NganSachConLai040515";
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

    void fLoadMaCP(string Key)
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
        //Obj.SpName = "sp_ChiTietPhieuTU_MaSoChiPhi_ByMaDV";
        Obj.SpName = "sp_ChiTietPhieuTU_MaSoChiPhi_ByMaDV040515";
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
        double idchitiet = Convert.ToDouble(RG.Items[e.Item.ItemIndex]["Id_ChiTiet"].Text);
       
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
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietPhieuTamUng_Update.ascx";
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

      
    }
    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        if (rdThanhTien.Text != "")
        {
            rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value * rnTiGia.Value);
        }
        
    }

    double NS_MCP, NS_MCP_TT;
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
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
                    Obj.ValueParameter = new object[] { tbMaDV.Text, cbMaChiPhi.SelectedValue, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
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
                            NS_MCP = Convert.ToDouble(Obj.Dt.Rows[0]["TongNSThang"].ToString());//79.000.000
                            NS_MCP_TT = Convert.ToDouble(Obj.Dt.Rows[0]["NSThucHien"].ToString());//7.800.000
                        }
                        catch { }
                    }


                    if (rdThanhTien.Value.Value > rnNganSachConLai.Value)
                    {
                        double dungsai5 = NS_MCP + (NS_MCP * 5 / 100);

                        double dungsai10 = NS_MCP + (NS_MCP * 10 / 100);

                        double dungsai20 = NS_MCP + (NS_MCP * 20 / 100);

                        if (dungsai5 < (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))) && NS_MCP > 10000000)
                        {
                            lbLoi.Text = "<font color='red'>Tạm ứng đã vượt ngân sách 5% (Ngân sách: " +
                                NS_MCP.ToString() + " ; tạm ứng: " + (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                            return;
                        }

                        if (dungsai10 < (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))) && NS_MCP > 5000000 && NS_MCP <= 10000000)
                        {
                            lbLoi.Text = "<font color='red'>Tạm ứng đã vượt ngân sách 10% (Ngân sách: " +
                                NS_MCP.ToString() + " ; tạm ứng: " + (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                            return;
                        }

                        if (dungsai20 < (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))) && NS_MCP <= 5000000)
                        {
                            lbLoi.Text = "<font color='red'>Tạm ứng đã vượt ngân sách 20% (Ngân sách: " +
                                NS_MCP.ToString() + " ; tạm ứng: " + (NS_MCP_TT - (rnNganSachConLai.Value > 0 ? rnNganSachConLai.Value : 0) + ((rdThanhTien.Value * rnTiGia.Value))).ToString() + ").<br>Vui lòng bổ sung ngân sách.</font>";
                            return;
                        }
                        //lbLoi.Text = "<font color='red'>Tạm ứng không thể vượt ngân sách.</font>";
                        //fLoad();
                    }
                    //else
                    //{
                       
                        #region Insert
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi", "@MaDV", "@Nam", "@Thang", "@SoTien", "@DienGiai", "@LyDo", "@SoTienTinh" };
                        Obj.ValueParameter = new object[] { tbPTU.Text, cbMaChiPhi.SelectedValue, txtMaBP.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text),
                    rdThanhTien.Value, cbMaChiPhi.Text, tbGhiChu.Text, rnNganSachConLai.Value };

                        Obj.SpName = "sp_ChiTietPhieuTamUng_Insert";
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
                        }
                        #endregion
                      
                   // }
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
}