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

public partial class Chuongtrinh_Kehoachngansach_KTKiemTra_bak : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
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
            Session["MSChiphi"] = String.Empty;          
            LoadNamQui();
            LoadDVPheDuyet();
            LoadHieuLucPDCuaDV();
           
            hieulucketoan();
            LoadCPThucHien();
            LoadNganSach();
        }
    }
    string item3;
    string LayThangCuaQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] {rnNam.Value, rnQui.Value, CboMaDV.SelectedValue, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_LayThangCuaQui";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item3 = Obj.Dt.Rows[0]["Thang"].ToString();

            }
            catch { }

        }
        else
        {

        }
        return item3;
    }
    string item4;
    int DemChiTietNganSach()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { rnNam.Value, CboMaDV.SelectedValue, rnQui.Value, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_ChiTietKeHoachNganSach_Load";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item4 = Obj.Dt.Rows[0]["DemChiTietNganSach"].ToString();

            }
            catch { }
        }
        else
        {

        }
        return Convert.ToInt32(item4);
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {


        if (RadCBoPD.SelectedValue == "False")
        {
            lbLoi.Text = "";

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@MaNVKT","@NgayKT", "@Hieuluc" };
            Obj.ValueParameter = new object[] { rnQui.Value, rnNam.Value, CboMaDV.SelectedValue, Convert.DBNull,Convert.DBNull, RadCBoPD.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_KTKiemTra_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Kiểm tra kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> đã chuyển sang trạng thái chưa xác nhận.</font>";
                //LoadDVPheDuyet();
                LoadCPThucHien();
                LoadNganSach();

            }

        }
        else
        {
            lbLoi.Text = "";

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@MaNVKT", "@NgayKT", "@Hieuluc" };
            Obj.ValueParameter = new object[] { rnQui.Value, rnNam.Value, CboMaDV.SelectedValue, Session["UserID"].ToString(),DateTime.Now, RadCBoPD.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_KTKiemTra_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Kiểm tra kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Kiểm tra kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thành công.</font>";

                // LoadDVPheDuyet();
                LoadCPThucHien();
                LoadNganSach();


            }
        }
    }
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }
   
    void LoadDVPheDuyet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Value, rnQui.Value };
        Obj.SpName = "SP_NSMADV_KeToanKiemTra_BYLOAD";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;       
    }


    void LoadCPThucHien()
    {      

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, int.Parse(rnNam.Text) };
        Obj.SpName = "sp_LoadKeHoachChiPhi_ByMaDV_Nam";
        Sql.fGetData(Obj);
        RadGDKHCP.DataSource = Obj.Dt;
        RadGDKHCP.DataBind();

    }
    void LoadNganSach()
    {
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
                RadGDNganSach.AllowFilteringByColumn = false;
            }          
            
        }
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Value, rnQui.Value };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui_KTKiemTra";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
       
    }
    public bool hieulucketoan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, int.Parse(rnNam.Text),int.Parse(rnQui.Text) };
        Obj.SpName = "sp_KeHoachNganSach_KeToanKiemTra_HieuLucKeToan";
        Sql.fGetData(Obj);

        return bool.Parse(Obj.Dt.Rows[0]["HieuLuc"].ToString());

    }

    void LoadHieuLucPDCuaDV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Value, rnQui.Value };
        Obj.SpName = "sp_KeHoachNganSach_KeToanKiemTra_HieuLucKeToan";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                RadCBoPD.SelectedValue = Obj.Dt.Rows[0]["HieuLuc"].ToString();
            }
            catch { }
        }
    }
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        LoadHieuLucPDCuaDV();
        LoadCPThucHien();
        LoadNganSach();
    }
 
    #region BUOC1
    protected void RadGDKHCP_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        foreach (GridDataItem item in RadGDKHCP.MasterTableView.Items)
        {
            if (item.Selected)
            {
                Session["MSChiphi"] = item["MSChiphi"].Text.Trim();
            }
        }

        LoadCPThucHien();
    }
    protected void RadGDKHCP_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadCPThucHien();
    }
    protected void RadGDKHCP_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                LOAD_RadGDNganSach();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LoadCPThucHien();
        }
    }
    #endregion
    #region BUOC2
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "SP_LoadNS_MaCP_KTKiemTra";

            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MSChiphi", "@Nam", "@Qui", "@MaDV" };
            provider.ValueCollection = new object[] { Session["MSChiphi"].ToString().Trim(), rnNam.Value, rnQui.Value, CboMaDV.SelectedValue };

            dt = provider.GetDataTable();

        }
        catch (SqlException sqlex)
        {
            lbLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
            RadGDNganSach.DataSource = dt;
            RadGDNganSach.DataBind();
        }
    }
    protected void RadGDNganSach_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LOAD_RadGDNganSach();
    }
    protected void RadGDKHCP_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
        LOAD_RadGDNganSach();
    }
    protected void RadGDNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
        LOAD_RadGDNganSach();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LOAD_RadGDNganSach();
    }
    #endregion
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LOAD_RadGDNganSach();
        }
    }


  
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Value, CboMaDV.SelectedValue, int.Parse(rnQui.Text) };
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
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
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
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
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
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
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
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui4.MasterTableView.ExportToExcel();
        }


    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        CboMaDV.Text = "";
        LoadDVPheDuyet();
        LoadCPThucHien();
        LoadNganSach();
    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {
        CboMaDV.Text = "";
        LoadDVPheDuyet();
        LoadCPThucHien();
        LoadNganSach();
    }
}