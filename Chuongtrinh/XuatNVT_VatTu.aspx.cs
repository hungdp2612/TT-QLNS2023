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

public partial class Chuongtrinh_XuatNVT_VatTu : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    clsFunction fuc = new clsFunction();
    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EventTab_Click();
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();      
            rdThangNam.SelectedDate = DateTime.Now;

            #region tab1
           
           
            fDonVi("");
            FLoadMaBPByIDCS();
            FLoadXuatVTTheoMaDV();          
            #endregion
           
            fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();

        }
    }
    void fDonVi(string key)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV","@IDMaCS" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString(),key };
        Obj.SpName = "sp_XuatNVL_VatTu_LoadMaDV_ByMaNV";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
        cbDonVi.SelectedIndex = 0;
    }

    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { cbDonVi.SelectedValue };
        Obj.SpName = "sp_XuatNVL_VatTu_MaBPByIDCS";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }
    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {

        EventTab_Click();

    }
    void EventTab_Click()
    {

        if (RadPageView1.Selected == true)
        {
            rnNam.Visible = false;
            lbNam.Visible = false;
            lbThangNam.Visible = true;
            rdThangNam.Visible = true;

        }
        else if (RadPageView2.Selected == true)
        {
            rnNam.Visible = false;
            lbNam.Visible = false;
            lbThangNam.Visible = true;
            rdThangNam.Visible = true;
        }
        else
        {
            rnNam.Visible = true;
            lbNam.Visible = true;
            lbThangNam.Visible = false;
            rdThangNam.Visible = false;
        }
    }
    #region tab1
    void FLoadXuatVTTheoMaDV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang", "@MADV" };
        Obj.ValueParameter = new object[] { rdThangNam.SelectedDate.Value.Year, rdThangNam.SelectedDate.Value.Month, txtMaBP.Text };
        Obj.SpName = "sp_XuatNVL_VatTu_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    protected void cbDonVi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fDonVi(e.Text);
        FLoadMaBPByIDCS();
    }
    protected void cbDonVi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadMaBPByIDCS();
        FLoadXuatVTTheoMaDV();
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }
    protected void rdThangNam_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }

    protected void cbMaChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { e.Text };
        Obj.SpName = "sp_KeHoachChiPhi_ChiPhiThucHien";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }
    private DataTable GetData(string key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@key" };
        Obj.ValueParameter = new object[] { key };
        Obj.SpName = "sp_Xuat_NVT_VatTu_GetMaVT";
        Sql.fGetData(Obj);
        DataTable data = new DataTable();
        data = Obj.Dt;
        return data;

    }
    private const int ItemsPerRequest = 50;
    private static string GetStatusMessage(int offset, int total)
    {
        if (total <= 0)
            return "Không có mã vật tư";

        return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
    }
    protected void cbMaVT_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {

        DataTable data = GetData(e.Text);

        int itemOffset = e.NumberOfItems;
        int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
        e.EndOfItems = endOffset == data.Rows.Count;

        for (int i = itemOffset; i < endOffset; i++)
        {
            cbMaVT.Items.Add(new RadComboBoxItem(data.Rows[i]["MaVT"].ToString(), data.Rows[i]["MaVT"].ToString()));
        }

        e.Message = GetStatusMessage(endOffset, data.Rows.Count);


    }


    void FLoadDVT(string key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@key" };
        Obj.ValueParameter = new object[] { key };
        Obj.SpName = "sp_Xuat_NVT_VatTu_GetDVT";
        Sql.fGetData(Obj);
        cbDVT.DataSource = Obj.Dt;
        cbDVT.DataBind();

    }
    protected void cbDVT_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        FLoadDVT(e.Text);
    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        int NAM = rdThangNam.SelectedDate.Value.Year;
        int THANG = rdThangNam.SelectedDate.Value.Month;
        string MADV = txtMaBP.Text;
        #region Kiểm tra trùng mã
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@nam", "@MaDV", "@MaVT" };
        Obj.ValueParameter = new object[] { THANG, NAM, MADV, cbMaVT.SelectedValue };
        Obj.SpName = "sp_XuatNVL_VatTu_KiemTraTrung";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có mã vật tư này. Vui lòng thử lại sau.</font>";
            FLoadXuatVTTheoMaDV();
            return;
        }
        #endregion
        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@NAM", "@THANG", "@MaVT", "@TenVT", "@DVT", "@MSCHIPHI", "@SoLuong", "@GiaTri" };
        Obj.ValueParameter = new object[] { MADV, NAM, THANG, cbMaVT.SelectedValue, cbMaVT.SelectedValue, cbDVT.SelectedValue, cbMaChiPhi.SelectedValue, rnSoLuong.Value, rnGiaTri.Value };
        Obj.SpName = "sp_XuatNVT_VatTu_Insert";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Thêm thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm thành công .</font>";
        }
        #endregion
        FLoadXuatVTTheoMaDV();
    }
    protected void RG_CancelCommand(object source, GridCommandEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
    }
    protected void RG_EditCommand(object source, GridCommandEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
    }
    protected void RG_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
    }
    protected void RG_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
    }
    protected void RG_DeleteCommand(object source, GridCommandEventArgs e)
    {
        string MaDV = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
        string Nam = RG.Items[e.Item.ItemIndex]["Nam"].Text;
        string Thang = RG.Items[e.Item.ItemIndex]["Thang"].Text;
        string MaVT = RG.Items[e.Item.ItemIndex]["MaVT"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@Nam","@Thang","@MaVT" };
        Obj.ValueParameter = new object[] { MaDV,int.Parse(Nam),int.Parse(Thang),MaVT };
        Obj.SpName = "sp_XuatNVL_VatTu_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công .</font>";
        }
        FLoadXuatVTTheoMaDV();
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
                FLoadXuatVTTheoMaDV();
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
            FLoadXuatVTTheoMaDV();

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
                FLoadXuatVTTheoMaDV();
                break;
            case RadGrid.FilterCommandName:
                FLoadXuatVTTheoMaDV();
                break;
            case RadGrid.RebindGridCommandName:
                FLoadXuatVTTheoMaDV();
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
            Obj.Parameter = new string[] { "@CHIPHI", "@kHOA" };
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
            FLoadXuatVTTheoMaDV();
        }
    }

    protected void RG_SortCommand(object source, GridSortCommandEventArgs e)
    {
        FLoadXuatVTTheoMaDV();
    }
    #endregion

    #region tab2
    public string DoSomething()
    {
        return rdThangNam.SelectedDate.Value.Year.ToString() + cbDonVi.SelectedValue;
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
                    string MaVT = table.Rows[i][0].ToString().ToUpper();
                    string TenVT = table.Rows[i][1].ToString();
                    string DVT = table.Rows[i][2].ToString();
                    string MSCHIPHI = table.Rows[i][3].ToString();
                    double SL = double.Parse(table.Rows[i][4].ToString());
                    double GT =double.Parse(table.Rows[i][5].ToString());
                    #region lưu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MaVT", "@TenVT", "@DVT", "@NguoiNhap", "@MSCHIPHI", "@SoLuong", "@GiaTri" };
                    Obj.ValueParameter = new object[] { txtMaBP.Text, rdThangNam.SelectedDate.Value.Year, rdThangNam.SelectedDate.Value.Month, MaVT, TenVT, DVT, Session["UserID"].ToString(), MSCHIPHI, SL,GT};
                    Obj.SpName = "sp_Excel_XuatNVL_vatTu_Insert";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        if (Maloi == "")
                        {
                            Maloi = MaVT;
                        }
                        else
                        {
                            Maloi += "; " + MaVT;
                        }
                    }

                    #endregion

                }
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                #region Thông báo
                if (Maloi != "")
                {
                    lbLoi.Text += " - <font color='red'>Mã VT này <b><font color='black'>" + Maloi + "</font></b> đã có</font>";
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
        Obj.Parameter = new string[] { "@Nam", "@Thang", "@MADV" };
        Obj.ValueParameter = new object[] { rdThangNam.SelectedDate.Value.Year, rdThangNam.SelectedDate.Value.Month, txtMaBP.Text };
        Obj.SpName = "sp_XuatNVL_VatTu_Excel_Load";
        Sql.fGetData(Obj);      
        rgNhapExcel.DataSource = Obj.Dt;
        rgNhapExcel.DataBind();
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
        string path = Server.MapPath("~/UploadFiles/MauVT.xls");
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
        Obj.Parameter = new string[] { "@MaDV","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, rdThangNam.SelectedDate.Value.Year, rdThangNam.SelectedDate.Value.Month };
        Obj.SpName = "sp_Excel_XuatNVL_VatTu_DeleteAll";
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
            lbLoi.Text = "";
            string Maloi = "";

            int kq = 0;

            foreach (GridDataItem item in rgNhapExcel.Items)
            {
                if ((item["Chon"].FindControl("chkChon") as CheckBox).Checked)
                {
                    int Nam = rdThangNam.SelectedDate.Value.Year;
                    int Thang = rdThangNam.SelectedDate.Value.Month;
                    string MaVT = item["MaVT"].Text;
                    string TenVT = item["TenVT"].Text;
                    string MSChiPhi = item["MSChiPhi"].Text;
                    string DVT = item["DVT"].Text;
                    double SL = clsConvertHelper.ToDouble(item["SoLuong"].Text);
                    double GT = clsConvertHelper.ToDouble(item["GiaTri"].Text);
                    #region Kiểm tra trùng
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MADV", "@Nam", "@Thang", "@MaVT" };
                    Obj.ValueParameter = new object[] { txtMaBP.Text, Nam, Thang, MaVT };
                    Obj.SpName = "sp_Excel_XuatNVL_VatTu_KiemTraTrung";
                    Sql.fGetData(Obj);
                    if (Obj.Dt.Rows.Count > 0)
                    {
                        if (Maloi == "")
                        {
                            Maloi = MaVT;
                        }
                        else
                        {
                            Maloi += "; " + MaVT;
                        }
                        continue;
                    }
                    #endregion

                    #region Insert
                    Obj = new clsObj();

                    Obj.Parameter = new string[] { "@MaDV", "@NAM", "@THANG", "@MaVT", "@TenVT", "@DVT", "@MSCHIPHI", "@SoLuong", "@GiaTri" };
                    Obj.ValueParameter = new object[] { txtMaBP.Text, Nam, Thang, MaVT, TenVT, DVT, MSChiPhi, SL, GT };
                    Obj.SpName = "sp_XuatNVT_VatTu_Insert";                   
                    Sql.fNonGetData(Obj);

                    if (Obj.KetQua > 0)
                    {
                        kq++;
                        //Obj = new clsObj();
                        //Obj.Parameter = new string[] { "@TenMayTinh", "@MSCHIPHI" };
                        //Obj.ValueParameter = new object[] { fuc.fID_Cookies(), MSCHIPHI };
                        //Obj.SpName = "spDelete_Excel_CHIPHI_THUCHIEN_ByKey";
                        //Sql.fNonGetData(Obj);
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MaVT" };
                        Obj.ValueParameter = new object[] {txtMaBP.Text, Nam, Thang, MaVT };
                        Obj.SpName = "sp_Excel_XuatNVL_VatTu_Delete";
                        Sql.fNonGetData(Obj);


                    }
                    #endregion
                }
            }
            if (kq > 0)
            {
                FLoadXuatVTTheoMaDV();
                fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
                lbLoi.Text = "<font color='blue'>Nhập thành công " + kq + " dòng.</font>";

            }
            #region Thông báo
            if (Maloi != "")
            {
                lbLoi.Text += " - <font color='red'>Mã VT trùng <b><font color='black'>" + Maloi + "</font></b></font>";
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

        string MaDV = rgNhapExcel.Items[e.Item.ItemIndex]["MaDV"].Text;
        string Nam = rgNhapExcel.Items[e.Item.ItemIndex]["Nam"].Text;
        string Thang = rgNhapExcel.Items[e.Item.ItemIndex]["Thang"].Text;
        string MaVT = rgNhapExcel.Items[e.Item.ItemIndex]["MaVT"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MaVT" };
        Obj.ValueParameter = new object[] { MaDV, int.Parse(Nam), int.Parse(Thang), MaVT };
        Obj.SpName = "sp_Excel_XuatNVL_VatTu_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công .</font>";
        }
      
        fLoad_Excel_CHIPHI_THUCHIEN_ByTenMayTinh();
    }
    #endregion
    #endregion   
  
    #region tab3

    void fLoadEXcel()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam","@MaDV" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), txtMaBP.Text
          };
        Obj.SpName = "sp_XuatNVL_VatTu_XuatExcel";
        Sql.fGetData(Obj);
        RGExcel_Tab3.DataSource = Obj.Dt;
        RGExcel_Tab3.DataBind();
    }
    public void ConfigureExport()
    {
        RGExcel_Tab3.ExportSettings.ExportOnlyData = true;
        RGExcel_Tab3.ExportSettings.IgnorePaging = true;
        RGExcel_Tab3.ExportSettings.OpenInNewWindow = true;
        RGExcel_Tab3.ExportSettings.FileName = "Xuat vat tu " + txtMaBP.Text + rnNam.Text;

    }
    protected void btnExcelXem_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoadEXcel();
        ConfigureExport();
        RGExcel_Tab3.MasterTableView.ExportToExcel();

    }

    #endregion
}