using System;
using System.Configuration;
using System.Web;
using Data;

public class clsPhanQuyen : System.Web.UI.Page
{
    protected override void OnPreInit(EventArgs e)
    {
        string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];

        string folder = "";
        if (Request.Url.Segments.Length > 3)
        {
            folder = Request.Url.Segments[Request.Url.Segments.Length - 2].ToString().Split('.')[0];
        }

        if (Session.Contents["UserID"] == null)
        {
            Session["WebID"] = "~/" + folder + site + ".aspx";
            Response.Redirect("~/Sites/Login.aspx");
        }
    }
}
public class clsPhanQuyenCaoCap : System.Web.UI.Page
{
    protected override void OnPreInit(EventArgs e)
    {
        string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];
        string cnnStringBieumauthue = ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ToString();

        string folder = "";
        if (Request.Url.Segments.Length > 3)
        {
            folder = Request.Url.Segments[Request.Url.Segments.Length - 2].ToString().Split('.')[0];
        }

        if (Session.Contents["UserID"] == null)
        {
            Session["WebID"] = "~/" + folder + site + ".aspx";
            Response.Redirect("~/Sites/Login.aspx");
        }
        else
        {
            clsObj Obj = new clsObj(cnnStringBieumauthue);
            clsSql Sql = new clsSql();

            Obj.Parameter = new string[] { "@manv", "@idsite","@IP" };
            Obj.ValueParameter = new object[] { Session["UserID"].ToString(), site, HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] };
            Obj.SpName = "sp_DMPhanQuyen_ById";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count == 0)
            {
                string Loi = "Bạn chưa được phân quyền vào trang này";
                Response.Redirect("~/Loi.aspx?Strloi=" + Loi + "");
            }
            else
            {
                if (Obj.Dt.Rows[0]["IDQuyen"].ToString() == "KH")
                {
                    string Loi = "Bạn chưa được phân quyền vào trang này";
                    Response.Redirect("~/Loi.aspx?Strloi=" + Loi + "");
                }
            }
        }
    }
}


   

   
        