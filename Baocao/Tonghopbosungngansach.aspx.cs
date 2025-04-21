using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using CrystalDecisions.CrystalReports.Engine;

public partial class Baocao_Tonghopbosungngansach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
   
    string ConnectWQLVT = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    ReportDocument report;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {           
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
        if (Obj.Dt.Rows.Count > 0)
        {
            tbChucVu.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
            tbBoPhan.Text = Obj.Dt.Rows[0]["TenDonVi"].ToString();
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { ddlNguoiNhan.SelectedValue.Split(':')[0] };
        Obj.SpName = "spThongTin_NV_QLNS";
        Obj.Connectionstring = ConnectWQLVT;
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            tbBoPhanNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
            tbChucVuNhan.Text = Obj.Dt.Rows[0]["TenDonVi"].ToString();
        }
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", "@tunam", 
            "@denthang", "@dennam" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(), rdTuThang.SelectedDate.Value.Year.ToString(),
            rdDenThang.SelectedDate.Value.Month.ToString(), rdDenThang.SelectedDate.Value.Year.ToString()
        };
        //Obj.SpName = "sp_rpt_bosungngansach_luoi";
        Obj.SpName = "sp_rpt_bosungngansach_luoi_040515";
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void btIn_Click(object sender, ImageClickEventArgs e)
    {
        fLoadBaoCao();
    }
    void fLoadBaoCao()
    {
       
            report = new ReportDocument();
            report = ReportFactory.GetReport(report.GetType());
            report.Load(Server.MapPath(@"~\Reports\rptBaoCaoBoSungNS.rpt"));
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
        RG.ExportSettings.FileName = "TongHopBoSungNganSach" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm").ToString();
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


    protected void btXem2_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", "@tunam", 
            "@denthang", "@dennam" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(), rdTuThang.SelectedDate.Value.Year.ToString(),
            rdDenThang.SelectedDate.Value.Month.ToString(), rdDenThang.SelectedDate.Value.Year.ToString()
        };
        Obj.SpName = "sp_rpt_bosungngansach_PhongBan_KDND";
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG2.DataSource = Obj.Dt;
        RG2.DataBind();
    }

    protected void btExcel2_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", "@tunam", 
            "@denthang", "@dennam" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(), rdTuThang.SelectedDate.Value.Year.ToString(),
            rdDenThang.SelectedDate.Value.Month.ToString(), rdDenThang.SelectedDate.Value.Year.ToString()
        };
        Obj.SpName = "sp_rpt_bosungngansach_PhongBan_KDND";
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG2.DataSource = Obj.Dt;
        RG2.DataBind();

        RG2.ExportSettings.ExportOnlyData = true;
        RG2.ExportSettings.IgnorePaging = true;
        RG2.ExportSettings.OpenInNewWindow = true;
        RG2.ExportSettings.FileName = "TongHopBoSungNganSachKDND" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm").ToString();
        RG2.MasterTableView.ExportToExcel();
    }
}
