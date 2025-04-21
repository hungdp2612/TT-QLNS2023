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


public partial class Chuongtrinh_KeHoachNganSach_ChiTiet : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region kế hoạch ngân sach
            fLoadDonVi();
            //rnThang.Text = DateTime.Now.AddMonths(1).Month.ToString();
            //rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();      
            LoadNamThang();
            fLoad();          
         
          
            #endregion

            #region xuất Excel
            //rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            LoadNamQui();
            #endregion


        }
        if (Session["ReloadKHNS"] != null)
        {
            fLoad();
            Session["ReloadKHNS"] = null;
           
        }
         
    }


   
    void LoadNamThang()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSach_LoadNam_Thang";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnThang.Value = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
    }  
    void fLoad()
    {       

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MABP" };
        Obj.ValueParameter = new object[] { rnNam.Text, txtMaBP.Text };
        Obj.SpName = "sp_KeHochNganSach_ChiTiet_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    } 
   
  
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
       // Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            //txtTenDV.Text = Obj.Dt.Rows[0]["HienThi"].ToString();
            TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();
            Session["MaDV"] = TxtMaDV.Text;
        }
        else
        {
           
        }
    }
    void fLoadMaCP(string Key)
    {
        //string IDMaCS;

        //if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        //{
        //    IDMaCS = txtIDMaCS.Text;
        //}
        //else
        //{
        //    IDMaCS = txtMaBP.Text;
        //}    

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@Key" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text), Key };
        Obj.SpName = "sp_KehoachNganSach_ChiTiet_GetMaCP";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
        cbMaChiPhi.SelectedIndex = 0;
    }

    void fLoadSoTienDuyetConLai()
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
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { IDMaCS, int.Parse(rnNam.Text), int.Parse(rnThang.Text), cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_KehoachNganSach_ChiTiet_SoTienDuyetConLai";
        Sql.fGetData(Obj);
        rnNganSachConLai.Text = Obj.Dt.Rows[0]["TienConLai"].ToString();
        rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["TienConLai"].ToString();
             
    }

    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
    }

    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {


            string IDKhoa = RG.Items[e.Item.ItemIndex]["IDKhoa"].Text;
            string MaDV = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
            string MSChiPhi = RG.Items[e.Item.ItemIndex]["MaCP_CT"].Text;
            int Nam = int.Parse(RG.Items[e.Item.ItemIndex]["Nam"].Text);
            int Thang = int.Parse(RG.Items[e.Item.ItemIndex]["Thang"].Text);

            #region Kiem tra trong phieu tam ung co ma chi phi can xoa hay khong

            int CountMaCP_CT;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MSChiPhi" };
            Obj.ValueParameter = new object[] { MaDV, Nam, Thang, MSChiPhi };
            Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Delete_KiemTraPhieuTU";
            Sql.fGetData(Obj);
            CountMaCP_CT = int.Parse(Obj.Dt.Rows[0]["CountMaCP_CT"].ToString());
            if (CountMaCP_CT > 0)
            {
                fLoad();
                throw new Exception("Chi tiết mã ns này đã lập phiếu TU, nên không xóa được. Vui lòng kiểm tra lại!!!");
               
            }
            #endregion

            #region Kiem tra trong giấy đề nghị thanh toán co ma chi phi can xoa hay khong

            int CountMaCP_CT2;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MSChiPhi" };
            Obj.ValueParameter = new object[] { MaDV, Nam, Thang, MSChiPhi };
            Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Delete_KiemTraChungTuThanhToan";
            Sql.fGetData(Obj);
            CountMaCP_CT2 = int.Parse(Obj.Dt.Rows[0]["CountMaCP_CT"].ToString());
            if (CountMaCP_CT2 > 0)
            {
                fLoad();
                throw new Exception("Chi tiết mã ns này đã lập giấy đề nghị thanh toán, nên không xóa được. Vui lòng kiểm tra lại!!!");

            }


            #endregion



            Obj = new clsObj();
            Obj.Parameter = new string[] { "@IDKhoa" };
            Obj.ValueParameter = new object[] { IDKhoa };
            Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
            rnSoTienChiTiet.Value = 0;
            fLoad();
            if (cbMaChiPhi.SelectedValue == cbMaChiPhi.Text && cbMaChiPhi.Text != "")
            {
                fLoadSoTienDuyetConLai();
            }
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

  
  
    string mschiphi;
    decimal sotien;

    void fLoadKeHoachNganSach_KeThua()
    {
        string ID_Khoa = txtIDMaCS.Text + "-" + rnNam.Text + rnThang.Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        //Obj.ValueParameter = new object[] { txtMaBP.Text, rnNam.Text, cbThang.SelectedValue };
        Obj.SpName = "sp_KeHoachNganSach_ChiTietNS_KeThuaMaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                foreach (DataRow row in Obj.Dt.Rows)
                {
                    mschiphi = row["MSChiphi"].ToString();
                    sotien = decimal.Parse(row["Sotien"].ToString());

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@ID_Khoa", "@MSChiPhi", "@MaBP", "@MaNV", "@SoTien", "@ID_KhoaCT" };
                    Obj.ValueParameter = new object[] { ID_Khoa, mschiphi, txtMaBP.Text, Session["UserID"].ToString(), sotien, ID_Khoa + mschiphi + txtIDMaCS.Text };
                    Obj.SpName = "sp_KeHoachNganSach_ChiTietNS_KeThua_Insert";
                    Sql.fNonGetData(Obj);
                    
                }              


            }
            catch { }
        }
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";      
       
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtIDMaCS.Text;
        }

        if (rnSoTienChiTiet.Value > rnNganSachConLaiAn.Value)
        {
            lbLoi.Text = "<font color='red'>Số tiền chi tiết không lớn hơn số tiền được duyệt.</font>";
            return;
        }

        if (rnSoTienChiTiet.Value ==0)
        {
            lbLoi.Text = "<font color='red'>Số tiền chi tiết phải khác 0.</font>";
            return;
        }

        string nam = rnNam.Text;
        string thang = rnThang.Text;

        string madv = TxtMaDV.Text;     

        string ID_Khoa = txtIDMaCS.Text + "-" + nam + thang;

        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@MaDV", "@IDMaCS", "@Nam", "@Thang", "@MaCP", "@SoTien", "@TenQuiCach" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text,txtIDMaCS.Text,int.Parse(rnNam.Text), int.Parse(rnThang.Text), cbMaChiPhi.SelectedValue, rnSoTienChiTiet.Value, txtTenQuiCach.Text };

        Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Thêm thất bại.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm thành công.</font>";
            fLoad();
            fLoadSoTienDuyetConLai();
        }
        #endregion

    }
   
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
       
      
        lbLoi.Text = "";

        if (rnNam.Text == "")
        {
            rnNam.Text = DateTime.Now.AddMonths(1).Year.ToString();
            lbLoi.Text = "<font color='red'>Vui lòng nhập năm ngân sách.</font>";
        }
        fLoad();
        fLoadDonVi();

    }
  
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        cbMaChiPhi.Text = "";
        fLoadMaCP("");
        fLoadSoTienDuyetConLai();
      
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }  
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
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

        ExcelQui1.Visible = true;
        ExcelQui2.Visible = false;
        ExcelQui3.Visible = false;
        ExcelQui4.Visible = false;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), IDMaCS, int.Parse(rnQui_Xem.Text) };
        Obj.SpName = "sp_KeHoachNganSach_ExeclNguoiLap";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    ExcelQui1.Columns[3].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[3].Visible = false;
                }
               
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
          
        }
        else if (rnQui_Xem.Value == 2)
        {
            ExcelQui1.Visible = false;
            ExcelQui2.Visible = true;
            ExcelQui3.Visible = false;
            ExcelQui4.Visible = false;
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui2.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[3].Visible = false;
                }
               
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
         
        }
        else if (rnQui_Xem.Value == 3)
        {
            ExcelQui1.Visible = false;
            ExcelQui2.Visible = false;
            ExcelQui3.Visible = true;
            ExcelQui4.Visible = false;

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui3.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[3].Visible = false;
                }
               
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
           
        }
        else if (rnQui_Xem.Value == 4)
        {

            ExcelQui1.Visible = false;
            ExcelQui2.Visible = false;
            ExcelQui3.Visible = false;
            ExcelQui4.Visible = true;
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui4.Columns[3].Visible = true;
                }
                else
                {

                   ExcelQui4.Columns[3].Visible = false;
                }               
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();           
        }
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
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
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), IDMaCS, int.Parse(rnQui_Xem.Text) };
        Obj.SpName = "sp_KeHoachNganSach_ExeclNguoiLap";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    ExcelQui1.Columns[3].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[3].Visible = false;
                }            
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 2)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui2.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[3].Visible = false;
                }
              
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 3)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui3.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[3].Visible = false;
                }
             
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 4)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui4.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[3].Visible = false;
                }
              
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui4.MasterTableView.ExportToExcel();
        }
    }
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }


    protected void cbMaChiPhi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadSoTienDuyetConLai();
    }
}