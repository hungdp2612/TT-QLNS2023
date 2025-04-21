using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using CrystalDecisions.CrystalReports.Engine;
using System.Web.Configuration;
using Data;

public partial class BaoCao_TongHopNganSach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
   
    string ConnectWQLVT = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    ReportDocument report;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdTuThang.SelectedDate = DateTime.Now;
            rdDenThang.SelectedDate = DateTime.Now;
            rdNgayTrinh.SelectedDate = DateTime.Now;
            rdNgayNhan.SelectedDate = DateTime.Now;
            fNguoiTrinh();
            fNguoiNhan();
            fThongTinNV();
        }
    }

    void fNguoiTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaBP" };
        Obj.ValueParameter = new object[] { "82" };
        Obj.SpName = "spLay_NV_BoPhan_QLNS";
        Obj.Connectionstring = ConnectWQLVT;
        Sql.fGetData(Obj);
        ddlNguoiTrinh.DataSource = Obj.Dt;
        ddlNguoiTrinh.DataBind();
    }
    void fNguoiNhan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "spLay_NV_PheDuyet_QLNS";
        Obj.Connectionstring = ConnectWQLVT;
        Sql.fGetData(Obj);
        ddlNguoiNhan.DataSource = Obj.Dt;
        ddlNguoiNhan.DataBind();
    }
    void fThongTinNV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { ddlNguoiTrinh.SelectedValue.Split(':')[0] };
        Obj.SpName = "spThongTin_NV_QLNS";
        Obj.Connectionstring = ConnectWQLVT;
        Sql.fGetData(Obj);
        tbChucVu.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
        tbBoPhan.Text = Obj.Dt.Rows[0]["TenDonVi"].ToString();

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { ddlNguoiNhan.SelectedValue.Split(':')[0] };
        Obj.SpName = "spThongTin_NV_QLNS";
        Obj.Connectionstring = ConnectWQLVT;
        Sql.fGetData(Obj);
        tbBoPhanNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
        tbChucVuNhan.Text = Obj.Dt.Rows[0]["TenDonVi"].ToString();
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", "@tunam", 
            "@denthang", "@dennam" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(), rdTuThang.SelectedDate.Value.Year.ToString(),
            rdDenThang.SelectedDate.Value.Month.ToString(), rdDenThang.SelectedDate.Value.Year.ToString()
        };
        //Obj.SpName = "sp_rpt_TongHopNganSachThang_LuyKe";
        Obj.SpName = "sp_rpt_TongHopNganSachThang_LuyKe_040515";
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    protected void btIn_Click(object sender, ImageClickEventArgs e)
    {
        #region Lấy report
        report = new ReportDocument();
        report = ReportFactory.GetReport(report.GetType());
        report.Load(Server.MapPath(@"~\Reports\rptBaoCaoTongHopNS.rpt"));
        report.SetParameterValue("@tuthang", rdTuThang.SelectedDate.Value.Month.ToString());
        report.SetParameterValue("@tunam", rdTuThang.SelectedDate.Value.Year.ToString());
        report.SetParameterValue("@denthang", rdDenThang.SelectedDate.Value.Month.ToString());
        report.SetParameterValue("@dennam", rdDenThang.SelectedDate.Value.Year.ToString());


        report.SetParameterValue("NguoiTrinh", ddlNguoiTrinh.SelectedValue.Split(':')[1]);
        report.SetParameterValue("NgayTrinh", rdNgayTrinh.SelectedDate.Value.ToString("dd/MM/yyyy"));
        report.SetParameterValue("BoPhanTrinh", tbBoPhan.Text);
        report.SetParameterValue("ChucVuTrinh", tbChucVu.Text);
        report.SetParameterValue("NguoiNhan", ddlNguoiNhan.SelectedValue.Split(':')[1]);
        report.SetParameterValue("NgayNhan", rdNgayNhan.SelectedDate.Value.ToString("dd/MM/yyyy"));
        report.SetParameterValue("BoPhanNhan", tbBoPhanNhan.Text);
        report.SetParameterValue("ChucVuNhan", tbChucVuNhan.Text);
        #endregion
        #region Gọi file report
        Session["report"] = report;
        //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
        DialogWindow.VisibleOnPageLoad = true;
        #endregion
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "TongHopNganSach" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm").ToString();
        RG.MasterTableView.ExportToExcel();
    }

    protected void ddlNguoiTrinh_SelectedIndexChanged(object sender, EventArgs e)
    {
        fThongTinNV();
    }
    protected void ddlNguoiNhan_SelectedIndexChanged(object sender, EventArgs e)
    {
        fThongTinNV();
    }    
}
