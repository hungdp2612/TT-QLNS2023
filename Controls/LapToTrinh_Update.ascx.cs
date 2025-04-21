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
using Data;

public partial class Controls_LapToTrinh_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {

    }
    void fLoadTienTe()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_CbLoaiTien_Load";
        Sql.fGetData(Obj);
        ddlLoaiTien.DataSource = Obj.Dt;
        ddlLoaiTien.DataBind();
    }
    void fLoadTiGia()
    {
        if (ddlLoaiTien.SelectedValue == "VND")
        {
            rnTiGia.Value = 1;
        }
        else
        {
            string TiGia = gtg.ExchangeRates(ddlLoaiTien.SelectedValue);
            if (TiGia != "")
            {
                rnTiGia.Value = double.Parse(gtg.ExchangeRates(ddlLoaiTien.SelectedValue));
            }
            else
            {
                rnTiGia.Text = "";
            }
        }
    }
    public string fGet(object tigia, object loaitien)
    {
        fLoadTienTe();
        rnTiGia.Value = double.Parse(tigia.ToString());
        ddlLoaiTien.SelectedValue = loaitien.ToString();
       
        return "";
    }
    protected void ddlLoaiTien_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadTiGia();
    }
}
