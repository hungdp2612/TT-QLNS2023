using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.Configuration;
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;
public partial class ChiTietKeHoachNganSach_PCU_HCQT : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID_Khoa"] != null)
            {
                txtKHCP_ID.Text = Request.QueryString["ID_Khoa"].ToString();
            }
            if (Request.QueryString["Nam"] != null)
            {
                txtNam.Text = Request.QueryString["Nam"].ToString();
                fLoadMaDV();
                FLoadKeHoachChiPhi();
                FLoadKeHoachNganSach();

            }
            if (Request.QueryString["Thang"] != null)
            {
                txtThang.Text = Request.QueryString["Thang"].ToString();
               
            }
            fLoadDonVi();
            fLoad();
                      

            Session["ReloadKHNS"] = "";

            #region Kiem tra lai ngan sach don vi uy quyen

          
            #endregion

        }
    }
    #region Nhập ngân sách chi tiết
    void fLoad()
    {

        if (txtMaBP.Text == "P.CU" || txtMaBP.Text == "P.HCQT")
        {
            RG.Columns[4].Visible = true;

        }
        else
        {
            RG.Columns[4].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_chitietkehoachngansach_PCU_HCQT_load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaDV.Text = Obj.Dt.Rows[0]["MADV"].ToString();
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();

            }
            catch { }

        }
        else
        {

        }
    }
    protected void RG_InsertCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
      
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietKeHoachNganSach_Update.ascx";
            fLoad();

        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoad();
        }
    }
    protected void RG_EditCommand(object sender, GridCommandEventArgs e)
    {

    }



    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }


    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }

    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    int tiepnhanKDND;
    int TiepNhan()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_LoginByMaNV_GetThongTin";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                tiepnhanKDND = int.Parse(Obj.Dt.Rows[0]["TiepNhan"].ToString());

            }
            catch { }

        }
        else
        {

        }
        return tiepnhanKDND;

    }

    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_KhoaCT = RG.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        string ID_Khoa = RG.Items[e.Item.ItemIndex]["ID_Khoa"].Text;
        string MSChiphi = RG.Items[e.Item.ItemIndex]["MSChiphi"].Text;
        string MaNV = RG.Items[e.Item.ItemIndex]["MaNV"].Text;
        string MaBP = RG.Items[e.Item.ItemIndex]["MaBP"].Text;
        string ghichu = RG.Items[e.Item.ItemIndex]["Ghichu"].Text;

        decimal sotien;

        if (RG.Items[e.Item.ItemIndex]["Sotien"].Text == "&nbsp;")
        {
            sotien = 0;
        }
        else
        {
            sotien = decimal.Parse(RG.Items[e.Item.ItemIndex]["Sotien"].Text);
        }


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_KhoaCT" };
        Obj.ValueParameter = new object[] { ID_KhoaCT };
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
        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();


    }

    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }

   
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }

  

    #endregion

    #region Kiem ta lai ngan sach don vi uy quyen

    void fLoadMaDV()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@Nam" ,"@Thang"};
        Obj.ValueParameter = new object[] {int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
        Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_GetMaDVUQ";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();

    }

    void FLoadKeHoachChiPhi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaDVUserDangNhap", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { ddlDonVi.SelectedValue, txtMaDV.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
        Obj.SpName = "sp_NganSachKhoiSanXuat_KeHoachChiPhi";
        Sql.fGetData(Obj);
        RD_ChiPhi.DataSource = Obj.Dt;
        RD_ChiPhi.DataBind();
    }
    void FLoadKeHoachNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDKhoa" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_ChiTietKeHoachNgansach_PCU_HCQT_LoadByIDKhoa";
        Sql.fGetData(Obj);
        RGNganSach.DataSource = Obj.Dt;
        RGNganSach.DataBind();

    }
   
    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();
    }
    #endregion

    protected void btLay_Click(object sender, ImageClickEventArgs e)
    {
        for (int i = 0; i < RD_ChiPhi.Items.Count; i++)
        {
            CheckBox chkSelect = RD_ChiPhi.Items[i].FindControl("chkSelect") as CheckBox;
            if (chkSelect.Checked)
            {
                string MaCP = RD_ChiPhi.Items[i]["MSChiphi"].Text;
                double SoTien = double.Parse(RD_ChiPhi.Items[i]["TienUyQuyen"].Text);
                string MaDVNhanUQ = RD_ChiPhi.Items[i]["DVNhanUQ"].Text;
              
                string idkhoaCT = txtKHCP_ID.Text + MaCP + txtIDMaCS.Text;

                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_Khoa", "@MSChiPhi", "@MaBP", "@MaDVUQ", "@MaNV", "@SoTien", "@ID_KhoaCT", "@GhiChu" };
                Obj.ValueParameter = new object[] { txtKHCP_ID.Text, MaCP, MaDVNhanUQ, ddlDonVi.SelectedValue, Session["USerID"].ToString(), SoTien, idkhoaCT, "UQ từ ĐV " + ddlDonVi.SelectedValue };
                Obj.SpName = "sp_KeHoachNganSachSanXuat_Insert";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Thất bại.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Thành công.</font>";

                }
                #endregion
            }           
        }
        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();
        fLoad();
    }
    protected void RGNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            FLoadKeHoachNganSach();
        }
    }
    protected void RGNganSach_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_KhoaCT = RGNganSach.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_KhoaCT" };
        Obj.ValueParameter = new object[] { ID_KhoaCT };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            FLoadKeHoachChiPhi();
            FLoadKeHoachNganSach();
            fLoad();
        }
    }
}