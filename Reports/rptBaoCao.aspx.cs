using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using CrystalDecisions.CrystalReports.Engine;

public partial class Report_rptBaoCao : System.Web.UI.Page
{
    string server = ConfigurationManager.AppSettings["Server"].ToString();
    string user = ConfigurationManager.AppSettings["Us"].ToString();
    string pass = ConfigurationManager.AppSettings["Pass"].ToString();
    string DB = ConfigurationManager.AppSettings["DB"].ToString();
    ReportDocument report = new ReportDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            try
            {
                int exportFormatFlags = (int)(CrystalDecisions.Shared.ViewerExportFormats.PdfFormat);
                CrystalReportViewer1.AllowedExportFormats = exportFormatFlags;

                if (Session["report"] != null)
                {
                    report = ReportFactory.GetReport(report.GetType());
                    report = (ReportDocument)Session["report"];
                    CrystalReportViewer1.ReportSource = report;
                    CrystalReportViewer1.DataBind();
                    report.SetDatabaseLogon(user, pass, server, DB);

                    report.ExportToStream(CrystalDecisions.Shared.ExportFormatType.Excel);
                }

                if (Session["report2"] != null)
                {
                    report = ReportFactory.GetReport(report.GetType());
                    report = (ReportDocument)Session["report2"];
                    CrystalReportViewer2.ReportSource = report;
                    CrystalReportViewer2.DataBind();
                    report.SetDatabaseLogon(user, pass, server, DB);
                }
            }
            catch (Exception ex)
            {
                lblloi.Text = ex.Message;
            }
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        try
        {
            if (Session["report"] != null)
            {
                report = ReportFactory.GetReport(report.GetType());
                report = (ReportDocument)Session["report"];
                CrystalReportViewer1.ReportSource = report;

            }
            if (Session["report2"] != null)
            {
                report = ReportFactory.GetReport(report.GetType());
                report = (ReportDocument)Session["report2"];
                CrystalReportViewer2.ReportSource = report;

            }
        }
        catch (Exception ex)
        {
            lblloi.Text = ex.Message;
        }
    }

    protected void CrystalReportViewer1_Unload(object sender, EventArgs e)
    {
        //report.Close();
        //report.Dispose();
    }
}