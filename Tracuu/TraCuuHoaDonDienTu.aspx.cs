using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Data;

namespace Tracuu
{
    public partial class Tracuu_TraCuuHoaDonDienTu : clsPhanQuyenCaoCap
    {
        clsObj Obj;
        clsSql Sql = new clsSql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                raddatepickerTuNgay.SelectedDate = DateTime.Now.AddMonths(-1);
                raddatepickerDenNgay.SelectedDate = DateTime.Now;
                fLoadMaDV();
            }
        }

        void fLoadMaDV()
        {
            Obj = new clsObj
            {
                Parameter = new string[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "SP_LoadNVIDMaDV"
            };

            Sql.fGetData(Obj);

            string maBoPhan = "";
            if (Obj.KetQua < 1)
            {
                maBoPhan = Obj.Dt.Rows[0]["IDMaCS"].ToString() == "100" ? "CONGSO" : Obj.Dt.Rows[0]["MABP"].ToString();
            }

            Obj = new clsObj
            {
                Parameter = new string[] { "@MaBP" },
                ValueParameter = new object[] { maBoPhan },
                SpName = "sp_TraCuuChungTuNopTien_By_MaDV"
            };
            Sql.fGetData(Obj);
            DropDownListDonVi.DataSource = Obj.Dt;
            DropDownListDonVi.DataBind();
        }

        protected void RG_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Obj = new clsObj
            {
                Parameter = new string[]
                {
                    "@TuNgay",
                    "@DenNgay",
                    "@MaDonVi",
                    "@SoPhieu",
                    "@MaSoThue",
                    "@SoHoaDon",
                    "@TenFile",
                    "@MaTraCuuHoacTaiKhoan"
                },
                ValueParameter = new object[]
                {
                    raddatepickerTuNgay.SelectedDate,
                    raddatepickerDenNgay.SelectedDate,
                    DropDownListDonVi.SelectedValue,
                    RadTextBoxSoPhieu.Text,
                    RadTextBoxMaSoThue.Text,
                    RadTextBoxSoHoaDon.Text,
                    RadTextBoxTenFile.Text,
                    RadTextBoxMaTraCuuHoacTaiKhoan.Text
                },
                SpName = "SP_GET_DANHSACH_HOADONDIENTU_THEONGAY"
            };
            Sql.fGetData(Obj);
            RG.DataSource = Obj.Dt;

        }

        protected void btnXem_OnClick(object sender, ImageClickEventArgs e)
        {
            RG.Rebind();
        }

        protected void btExcel_OnClick(object sender, ImageClickEventArgs e)
        {
            RG.MasterTableView.GetColumn("CHITIET").Display = false;
            RG.MasterTableView.GetColumn("STT").Display = false; 
            RG.MasterTableView.GetColumn("DUONGDANLUUFILE").Display = false;
            RG.ExportSettings.Excel.Format = GridExcelExportFormat.Html;
            RG.ExportSettings.ExportOnlyData = true;
            RG.ExportSettings.IgnorePaging = true;
            RG.ExportSettings.OpenInNewWindow = true;
            RG.ExportSettings.FileName = "DanhSachHoaDonDienTu";
            RG.GridLines = GridLines.Both;
            RG.MasterTableView.ExportToExcel();
        }

        protected void RG_OnExportCellFormatting(object sender, ExportCellFormattingEventArgs e)
        {
            if (e.FormattedColumn.DataTypeName == "System.Decimal")
            {
                e.Cell.Style["mso-number-format"] = @"#,##0";
            }
            else if (e.FormattedColumn.DataTypeName == "System.String")
            {
                e.Cell.Style["mso-number-format"] = @"\@";
                e.Cell.HorizontalAlign = HorizontalAlign.Left;
            }
        }
    }
}