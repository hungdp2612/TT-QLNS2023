using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sites_Loi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            lbuser.Text = Session["Name"].ToString();
            string loi = Request.QueryString["Strloi"].ToString();
            lbquyen.Text = loi;
            LabelIP.Text = "IP: " + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        catch (Exception)
        {
            Response.Redirect("~/Sites/Login.aspx");
        }
    }

}

