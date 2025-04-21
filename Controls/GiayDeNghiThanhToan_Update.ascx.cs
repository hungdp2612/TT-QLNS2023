using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
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
using Telerik.Web.UI;

public partial class Controls_GiayDeNghiThanhToan_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    protected void Page_Load(object sender, EventArgs e)
    {
        fLoadThongTinTaiKhoan();
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
    public string fGet(object tigia, object loaitien, object HanTT, object HTTT, object NganHang, object TenTaiKhoan, object SoTaiKhoan, object loaiHoaDon)
    {
        fLoadTienTe();

        rnTiGia.Value = double.Parse(tigia.ToString());
        rnTiGiaCu.Value = double.Parse(tigia.ToString());
        ddlLoaiTien.SelectedValue = loaitien.ToString();
        rdHanThanhToan.SelectedDate = DateTime.Parse(HanTT.ToString());
        rdHanThanhToanCu.SelectedDate = DateTime.Parse(HanTT.ToString());
        ddlHinhThucThanhToan.SelectedValue = HTTT.ToString();
        txtNganHang.Text = NganHang.ToString();
        txtTenTK.Text = TenTaiKhoan.ToString();
        txtSoTK.Text = SoTaiKhoan.ToString();
        DropDownListLoaiHoaDon.SelectedValue = loaiHoaDon.ToString();
        if (loaiHoaDon.ToString() == "DIENTU")
        {
            trLoaiHoaDonDienTu1.Visible = true;
            trLoaiHoaDonDienTu2.Visible = true;
            trLoaiHoaDonDienTu3.Visible = true;
        }
        else
        {
            trLoaiHoaDonDienTu1.Visible = false;
            trLoaiHoaDonDienTu2.Visible = false;
            trLoaiHoaDonDienTu3.Visible = false;
        }

        fLoadThongTinTaiKhoan();
        return "";
    }
    protected void ddlLoaiTien_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadTiGia();
    }

    void fLoadThongTinTaiKhoan()
    {

        if (ddlHinhThucThanhToan.SelectedValue == "NH")
        {
            txtTenTK.Enabled = true;
            txtSoTK.Enabled = true;
            txtNganHang.Enabled = true;
        }
        else
        {
            txtTenTK.Text = "";
            txtSoTK.Text = "";
            txtNganHang.Text = "";
            txtTenTK.Enabled = false;
            txtSoTK.Enabled = false;
            txtNganHang.Enabled = false;
        }
    }
    protected void ddlHinhThucThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadThongTinTaiKhoan();
    }

    protected void DropDownListLoaiHoaDon_OnSelectedIndexChanged(object sender, EventArgs e)
    {

        if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
        {
            trLoaiHoaDonDienTu1.Visible = true;
            trLoaiHoaDonDienTu2.Visible = true;
            trLoaiHoaDonDienTu3.Visible = true;
        }
        else
        {
            trLoaiHoaDonDienTu1.Visible = false;
            trLoaiHoaDonDienTu2.Visible = false;
            trLoaiHoaDonDienTu3.Visible = false;
        }
    }

    protected void RadButtonXoaHoaDonDienTu_OnClick(object sender, EventArgs e)
    {
        Download.HRef = string.Empty;

        LabelLoi.ForeColor = Color.Blue;
        LabelLoi.Text = "Xóa thành công. Bấm lưu để cập nhật dữ liệu";
    }

    protected void RadAsyncUploadFileHoaDonDienTu_OnFileUploaded(object sender, FileUploadedEventArgs e)
    {
        try
        {
            string targetFolder = @"Host Web\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu";
            string id = DateTime.Now.ToString("_yyyyMMdd_HH_mm_ss");
            string targetFileName = Path.Combine(Server.MapPath("~").Split(':')[0] + @":\\", targetFolder,
                e.File.GetNameWithoutExtension() + id + e.File.GetExtension());

            if (RadAsyncUploadFileHoaDonDienTu.UploadedFiles.Count > 0)
            {
                e.File.SaveAs(targetFileName);

                string link = Path.Combine(@"http:\\thaituangarment.com.vn\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu",
                    e.File.GetNameWithoutExtension() + id + e.File.GetExtension());
                Download.HRef = link;

                LabelLoi.ForeColor = Color.Blue;
                LabelLoi.Text = "Tải lên thành công. Bấm lưu để cập nhật dữ liệu";
            }
            else
            {
                throw new Exception("Không tìm thấy File tải lên.");
            }
        }
        catch (Exception ex)
        {
            LabelLoi.ForeColor = Color.Red;
            LabelLoi.Text = ex.Message;
        }
    }
}
