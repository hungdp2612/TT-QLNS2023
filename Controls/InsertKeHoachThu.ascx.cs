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
using System.Web.Configuration;
using Telerik.Web.UI;
using System.Xml.Linq;
using Data;
public partial class uc_insert_KeHoachThu : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void cbBoPhan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { e.Text };
        Obj.SpName = "spLoad_BoPhan";
        Sql.fGetData(Obj);
        cbBoPhan.DataSource = Obj.Dt;
        cbBoPhan.DataBind();
    }
}
