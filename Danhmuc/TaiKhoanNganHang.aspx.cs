using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Configuration;
using Data;
using System.Text.RegularExpressions;
using Telerik.Web.UI.Skins;
using Telerik.Web.UI;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.OleDb;

public partial class Danhmuc_TaiKhoanNganHang : clsPhanQuyenCaoCap
{
    QLNS2013DBDataContext db_ = new QLNS2013DBDataContext();
    QLVattuDataContext dbvt_ = new QLVattuDataContext();
    clsObj Obj;
    clsSql Sql = new clsSql();
    clsFunction fuc = new clsFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fLoadTenTaiKhoan();
            fLoadDonVi();
            fLoad();
        }
    }

    void fLoad()
    {
        var item = db_.TaiKhoanNganHangs.ToList();
        RG.DataSource = item;
        RG.DataBind();
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


    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            EditCommandColumn e1 = new EditCommandColumn();
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/TaiKhoanNganHang_Update.ascx";
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoad();
        }
    }

    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        string ID = RG.Items[e.Item.ItemIndex]["ID"].Text;
        db_.spDelete_TaiKhoanNganHang(Convert.ToInt32(ID));
        lbLoi.Text = "<font color='blue'> Xóa thành công.</font>";
        fLoad();
    }

    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }

    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }

    protected void RG_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        fLoad();
    }

    protected void RG_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }

    protected void RG_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox sotk = userControl.FindControl("txtSotaikhoan") as TextBox;
        Telerik.Web.UI.RadComboBox donvi = userControl.FindControl("rdDonVi") as Telerik.Web.UI.RadComboBox;
        Telerik.Web.UI.RadComboBox tentk = userControl.FindControl("rdTenTaiKhoan") as Telerik.Web.UI.RadComboBox;
        TextBox tennganhang = userControl.FindControl("txtTenNganHang") as TextBox;
        TextBox ghichu = userControl.FindControl("txtGhichu") as TextBox;
        string ID = RG.Items[e.Item.ItemIndex]["ID"].Text;

        db_.spUpdate_TaiKhoanNganHang(donvi.SelectedValue, tentk.SelectedValue, tennganhang.Text, sotk.Text, ghichu.Text, Convert.ToInt32(ID));
        lbLoi.Text = "<font color='blue'> Sửa thành công.</font>";
        fLoad();
    }

    void refesh()
    {
        txtSotaikhoan.Text = string.Empty;
        txtTenNganHang.Text = string.Empty;
        txtGhichu.Text = string.Empty;
        rdDonVi.SelectedValue = null;
        rdDonVi.Text = string.Empty;
        rdTenTaiKhoan.SelectedValue = null;
        rdTenTaiKhoan.Text = string.Empty;
    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        db_.spInsert_TaiKhoanNganHang(rdDonVi.SelectedValue, rdTenTaiKhoan.SelectedValue, txtTenNganHang.Text, txtSotaikhoan.Text, txtGhichu.Text);
        lbLoi.Text = "<font color='blue'> Thêm thành công.</font>";
        refesh();
        fLoad();
    }

    protected void rdDonVi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rdTenTaiKhoan.SelectedValue = null;
        rdTenTaiKhoan.Text = string.Empty;
        fLoadTenTaiKhoan();
    }

    void fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TenMayTinh" };
        Obj.ValueParameter = new object[] { fuc.fID_Cookies() };
        Obj.SpName = "spLoad_Excel_TaiKhoanNganHang_ByTenMayTinh";
        Sql.fGetData(Obj);
        rgNhapExcel.DataSource = Obj.Dt;
        rgNhapExcel.DataBind();
    }

    public void Import(String path)
    {
        try
        {
            DataTable table = new DataTable();
            String sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;" +
            "Data Source=" + Server.MapPath(path) + ";Extended Properties=\"Excel 12.0;HDR=NO\"";
            OleDbConnection conn = new OleDbConnection(sConnectionString);
            conn.Open();
            OleDbCommand dbCommand = new OleDbCommand("SELECT * FROM [Sheet1$]", conn);
            OleDbDataAdapter da = new OleDbDataAdapter(dbCommand);
            da.Fill(table);
            conn.Close();

            var data_delete = db_.ImportTaiKhoanNganHang_tmps.Where(p => p.TENMAYTINH == fuc.fID_Cookies()).ToList();
            db_.ImportTaiKhoanNganHang_tmps.DeleteAllOnSubmit(data_delete);
            db_.SubmitChanges();

            if (table.Rows.Count > 1)
            {
                for (int i = 1; i < table.Rows.Count; i++)
                {
                    string MADV = table.Rows[i][0].ToString();
                    string MANV = table.Rows[i][1].ToString();
                    string TENNGANHANG = table.Rows[i][2].ToString();
                    string SOTAIKHOAN = table.Rows[i][3].ToString();
                    string TENTAIKHOAN = table.Rows[i][4].ToString();
                    string GHICHU = table.Rows[i][5].ToString();
                    #region lưu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MADV", "@MANV", "@TenNganHang", "@SoTaiKhoan", "@TenTaiKhoan", "@GhiChu", "@TenMayTinh" };
                    Obj.ValueParameter = new object[] { MADV, MANV, TENNGANHANG, SOTAIKHOAN, TENTAIKHOAN, GHICHU, fuc.fID_Cookies() };
                    Obj.SpName = "spInsert_Import_TaiKhoanNganHang_tmp";
                    Sql.fNonGetData(Obj);
                    #endregion
                }
                fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
            }
            else
            {
                lbLoi.Text = "<font color='red'>Không có dữ liệu.</font>";
                return;
            }
        }
        catch
        {
            lbLoi.Text = "<font color='red'>Có lỗi xảy ra</font>";
        }
    }

    protected void btnLoadExcel_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        if (fuDuongDan.HasFile)
        {
            //Check Folder exists or not
            DirectoryInfo dInfo = new DirectoryInfo(Server.MapPath("~/UploadFiles"));
            if (!dInfo.Exists)
            {
                dInfo.Create();
            }

            //check file browsed or not
            if (!fuDuongDan.HasFile)
            {
                lbLoi.Text = "<font color='red'>Bạn chưa chọn file.</font>";
                return;
            }
            else
            {
                fuDuongDan.PostedFile.SaveAs(Server.MapPath("~/UploadFiles/" + Session["UserID"].ToString() + fuDuongDan.FileName));
                string fileExt = "~/UploadFiles/" + Session["UserID"].ToString() + fuDuongDan.FileName;
                Import(fileExt);
                fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
            }

        }
    }

    protected void btnExportMau_Click(object sender, ImageClickEventArgs e)
    {
        string path = Server.MapPath("~/UploadFiles/MauNhapTaiKhoanNganHang.xls");
        //get file object as FileInfo
        System.IO.FileInfo file = new System.IO.FileInfo(path);
        //-- if the file exists on the server
        //set appropriate headers
        if (file.Exists)
        {
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(file.FullName);
            Response.End();
            //if file does not exist
        }
        else
        {
            Response.Write("This file does not exist.");
        }
        //nothing in the URL as HTTP GET

    }

    protected void btXoaTatCaExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TenMayTinh" };
        Obj.ValueParameter = new object[] { fuc.fID_Cookies() };
        Obj.SpName = "spDelete_Excel_TaiKhoanNganHang_ByTenMayTinh";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại.</font>";
        }

        fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
        return;

    }

    protected void btnNhapDuLieu_Click(object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {
            #region Kiểm tra null
            foreach (GridDataItem item in rgNhapExcel.Items)
            {
                if ((item["Chon"].FindControl("chkChon") as CheckBox).Checked)
                {
                    string MADV = item["MADV"].Text.ToString();
                    string MANV = item["MANV"].Text.ToString();
                    string TENNGANHANG = item["TENNGANHANG"].Text.ToString();
                    string SOTAIKHOAN = item["SOTAIKHOAN"].Text.Trim().ToString();
                    string TENTAIKHOAN = item["TENTAIKHOAN"].Text.ToString();
                    string GHICHU = item["GHICHU"].Text.ToString();

                    #region Kiểm tra trống
                    if (string.IsNullOrEmpty(MADV) || MADV == "&nbsp;")
                    {
                        lbLoi.Text = "<font color='red'>MADV không thể trống.</font>";
                        return;
                    }

                    if (string.IsNullOrEmpty(MANV) || MANV == "&nbsp;")
                    {
                        lbLoi.Text = "<font color='red'>MANV không thể trống.</font>";
                        return;
                    }

                    if (string.IsNullOrEmpty(TENNGANHANG) || TENNGANHANG == "&nbsp;")
                    {
                        lbLoi.Text = "<font color='red'>Tên ngân hàng không thể trống.</font>";
                        return;
                    }

                    if (string.IsNullOrEmpty(SOTAIKHOAN) || SOTAIKHOAN == "&nbsp;")
                    {
                        lbLoi.Text = "<font color='red'>STK không thể trống.</font>";
                        return;
                    }

                    if (string.IsNullOrEmpty(TENTAIKHOAN) || TENTAIKHOAN == "&nbsp;")
                    {
                        lbLoi.Text = "<font color='red'>Tên tài khoản không thể trống.</font>";
                        return;
                    }
                    #endregion
                }
            }
            #endregion
            foreach (GridDataItem item in rgNhapExcel.Items)
            {
                if ((item["Chon"].FindControl("chkChon") as CheckBox).Checked)
                {
                    string MADV = item["MADV"].Text.ToString();
                    string MANV = item["MANV"].Text.ToString();
                    string TENNGANHANG = item["TENNGANHANG"].Text.ToString();
                    string SOTAIKHOAN = item["SOTAIKHOAN"].Text.ToString();
                    string TENTAIKHOAN = item["TENTAIKHOAN"].Text.ToString();
                    string GHICHU = item["GHICHU"].Text.ToString();

                    TaiKhoanNganHang models = new TaiKhoanNganHang();
                    models.MADV = MADV == null ? "" : MADV;
                    models.MANV = MANV == null ? "" : MANV;
                    models.TenNganHang = TENNGANHANG == null ? "" : TENNGANHANG;
                    models.SoTaiKhoan = SOTAIKHOAN == null ? "" : SOTAIKHOAN;
                    models.TenTaiKhoan = TENTAIKHOAN == null ? "" : TENTAIKHOAN;
                    models.Ghichu = GHICHU == null ? "" : GHICHU;
                    models.HieuLuc = true;
                    db_.TaiKhoanNganHangs.InsertOnSubmit(models);

                    var data_delete = db_.ImportTaiKhoanNganHang_tmps.Where(p => p.TENMAYTINH == fuc.fID_Cookies()).ToList();
                    db_.ImportTaiKhoanNganHang_tmps.DeleteAllOnSubmit(data_delete);
                    db_.SubmitChanges();
                }
            }
            fLoad();
            fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
            lbLoi.Text = "<font color='blue'>Nhập thành công.</font>";
        }
    }

    protected void rgNhapExcel_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string stk = rgNhapExcel.Items[e.Item.ItemIndex]["SOTAIKHOAN"].Text;
        string tmt = rgNhapExcel.Items[e.Item.ItemIndex]["TENMAYTINH"].Text;
        string madv = rgNhapExcel.Items[e.Item.ItemIndex]["MADV"].Text;
        var data_delete = db_.ImportTaiKhoanNganHang_tmps.Where(p => p.TENMAYTINH == tmt && p.SOTAIKHOAN == stk && p.MADV == madv).ToList();
        db_.ImportTaiKhoanNganHang_tmps.DeleteAllOnSubmit(data_delete);
        db_.SubmitChanges();
        fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
    }

    protected void rgNhapExcel_ItemCommand(object sender, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case Telerik.Web.UI.RadGrid.RebindGridCommandName:
                fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
                break;
            case Telerik.Web.UI.RadGrid.FilterCommandName:
                fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
                break;
        }
    }

    protected void rgNhapExcel_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
    }

    protected void rgNhapExcel_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad_Excel_TaiKhoanNganHang_ByTenMayTinh();
    }
}