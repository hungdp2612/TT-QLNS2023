using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

public partial class Chuongtrinh_Kehoachngansach_Pduyet_bak : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    ReportDocument report;
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
                       
            LoadNam();
            LoadDVPheDuyet();

         
            LoadNganSach();
             


            #region xem ngân sach
            LoadNamQui();
            LoadDVCanXem();
            FLoadButtonDonVi();
            FLoadXemNS();

            #endregion

            #region Hiệu chỉnh ns

            LoadNamCanHieuChinh();
            LoadDVCanHieuChinh();
            FLoadHieuChinhNS();
            #endregion
        }
    }

    #region Phê duyệt ngân sách
  

    protected void RadCBoPD_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi_PD.Text = "";
        lbEmail.Text = "";


        try
        {
           
            if (RadCBoPD.SelectedValue == "False")
            {
                throw new Exception("Chưa duyệt ngân sách");
            }



            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
            Obj.ValueParameter = new object[] { rnQui.Text, rnNam_PD.Value, CboMaDV.SelectedValue, DateTime.Now, RadCBoPD.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi_PD.Text = "<font color='red'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi_PD.Text = "<font color='blue'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thành công.</font>";
                SendEmail();
            }           


        }
        catch (Exception ex)
        {
            lbLoi_PD.Text = "<font color='red'>" + ex.Message + "</font>";
        }
        finally
        {
            RadCBoPD.SelectedValue = "False";

            LoadDVPheDuyet();

            LoadNganSach();
          
            FLoadXemNS();
            FLoadHieuChinhNS();
        }
    }    
    void SendEmail()
    {

        string email="";
       
        Obj = new clsObj();

        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
        Obj.Connectionstring = wqlvattu;
        Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                foreach (DataRow row in Obj.Dt.Rows)
                {
                    email += row["EmailXX"].ToString().Trim() + ";";
                }

                

                string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                string SB = "BAN TONG GIAM DOC PHE DUYET KE HOACH NGAN SACH QUI " + rnQui.Text + "/" + rnNam_PD.Value;
                string noidung = "";
            
                noidung += "Ban Tổng giám đốc đã phê duyệt kế hoạch ngân sách quí " + rnQui.Text + "/" + rnNam_PD.Value + "%0D%0A";
            
                noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                noidung += "";
                clssys clss = new clssys();
                noidung = clss.RemoveSign4VietnameseString(noidung);

                hlEmail.NavigateUrl = "mailto:" + email + "&cc=" + cc + "?subject=" + SB + "&body=" + noidung;

                lbEmail.Text = "<font color='blue'>Vui lòng click nút gửi mail.</font>";

            }
            catch { }
        }
        else
        {
            lbEmail.Text = "<font color='red'>Gửi email thất bại.</font>";
        }
      
      
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        //if (Page.IsValid)
        //{
        //    if (LayThangCuaQui() == null || LayThangCuaQui() == "")
        //    {
        //        lbLoi_PD.Text = "<font color='red'>Ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> chưa được lập hoặc chưa xem xét nên không thể phê duyệt.</font>";
        //    }
        //    else
        //    {
        //        if (DemChiTietNganSach() == 0)
        //        {
        //            lbLoi_PD.Text = "<font color='red'>Ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> chưa có chi tiết nên không thể phê duyệt.</font>";
        //        }
        //        else
        //        {

        //            if (RadCBoPD.SelectedValue == "False")
        //            {
        //                lbLoi_PD.Text = "";

        //                Obj = new clsObj();
        //                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
        //                Obj.ValueParameter = new object[] { rnQui.Text, rnNam_PD.Value, CboMaDV.SelectedValue, Convert.DBNull, RadCBoPD.SelectedValue };
        //                Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
        //                Sql.fNonGetData(Obj);
        //                if (Obj.KetQua < 1)
        //                {
        //                    lbLoi_PD.Text = "<font color='red'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
        //                }
        //                else
        //                {
        //                    lbLoi_PD.Text = "<font color='blue'>Kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> đã chuyển sang trạng thái chưa phê duyệt.</font>";
                           
                         
        //                    LoadNganSach();
        //                    LOAD_RadGDNganSach();
        //                    FLoadXemNS();
        //                    FLoadHieuChinhNS();
        //                }

        //            }
        //            else
        //            {

        //                lbLoi_PD.Text = "";

        //                Obj = new clsObj();
        //                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
        //                Obj.ValueParameter = new object[] { rnQui.Text, rnNam_PD.Value, CboMaDV.SelectedValue, DateTime.Now, RadCBoPD.SelectedValue };
        //                Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
        //                Sql.fNonGetData(Obj);
        //                if (Obj.KetQua < 1)
        //                {
        //                    lbLoi_PD.Text = "<font color='red'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
        //                }
        //                else
        //                {
        //                    lbLoi_PD.Text = "<font color='blue'>Phê duyệt kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thành công.</font>";
        //                    SendEmail();
        //                    LoadDVPheDuyet();
                          
        //                    LoadNganSach();
        //                    LOAD_RadGDNganSach();
        //                    FLoadXemNS();
        //                    FLoadHieuChinhNS();
        //                }

        //            }

        //        }
        //    }


        //}
    }
  
    void LoadNam()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "SP_Nam_BYLOAD";
        Sql.fGetData(Obj);
        rnNam_PD.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());

    }
    void LoadDVPheDuyet()
    {       
        Obj = new clsObj();

        Obj.Parameter = new string[] { "@Nam", "@BanTGD_PD", "@QUI" };
        Obj.ValueParameter = new object[] { rnNam_PD.Value, Session["UserID"].ToString(), rnQui.Text };
        Obj.SpName = "SP_NSMADV_PD_BYLOAD";

        //Obj.Parameter = new string[] { "@Nam",  "@QUI" };
        //Obj.ValueParameter = new object[] { rnNam_PD.Value, rnQui.Text };
        //Obj.SpName = "SP_NSMADV_PD_BYLOAD_Test";

        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        if (CboMaDV.SelectedIndex == -1)
        {
            CboMaDV.Text = "";
        }
    }
   
    void LoadNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam_PD.Value, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_HieuLucPD";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                RadCBoPD.SelectedValue = Obj.Dt.Rows[0]["Hieuluc_PD"].ToString();
            }
            catch { }
        }

        if (CboMaDV.SelectedValue == "KDND")
        {
            RadGDNganSach.Columns[3].Visible = true;
            RadGDNganSach.Columns[4].Visible = false;
            RadGDNganSach.GroupingEnabled = true;
            RadGDNganSach.AllowFilteringByColumn = true;
        }
        else
        {
            RadGDNganSach.Columns[3].Visible = false;
            if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
            {
                RadGDNganSach.Columns[4].Visible = true;
                RadGDNganSach.GroupingEnabled = true;
                RadGDNganSach.AllowFilteringByColumn = true;
            }
            else
            {
                RadGDNganSach.Columns[4].Visible = false;
                RadGDNganSach.GroupingEnabled = false;
               // RadGDNganSach.AllowFilteringByColumn = false;
            }
        }

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        //Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam_PD.Value, rnQui.Text, Session["UserID"].ToString() };
        //Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui";
        //Sql.fGetData(Obj);
        //RadGDNganSach.DataSource = Obj.Dt;
        //RadGDNganSach.DataBind();

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam_PD.Value, rnQui.Text, CboMaDV.SelectedValue };
        Obj.SpName = "sp_KeHoachNganSach_Pheduyet_LoadNS";

        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }

    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi_PD.Text = "";
      
        LoadNganSach();
      
     
    }
    
    protected void RadGDNganSach_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {      
        LoadNganSach();
    }
    protected void RadGDKHCP_SelectedIndexChanged(object sender, EventArgs e)
    {
      
        LoadNganSach();
    }
    protected void RadGDNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
     
        LoadNganSach();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
       
        LoadNganSach();
    }
  
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
           
            LoadNganSach();
        }
    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {

        LoadDVPheDuyet();     
        LoadNganSach();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam_PD.Value, CboMaDV.SelectedValue, int.Parse(rnQui.Text) };
        Obj.SpName = "sp_KeHoachNganSach_Execl";
        Sql.fGetData(Obj);

        if (rnQui.Value == 1)
        {

            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {
                    ExcelQui1.Columns[5].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[5].Visible = false;
                }
                ExcelQui1.Columns[2].Visible = false;
                ExcelQui1.Columns[1].Visible = false;
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value +"_"+ CboMaDV.SelectedValue;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 2)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui2.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[5].Visible = false;
                }
                ExcelQui2.Columns[2].Visible = false;
                ExcelQui2.Columns[1].Visible = false;
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 3)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui3.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[5].Visible = false;
                }
                ExcelQui3.Columns[2].Visible = false;
                ExcelQui3.Columns[1].Visible = false;
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 4)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui4.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[5].Visible = false;
                }
                ExcelQui4.Columns[2].Visible = false;
                ExcelQui4.Columns[1].Visible = false;
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value + "_" + CboMaDV.SelectedValue;
            ExcelQui4.MasterTableView.ExportToExcel();
        }


    }

    #endregion

    #region Xem ngân sach
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

    void LoadDVCanXem()
    {
        Obj = new clsObj();

        Obj.Parameter = new string[] { "@Nam", "@QUI", "@MaNV" };
        Obj.ValueParameter = new object[] { rnNam_Xem.Text, rnQui_Xem.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_PheDuyet_LoadDonVi_XemNS";

        //Obj.Parameter = new string[] { "@Nam", "@QUI" };
        //Obj.ValueParameter = new object[] { rnNam_Xem.Value, rnQui_Xem.Text };
        //Obj.SpName = "SP_NSMADV_PD_BYLOAD_Test";


        Sql.fGetData(Obj);
        CboMaDV_XemNS.DataSource = Obj.Dt;
        CboMaDV_XemNS.DataBind();
        CboMaDV_XemNS.SelectedIndex = 0;

    }

    void FLoadXemNS()
    {
        if (CboMaDV_XemNS.SelectedValue == "KDND")
        {
            RG_XemNS.Columns[4].Visible = true;
        }
        else
        {
            RG_XemNS.Columns[4].Visible = false;
        }

        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            RG_XemNS.Columns[5].Visible = true;
        }
        else
        {
            RG_XemNS.Columns[5].Visible = false;
        }

        Obj = new clsObj();
       

        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV_XemNS.SelectedValue, rnNam_Xem.Text, rnQui_Xem.Text };
        Obj.SpName = "sp_PheDuyet_XemNganSach";
        Sql.fGetData(Obj);
        RG_XemNS.DataSource = Obj.Dt;
        RG_XemNS.DataBind();
    }
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        FLoadXemNS();
    }

    protected void btnExcelXem_Click(object sender, ImageClickEventArgs e)
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), CboMaDV_XemNS.SelectedValue, int.Parse(rnQui_Xem.Text) };
        Obj.SpName = "sp_KeHoachNganSach_Execl2";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {

            if (CboMaDV_XemNS.SelectedValue == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[5].Visible = false;

                ExcelQui1.Columns[6].Visible = false;
                ExcelQui1.Columns[7].Visible = false;

                ExcelQui1.Columns[8].Visible = true;
                ExcelQui1.Columns[9].Visible = true;
            }
            else
            {
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
                {
                    ExcelQui1.Columns[5].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[5].Visible = false;
                }
                ExcelQui1.Columns[2].Visible = false;
                ExcelQui1.Columns[1].Visible = false;

                ExcelQui1.Columns[6].Visible = true;
                ExcelQui1.Columns[7].Visible = true;

                ExcelQui1.Columns[8].Visible = false;
                ExcelQui1.Columns[9].Visible = false;
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 2)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[5].Visible = false;

                ExcelQui2.Columns[6].Visible = false;
                ExcelQui2.Columns[7].Visible = false;

                ExcelQui2.Columns[8].Visible = true;
                ExcelQui2.Columns[9].Visible = true;
            }
            else
            {
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
                {

                    ExcelQui2.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[5].Visible = false;
                }
                ExcelQui2.Columns[2].Visible = false;
                ExcelQui2.Columns[1].Visible = false;

                ExcelQui2.Columns[6].Visible = true;
                ExcelQui2.Columns[7].Visible = true;

                ExcelQui2.Columns[8].Visible = false;
                ExcelQui2.Columns[9].Visible = false;
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 3)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[5].Visible = false;

                ExcelQui3.Columns[6].Visible = false;
                ExcelQui3.Columns[7].Visible = false;

                ExcelQui3.Columns[8].Visible = true;
                ExcelQui3.Columns[9].Visible = true;
            }
            else
            {
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
                {

                    ExcelQui3.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[5].Visible = false;
                }
                ExcelQui3.Columns[2].Visible = false;
                ExcelQui3.Columns[1].Visible = false;

                ExcelQui3.Columns[6].Visible = true;
                ExcelQui3.Columns[7].Visible = true;

                ExcelQui3.Columns[8].Visible = false;
                ExcelQui3.Columns[9].Visible = false;
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 4)
        {
            if (CboMaDV_XemNS.SelectedValue == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;

                ExcelQui4.Columns[6].Visible = false;
                ExcelQui4.Columns[7].Visible = false;

                ExcelQui4.Columns[8].Visible = true;
                ExcelQui4.Columns[9].Visible = true;
            }
            else
            {
                if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
                {

                    ExcelQui4.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[5].Visible = false;
                }
                ExcelQui4.Columns[2].Visible = false;
                ExcelQui4.Columns[1].Visible = false;

                ExcelQui4.Columns[6].Visible = true;
                ExcelQui4.Columns[7].Visible = true;

                ExcelQui4.Columns[8].Visible = false;
                ExcelQui4.Columns[9].Visible = false;
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value + "_" + CboMaDV_XemNS.SelectedValue;
            ExcelQui4.MasterTableView.ExportToExcel();
        }

    }
    protected void rnQui_Xem_TextChanged(object sender, EventArgs e)
    {
        LoadDVCanXem();
        FLoadXemNS();
    }
    protected void rnNam_Xem_TextChanged(object sender, EventArgs e)
    {
        CboMaDV_XemNS.Text = "";
        LoadDVCanXem();
        FLoadXemNS();
    }
    void FLoadButtonDonVi()
    {
        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            btnNSUyQuyenCacDV.Visible = false;
            btnNSUyQuyen.Visible = true;
        }
        else
        {
            btnNSUyQuyenCacDV.Visible = true;
            btnNSUyQuyen.Visible = false;
        }
    }
    protected void btnNSUyQuyen_Click(object sender, ImageClickEventArgs e)
    {
       // lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachDonViNhanUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", CboMaDV_XemNS.SelectedValue);
        report.SetParameterValue("@Nam", int.Parse(rnNam_Xem.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui_Xem.Text));
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void btnNSUyQuyenCacDV_Click(object sender, ImageClickEventArgs e)
    {
        //lbLoi.Text = "";
        #region Lấy report
        report = new ReportDocument();

        report.Load(Server.MapPath(@"~\Reports\rptNganSachUyQuyen.rpt"));
        report.SetParameterValue("@MaDV", CboMaDV_XemNS.SelectedValue);
        report.SetParameterValue("@Nam", int.Parse(rnNam_Xem.Text));
        report.SetParameterValue("@Qui", int.Parse(rnQui_Xem.Text));
        #endregion


        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void CboMaDV_XemNS_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (CboMaDV_XemNS.SelectedValue == "P.CU" || CboMaDV_XemNS.SelectedValue == "P.HCQT")
        {
            btnNSUyQuyenCacDV.Visible = false;
            btnNSUyQuyen.Visible = true;
        }
        else
        {
            btnNSUyQuyenCacDV.Visible = true;
            btnNSUyQuyen.Visible = false;
        }

        FLoadXemNS();
    }

    protected void RG_XemNS_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadXemNS();
        }
    }

    #endregion

    #region Hiệu chỉnh ngân sách
    void LoadNamCanHieuChinh()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_PheDuyet_LoadNamXemNS";
        Sql.fGetData(Obj);
        rnNam_HieuChinh.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui_HieuChinh.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
        
    }

    void LoadDVCanHieuChinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@QUI", "@MaNV" };
        Obj.ValueParameter = new object[] { rnNam_HieuChinh.Value, rnQui_HieuChinh.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_PheDuyet_LoadDonVi_XemNS";


        //Obj.Parameter = new string[] { "@Nam", "@QUI" };
        //Obj.ValueParameter = new object[] { rnNam_HieuChinh.Value, rnQui.Text };
        //Obj.SpName = "SP_NSMADV_PD_BYLOAD_Test";

        Sql.fGetData(Obj);
        CboMaDV_HieuChinh.DataSource = Obj.Dt;
        CboMaDV_HieuChinh.DataBind();
        CboMaDV_HieuChinh.SelectedIndex = 0;

    }

    void FLoadHieuChinhNS()
    {
        if (CboMaDV_HieuChinh.SelectedValue == "KDND")
        {
            RG_HieuChinh.Columns[6].Visible = true;
        }
        else
        {
            RG_HieuChinh.Columns[6].Visible = false;
        }

        if (CboMaDV_HieuChinh.SelectedValue == "P.CU" || CboMaDV_HieuChinh.SelectedValue == "P.HCQT")
        {
            RG_HieuChinh.Columns[7].Visible = true;
        }
        else
        {
            RG_HieuChinh.Columns[7].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV_HieuChinh.SelectedValue, rnNam_HieuChinh.Value, rnQui_HieuChinh.Text };
        Obj.SpName = "sp_PheDuyet_HieuChinhNganSach";
        Sql.fGetData(Obj);
        RG_HieuChinh.DataSource = Obj.Dt;
        RG_HieuChinh.DataBind();

    }
    protected void CboMaDV_HieuChinh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadHieuChinhNS();
    }
    protected void RG_HieuChinh_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietKeHoachNganSachPheDuyet_Update.ascx";
            FLoadHieuChinhNS();

        }

        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {

            FLoadHieuChinhNS();
        }
    }
    protected void RG_HieuChinh_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_khoaCT = RG_HieuChinh.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        bool ketthuc = ((CheckBox)RG_HieuChinh.Items[e.Item.ItemIndex]["Hieuluc_PD"].FindControl("cbHieuluc3")).Checked;
        if (ketthuc == true)
        {
            lbLoi_HieuChinh.Text = "<font color='red'>Không xóa được vì đang ở trạng thái phê duyệt.</br> Phải bỏ duyệt mới xóa được.</font>";
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { ID_khoaCT };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi_HieuChinh.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi_HieuChinh.Text = "<font color='blue'>Xóa thành công.</font>";
            }
        }
        FLoadHieuChinhNS();
    }
    protected void RG_HieuChinh_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtIDKhoaCT = userControl.FindControl("txtIDKhoaCT") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rnChiPhi = userControl.FindControl("rnChiPhi") as Telerik.Web.UI.RadNumericTextBox;
        TextBox txtGhiChu = userControl.FindControl("txtGhiChu") as TextBox;
        TextBox txtPheDuyet = userControl.FindControl("txtPheDuyet") as TextBox;

        bool pheduyet = bool.Parse(txtPheDuyet.Text);

        //if (pheduyet == true)
        //{
        //    lbLoi_HieuChinh.Text = "<font color='red'>Không sửa được vì đang ở trạng thái phê duyệt.</br> Phải bỏ duyệt mới sửa được.</font>";
        //}
        //else
        //{

        #region Luu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_KhoaCT", "@Sotien", "@Ghichu" };
        Obj.ValueParameter = new object[] { txtIDKhoaCT.Text, rnChiPhi.Text, txtGhiChu.Text };
        Obj.SpName = "sp_PheDuyet_NganSach_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi_HieuChinh.Text = "<font color='blue'>Cập nhật thành công .</font>";

        }
        else
        {
            lbLoi_HieuChinh.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        #endregion
        // }
        FLoadHieuChinhNS();


    }
    protected void RG_HieuChinh_CancelCommand(object sender, GridCommandEventArgs e)
    {
        FLoadHieuChinhNS();
    }
    protected void rnQui_HieuChinh_TextChanged(object sender, EventArgs e)
    {
        LoadDVCanHieuChinh();
        FLoadHieuChinhNS();
    }

    protected void btnBoDuyet_Click(object sender, ImageClickEventArgs e)
    {

        if (RC_HieuChinh.SelectedValue == "False")
        {
            lbLoi_HieuChinh.Text = "";

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
            Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, rnNam_HieuChinh.Value, CboMaDV_HieuChinh.SelectedValue, Convert.DBNull, RC_HieuChinh.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi_HieuChinh.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi_HieuChinh.Text = "<font color='blue'>Đã bỏ phê duyệt.</font>";

            }
        }
        else
        {

            lbLoi_HieuChinh.Text = "";
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
            Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, rnNam_HieuChinh.Value, CboMaDV_HieuChinh.SelectedValue, DateTime.Now, RC_HieuChinh.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi_HieuChinh.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi_HieuChinh.Text = "<font color='blue'>Phê duyệt thành công.</font>";

            }

        }
        FLoadHieuChinhNS();

        LoadDVPheDuyet(); 
        
        LoadNganSach();
      
        FLoadXemNS();
      
    }
    protected void RC_HieuChinh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            if (RC_HieuChinh.SelectedValue == "False")
            {
                lbLoi_HieuChinh.Text = "";

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
                Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, rnNam_HieuChinh.Value, CboMaDV_HieuChinh.SelectedValue, Convert.DBNull, RC_HieuChinh.SelectedValue };
                Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi_HieuChinh.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
                }
                else
                {
                    lbLoi_HieuChinh.Text = "<font color='blue'>Đã bỏ phê duyệt.</font>";

                }
            }
            else
            {

                lbLoi_HieuChinh.Text = "";
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@Ngay_PD", "@Hieuluc_PD" };
                Obj.ValueParameter = new object[] { rnQui_HieuChinh.Text, rnNam_HieuChinh.Value, CboMaDV_HieuChinh.SelectedValue, DateTime.Now, RC_HieuChinh.SelectedValue };
                Obj.SpName = "sp_KeHoachNganSach_PheDuyet_ByQui";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi_HieuChinh.Text = "<font color='red'>Thất bại. Vui lòng thử lại sau.</font>";
                }
                else
                {
                    lbLoi_HieuChinh.Text = "<font color='blue'>Phê duyệt thành công.</font>";

                }

            }

        }
        catch(Exception ex)
        {
            lbLoi_HieuChinh.Text = "<font color='red'>" + ex.Message + "</font>";
        }
        finally{

            FLoadHieuChinhNS();

            LoadDVPheDuyet();

            LoadNganSach();

            FLoadXemNS();
        }
    }
    #endregion




   
}
