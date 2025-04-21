using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;

public partial class Chuongtrinh_XemChungTuThanhToan_Mar : clsPhanQuyenCaoCap
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
          


            fLoadMaDV2();
            DateTime Next = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            Next = Next.AddMonths(1).AddDays(-1);

            rdLapTuNgay.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            rdLapDenNgay.SelectedDate = Next;

            rdTuThangThanhToan.SelectedDate = DateTime.Now;

            rdDenThangThanhToan.SelectedDate = DateTime.Now;
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
        if (txtMaBP.Text != "P.TCKT")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP" };
            Obj.ValueParameter = new object[] { txtMaBP.Text };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
            Sql.fGetData(Obj);
            ddlMaDV.DataSource = Obj.Dt;
            ddlMaDV.DataBind();
            // ddlMaDV.Enabled = false;
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { };
            Obj.ValueParameter = new object[] { };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
            Sql.fGetData(Obj);
            ddlMaDV.DataSource = Obj.Dt;
            ddlMaDV.DataBind();
        }

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
        Obj.Parameter = new string[] {"@MaDV", "@tunam", 
            "@tuthang", "@dennam", 
            "@denthang"  };
        Obj.ValueParameter = new object[] { txtMaBP.Text,rdTuThang.SelectedDate.Value.Year, 
            rdTuThang.SelectedDate.Value.Month, rdDenThang.SelectedDate.Value.Year, 
            rdDenThang.SelectedDate.Value.Month};
        Obj.SpName = "sp_ChungTuThanhToan_ChiTiet_Mar";
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
        FLoadMaBPByIDCS();
        fLoad();
        ConfigureExport();
        RG.MasterTableView.ExportToExcel();
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoad();
    }
    public void ConfigureExport()
    {
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "Ke hoach ngan sach thang ";

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

   

    #region xem chi tiết chứng từ thanh toán
    protected void btnXemChungTu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS2();
        fLoadChungTu_DienGiai();
    }
    protected void btnExcellChungTu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS2();
        fLoadChungTu_DienGiai();
        ConfigureExport_ChungTu();
        rgChungTu.MasterTableView.ExportToExcel();
    }

    void fLoadMaDV2()
    {
        if (txtMaBP.Text != "P.TCKT")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP" };
            Obj.ValueParameter = new object[] { txtMaBP.Text };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui";
            Sql.fGetData(Obj);
            ddlDonVi.DataSource = Obj.Dt;
            ddlDonVi.DataBind();
            // ddlMaDV.Enabled = false;
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { };
            Obj.ValueParameter = new object[] { };
            Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
            Sql.fGetData(Obj);
            ddlDonVi.DataSource = Obj.Dt;
            ddlDonVi.DataBind();
        }

    }
  
    void FLoadMaBPByIDCS2()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonVi.SelectedValue };

        Obj.SpName = "sp_TraCuuChungTu_MaBPByIDMaCS";
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


    void fLoadChungTu_DienGiai()
    {
        DateTime Next = new DateTime(rdDenThangThanhToan.SelectedDate.Value.Year, rdDenThangThanhToan.SelectedDate.Value.Month, 1);
        Next = Next.AddMonths(1).AddDays(-1);

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TuNgay", 
            "@DenNgay", "@TuThangThanhToan", 
            "@DenThangThanhToan",
            "@DonVi", "@NguoiThanhToan",
            "@LoaiThanhToan", "@ckTuNgay", "@ckTuThangThanhToan", 
            "@ckDonVi",  "@ckNguoiThanhToan", "@ckLoaiThanhToan" };
        Obj.ValueParameter = new object[] { rdLapTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
            rdLapDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy"), rdTuThangThanhToan.SelectedDate.Value.ToString("dd/MM/yyyy"),
            Next.ToString("dd/MM/yyyy"),
             txtMaBP.Text, tbNguoiThanhToan.Text,
            ddlLoaiThanhToan.SelectedValue, cbTuNgay.Checked, cbTuThang.Checked,
           true, cbNguoiThanhToan.Checked, cbLoaiThanhToan.Checked
        };
        Obj.SpName = "sp_ChungTuThanhToan_ChiTiet_Mar_ChiTiet";
        Sql.fGetData(Obj);
        rgChungTu.DataSource = Obj.Dt;
        rgChungTu.DataBind();


    }

    public void ConfigureExport_ChungTu()
    {
        rgChungTu.ExportSettings.ExportOnlyData = true;
        rgChungTu.ExportSettings.IgnorePaging = true;
        rgChungTu.ExportSettings.OpenInNewWindow = true;
        rgChungTu.ExportSettings.FileName = "Chung tu thanh toan";
    }
    
   
    protected void rgChungTu_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoadChungTu_DienGiai();
    }
    protected void rgChungTu_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoadChungTu_DienGiai();
    }

    #endregion
  
}