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


public partial class BaoCao_TongHopThucHienNganSach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        //rdTuThang.SelectedDate = DateTime.Now;
        //rdDenThang.SelectedDate = DateTime.Now;
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", 
            "@tunam", "@denthang", 
            "@dennam" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(),
            rdTuThang.SelectedDate.Value.Year.ToString(), rdDenThang.SelectedDate.Value.Month.ToString(),
            rdDenThang.SelectedDate.Value.Year.ToString()
        };


        Obj.SpName = "spBaoCaoTongHopThucHienNganSach";
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void btIn_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }
    protected void RG_GroupsChanging(object source, Telerik.Web.UI.GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "TongHopThucHienNganSachToanCongTy" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm").ToString();
        RG.MasterTableView.ExportToExcel();
    }
}
