using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_LoginInfo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Name"] != null)
        {
            Label1.Text = Session["Name"].ToString();
        }
        else
        {
            Panel1.Visible = false;
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        HttpCookie ckThaiTuan = Request.Cookies["aefdcgtbfuights"];
       

        if (ckThaiTuan != null)
        {
            ckThaiTuan.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(ckThaiTuan);
        }
        Session.RemoveAll();
        Session["WebID"] = "~/sites/Trangchu.aspx";
        Response.Redirect("~/sites/login.aspx", "_self", "");
    }
}