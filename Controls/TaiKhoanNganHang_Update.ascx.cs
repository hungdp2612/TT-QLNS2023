using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_TaiKhoanNganHang_Update : System.Web.UI.UserControl
{
    QLVattuDataContext dbvt_ = new QLVattuDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    void fLoadTenTaiKhoan()
    {
        var item = dbvt_.DMNHANVIENs.Where(p => p.MADV == rdDonVi.SelectedValue && p.HieuLuc == 1).ToList();
        rdTenTaiKhoan.DataSource = item;
        rdTenTaiKhoan.DataBind();
    }

    void fLoadDonVi()
    {
        var item = dbvt_.DMDONVIs.Where(p => p.HieuLuc == 1).ToList();
        rdDonVi.DataSource = item;
        rdDonVi.DataBind();
    }

    public string fGet(object MADV, object MANV, object TenNganHang, object SoTaiKhoan, object Ghichu)
    {
        txtSotaikhoan.Text = SoTaiKhoan.ToString();
        rdDonVi.SelectedValue = MADV.ToString();
        rdTenTaiKhoan.SelectedValue = MANV.ToString();
        txtTenNganHang.Text = TenNganHang.ToString();
        txtGhichu.Text = Ghichu.ToString();

        fLoadTenTaiKhoan();
        fLoadDonVi();
        return "";
    }

    protected void rdDonVi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdTenTaiKhoan.SelectedValue = null;
        rdTenTaiKhoan.Text = string.Empty;
        fLoadTenTaiKhoan();
    }
}