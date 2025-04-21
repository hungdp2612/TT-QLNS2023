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

public partial class Controls_LapTamUng_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    QLNS2013DBDataContext db_ = new QLNS2013DBDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {

    }
    void fLoadTienTe()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_CbLoaiTien_Load";
        Sql.fGetData(Obj);
        ddlLoaiTien.DataSource = Obj.Dt;
        ddlLoaiTien.DataBind();
    }
    void fLoadTiGia()
    {
        if (ddlLoaiTien.SelectedValue == "VND")
        {
            rnTiGia.Value = 1;
        }
        else
        {
            string TiGia = gtg.ExchangeRates(ddlLoaiTien.SelectedValue);
            if (TiGia != "")
            {
                rnTiGia.Value = double.Parse(gtg.ExchangeRates(ddlLoaiTien.SelectedValue));
            }
            else
            {
                rnTiGia.Text = "";
            }
        }
    }
    public string fGet(object tigia, object loaitien, object HanTT, object HinhThucTamUng, object SoTaiKhoan)
    {
        fLoadTienTe();
        LoadTaiKhoanNganHang();

        rnTiGia.Value = double.Parse(tigia.ToString());
        ddlLoaiTien.SelectedValue = loaitien.ToString();
        rdHanThanhToan.SelectedDate = DateTime.Parse(HanTT.ToString());
        rdHinhThucTamUng.SelectedValue = HinhThucTamUng.ToString();
        rdTaiKhoanNganHang.SelectedValue = SoTaiKhoan.ToString();

        rdHinhThucTamUng_SelectedIndexChanged(null, null);

        return "";
    }
    protected void ddlLoaiTien_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadTiGia();
    }

    void LoadTaiKhoanNganHang()
    {
        var item = db_.TaiKhoanNganHangs.ToList();
        rdTaiKhoanNganHang.DataSource = item;
        rdTaiKhoanNganHang.DataBind();
    }

    protected void rdHinhThucTamUng_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rdHinhThucTamUng.SelectedValue == "CK")
        {
            rdTaiKhoanNganHang.Enabled = true;
        }
        else
        {
            rdTaiKhoanNganHang.Text = string.Empty;
            rdTaiKhoanNganHang.SelectedValue = null;
            rdTaiKhoanNganHang.Enabled = false;
        }
    }
}
