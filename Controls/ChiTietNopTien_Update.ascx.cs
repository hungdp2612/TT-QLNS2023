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

public partial class Controls_ChiTietNopTien_Update : System.Web.UI.UserControl
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
    void SoTienConLai()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, txtMSCHiPhi.Text };
        Obj.SpName = "sp_ChungTuNopTien_ByMaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            rnSoTienConLai.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();
            rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["TIENCON"].ToString();

        }
    }
   
    public string fGet(object TienThanhToan)
    {

        SoTienConLai();
        rnSoTienThanhToan.Value = double.Parse(TienThanhToan.ToString());
       // rnSoTienConLai.Value = double.Parse(TienConLai.ToString());

        rdThanhTienAn.Value = double.Parse(TienThanhToan.ToString());

        //rnNganSachConLaiAn.Value = double.Parse(TienConLai.ToString());

        return "";
    }
   
    //protected void UCrdSoTien_TextChanged(object sender, EventArgs e)
    //{
    //    if (UCrdSoTien.Text != "")
    //    {
    //        rnNganSachConLai.Value = rnNganSachConLaiAn.Value + (rdThanhTienAn.Value - UCrdSoTien.Value) * rnTiGia.Value;
    //    }
    //}
    protected void rnSoTienThanhToan_TextChanged(object sender, EventArgs e)
    {
        if (rnSoTienThanhToan.Text != "")
        {
            rnSoTienConLai.Value = rnNganSachConLaiAn.Value + (rdThanhTienAn.Value - rnSoTienThanhToan.Value);
        }
    }
}
