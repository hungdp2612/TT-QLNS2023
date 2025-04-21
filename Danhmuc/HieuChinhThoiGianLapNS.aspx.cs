using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Web.UI.WebControls.WebParts;
using System.Web.Configuration;
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;

public partial class Danhmuc_HieuChinhThoiGianLapNS : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rnNam.Text = DateTime.Now.Year.ToString();
            rnThang.Text = DateTime.Now.Month.ToString();
            rdNgayLap.SelectedDate = DateTime.Now;
          
            fLoadByNam();
            FLOAD_DONVI_COMBOBOX("");
            fLoad();
        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "MaDV", "@Nam" };
        Obj.ValueParameter = new object[] { cbMaDV.SelectedValue, rnNam.Text };
        Obj.SpName = "sp_HieuChinhNgayLapNS_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    void fLoadByNam()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] { rnNam.Text };
        Obj.SpName = "sp_HieuChinhNgayLapNS_LoadByNam";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    public string ConvertDatedmy2(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + thang + ngay;
        return strbao;
    }
    public string ConvertDatedmy3(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + thang;
        return strbao;
    }
    string item2;
    int NgayLapNSTrongDB()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS1";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                string mm, dd;
                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                {
                    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }
                else
                {
                    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }


                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                {
                    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }
                else
                {
                    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }
                item2 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + mm + dd;
               // item2 = ConvertDatedmy2(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());

            }
            catch { }
        }
        return Convert.ToInt32(item2);
    }


    string item3;
    int KeHoachNS_HieuChinhNgayLap()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { cbMaDV.SelectedValue, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_MacDinhNgayLapNS_KeHoachNS_KiemTra";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item3 = Obj.Dt.Rows[0]["DemKeHoachNS"].ToString();

            }
            catch { }
        }
        return Convert.ToInt32(item3);
    }

    int SoNgayHienTai()
    {

        string mm, dd;
        if (DateTime.Now.Month < 10)
        {
            mm = "0" + DateTime.Now.Month.ToString();
        }
        else
        {
            mm = DateTime.Now.Month.ToString();
        }


        if (DateTime.Now.Day < 10)
        {
            dd = "0" + DateTime.Now.Day.ToString();
        }
        else
        {
            dd = DateTime.Now.Day.ToString();
        }
        string result = DateTime.Now.Year.ToString() + mm + dd;
        return Convert.ToInt32(result);
    }

    string layngaylapnscuathang;


    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        //string ngaylap = ConvertDatedmy2(rdNgayLap.SelectedDate.ToString());

        string mm, dd;
        if (Convert.ToDateTime(rdNgayLap.SelectedDate).Month < 10)
        {
            mm = "0" + Convert.ToDateTime(rdNgayLap.SelectedDate).Month.ToString();
        }
        else
        {
            mm = Convert.ToDateTime(rdNgayLap.SelectedDate).Month.ToString();
        }


        if (Convert.ToDateTime(rdNgayLap.SelectedDate).Day < 10)
        {
            dd = "0" + Convert.ToDateTime(rdNgayLap.SelectedDate).Day.ToString();
        }
        else
        {
            dd = Convert.ToDateTime(rdNgayLap.SelectedDate).Day.ToString();
        }

        string ngaylap = Convert.ToDateTime(rdNgayLap.SelectedDate.ToString()).Year.ToString() + mm + dd;

        // lbLoi.Text = ngaylap.ToString();
        string nam = rnNam.Text;
        string thang = rnThang.Text;      
    
        string thangthang;
        if (int.Parse(thang) < 10)
        {
            thangthang = "0" + thang;
        }
        else
        {
            thangthang = thang;
        }
        string namthang = nam + thangthang;      

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { nam, thang };
        Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS1";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                layngaylapnscuathang = ConvertDatedmy2(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());

            }
            catch { }

            if (layngaylapnscuathang == null)
            {
                lbLoi.Text = "<font color='red'>Ngày lập ngân sách chưa được lập nên không thể hiệu chỉnh được.</font>";
                fLoad();
            }
            else
            {
                //if (SoNgayHienTai() > int.Parse(layngaylapnscuathang))
                //{
                //    lbLoi.Text = "<font color='red'>Không thể thêm hiệu chỉnh vì tháng <b><font color='black'> " + thang + "</font></b> đã hết thời gian lập ngân sách.</font>";
                //    fLoad();
                //}
                //else
                //{

                if (KeHoachNS_HieuChinhNgayLap() == 0)
                {
                    if (int.Parse(ngaylap) <= NgayLapNSTrongDB())
                    {
                        lbLoi.Text = "<font color='red'>Ngày hiệu chỉnh không thể nhỏ hơn hoặc bằng ngày lập ngân sách.</font>";
                        fLoad();
                    }
                    else
                    {
                        


                        #region Insert
                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MANV", "@NgayHieuChinh","@MABP" };
                        Obj.ValueParameter = new object[] { cbMaDV.SelectedValue, nam, thang, Session["UserID"].ToString(), rdNgayLap.SelectedDate, cbMABP.SelectedValue };

                        Obj.SpName = "sp_HieuChinhNgayLapNS_Insert";

                        Sql.fNonGetData(Obj);
                        if (Obj.KetQua < 1)
                        {
                            lbLoi.Text = "<font color='red'>Hiệu chỉnh ngân sách tháng <b><font color='black'> " + thang + "</font></b> đã có trong danh sách. Vui lòng thử lại sau.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='blue'>Thêm hiệu chỉnh ngân sách thành công.</font>";
                        }
                        #endregion
                        fLoad();
                    }
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Ngân sách tháng <b><font color='black'> " + thang + "</font></b> đã xem xét nên không thể hiệu chỉnh được.</font>";
                    fLoad();

                }
                //}
            }
        }
        // }

    }
 
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        int item1;
        string madv = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
        string nam = RG.Items[e.Item.ItemIndex]["Nam"].Text;
        string thang = RG.Items[e.Item.ItemIndex]["Thang"].Text;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { madv, nam, thang };
        Obj.SpName = "sp_MacDinhNgayLapNS_HieuChinhNgayLapNS";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item1 = int.Parse(Obj.Dt.Rows[0]["HieuChinhNgayLapNS"].ToString());

                if (item1 == 0)
                {
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
                    Obj.ValueParameter = new object[] { madv, nam, thang };
                    Obj.SpName = "sp_HieuChinhNgayLapNS_Delete";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
                        fLoadByNam();
                    }

                }
                else
                {
                    lbLoi.Text = "<font color='red'>Không thể xóa vì tháng <b><font color='black'> " + thang + "/" + nam + "</font></b> đã được lập.</font>";
                    fLoadByNam();
                }
            }
            catch { }
        }


    }
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/HieuChinhThoiGianLapNS_Update.ascx";
            fLoadByNam();

        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            fLoadByNam();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoadByNam();
        }
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



    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }


    private void FLOAD_DONVI_COMBOBOX(string  KEY)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@KEY" };
        Obj.ValueParameter = new object[] { KEY };
        Obj.SpName = "SP_KEHOACHCHIPHI_LOAD_COMBOBOX_DONVI";
        Sql.fGetData(Obj);
        cbMaDV.DataSource = Obj.Dt;
        cbMaDV.DataBind();
        cbMaDV.SelectedIndex = 0;
    }
    void loadMABP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDDV" };
        Obj.ValueParameter = new object[] { cbMaDV.SelectedValue };
        Obj.SpName = "SP_LoadShowroom_DV30";
        Sql.fGetData(Obj);
        cbMABP.DataSource = Obj.Dt;
        cbMABP.DataBind();
        cbMABP.SelectedIndex = 0;
    }
    protected void cbMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if(cbMaDV.SelectedValue == "KDND")
        {
            //cbMABP.Visible = true;
            tdmabp.Attributes.Add("style", "display:normal");
        }
        else
        {
            tdmabp.Attributes.Add("style", "display:none");
        }    
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam" };
        Obj.ValueParameter = new object[] { cbMaDV.SelectedValue, rnNam.Text };
        Obj.SpName = "sp_HieuChinhNgayLapNS_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void cbMaDV_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        FLOAD_DONVI_COMBOBOX(e.Text);

    }

    string item4;
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

        try
        {
            lbLoi.Text = "";
            UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
            TextBox txtMaDV = userControl.FindControl("txtMaDV") as TextBox;
            TextBox txtNam = userControl.FindControl("txtNam") as TextBox;
            TextBox txtThang = userControl.FindControl("txtThang") as TextBox;
            Telerik.Web.UI.RadDatePicker rdngayhieuchinh = userControl.FindControl("rdNgayHieuChinh") as Telerik.Web.UI.RadDatePicker;
            CheckBox HieuLuc = userControl.FindControl("ChkHieuLuc") as CheckBox;

            int item1;
            int hieuluc = 0;
            if (HieuLuc.Checked)
            {
                hieuluc = 1;
            }
            else
            {
                hieuluc = 0;
            }

            string thangthang;
            if (int.Parse(txtThang.Text) < 10)
            {
                thangthang = "0" + txtThang.Text;
            }
            else
            {
                thangthang = txtThang.Text;
            }
            string namthang = txtNam.Text + thangthang;


            string mm, dd;
            if (Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Month < 10)
            {
                mm = "0" + Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Month.ToString();
            }
            else
            {
                mm = Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Month.ToString();
            }


            if (Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Day < 10)
            {
                dd = "0" + Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Day.ToString();
            }
            else
            {
                dd = Convert.ToDateTime(rdngayhieuchinh.SelectedDate).Day.ToString();
            }

            string ngaylapnamthang = Convert.ToDateTime(rdngayhieuchinh.SelectedDate.ToString()).Year.ToString() + mm + dd;

           // string ngaylapnamthang = ConvertDatedmy3(rdngayhieuchinh.SelectedDate.ToString());


            //if (int.Parse(ngaylapnamthang) >= int.Parse(namthang))
            //{
            //    lbLoi.Text = "<font color='red'>Hiệu chỉnh ngày lập ngân sách không thể lớn hơn  <b><font color='black'> " + thangthang + "/" + txtNam.Text + "</font></b>.</font>";
            //    fLoadByNam();
            //}
            //else
            //{

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
            Obj.ValueParameter = new object[] { txtMaDV.Text, txtNam.Text, txtThang.Text };
            Obj.SpName = "sp_MacDinhNgayLapNS_HieuChinhNgayLapNS";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {
                    item1 = int.Parse(Obj.Dt.Rows[0]["HieuChinhNgayLapNS"].ToString());

                    if (item1 == 0)//Ngân sách chưa được lập
                    {

                        Obj = new clsObj();
                        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
                        Obj.ValueParameter = new object[] { txtMaDV.Text, txtNam.Text, txtThang.Text };
                        Obj.SpName = "sp_MacDinhNgayLapNS_KeHoachNS_KiemTraHieuLucXemXet";
                        Sql.fGetData(Obj);
                        if (Obj.KetQua < 1)
                        {
                            try
                            {

                                item4 = Obj.Dt.Rows[0]["Nam"].ToString();

                            }
                            catch { }
                        }

                        else
                        {

                        }

                        if (item4 == null || item4 == "")
                        {
                            string item2;
                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@Nam", "@Thang" };
                            Obj.ValueParameter = new object[] { txtNam.Text, txtThang.Text };
                            Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS1";
                            Sql.fGetData(Obj);
                            if (Obj.KetQua < 1)
                            {
                                try
                                {

                                    string mm1, dd1;
                                    if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                                    {
                                        mm1 = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                                    }
                                    else
                                    {
                                        mm1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                                    }


                                    if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                                    {
                                        dd1 = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                                    }
                                    else
                                    {
                                        dd1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                                    }
                                    item2 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + mm1 + dd1;

                                   // item2 = ConvertDatedmy2(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());


                                    if (int.Parse(ngaylapnamthang) <= int.Parse(item2))
                                    {
                                        lbLoi.Text = "<font color='red'>Ngày hiệu chỉnh không thể nhỏ hơn hoặc bằng ngày lập ngân sách.</font>";
                                        fLoadByNam();
                                    }
                                    else
                                    {
                                        #region Insert
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@NgayHieuChinh", "@Hieuluc" };
                                        Obj.ValueParameter = new object[] { txtMaDV.Text, txtNam.Text, txtThang.Text, rdngayhieuchinh.SelectedDate, hieuluc };

                                        Obj.SpName = "sp_HieuChinhNgayLapNS_Update";

                                        Sql.fNonGetData(Obj);
                                        if (Obj.KetQua < 1)
                                        {
                                            lbLoi.Text = "<font color='red'>Cập nhật thời gian hiệu chỉnh ngân sách thất bại. Vui lòng thử lại sau.</font>";
                                        }
                                        else
                                        {
                                            lbLoi.Text = "<font color='blue'>Cập nhật thời gian hiệu chỉnh ngân sách thành công.</font>";
                                        }
                                        #endregion
                                        fLoadByNam();
                                    }

                                }
                                catch { }
                            }
                        }
                        else
                        {
                            bool xx;
                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
                            Obj.ValueParameter = new object[] { txtMaDV.Text, txtNam.Text, txtThang.Text };
                            Obj.SpName = "sp_MacDinhNgayLapNS_KeHoachNS_KiemTraHieuLucXemXet";
                            Sql.fGetData(Obj);

                            if (Obj.KetQua < 1)
                            {
                                try
                                {
                                    xx = bool.Parse(Obj.Dt.Rows[0]["Hieuluc_XX"].ToString());

                                    if (xx == true)
                                    {
                                        lbLoi.Text = "<font color='red'>Ngân sách tháng <b><font color='black'> " + txtThang.Text + "</font></b> đã được xem xét nên không thể hiệu chỉnh.</font>";
                                        fLoadByNam();
                                    }
                                    else
                                    {

                                        string item2;
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@Nam", "@Thang" };
                                        Obj.ValueParameter = new object[] { txtNam.Text, txtThang.Text };
                                        Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS1";
                                        Sql.fGetData(Obj);
                                        if (Obj.KetQua < 1)
                                        {
                                            try
                                            {
                                                string mm1, dd1;
                                                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                                                {
                                                    mm1 = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                                                }
                                                else
                                                {
                                                    mm1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                                                }


                                                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                                                {
                                                    dd1 = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                                                }
                                                else
                                                {
                                                    dd1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                                                }
                                                item2 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + mm1 + dd1;

                                              //  item2 = ConvertDatedmy2(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());
                                                if (int.Parse(ngaylapnamthang) <= int.Parse(item2))
                                                {
                                                    lbLoi.Text = "<font color='red'>Ngày hiệu chỉnh không thể nhỏ hơn hoặc bằng ngày lập ngân sách.</font>";
                                                    fLoadByNam();
                                                }
                                                else
                                                {
                                                    #region Insert
                                                    Obj = new clsObj();
                                                    Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@NgayHieuChinh", "@Hieuluc" };
                                                    Obj.ValueParameter = new object[] { txtMaDV.Text, txtNam.Text, txtThang.Text, rdngayhieuchinh.SelectedDate, hieuluc };

                                                    Obj.SpName = "sp_HieuChinhNgayLapNS_Update";

                                                    Sql.fNonGetData(Obj);
                                                    if (Obj.KetQua < 1)
                                                    {
                                                        lbLoi.Text = "<font color='red'>Cập nhật thời gian hiệu chỉnh ngân sách thất bại. Vui lòng thử lại sau.</font>";
                                                    }
                                                    else
                                                    {
                                                        lbLoi.Text = "<font color='blue'>Cập nhật thời gian hiệu chỉnh ngân sách thành công.</font>";
                                                    }
                                                    #endregion
                                                    fLoadByNam();
                                                }

                                            }
                                            catch { }
                                        }

                                    }

                                }
                                catch
                                {

                                }
                            }
                            else
                            {

                            }
                        }
                    }
                    else // Ngân sách đã đươc lập
                    {
                        lbLoi.Text = "<font color='red'>Không thể cập nhật vì tháng <b><font color='black'> " + txtThang.Text + "/" + txtNam.Text + "</font></b> đã được lập.</font>";
                        fLoadByNam();
                    }
                }
                catch { }
            }
            //  }

        }
        catch { }

    }

    protected void cbMABP_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        loadMABP();
    }

 
}
