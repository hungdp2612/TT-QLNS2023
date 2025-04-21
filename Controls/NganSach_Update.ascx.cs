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
using Telerik.Web.UI.Skins;
using Telerik.Web.UI;
using System.Configuration;

public partial class Controls_NganSach_Update : System.Web.UI.UserControl
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
          
        }
    }
    void fLoadNhomNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_NhomNganSach_Load";
        Sql.fGetData(Obj);
        cbMaNhom.DataSource = Obj.Dt;
        cbMaNhom.DataBind();
    }
    public string fGet(object MaNhomNS)
    {
        fLoadNhomNganSach();

     
        cbMaNhom.SelectedValue = MaNhomNS.ToString();
       
         return "";
    }

}
