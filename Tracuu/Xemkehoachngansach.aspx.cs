using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Web.Configuration;

public partial class TraCuu_Xemkehoachngansach : clsPhanQuyenCaoCap
{
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["ID_Khoa"] = String.Empty;
            fLoadNam();
            fLoadDonVi();
            LOAD_RadGDPHIEU();
            LOAD_RD_Chitiet();
        }

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
      
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {

            if (Obj.Dt.Rows[0]["IDMaCS"].ToString() == "100")
            {
                txtIDMaCS.Text = "49";
            }
            else
            {
                TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
        }
        else
        {
           
        }
    }
    void fLoadNam()
    {
        ClassLibrary lib = new ClassLibrary(ConnectionString);
        DataTable dt = lib.GetDataStore("spLoad_Nam_XemKeHoachNganSach", new string[] { }, new object[] { });
        CboNam.DataSource = dt;
        CboNam.DataBind();
        CboNam.SelectedIndex = 0;
        
    }
    protected void CboNam_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        LOAD_RadGDPHIEU();
        LOAD_RD_Chitiet();
    }
    protected void LOAD_RadGDPHIEU()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RD_Chitiet.Columns[1].Visible = true;
            RD_Chitiet.Columns[2].Visible = false;
        }
        else
        {
            RD_Chitiet.Columns[1].Visible = false;
            if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
            {
                RD_Chitiet.Columns[2].Visible = true;
                
            }
            else
            {
                RD_Chitiet.Columns[2].Visible = false;
               
            }
        }

        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "sp_KeHochNganSach_Load_ByMaBP";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@NAM", "@MaBP" };
            provider.ValueCollection = new object[] { CboNam.SelectedValue.Trim(), txtIDMaCS.Text };

            dt = provider.GetDataTable();

        }
        catch (SqlException sqlex)
        {
            lblLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
        }

        RadGDPHIEU.DataSource = dt;
        RadGDPHIEU.DataBind();

    }


    #region BUOC1
    protected void RadGDPHIEU_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGDPHIEU.MasterTableView.Items)
        {
            if (item.Selected)
            {
                Session["ID_Khoa"] = item["ID_Khoa"].Text.Trim();
            }
        }

        LOAD_RD_Chitiet();
    }
    #endregion

    #region BUOC2
    protected void LOAD_RD_Chitiet()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "SP_LoadChiTiet_NS";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@ID_Khoa" };
            provider.ValueCollection = new object[] { Session["ID_Khoa"].ToString().Trim() };

            dt = provider.GetDataTable();
            RD_Chitiet.DataSource = dt;
            RD_Chitiet.DataBind();
        }
        catch (SqlException sqlex)
        {
            lblLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
        }
    }
    protected void RD_Chitiet_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LOAD_RD_Chitiet();
    }
    protected void RD_Chitiet_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LOAD_RD_Chitiet();
    }
    protected void RD_Chitiet_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LOAD_RD_Chitiet();
    }
    #endregion
    protected void RadGDPHIEU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                LOAD_RadGDPHIEU();
                break;
        }
    }
    protected void RadGDPHIEU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LOAD_RadGDPHIEU();
    }
    protected void RadGDPHIEU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LOAD_RadGDPHIEU();
    }
    protected void RD_Chitiet_ItemCommand(object sender, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                LOAD_RD_Chitiet();
                break;
        }
    }
}