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

public partial class Controls_ChiTietThanhToanKhongTamUng_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    protected void Page_Load(object sender, EventArgs e)
    {
        fLoadDonVi();
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {

            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
    protected void rdThanhTien_TextChanged(object sender, EventArgs e)
    {
        rdThanhTien.Value = rnSoLuong.Value * rnDonGia.Value;
        if (rdThanhTien.Text != "")
        {
            rnNganSachConLai.Value = rnNganSachConLaiAn.Value - (rdThanhTien.Value * rnTiGia.Value);
        }

    }
    void FLoadNganSachConLai()
    {

        string IDMaCS;
        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtMaBP.Text;
            }
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { txtSoPhieu.Text };
        Obj.SpName = "sp_GiayDeNghiThanhToan_GetNamThang_BySoPhieu";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { IDMaCS, txtMSCHiPhi.Text ,nam,thang};
       // Obj.SpName = "sp_GiayDeNghiThanhToan_NganSachConLai";
        Obj.SpName = "sp_GiayDeNghiThanhToan_NganSachConLai040515";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnNganSachConLai.Text = Obj.Dt.Rows[0]["STCON"].ToString();
                rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["STCON"].ToString();
            }
            catch { }
        }
    }
    public string fGet(object Tigia, object TienThanhToan, object SoLuong, object DonGia, object VAT)
    {
        if (VAT.ToString() != "")
        {
            rnVAT.Value = float.Parse(VAT.ToString());
        }
        rnSoLuong.Value = double.Parse(SoLuong.ToString());
        rnDonGia.Value = double.Parse(DonGia.ToString());

        rnTiGia.Value = double.Parse(Tigia.ToString());
        rdThanhTien.Value = double.Parse(TienThanhToan.ToString());

        
        rdThanhTienAn.Value = double.Parse(TienThanhToan.ToString());
        FLoadNganSachConLai();  
        return "";
    }
}
