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
using CrystalDecisions.CrystalReports.Engine;
using Telerik.Web.UI;


public partial class Chuongtrinh_TraCuuChungTu : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    ReportDocument report = new ReportDocument();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region tra cuu chung tu
           
            fLoadDonVi();
            DateTime Next = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            Next = Next.AddMonths(1).AddDays(-1);

            rdLapTuNgay.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            rdLapDenNgay.SelectedDate = Next;

            rdTuThangThanhToan.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            rdDenThangThanhToan.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            #endregion

            #region tra cuu phieu tam ung
            PTU_rdTuNgay.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            PTU_rdDenNgay.SelectedDate = Next;
            #endregion
        }       

    }
    #region Tra cuu chung tu
    void fLoadDonVi()
    {
        string mabp = Session["MABP"].ToString();
        if (mabp == "CS1" || mabp == "CONGSO")
        {
            mabp = "CONGSO";
        }
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaBP" };
        Obj.ValueParameter = new object[] { mabp };
        Obj.SpName = "sp_LayBoPhan_TraCuuChungTu_BY_MABP";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();

        PTU_ddlDonVi.DataSource = Obj.Dt;
        PTU_ddlDonVi.DataBind();
       
    }
    void FLoadMaBPByIDCS()
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
    void fLoadChungTu()
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
            cbDonVi.Checked, cbNguoiThanhToan.Checked, cbLoaiThanhToan.Checked
        };
        //Obj.SpName = "spTraCuuChungTuThanhToan_New";
        Obj.SpName = "sp_TraCuuChungTu_GDNTT_GTTTU";
        Sql.fGetData(Obj);
        RGTraCuuCTTT.DataSource = Obj.Dt;
        RGTraCuuCTTT.DataBind();   

    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
       
        FLoadMaBPByIDCS();
        fLoadChungTu();    
        fLoadChungTu_DienGiai();
    }
    protected void RGTraCuuCTTT_ItemCommand(object sender, GridCommandEventArgs e)
    {
        fLoadChungTu();
    }
    protected void RGTraCuuCTTT_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadChungTu();
    }
    protected void RGTraCuuCTTT_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadChungTu();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();       

        fLoadChungTu();
        RGTraCuuCTTT.GridLines = GridLines.Both;     
     
        RGTraCuuCTTT.ExportSettings.ExportOnlyData = true;
        RGTraCuuCTTT.ExportSettings.IgnorePaging = true;
        RGTraCuuCTTT.ExportSettings.OpenInNewWindow = true;
        RGTraCuuCTTT.ExportSettings.FileName = "Chung tu thanh toan";
        RGTraCuuCTTT.MasterTableView.ExportToExcel();
    }
  
    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
    protected void RGTraCuuCTTT_ItemCommand1(object sender, GridCommandEventArgs e)
    {
      
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChungTu();
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
            cbDonVi.Checked, cbNguoiThanhToan.Checked, cbLoaiThanhToan.Checked
        };
        Obj.SpName = "spTraCuuChungTuThanhToan_New";
        Sql.fGetData(Obj);
        rgChungTu.DataSource = Obj.Dt;
        rgChungTu.DataBind();    

    }

 
    protected void btnXemChungTu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS(); 
        fLoadChungTu_DienGiai();
        fLoadChungTu();    
    }
    protected void btnExcellChungTu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoadChungTu_DienGiai();
        rgChungTu.GridLines = GridLines.Both; 
        rgChungTu.ExportSettings.ExportOnlyData = true;
        rgChungTu.ExportSettings.IgnorePaging = true;
        rgChungTu.ExportSettings.OpenInNewWindow = true;
        rgChungTu.ExportSettings.FileName = "Chi tiet chung tu thanh toan";
        rgChungTu.MasterTableView.ExportToExcel();
    }
    protected void rgChungTu_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
      
        fLoadChungTu_DienGiai();     
    }
    protected void rgChungTu_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
       
        fLoadChungTu_DienGiai();     
    }
    protected void rgChungTu_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChungTu_DienGiai();    
        }
    }
    #endregion
    #region Tra cuu phieu tam ung
    void FLoadDV2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { PTU_ddlDonVi.SelectedValue };

        Obj.SpName = "sp_TraCuuChungTu_MaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP2.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }
    protected void PTU_ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {

        FLoadDV2();

    }

    void fLoadPTU()
    {
        //DateTime Next = new DateTime(rdDenThangThanhToan.SelectedDate.Value.Year, rdDenThangThanhToan.SelectedDate.Value.Month, 1);
        //Next = Next.AddMonths(1).AddDays(-1);

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TuNgay", 
            "@DenNgay","@MaDV"};
        Obj.ValueParameter = new object[] { PTU_rdTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
            PTU_rdDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),  txtMaBP2.Text
        };       
        Obj.SpName = "sp_TraCuuPhieuTU_DaThanhToanHayChua";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    protected void PTU_btnXem_Click(object sender, ImageClickEventArgs e)
    {
        FLoadDV2();
        fLoadPTU();
    }
   

    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadPTU();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadPTU();
    }
   
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadPTU();
        }
    }
    #endregion
}