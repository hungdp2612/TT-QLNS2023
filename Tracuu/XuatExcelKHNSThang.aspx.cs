using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;

public partial class TraCuu_XuatExcelKHNSThang : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdTuThang.SelectedDate = DateTime.Now;
        }
    }


    void fLoad()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@nam", "@thang" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Year, rdTuThang.SelectedDate.Value.Month};
        Obj.SpName = "Ngansach_theothang_xuatExcel";
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
        Obj.Parameter = new string[] { "@nam", "@thang" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Year, rdTuThang.SelectedDate.Value.Month };
        Obj.SpName = "Ngansach_theothang_xuatExcel";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

        ConfigureExport();
        RG.MasterTableView.ExportToExcel();
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }
    public void ConfigureExport()
    {
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "Ke hoach ngan sach thang " +
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
}