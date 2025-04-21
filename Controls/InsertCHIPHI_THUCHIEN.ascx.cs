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
public partial class uc_insert_CHIPHI_THUCHIEN : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        //IAbstractBaseClass page = (IAbstractBaseClass)Page;
        //hfNam_DonVi.Value = page.DoSomething();
    }
    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key", "@Nam_DonVi" };
        Obj.ValueParameter = new object[] { e.Text, hfNam_DonVi.Value };
        Obj.SpName = "spLoad_DmChiPhi_ByKeHoach";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (cbMaChiPhi.SelectedValue == null || cbMaChiPhi.SelectedValue == "")
        {
            args.IsValid = false;
        }
        else
            args.IsValid = true;
    }
}
