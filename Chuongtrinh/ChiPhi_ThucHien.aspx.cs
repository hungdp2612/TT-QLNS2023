using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Data;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Web.Configuration;

public partial class Chuongtrinh_ChiPhi_ThucHien : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    clsFunction fuc = new clsFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdThangNam.SelectedDate = DateTime.Now;
            fLoadDonVi();
            fDonVi();
            fLoadQuyen();
            fLoad();
            fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();

        }
    }
    public string DoSomething()
    {
        return rdThangNam.SelectedDate.Value.Year.ToString() + cbDonVi.SelectedValue;
    }
    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang", "@MADV" };
        Obj.ValueParameter = new object[] { rdThangNam.SelectedDate.Value.Year, rdThangNam.SelectedDate.Value.Month.ToString("00"), cbDonVi.SelectedValue };
        Obj.SpName = "spLoad_CHIPHI_THUCHIEN_ByMADV";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { "" };
        Obj.SpName = "spLoad_DonVi";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
    }
    void fDonVi()
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaNV" };
        //Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        //Obj.SpName = "SP_LoadNVIDMaDV";
        //Obj.Connectionstring = connectionString;
        //Sql.fGetData(Obj);
        //if (Obj.Dt.Rows.Count < 1)
        //{

        //}
        //else
        //{
        //    cbDonVi.SelectedValue = Obj.Dt.Rows[0]["MaDV"].ToString();
         
        //}
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachChiPhi_LoadMaDV_ByMaNV";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
        cbDonVi.SelectedIndex = 0;
    }
    void fLoadQuyen()
    {
        string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];

        string folder = "";
        if (Request.Url.Segments.Length > 3)
        {
            folder = Request.Url.Segments[Request.Url.Segments.Length - 2].ToString().Split('.')[0];
        }

        if (Session.Contents["UserID"] == null)
        {
            Session["WebID"] = "~/" + folder + site + ".aspx";
            Response.Redirect("~/Sites/Login.aspx");
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@manv", "@idsite" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString(), site };
        Obj.SpName = "sp_DMPhanQuyen_ById";
        Sql.fGetData(Obj);

        if (Obj.Dt.Rows.Count == 0)
        {
            string Loi = "Bạn chưa được phân quyền vào trang này";
            Response.Redirect("~/Loi.aspx?Strloi=" + Loi + "");
        }
        else
        {
            if (Obj.Dt.Rows[0]["IDQuyen"].ToString() == "KH")
            {
                string Loi = "Bạn chưa được phân quyền vào trang này";
                Response.Redirect("~/Loi.aspx?Strloi=" + Loi + "");
            }
            else
            {
                if (Obj.Dt.Rows[0]["IDQuyen"].ToString() == "TC")
                {
                    cbDonVi.Enabled = true;
                }
            }
        }
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

            if (table.Rows.Count > 1)
            {
                string Maloi = "";
                for (int i = 1; i < table.Rows.Count; i++)
                {
                    string MSCHIPHI = table.Rows[i][0].ToString().ToUpper();
                    double CHIPHI = clsConvertHelper.ToDouble(table.Rows[i][1].ToString().ToUpper());
                    #region lưu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MSCHIPHI", "@CHIPHI", "@NguoiNhap", "@TenMayTinh", "@Nam_DonVi" };
                    Obj.ValueParameter = new object[] { MSCHIPHI, CHIPHI, Session["UserID"].ToString(), fuc.fID_Cookies(), rdThangNam.SelectedDate.Value.Year.ToString() + cbDonVi.SelectedValue };
                    Obj.SpName = "spInsert_Excel_CHIPHI_THUCHIEN_TungDong";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        if (Maloi == "")
                        {
                            Maloi = MSCHIPHI;
                        }
                        else
                        {
                            Maloi += "; " + MSCHIPHI;
                        }
                    }

                    #endregion

                }
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                #region Thông báo
                if (Maloi != "")
                {
                    lbLoi.Text += " - <font color='red'>Mã chi phí lưu thất bại <b><font color='black'>" + Maloi + "</font></b></font>";
                }
                #endregion
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
    void fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TenMayTinh" };
        Obj.ValueParameter = new object[] { fuc.fID_Cookies() };
        Obj.SpName = "spLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh";
        Sql.fGetData(Obj);
        rgNhapExcel.DataSource = Obj.Dt;
        rgNhapExcel.DataBind();
    }
    protected void RG_CancelCommand(object source, GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_EditCommand(object source, GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_DeleteCommand(object source, GridCommandEventArgs e)
    {
        string kHOA = RG.Items[e.Item.ItemIndex]["kHOA"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@kHOA" };
        Obj.ValueParameter = new object[] { kHOA };
        Obj.SpName = "spDelete_CHIPHI_THUCHIEN";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công .</font>";
        }
        fLoad();
    }
    protected void RG_InsertCommand(object source, GridCommandEventArgs e)
    {
        if (Page.IsValid)
        {
            lbLoi.Text = "";
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
            int NAM = rdThangNam.SelectedDate.Value.Year;
            string THANG = rdThangNam.SelectedDate.Value.Month.ToString("00");
            string MADV = cbDonVi.SelectedValue;
            string MSCHIPHI = (userControl.FindControl("cbMaChiPhi") as RadComboBox).SelectedValue.Trim();
            double CHIPHI = clsConvertHelper.ToDouble((userControl.FindControl("rnCHIPHI") as RadNumericTextBox).Value.ToString());
            #region Kiểm tra trùng mã
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Thang", "@nam", "@MaDV", "@MSCHIPHI" };
            Obj.ValueParameter = new object[] { THANG, NAM, MADV, MSCHIPHI };
            Obj.SpName = "spLoad_CHIPHI_THUCHIEN_ByID2";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                lbLoi.Text = "<font color='red'>Đã có mã này. Vui lòng thử lại sau.</font>";
                fLoad();
                return;
            }
            #endregion
            #region Insert
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@NAM", "@THANG", "@MADV", "@MSCHIPHI", "@CHIPHI" };
            Obj.ValueParameter = new object[] { NAM, THANG, MADV, MSCHIPHI, CHIPHI };
            Obj.SpName = "spInsert_CHIPHI_THUCHIEN";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Thêm thất bại mã chi phí <font color='black'><b>" + MSCHIPHI + "</b></font>. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thêm thành công mã chi phí <font color='black'><b>" + MSCHIPHI + "</b></font>.</font>";
            }
            #endregion
            fLoad();

        }
    }
    protected void RG_ItemCommand(object source, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            //case RadGrid.InitInsertCommandName:
            //    RG.MasterTableView.ClearEditItems();
            //    e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/InsertCHIPHI_THUCHIEN.ascx";
            //    e.Item.OwnerTableView.InsertItem();
            //    fLoad();
            //    break;
            case RadGrid.EditCommandName:
                RG.MasterTableView.IsItemInserted = false;
                e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/UpdateCHIPHI_THUCHIEN.ascx";
                fLoad();
                break;
            case RadGrid.FilterCommandName:
                fLoad();
                break;
            case RadGrid.RebindGridCommandName:
                fLoad();
                break;
        }
    }
    protected void RG_UpdateCommand(object source, GridCommandEventArgs e)
    {
        if (Page.IsValid)
        {
            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            TextBox txtMaCP = userControl.FindControl("txtMaCP") as TextBox;
            float rnChiPhi = float.Parse((userControl.FindControl("rnChiPhi") as RadNumericTextBox).Value.ToString());
            string kHOA = RG.Items[e.Item.ItemIndex]["kHOA"].Text;
            #region Update
            Obj = new clsObj();
            Obj.Parameter = new string[] {   "@CHIPHI", "@kHOA" };
            Obj.ValueParameter = new object[] { rnChiPhi, kHOA };
            Obj.SpName = "spEdit_CHIPHI_THUCHIEN";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
            }
            #endregion
            fLoad();
        }
    }

    protected void RG_SortCommand(object source, GridSortCommandEventArgs e)
    {
        fLoad();
    }

    protected void cbDonVi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { e.Text };
        Obj.SpName = "spLoad_DonVi";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
    }
    protected void cbDonVi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoad();
    }
    protected void rdThangNam_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        fLoad();
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (cbDonVi.SelectedValue == null || cbDonVi.SelectedValue == "")
        {
            args.IsValid = false;
        }
        else
            args.IsValid = true;
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
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
            }

        }
    }
    protected void btnExportMau_Click(object sender, ImageClickEventArgs e)
    {
        string path = Server.MapPath("~/UploadFiles/MauNhapChiPhiThucHien.xls");
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
        Obj.SpName = "spDelete_Excel_CHIPHI_THUCHIEN_ByTenMayTinh";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại.</font>";
        }

        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
        return;

    }
    protected void btnNhapDuLieu_Click(object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {
            string Maloi = "";

            int kq = 0;

            foreach (GridDataItem item in rgNhapExcel.Items)
            {
                if ((item["Chon"].FindControl("chkChon") as CheckBox).Checked)
                {
                    int Nam = rdThangNam.SelectedDate.Value.Year;
                    string Thang = rdThangNam.SelectedDate.Value.Month.ToString("00");
                    string MSCHIPHI = item["MSCHIPHI"].Text;
                    double CHIPHI = clsConvertHelper.ToDouble(item["CHIPHI"].Text);
                    #region Kiểm tra trùng
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MSCHIPHI", "@Thang", "@Nam", "@MADV" };
                    Obj.ValueParameter = new object[] { MSCHIPHI, Thang, Nam, cbDonVi.SelectedValue };
                    Obj.SpName = "spLoad_CHIPHI_THUCHIEN_ByID2";
                    Sql.fGetData(Obj);
                    if (Obj.Dt.Rows.Count > 0)
                    {
                        if (Maloi == "")
                        {
                            Maloi = MSCHIPHI;
                        }
                        else
                        {
                            Maloi += "; " + MSCHIPHI;
                        }
                        continue;
                    }
                    #endregion

                    #region Insert
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MSCHIPHI", "@Thang", "@Nam", "@CHIPHI", "@MADV" };
                    Obj.ValueParameter = new object[] { MSCHIPHI, Thang, Nam, CHIPHI, cbDonVi.SelectedValue };
                    Obj.SpName = "spInsert_CHIPHI_THUCHIEN";
                    Sql.fNonGetData(Obj);

                    if (Obj.KetQua > 0)
                    {
                        kq++;
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@TenMayTinh", "@MSCHIPHI" };
                        Obj.ValueParameter = new object[] { fuc.fID_Cookies(), MSCHIPHI };
                        Obj.SpName = "spDelete_Excel_CHIPHI_THUCHIEN_ByKey";
                        Sql.fNonGetData(Obj);
                    }
                    #endregion
                }
            }
            if (kq > 0)
            {
                fLoad();
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                lbLoi.Text = "<font color='blue'>Nhập thành công " + kq + " dòng.</font>";

            }
            #region Thông báo
            if (Maloi != "")
            {
                lbLoi.Text += " - <font color='red'>Mã chi phí trùng <b><font color='black'>" + Maloi + "</font></b></font>";
            }
            #endregion
        }
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (cbDonVi.SelectedValue == null || cbDonVi.SelectedValue == "")
        {
            args.IsValid = false;
        }
        else
            args.IsValid = true;
    }
    #region rgNhapExcel
    protected void rgNhapExcel_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }
    protected void rgNhapExcel_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }
    protected void rgNhapExcel_ItemCommand(object sender, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case RadGrid.RebindGridCommandName:
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                break;
            case RadGrid.FilterCommandName:
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                break;
        }
    }
    protected void rgNhapExcel_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string MSCHIPHI = rgNhapExcel.Items[e.Item.ItemIndex]["MSCHIPHI"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TenMayTinh", "@MSCHIPHI" };
        Obj.ValueParameter = new object[] { fuc.fID_Cookies(), MSCHIPHI };
        Obj.SpName = "spDelete_Excel_CHIPHI_THUCHIEN_ByKey";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại mã chi phí <font color='black'><b>" + MSCHIPHI + "</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công mã chi phí <font color='black'><b>" + MSCHIPHI + "</b></font>.</font>";
        }
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }
    #endregion
    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {      
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@Key", "@Nam_DonVi" };
        //Obj.ValueParameter = new object[] { e.Text, rdThangNam.SelectedDate.Value.Year + cbDonVi.SelectedValue };
        //Obj.SpName = "spLoad_DmChiPhi_ByKeHoach";
        //Sql.fGetData(Obj);
        //cbMaChiPhi.DataSource = Obj.Dt;
        //cbMaChiPhi.DataBind();

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { e.Text };
        Obj.SpName = "sp_KeHoachChiPhi_ChiPhiThucHien";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";      
        int NAM = rdThangNam.SelectedDate.Value.Year;
        string THANG = rdThangNam.SelectedDate.Value.Month.ToString("00");
        string MADV = cbDonVi.SelectedValue;   
        #region Kiểm tra trùng mã
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@nam", "@MaDV", "@MSCHIPHI" };
        Obj.ValueParameter = new object[] { THANG, NAM, MADV, cbMaChiPhi.SelectedValue };
        Obj.SpName = "spLoad_CHIPHI_THUCHIEN_ByID2";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có mã này. Vui lòng thử lại sau.</font>";
            fLoad();
            return;
        }
        #endregion
        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@NAM", "@THANG", "@MADV", "@MSCHIPHI", "@CHIPHI" };
        Obj.ValueParameter = new object[] { NAM, THANG, MADV, cbMaChiPhi.SelectedValue, rnCHIPHI.Value };
        Obj.SpName = "spInsert_CHIPHI_THUCHIEN";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Thêm thất bại mã chi phí <font color='black'><b>" + cbMaChiPhi.SelectedValue + "</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm thành công mã chi phí <font color='black'><b>" + cbMaChiPhi.SelectedValue + "</b></font>.</font>";
        }
        #endregion
        fLoad();
    }
}