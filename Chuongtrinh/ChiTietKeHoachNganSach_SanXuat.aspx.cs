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
public partial class ChiTietKeHoachNganSach_SanXuat : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
   
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            if (Request.QueryString["ID_Khoa"] != null)
            {
                txtIDKhoa.Text = Request.QueryString["ID_Khoa"].ToString();
            }
            if (Request.QueryString["Nam"] != null)
            {
                txtNam.Text = Request.QueryString["Nam"].ToString();
            }
            if (Request.QueryString["Thang"] != null)
            {
                txtThang.Text = Request.QueryString["Thang"].ToString();
            }
            if (Request.QueryString["MaDV"] != null)
            {
                txtMaDV.Text = Request.QueryString["MaDV"].ToString();
            }

            fLoadMaDV();
            fLoadDonVi();
            FLoadKeHoachChiPhi();
            FLoadKeHoachNganSach();

            FLoadKeHoachChiPhiCacDonVi();
            FLoadKeHoachNganSachCacDonVi();
            Session["KHNSSanXua"] = "";
        }

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        // Obj.Connectionstring = wqlvattu;
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }
    void fLoadMaDV()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDVNhanUQ", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] {txtMaDV.Text,int.Parse(txtNam.Text),int.Parse(txtThang.Text) };        
        //Obj.SpName = "sp_KeHoachNganSachSanXuat_GetDVUyQuyen";
        Obj.SpName = "sp_KeHoachNganSach_LoadMaDV";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();     

    }
    void FLoadKeHoachChiPhi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaDVUserDangNhap", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] {ddlDonVi.SelectedValue,txtMaDV.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
        Obj.SpName = "sp_NganSachKhoiSanXuat_KeHoachChiPhi";
        Sql.fGetData(Obj);
        RD_ChiPhi.DataSource = Obj.Dt;
        RD_ChiPhi.DataBind();
    }
    void FLoadKeHoachNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDKhoa" };
        Obj.ValueParameter = new object[] { txtIDKhoa.Text };
        Obj.SpName = "sp_ChiTietKeHoachNgansachSanXuat_LoadByIDKhoa";
        Sql.fGetData(Obj);
        RGNganSach.DataSource = Obj.Dt;
        RGNganSach.DataBind();

    }

    protected void RD_ChiPhi_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadKeHoachChiPhi();
    }
    protected void RD_ChiPhi_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadKeHoachChiPhi();
    }

    protected void RD_ChiPhi_ItemCommand(object sender, GridCommandEventArgs e)
    {
        FLoadKeHoachChiPhi();
    }


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
               // string GhiChu = RD_ChiPhi.Items[i]["GhiChu"].Text == "&nbsp;" ? "" : RD_ChiPhi.Items[i]["GhiChu"].Text;

                //#region Kiểm tra
                //Obj = new clsObj();
                //Obj.Parameter = new string[] { "@Thang", "@Nam", "@MaDV", "@MSChiPhi" };
                //Obj.ValueParameter = new object[] { txtMaDV.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text), MaCP };
                //Obj.SpName = "spLoad_KeHoachNganSach_ByMaNS";
                //Sql.fGetData(Obj);
                //if (Obj.Dt.Rows.Count > 0)
                //{
                //    goto Het;
                //}
               // #endregion
                string idkhoaCT = txtIDKhoa.Text + MaCP+ txtIDMaCS.Text;

                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_Khoa", "@MSChiPhi", "@MaBP", "@MaDVUQ", "@MaNV", "@SoTien", "@ID_KhoaCT", "@GhiChu" };
                Obj.ValueParameter = new object[] { txtIDKhoa.Text, MaCP, MaDVNhanUQ, ddlDonVi.SelectedValue, Session["USerID"].ToString(), SoTien, idkhoaCT,"UQ từ ĐV "+ddlDonVi.SelectedValue };
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

      //  Het: ;
        }
        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();

        FLoadKeHoachChiPhiCacDonVi();
        FLoadKeHoachNganSachCacDonVi();
                    
    }
    protected void RGNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadKeHoachNganSach();
    }
    protected void RGNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadKeHoachNganSach();
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

            FLoadKeHoachChiPhiCacDonVi();
            FLoadKeHoachNganSachCacDonVi();
        }
       
    }

    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();
    }


    #region xử lý tất cả đơn vị
    void FLoadKeHoachChiPhiCacDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] {txtMaDV.Text, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
        Obj.SpName = "sp_NganSachKhoiSanXuat_KeHoachChiPhi_TatCaDonVi";
        Sql.fGetData(Obj);
        RGChiPhiUQ.DataSource = Obj.Dt;
        RGChiPhiUQ.DataBind();
    }
    void FLoadKeHoachNganSachCacDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDKhoa" };
        Obj.ValueParameter = new object[] { txtIDKhoa.Text };
        Obj.SpName = "sp_ChiTietKeHoachNgansachSanXuat_LoadByIDKhoa";
        Sql.fGetData(Obj);
        RGNS.DataSource = Obj.Dt;
        RGNS.DataBind();

    }
  
    protected void btnGetAll_Click(object sender, ImageClickEventArgs e)
    {
        for (int i = 0; i < RGChiPhiUQ.Items.Count; i++)
        {
            CheckBox chkSelect = RGChiPhiUQ.Items[i].FindControl("chkSelect2") as CheckBox;
            if (chkSelect.Checked)
            {
                string MaCP = RGChiPhiUQ.Items[i]["MSChiphi"].Text;
                double SoTien = double.Parse(RGChiPhiUQ.Items[i]["TienUyQuyen"].Text);
                string MaDVNhanUQ = RGChiPhiUQ.Items[i]["DVNhanUQ"].Text;
                string MaDVUQ = RGChiPhiUQ.Items[i]["DVUQ"].Text;  
                string idkhoaCT = txtIDKhoa.Text + MaCP + txtIDMaCS.Text;

                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_Khoa", "@MSChiPhi", "@MaBP", "@MaDVUQ", "@MaNV", "@SoTien", "@ID_KhoaCT", "@GhiChu" };
                Obj.ValueParameter = new object[] { txtIDKhoa.Text, MaCP, MaDVNhanUQ, MaDVUQ, Session["USerID"].ToString(), SoTien, idkhoaCT, "UQ từ ĐV " + MaDVUQ };
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

            //  Het: ;
        }
        FLoadKeHoachChiPhiCacDonVi();
        FLoadKeHoachNganSachCacDonVi();

        FLoadKeHoachChiPhi();
        FLoadKeHoachNganSach();
    }
   
    protected void RGNS_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_KhoaCT = RGNS.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
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

            FLoadKeHoachChiPhiCacDonVi();
            FLoadKeHoachNganSachCacDonVi();
        }
    }
   
    protected void RGNS_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            FLoadKeHoachNganSachCacDonVi();
        }
    }
    #endregion

}