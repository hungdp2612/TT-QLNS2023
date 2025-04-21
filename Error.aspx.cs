using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string loi = Request.QueryString["strloi"].ToString();  //pi.GetValue(rec, null) == null ? DBNull.Value : pi.GetValue

        lblLoi.Text = "User: " + Session["UserID"].ToString().Trim() == null ? "GUEST" : Session["UserID"].ToString().Trim() + " - " + Session["Name"].ToString() == null ? "NO_NAME" : Session["Name"].ToString() + " - " + loi;

        Page.Title += "User: " + Session["UserID"].ToString().Trim() == null ? "GUEST" : Session["UserID"].ToString().Trim() + " - " + loi;
    }
}