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

public partial class Controls_UpdateCHIPHI_THUCHIEN : System.Web.UI.UserControl
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {

    }
   
    public string fGet(object ChiPhi)
    {

        rnChiPhi.Value = double.Parse(ChiPhi.ToString());    
        return "";
    }
   
}
