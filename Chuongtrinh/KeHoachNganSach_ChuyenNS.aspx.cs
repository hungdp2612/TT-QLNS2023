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
using System.Data;
using Telerik.Web.UI;


public partial class Chuongtrinh_KeHoachNganSach_ChuyenNS : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            rnThangMoi.Text = DateTime.Now.AddMonths(0).Month.ToString();
            rnNamMoi.Text = DateTime.Now.AddMonths(0).Year.ToString();

            fLoadMaDV();
            FLoadMaBPByIDCS();

            fLoadPhuTrachDonVi();
            LoadNguoiPheDuyetTheoPhongBan();
            fLoadThangTruoc();
            fLoad_NSThangTruoc();
            fLoad();
         
        }
      
         
    }
    public double fInt(object Value)
    {
        return Convert.ToDouble(Value.ToString());
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.SpName = "sp_ChuyenKeHoachNganSach_LoadNguoiXemXet";
        Sql.fGetData(Obj);
        cbXemXet.DataSource = Obj.Dt;
        cbXemXet.DataBind();
    }
    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.Connectionstring = wqlvattu;      
        Obj.SpName = "sp_ToTrinh_KeToan_GetThongTinNguoiPheDuyet3";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                cbNguoiPheDuyet.DataSource = Obj.Dt;
                cbNguoiPheDuyet.DataBind();
                //txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
                //txtBoPhanNhan.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            }
            catch { }
        }
        else
        {

        }


    }
    void fLoadThangTruoc()
    {
        DateTime Moi = new DateTime(int.Parse(rnNamMoi.Text), int.Parse(rnThangMoi.Text), 01);
        DateTime Cu = Moi.AddMonths(-1);
        rnThangCu.Value = Cu.Month;
        rnNamCu.Value = Cu.Year;
    }
    void fLoad_NSThangTruoc()
    {

        //string IDMaCS;

        //if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        //{
        //    IDMaCS = txtIDMaCS.Text;
        //}
        //else
        //{
        //    IDMaCS = txtMaBP.Text;
        //}
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, int.Parse(rnNamCu.Text), int.Parse(rnThangCu.Text) };
        //Obj.SpName = "sp_ChuyenKeHoachNganSach_Load_MaCP";
        Obj.SpName = "sp_ChuyenKeHoachNganSach_Load_MaCP_040515";
        Sql.fGetData(Obj);
        RG_ThangTruoc.DataSource = Obj.Dt;
        RG_ThangTruoc.DataBind();
    }
    void fLoad()
    {

        //string IDMaCS;

        //if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        //{
        //    IDMaCS = txtIDMaCS.Text;
        //}
        //else
        //{
        //    IDMaCS = txtMaBP.Text;
        //}
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaBP","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, int.Parse(rnNamMoi.Text), int.Parse(rnThangMoi.Text) };
        Obj.SpName = "sp_ChuyenKeHoachNganSach_Load_NSChuyen";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }


    void fLoadMaDV()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        // Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV";
        //Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV_AndMaBP";
        Obj.SpName = "sp_ToTrinh_KeToan_LayMaDV_AndMaBP2";
        Sql.fGetData(Obj);
        ddlMaDV.DataSource = Obj.Dt;
        ddlMaDV.DataBind();
        // ddlMaDV.Items.RemoveAt(0);
    }  


    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
           
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/KeHoachNganSach_ChuyenNS_Update.ascx";
            fLoad();

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoad();
        }

    }
   
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {


        string ID_khoaCT = RG.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        string MaNV = RG.Items[e.Item.ItemIndex]["MaNV"].Text;

        if (MaNV != Session["UserID"].ToString())
        {
            lbLoi.Text = "<font color='Red'>Bạn không xóa của người khác được.</font>";
            fLoad();
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { ID_khoaCT };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
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
            fLoad_NSThangTruoc();

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
   
    void FLoadMaBPByIDCS()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };

        Obj.SpName = "sp_ChuyenKeHoachNganSach_GetMaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();

            }
            catch { }

        }
    }
    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbXemXet.Text = "";
        cbNguoiPheDuyet.Text = "";
        //txtBoPhanNhan.Text = "";
        //txtChucVuNguoiNhan.Text = "";      
        FLoadMaBPByIDCS();

        fLoadPhuTrachDonVi();
        LoadNguoiPheDuyetTheoPhongBan();

        fLoad_NSThangTruoc();
        fLoad();
       
    }
    protected void rnThangCu_TextChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoad_NSThangTruoc();
    }
    protected void rnNamCu_TextChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoad_NSThangTruoc();
    }
    string  id_khoaCT;
    protected void btLay_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        if (int.Parse(rnNamMoi.Text) > int.Parse(rnNamMoi.Text))
        {
            lbLoi.Text = "<font color='red'>Không thể chuyển ngân sách năm" + rnNamMoi.Text + " xuống năm " + rnNamMoi.Text + " được.</font>";
        }
        else
        {

            if (int.Parse(rnNamCu.Text) == int.Parse(rnNamMoi.Text) && int.Parse(rnThangCu.Text) == int.Parse(rnThangMoi.Text))
            {
                lbLoi.Text = "<font color='red'>" + "Không chuyển ngân sách cùng tháng được." + "</font>";
            }
            else if (int.Parse(rnNamCu.Text) == int.Parse(rnNamMoi.Text) && int.Parse(rnThangCu.Text) > int.Parse(rnThangMoi.Text))
            {
                lbLoi.Text = "<font color='red'>Không thể chuyển ngân sách tháng" + rnThangCu.Text + " xuống tháng " + rnThangMoi.Text + " được.</font>";
            }

            else
            {

                //#region Lấy khóa ngân sách cần chuyên
                //Obj = new clsObj();
                //Obj.Parameter = new string[] { "@MaBP", "@Nam", "@Thang" };
                //Obj.ValueParameter = new object[] { txtMaBP.Text, int.Parse(rnNamMoi.Text), int.Parse(rnThangMoi.Text) };
                //Obj.SpName = "sp_ChuyenKeHoachNganSach_GetIDKhoa_ByNamThangMaDV";
                //Sql.fGetData(Obj);
                //if (Obj.KetQua < 1)
                //{

                //    idkhoa = Obj.Dt.Rows[0]["ID_Khoa"].ToString();
                //}
                //#endregion
                string idkhoa = ddlMaDV.SelectedValue + "-" + rnNamMoi.Text + rnThangMoi.Text;

                for (int i = 0; i < RG_ThangTruoc.Items.Count; i++)
                {
                    CheckBox chkSelect = RG_ThangTruoc.Items[i].FindControl("chkSelect") as CheckBox;


                    if (chkSelect.Checked)
                    {
                        RadNumericTextBox rnSTChuyen = RG_ThangTruoc.Items[i].FindControl("rnSTChuyen") as RadNumericTextBox;
                        double STCON = double.Parse(RG_ThangTruoc.Items[i]["STCON"].Text);

                        if (rnSTChuyen.Value > STCON)
                        {
                            lbLoi.Text = "<font color='red'>Số tiền chuyển không vượt ngân sách còn lại.</font>";
                        }
                        else
                        {

                            id_khoaCT = idkhoa + RG_ThangTruoc.Items[i]["MSCHIPHI"].Text + txtIDMaCS.Text;

                            //Obj = new clsObj();
                            //Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@ToTrinh", "@SoTienChuyen", "@ID_khoaCT" };
                            //Obj.ValueParameter = new object[] { idkhoa, RG_ThangTruoc.Items[i]["MSCHIPHI"].Text, txtMaBP.Text, Session["UserID"].ToString(), Convert.ToString("Chuyen NS tu thang " + Convert.ToString(int.Parse(RG_ThangTruoc.Items[i]["THANG"].Text))), rnSTChuyen.Value, id_khoaCT };
                            //Obj.SpName = "sp_ChuyenKeHoachNganSach_Insert";
                            //Sql.fNonGetData(Obj);


                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@ToTrinh", "@SoTienChuyen", "@ID_khoaCT","@Nam","@Thang","@MaNVXX","@MaNVPD" };
                            Obj.ValueParameter = new object[] { idkhoa, RG_ThangTruoc.Items[i]["MSCHIPHI"].Text, txtMaBP.Text, Session["UserID"].ToString(), Convert.ToString("Chuyen NS tu thang " + Convert.ToString(int.Parse(RG_ThangTruoc.Items[i]["THANG"].Text)) +"/"+ Convert.ToString(int.Parse(RG_ThangTruoc.Items[i]["Nam"].Text))), rnSTChuyen.Value, id_khoaCT, int.Parse(rnNamMoi.Text), int.Parse(rnThangMoi.Text), cbXemXet.SelectedValue, cbNguoiPheDuyet.SelectedValue };
                            Obj.SpName = "sp_ChuyenKeHoachNganSach_Insert_KeToan";
                            Sql.fNonGetData(Obj);
                        }

                    }

                }
               
            }
        }
        fLoad();
        fLoad_NSThangTruoc();
    }

    protected void RG_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtIDKhoaCT = userControl.FindControl("txtIDKhoaCT") as TextBox;
        TextBox txtMSChiPhi = userControl.FindControl("txtMSChiPhi") as TextBox;
        Telerik.Web.UI.RadNumericTextBox rnChiPhi = userControl.FindControl("rnChiPhi") as Telerik.Web.UI.RadNumericTextBox;

        Telerik.Web.UI.RadNumericTextBox rnChiPhiAn = userControl.FindControl("rnChiPhiAn") as Telerik.Web.UI.RadNumericTextBox;

        if (rnChiPhiAn.Value < rnChiPhi.Value)
        {
            lbLoi.Text = "<font color='red'>Số tiền không vượt ngân sách còn lại.</font>";
        }
        else
        {
            #region Luu
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT", "@Sotien" };
            Obj.ValueParameter = new object[] { txtIDKhoaCT.Text, rnChiPhi.Text };
            Obj.SpName = "sp_KeHoachNS_ChuyenNS_Update";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
           
        }
        fLoad();
        fLoad_NSThangTruoc();

    }
    protected void RG_ThangTruoc_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad_NSThangTruoc();
    }
    protected void RG_ThangTruoc_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad_NSThangTruoc();
    }
    protected void RG_ThangTruoc_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {

            fLoad_NSThangTruoc();
        }
    }
    protected void rnThangMoi_TextChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoad();
    }
    protected void rnNamMoi_TextChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
        fLoad();
    }
}