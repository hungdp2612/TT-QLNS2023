using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class site_Home : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            //Response.Redirect("~/site/Login.aspx");
            Response.Redirect("~/sites/login.aspx", "_self", "");
            //Radsplitbar1.EnableResize = false;
        }
        if (!IsPostBack)
        {
            if (Session["ShowHideRadpane1"] == null)
            {
                Session["ShowHideRadpane1"] = "1";
                RdioHideShow.SelectedValue = Session["ShowHideRadpane1"].ToString().Trim();
            }
            else
            {
                RdioHideShow.SelectedValue = Session["ShowHideRadpane1"].ToString().Trim();
            }

            HideShowRadPanel1();
        }
    }

    protected void HideShowRadPanel1()
    {
        if (Session["ShowHideRadpane1"] == null)
        {
            Session["ShowHideRadpane1"] = "1";
            RdioHideShow.SelectedValue = Session["ShowHideRadpane1"].ToString().Trim();
        }

        if (Session["ShowHideRadpane1"].ToString().Trim() == "1")
        {
            Radpane1.Visible = false;
        }
        else if (Session["ShowHideRadpane1"].ToString().Trim() == "0")
        {
            Radpane1.Visible = true;
        }
    }

    protected void Radpane1_Load(object sender, EventArgs e)
    {
        //HideShowRadPanel1();
    }

    protected void RdioHideShow_SelectedIndexChanged(object sender, EventArgs e)
    {
        //HideShowRadPanel1();
        if (RdioHideShow.SelectedValue == "1")
        {
            Session["ShowHideRadpane1"] = "1";
        }
        else if (RdioHideShow.SelectedValue == "0")
        {
            Session["ShowHideRadpane1"] = "0";
        }

        HideShowRadPanel1();
    }
}
