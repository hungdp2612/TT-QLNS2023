using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using Data;
using System.Data;

public partial class Reports_rptGiayNopTien : System.Web.UI.Page
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    private ReportDocument report = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {

        LOADREPORT();
    }

    #region LOADREPORT
    protected void LOADREPORT()
    {
        try
        {
            lblLoi.Text = String.Empty;

            string SoPhieu = String.Empty;
            if (Request.QueryString["SoPhieu"] != null)
            {
                SoPhieu = Request.QueryString["SoPhieu"].ToString().Trim();
               
            }

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu" };
            Obj.ValueParameter = new object[] { SoPhieu };
            Obj.SpName = "sp_ChungTuNopTien_Report";
            Sql.fGetData(Obj);
            DataTable data = Obj.Dt;

            report.Load(Server.MapPath(@"~\Reports\rptGiayNopTien.rpt"));                  

           
            report.SetDataSource(data);

            DataTable dtsub = new DataTable();
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoPhieu" };
            Obj.ValueParameter = new object[] { SoPhieu };
            Obj.SpName = "sp_ChiTietNopTienReport";
            Sql.fGetData(Obj);
            dtsub = Obj.Dt;
            report.Subreports["rptKhongTamUng_sub.rpt"].SetDataSource(dtsub);


            int exportFormatFlags = (int)(CrystalDecisions.Shared.ViewerExportFormats.PdfFormat);
            CrystalReportViewer1.AllowedExportFormats = exportFormatFlags;


            CrystalReportViewer1.ReportSource = report;            
            CrystalReportViewer1.Zoom(100);
            CrystalReportViewer1.DataBind();
        }
        catch (Exception ex)
        {
            lblLoi.Text = ex.Message;
        }
    }
    #endregion


    #region CrystalReportViewer1
    protected void CrystalReportViewer1_Unload(object sender, EventArgs e)
    {
        report.Close();
        report.Dispose();
    }
    #endregion
}