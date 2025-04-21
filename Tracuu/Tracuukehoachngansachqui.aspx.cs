using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;

public partial class TraCuu_Tracuukehoachngansachqui : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdTuThang.SelectedDate = DateTime.Now;
            rdDenThang.SelectedDate = DateTime.Now;

            fLoadDonVi();
            fLoadMaDV();
            FLoadMaBPByIDCS();
        }
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
           
                txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();           

        }
        else
        {

        }
    }

    void fLoadMaDV()
    {
        string mabp="";
        if (txtMaBP.Text == "CS1" || txtMaBP.Text == "CONGSO")
        {
            mabp = "CONGSO";
        }
        else
        {
            mabp = txtMaBP.Text;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaBP" };
        Obj.ValueParameter = new object[] { mabp };
        Obj.SpName = "sp_TraCuuKeHoachNganSach_By_MaDV";
        Sql.fGetData(Obj);
        ddlMaDV.DataSource = Obj.Dt;
        ddlMaDV.DataBind();

        //if (txtMaBP.Text != "P.TCKT" || txtMaBP.Text != "TT.TH-TK")
        //{

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] { "@MaBP" };
        //    Obj.ValueParameter = new object[] { txtMaBP.Text };
        //    Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
        //    Sql.fGetData(Obj);
        //    ddlMaDV.DataSource = Obj.Dt;
        //    ddlMaDV.DataBind();
        //   // ddlMaDV.Enabled = false;
        //}
        //else
        //{           

        //    Obj = new clsObj();
        //    Obj.Parameter = new string[] {  };
        //    Obj.ValueParameter = new object[] {  };
        //    Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
        //    Sql.fGetData(Obj);
        //    ddlMaDV.DataSource = Obj.Dt;
        //    ddlMaDV.DataBind();     
        //}

    }
    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };

        Obj.SpName = "sp_TraCuuKeHoachNSQui_MaBPByIDCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }
    

    void fLoad()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tunam", 
            "@tuthang", "@dennam", 
            "@denthang", "@MaDV"  };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Year, 
            rdTuThang.SelectedDate.Value.Month, rdDenThang.SelectedDate.Value.Year, 
            rdDenThang.SelectedDate.Value.Month, txtMaBP.Text };
       // Obj.SpName = "sp_TraCuuKeHoachNganSachTuThang_DenThang";
        Obj.SpName = "sp_TraCuuKeHoachNganSachTuThang_DenThang_040515";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    public bool fBool(object Value)
    {
        return bool.Parse(Value.ToString());
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tunam", 
            "@tuthang", "@dennam", 
            "@denthang", "@MaDV" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Year, 
            rdTuThang.SelectedDate.Value.Month, rdDenThang.SelectedDate.Value.Year, 
            rdDenThang.SelectedDate.Value.Month, txtMaBP.Text };
        Obj.SpName = "sp_TraCuuKeHoachNganSachTuThang_DenThang";
        Sql.fGetData(Obj);
        RGExCell.DataSource = Obj.Dt;
        RGExCell.DataBind();

        ConfigureExport();
        RGExCell.MasterTableView.ExportToExcel();
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }
    public void ConfigureExport()
    {
        RGExCell.ExportSettings.ExportOnlyData = true;
        RGExCell.ExportSettings.IgnorePaging = true;
        RGExCell.ExportSettings.OpenInNewWindow = true;
        RGExCell.ExportSettings.FileName = "Ke hoach ngan sach thang " +
            rdTuThang.SelectedDate.Value.Month.ToString() +
            "/" + rdTuThang.SelectedDate.Value.Year.ToString();
    }
    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }

    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
}