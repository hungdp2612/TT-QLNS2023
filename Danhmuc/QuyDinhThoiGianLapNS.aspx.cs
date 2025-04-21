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

public partial class Danhmuc_QuyDinhThoiGianLapNS : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            rdNgayLap.SelectedDate = DateTime.Now;
            fLoad();

            //lbLoi.Text = NgayLapNSMaxCuaThangTrongDB().ToString();

            //lbLoi.Text = SoNgayHienTai().ToString();
        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] { rnNam.Text};
        Obj.SpName = "sp_MacDinhLapNS_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    public string ConvertDatedmy2(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + thang;
        return strbao;
    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {



        lbLoi.Text = "";
        string nam = rnNam.Text;
        string thang = rnThang.Text;
        DateTime ngaycn = DateTime.Now;       

        string thangthang;
        if (int.Parse(thang) < 10)
        {
            thangthang = "0"+thang;
        }
        else
        {
            thangthang = thang;
        }
        string namthangngay = nam + thangthang;
        string ngaylap =rdNgayLap.SelectedDate.Value.Year.ToString()+rdNgayLap.SelectedDate.Value.Month.ToString();        

      

        if (int.Parse(ngaylap) >= int.Parse( namthangngay))
        {
            lbLoi.Text = "<font color='red'>Ngày lập ngân sách không thể lớn hơn  <b><font color='black'> " + thangthang +"/"+ nam + "</font></b>.</font>";
            fLoad();
        }
        else
        {

            #region Insert
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@Thang", "@NgayLapNS", "@NgayCN" };
            Obj.ValueParameter = new object[] { nam, thang, rdNgayLap.SelectedDate,  ngaycn };

            Obj.SpName = "sp_MacDinhLapNS_Insert";

            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Đã có thời gian lập ngân sách tháng này rồi !!!.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thêm thời gian lập ngân sách thành công.</font>";
            }
            #endregion
            fLoad();
        }
    }
   
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {          

        lbLoi.Text = "";
        int item1;
        string nam = RG.Items[e.Item.ItemIndex]["Nam"].Text;
        string thang = RG.Items[e.Item.ItemIndex]["Thang"].Text;


        string item2;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { nam, thang };
        Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS1";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item2 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
              //  item2 = item2.ToString().Replace("/", "");
                if (SoNgayHienTai() > int.Parse(item2))
                {
                    lbLoi.Text = "<font color='red'>Không xóa được </font>";
                    fLoad();
                }
                else
                {

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@Nam", "@Thang" };
                    Obj.ValueParameter = new object[] { nam, thang };
                    Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS";
                    Sql.fGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        try
                        {
                            item1 = int.Parse(Obj.Dt.Rows[0]["KiemTraNgayLapNS"].ToString());

                            if (item1 == 0)
                            {
                                Obj = new clsObj();
                                Obj.Parameter = new string[] { "@Nam", "@Thang" };
                                Obj.ValueParameter = new object[] { nam, thang };
                                Obj.SpName = "sp_MacDinhLapNS_Delete";
                                Sql.fNonGetData(Obj);
                                if (Obj.KetQua < 1)
                                {
                                    lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
                                }
                                else
                                {
                                    lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
                                }
                                fLoad();
                            }
                            else
                            {
                                lbLoi.Text = "<font color='red'>Không thể xóa vì tháng <b><font color='black'> " + thang + "</font></b> đang được thực hiện.</font>";
                                fLoad();
                            }
                        }
                        catch { }
                    }
                    else { }
                }
            }
            catch { }
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
    protected void txtNam_TextChanged(object sender, EventArgs e)
    {
       
        fLoad();
    }
    public string ConvertDatedmy(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + "/" + thang + "/" + ngay;
        return strbao;
    }
   
    int SoNgayHienTai()
    {

        string result = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString();
        return Convert.ToInt32(result);
    }  
    
    
    protected void RG_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        int item1;
        try
        {
            lbLoi.Text = "";
            UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
            TextBox txtNam = userControl.FindControl("txtNam") as TextBox;
            TextBox txtThang = userControl.FindControl("txtThang") as TextBox;
            Telerik.Web.UI.RadDatePicker rdngaylap = userControl.FindControl("rdNgayLap") as Telerik.Web.UI.RadDatePicker;

            CheckBox HieuLuc = userControl.FindControl("ChkHieuLuc") as CheckBox;

            DateTime ngaycn = DateTime.Now;

            bool hieuluc = false;
            if (HieuLuc.Checked)
            {
                hieuluc = true;
            }
            else
            {
                hieuluc = false;
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
            string namthangngay = txtNam.Text + thangthang;
            string ngaylap = Convert.ToDateTime(rdngaylap.SelectedDate.ToString()).Year.ToString() + Convert.ToDateTime(rdngaylap.SelectedDate.ToString()).Month.ToString();        



            if (int.Parse(ngaylap) >= int.Parse(namthangngay))
            {
                lbLoi.Text = "<font color='red'>Cập nhật ngày lập ngân sách không thể lớn hơn  <b><font color='black'> " + thangthang + "/" + txtNam.Text + "</font></b>.</font>";
                fLoad();
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
                        //item2 = ConvertDatedmy(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());
                        //item2 = item2.ToString().Replace("/", "");
                        item2 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                        if (SoNgayHienTai() > int.Parse(item2))
                        {
                            lbLoi.Text = "<font color='red'>Không thể cập nhật vì tháng <b><font color='black'> " + txtThang.Text + "</font></b> đã hết thời gian lập ngân sách.</font>";
                            fLoad();
                        }
                        else
                        {
                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@Nam", "@Thang" };
                            Obj.ValueParameter = new object[] { txtNam.Text, txtThang.Text };
                            Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNgayLapNS";
                            Sql.fGetData(Obj);
                            if (Obj.KetQua < 1)
                            {
                                try
                                {
                                    item1 = int.Parse(Obj.Dt.Rows[0]["KiemTraNgayLapNS"].ToString());
                                    if (item1 == 0)
                                    {
                                        #region Insert
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@Nam", "@Thang", "@NgayLapNS", "@HieuLuc", "@NgayCN" };
                                        Obj.ValueParameter = new object[] { txtNam.Text, txtThang.Text, rdngaylap.SelectedDate, hieuluc, ngaycn };
                                        Obj.SpName = "sp_MacDinhLapNS_Update";

                                        Sql.fNonGetData(Obj);
                                        if (Obj.KetQua < 1)
                                        {
                                            lbLoi.Text = "<font color='red'>Cập nhật thời gian lập ngân sách thất bại. Vui lòng thử lại sau.</font>";
                                        }
                                        else
                                        {
                                            lbLoi.Text = "<font color='blue'>Cập nhật thời gian lập ngân sách thành công.</font>";
                                        }
                                        #endregion
                                        fLoad();
                                    }
                                    else
                                    {
                                        lbLoi.Text = "<font color='red'>Không thể cập nhật thời gian ngân sách vì tháng <b><font color='black'> " + txtThang.Text + "</font></b> đang được thực hiện.</font>";
                                        fLoad();
                                    }
                                }
                                catch { }

                            }
                            else
                            {
                                lbLoi.Text = "<font color='red'>Có lỗi xảy ra.</font>";
                            }
                        }


                    }
                    catch { }
                }
            }

        }
        catch { }
   

    }
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {       
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {            
            EditCommandColumn e1 = new EditCommandColumn();
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/QuyDinhThoiGianLapNS_Update.ascx";
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
    protected void RG_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }
}