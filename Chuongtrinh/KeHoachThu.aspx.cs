using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using Telerik.Web.UI;
using System.IO;
using System.Data;
using System.Data.OleDb;

public partial class Chuongtrinh_KeHoachThu : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FLOAD_MABP1();
            rThangNam.SelectedDate = DateTime.Now;
            fLoad();


            FLOAD_MABP();
            FLOAD_KEHOACHTHU_EXCECL();
        }
    }

    #region TAB1
    void FLOAD_MABP1()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { "" };
        Obj.SpName = "spLoad_BoPhan";
        Sql.fGetData(Obj);
        cbBoPhan1.DataSource = Obj.Dt;
        cbBoPhan1.DataBind();
        cbBoPhan1.SelectedIndex = 0;
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV", "@Nam" };
        Obj.ValueParameter = new object[] {cbBoPhan1.SelectedValue, rThangNam.SelectedDate.Value.Year };
        Obj.SpName = "spLoad_KeHoachThu_ByThangNam";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void cbBoPhan1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoad();
    }

    protected void btnInsert_Click(object sender, ImageClickEventArgs e)
    {
        #region Kiểm tra trùng mã
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP" };
        Obj.ValueParameter = new object[] { rThangNam.SelectedDate.Value.Month, rThangNam.SelectedDate.Value.Year, cbBoPhan1.SelectedValue };
        Obj.SpName = "spLoad_KeHoachThu_ByID";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có bộ phận <font color='black'><b>" + cbBoPhan1.SelectedValue + "</b></font>. Vui lòng thử lại sau.</font>";
            fLoad();
            return;
        }
        #endregion
        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP", "@SoTien", "@ThucThu", "@DienGiai" };
        Obj.ValueParameter = new object[] { rThangNam.SelectedDate.Value.Month, rThangNam.SelectedDate.Value.Year, cbBoPhan1.SelectedValue, rnSoTien.Value,rnThucThu.Value, tbDienGiai.Text };
        Obj.SpName = "spInsert_KeHoachThu";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Thêm thất bại bộ phận <font color='black'><b>" + cbBoPhan1.SelectedValue + "</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm thành công bộ phận <font color='black'><b>" + cbBoPhan1.SelectedValue + "</b></font>.</font>";
        }
        fLoad();
        #endregion
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
        int Thang = clsConvertHelper.ToInt( RG.Items[e.Item.ItemIndex]["Thang"].Text);
        int Nam = clsConvertHelper.ToInt( RG.Items[e.Item.ItemIndex]["Nam"].Text);
        string MABP = RG.Items[e.Item.ItemIndex]["MABP"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP" };
        Obj.ValueParameter = new object[] { Thang, Nam, MABP };
        Obj.SpName = "spDelete_KeHoachThu";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại bộ phận <font color='black'><b>" + MABP + "</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công bộ phận <font color='black'><b>" + MABP + "</b></font>.</font>";
        }
        fLoad();
    }
    protected void RG_InsertCommand(object source, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
        int Thang = rThangNam.SelectedDate.Value.Month;
        int Nam = rThangNam.SelectedDate.Value.Year;
        string MABP = (userControl.FindControl("cbBoPhan") as RadComboBox).SelectedValue.Trim();
        double SoTien = clsConvertHelper.ToDouble((userControl.FindControl("rnSoTien") as RadNumericTextBox).Value.ToString());
        string DienGiai = (userControl.FindControl("tbDienGiai") as TextBox).Text.Trim();
        #region Kiểm tra trùng mã
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP" };
        Obj.ValueParameter = new object[] { Thang, Nam, MABP };
        Obj.SpName = "spLoad_KeHoachThu_ByID";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có bộ phận <font color='black'><b>" + MABP + "</b></font>. Vui lòng thử lại sau.</font>";
            fLoad();
            return;
        }
        #endregion
        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP", "@SoTien", "@DienGiai" };
        Obj.ValueParameter = new object[] { Thang, Nam, MABP, SoTien, DienGiai };
        Obj.SpName = "spInsert_KeHoachThu";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Thêm thất bại bộ phận <font color='black'><b>"+MABP+"</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm thành công bộ phận <font color='black'><b>" + MABP + "</b></font>.</font>";
        }
        #endregion
        fLoad();
    }
    protected void RG_ItemCommand(object source, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case RadGrid.InitInsertCommandName:
                RG.MasterTableView.ClearEditItems();
                e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/InsertKeHoachThu.ascx";
                e.Item.OwnerTableView.InsertItem();
                fLoad();
                break;
            case RadGrid.EditCommandName:
                RG.MasterTableView.IsItemInserted = false;
                e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/UpdateKeHoachThu.ascx";
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
        UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);
        int Thang = rThangNam.SelectedDate.Value.Month;
        int Nam = rThangNam.SelectedDate.Value.Year;
        string MABP = (userControl.FindControl("cbBoPhan") as RadComboBox).SelectedValue.Trim();
        double SoTien = clsConvertHelper.ToDouble((userControl.FindControl("rnSoTien") as RadNumericTextBox).Value.ToString());
        double ThucThu = clsConvertHelper.ToDouble((userControl.FindControl("rnThucThu") as RadNumericTextBox).Value.ToString());
        string DienGiai = (userControl.FindControl("tbDienGiai") as TextBox).Text.Trim();
        #region Update
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam", "@MABP", "@SoTien", "@ThucThu", "@DienGiai" };
        Obj.ValueParameter = new object[] { Thang, Nam, MABP, SoTien, ThucThu, DienGiai };
        Obj.SpName = "spEdit_KeHoachThu";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại bộ phận <font color='black'><b>" + MABP + "</b></font>. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công bộ phận <font color='black'><b>" + MABP + "</b></font>.</font>";
        }
        #endregion
        fLoad();
    }
    protected void RG_GroupsChanging(object source, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
    protected void RG_SortCommand(object source, GridSortCommandEventArgs e)
    {
        fLoad();
    }
    protected void rThangNam_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        fLoad();
    }
    #endregion

    #region TAB2

    void FLOAD_MABP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { "" };
        Obj.SpName = "spLoad_BoPhan";
        Sql.fGetData(Obj);
        cbBoPhan.DataSource = Obj.Dt;
        cbBoPhan.DataBind();
        cbBoPhan.SelectedIndex = 0;
    }

    protected void cbBoPhan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLOAD_KEHOACHTHU_EXCECL();
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
             
                for (int i = 1; i < table.Rows.Count; i++)
                {                   
                    double DOANHTHU = clsConvertHelper.ToDouble(table.Rows[i][0].ToString().ToUpper());
                    double THUCTHU = clsConvertHelper.ToDouble(table.Rows[i][1].ToString().ToUpper());
                    int NAM = clsConvertHelper.ToInt(table.Rows[i][2].ToString().ToUpper());
                    int THANG = clsConvertHelper.ToInt(table.Rows[i][3].ToString().ToUpper());   
                    string Ghichu = table.Rows[i][4].ToString().ToUpper();
                    
                   
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@THANG", "@NAM", "@MABP", "@DOANHTHU","@THUCTHU", "@GHICHU", "@MANV" };
                    Obj.ValueParameter = new object[] { THANG, NAM, cbBoPhan.SelectedValue, DOANHTHU,THUCTHU, Ghichu, Session["UserID"].ToString() };
                    Obj.SpName = "SP_KEHOACHTHU_EXCEL_INSERT";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                       
                    }

                    
                }
                FLOAD_KEHOACHTHU_EXCECL();             
            }
            else
            {
                lbLoi.Text = "<font color='red'>Không có dữ liệu.</font>";
                return;
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }
    }
    void FLOAD_KEHOACHTHU_EXCECL()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV"};
        Obj.ValueParameter = new object[] { cbBoPhan.SelectedValue };
        Obj.SpName = "SP_KEHOACHTHU_EXCEL_BY_MANV";
        Sql.fGetData(Obj);
        RG_EXCEL.DataSource = Obj.Dt;
        RG_EXCEL.DataBind();
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
                FLOAD_KEHOACHTHU_EXCECL();
            }

        }
    }
    protected void btnExportMau_Click(object sender, ImageClickEventArgs e)
    {
        string path = Server.MapPath("~/UploadFiles/MAUDOANHTHU.xls");
       
        System.IO.FileInfo file = new System.IO.FileInfo(path);      
        if (file.Exists)
        {
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(file.FullName);
            Response.End();
           
        }
        else
        {
            Response.Write("This file does not exist.");
        }
    }
    protected void btXoaTatCaExcel_Click(object sender, ImageClickEventArgs e)
    {    
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV", "@MANV" };
        Obj.ValueParameter = new object[] { cbBoPhan.SelectedValue, Session["UserID"].ToString()};
        Obj.SpName = "SP_KEHOACHTHU_EXCEL_DELETE_BY_MANV_MADV";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại.</font>";
        }

        FLOAD_KEHOACHTHU_EXCECL();
        return;
    }
    protected void btnNhapDuLieu_Click(object sender, ImageClickEventArgs e)
    {
        string Maloi = "";

        int kq = 0;

        foreach (GridDataItem item in RG_EXCEL.Items)
        {

            int Nam = int.Parse(item["NAM"].Text);
            int Thang = int.Parse(item["THANG"].Text);
            double SOTIEN = clsConvertHelper.ToDouble(item["SOTIEN"].Text);
            double THUCTHU = clsConvertHelper.ToDouble(item["THUCTHU"].Text);
            string GhiChu = item["GhiChu"].Text;

            #region Kiểm tra trùng
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MADV", "@Nam","@Thang" };
            Obj.ValueParameter = new object[] { cbBoPhan.SelectedValue, Nam, Thang };
            Obj.SpName = "SP_KEHOACHTHU_KIEMTRA_BY_ID";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                if (Maloi == "")
                {
                    Maloi = Nam.ToString() + "-" + Thang.ToString();
                }
                else
                {
                    Maloi += "; " + Nam.ToString() + "-" + Thang.ToString();
                }
                continue;
            }
            #endregion

            #region Insert
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MABP", "@NAM", "@THANG", "@SOTIEN","@THUCTHU", "@DienGiai" };
            Obj.ValueParameter = new object[] { cbBoPhan.SelectedValue, Nam, Thang, SOTIEN, THUCTHU, GhiChu };
            Obj.SpName = "spInsert_KeHoachThu";
            Sql.fNonGetData(Obj);

            if (Obj.KetQua > 0)
            {
                kq++;
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@MANV", "@MADV" };
                Obj.ValueParameter = new object[] { Session["UserID"].ToString(), cbBoPhan.SelectedValue };
                Obj.SpName = "SP_KEHOACHTHU_EXCEL_DELETE_BY_MANV_MADV";
                Sql.fNonGetData(Obj);
            }
            #endregion

        }
        if (kq > 0)
        {
            fLoad();
            FLOAD_KEHOACHTHU_EXCECL();
            lbLoi.Text = "<font color='blue'>Nhập thành công " + kq + " dòng.</font>";

        }
        #region Thông báo
        if (Maloi != "")
        {
            lbLoi.Text += " - <font color='red'Đã có năm tháng này rồi <b><font color='black'>" + Maloi + "</font></b></font>";
        }
        #endregion
    }   

    protected void RG_EXCEL_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int NAM =int.Parse(RG_EXCEL.Items[e.Item.ItemIndex]["Nam"].Text);
        int Thang = int.Parse(RG_EXCEL.Items[e.Item.ItemIndex]["Thang"].Text);
        string Madv = cbBoPhan.SelectedValue;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV","@NAM","@THANG" };
        Obj.ValueParameter = new object[] { Madv,NAM,Thang };
        Obj.SpName = "SP_KEHOACHTHU_EXECL_DELETE_BY_ID";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
        }      

        FLOAD_KEHOACHTHU_EXCECL();
    }


    #endregion

  
}