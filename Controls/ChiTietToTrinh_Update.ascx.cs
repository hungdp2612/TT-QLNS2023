﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class Controls_ChiTietToTrinh_Update : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public string fGet(object SoTien)
    {
        UCrnChiPhi.Value = double.Parse(SoTien.ToString());
      
        return "";
    }

}
