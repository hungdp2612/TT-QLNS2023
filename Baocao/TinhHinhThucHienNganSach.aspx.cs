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
using Data;

public partial class BaoCao_TinhHinhThucHienNganSach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //rnTuThang.SelectedDate = DateTime.Now;
            //rnDenThang.SelectedDate = DateTime.Now;
        }
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", 
            "@tunam",
            "@denthang", 
            "@dennam" };
        Obj.ValueParameter = new object[] { rnTuThang.SelectedDate.Value.Month.ToString().Length==1? 
                "0" + rnTuThang.SelectedDate.Value.Month.ToString():rnTuThang.SelectedDate.Value.Month.ToString(),
            rnTuThang.SelectedDate.Value.Year.ToString(),
            rnDenThang.SelectedDate.Value.Month.ToString().Length==1? 
                "0" + rnDenThang.SelectedDate.Value.Month.ToString():rnDenThang.SelectedDate.Value.Month.ToString(),
            rnDenThang.SelectedDate.Value.Year.ToString() };
        Obj.SpName = "sp_BaoCao_TinhHnhThucHienNganSach";
        //sp_BaoCaoTinhHinhThucHienNganSach
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        rg.DataSource = Obj.Dt;
        rg.DataBind();
        rg.Items[0].Style.Add("color", "Blue");
    }
    protected void btXem_Click(object sender, ImageClickEventArgs e)
    {
        

        fLoad();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
        rg.ExportSettings.ExportOnlyData = true;
        rg.ExportSettings.IgnorePaging = true;
        rg.ExportSettings.OpenInNewWindow = true;
        rg.ExportSettings.FileName = "Tong Hop Tinh Hinh Thuc Hien Ngan Sach " + (rnTuThang.SelectedDate.Value.Month.ToString().Length==1? 
                "0" + rnTuThang.SelectedDate.Value.Month.ToString():rnTuThang.SelectedDate.Value.Month.ToString()) +
            rnTuThang.SelectedDate.Value.Year.ToString()+
            (rnDenThang.SelectedDate.Value.Month.ToString().Length==1? 
                "0" + rnDenThang.SelectedDate.Value.Month.ToString():rnDenThang.SelectedDate.Value.Month.ToString()) +
            rnDenThang.SelectedDate.Value.Year.ToString();
        rg.MasterTableView.ExportToExcel();
    }
}
