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
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;
using System.Text.RegularExpressions;
public partial class ChiTietToTrinh_XemXet : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["SoToTrinh"] != null)
            {
                tbSoPhieu.Text = Request.QueryString["SoToTrinh"].ToString();
                fLoadChiTietToTrinh();
            }         
          
        }
    }     
   

    void fLoadChiTietToTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { tbSoPhieu.Text };
        Obj.SpName = "sp_ToTrinh_Load_ChiTietToTrinh";
        Sql.fGetData(Obj);
        RGChiTietToTrinh.DataSource = Obj.Dt;
        RGChiTietToTrinh.DataBind();
    }
   
   
}