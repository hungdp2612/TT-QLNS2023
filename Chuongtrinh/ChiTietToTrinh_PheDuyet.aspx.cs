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
public partial class ChiTietToTrinh_PheDuyet : clsPhanQuyen
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
        Session["ChiTietPDToTrinh"] = "";
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
    public double fInt(object Value)
    {
        return Convert.ToDouble(Value.ToString());
    }

    protected void rnSoTien_PD_TextChanged(object sender, EventArgs e)
    {      

        Telerik.Web.UI.RadNumericTextBox rnSoTien = (Telerik.Web.UI.RadNumericTextBox)sender;

        if (rnSoTien.Text == "")
        {
            rnSoTien.Text = "0";
        }

        int Dem = 0;

        for (int i = 0; i < RGChiTietToTrinh.Items.Count; i++)
        {
            Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGChiTietToTrinh.Items[i].FindControl("rnSoTien_PD");
            if (rnSoTien.Value == rnSoTienRG.Value)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
        TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[Dem].FindControl("txtGhiChuDuyet");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { tbSoPhieu.Text, MSChiPhi, rnSoTien.Value, txtGhiChuDuyet.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);
        //if (Obj.KetQua > 0)
        //{
        //    lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
        //}
        //else
        //{
        //    lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        //}

        fLoadChiTietToTrinh();
    }

    protected void txtGhiChuDuyet_TextChanged(object sender, EventArgs e)
    {
        TextBox tbGhiChu = (TextBox)sender;
      
        int Dem = 0;

        for (int i = 0; i < RGChiTietToTrinh.Items.Count; i++)
        {

            TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[i].FindControl("txtGhiChuDuyet");
            if (tbGhiChu == txtGhiChuDuyet)
            {
                break;
            }
            Dem += 1;
          
        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGChiTietToTrinh.Items[Dem].FindControl("rnSoTien_PD");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { tbSoPhieu.Text, MSChiPhi, Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);     

        fLoadChiTietToTrinh();
    }
   
   
}