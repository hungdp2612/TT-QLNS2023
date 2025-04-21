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

public partial class Kiemtra_Kehoachngansach_KTKiemTra : clsPhanQuyenCaoCap
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
            LoadNganSach();
            
          
            //LOAD_RadGDNganSach();
            LoadNam();
            LoadDVPheDuyet();
            LoadCPThucHien();
            LoadNganSach();
        }
    }
    string item3;
    string LayThangCuaQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, txtQui.Text, CboMaDV.SelectedValue, Session["UserID"].ToString() };
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
        Obj.ValueParameter = new object[] { CboNam.Text, CboMaDV.SelectedValue, txtQui.Text, Session["UserID"].ToString() };
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
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@MaNVKT", "@Ngay_TCKT", "@Hieuluc" };
            Obj.ValueParameter = new object[] { txtQui.Text, CboNam.SelectedValue, CboMaDV.SelectedValue, Convert.DBNull, Convert.DBNull, RadCBoPD.SelectedValue };
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
            Obj.Parameter = new string[] { "@Qui", "@Nam", "@MaDV", "@MaNVKT", "@Ngay_TCKT", "@Hieuluc" };
            Obj.ValueParameter = new object[] { txtQui.Text, CboNam.SelectedValue, CboMaDV.SelectedValue, Session["UserID"].ToString(), DateTime.Now, RadCBoPD.SelectedValue };
            Obj.SpName = "sp_KeHoachNganSach_KTKiemTra_ByQui";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Kiểm tra kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Kiểm tra kế hoạch ngân sách của <b><font color='black'>" + CboMaDV.Text + "</font></b> thành công.</font>";
              
                LoadDVPheDuyet();
                LoadCPThucHien();
                LoadNganSach();

              
            }
        }
    }   
    void LoadNam()
    {
        ClassLibrary lib = new ClassLibrary(ConnectionString);
        DataTable dt = lib.GetDataStore("SP_Nam_BYLOAD", new string[] { },
                    new object[] { });
        CboNam.DataSource = dt;
        CboNam.DataBind();
        CboNam.SelectedIndex = 0;
        txtQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;
    }
    void LoadDVPheDuyet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam","@Qui"};
        Obj.ValueParameter = new object[] { CboNam.SelectedValue,txtQui.Text };
        Obj.SpName = "SP_NSMADV_KeToanKiemTra_BYLOAD";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        CboMaDV.Text = "";
    }
    void LoadCPThucHien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
        Obj.SpName = "SP_LoadKHCP";
        Sql.fGetData(Obj);
        RadGDKHCP.DataSource = Obj.Dt;
        RadGDKHCP.DataBind();
       
    }
    void LoadNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, CboNam.SelectedValue, txtQui.Text, Session["UserID"].ToString() };
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
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, CboNam.SelectedValue, txtQui.Text };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui_KTKiemTra";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        LoadCPThucHien();
        LoadNganSach();
    }
   
    protected void CboNam_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;

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

        LOAD_RadGDNganSach();
    }
    protected void RadGDKHCP_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LOAD_RadGDNganSach();
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

            provider.ParameterCollection = new string[] { "@MSChiphi","@Nam","@Qui","@MaDV" };
            provider.ValueCollection = new object[] { Session["MSChiphi"].ToString().Trim(), CboNam.SelectedValue, txtQui.Text,CboMaDV.SelectedValue };

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
}