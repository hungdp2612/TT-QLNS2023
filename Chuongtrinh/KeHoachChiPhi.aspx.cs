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

public partial class Chuongtrinh_KeHoach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadNamThang();
            fLoadDonVi();
           // txtNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
           
            fLoadMaDV();
            fLoad();
        }
        if (Session["Reload"] != null)
        {
            fLoad();
            Session["Reload"] = null;
            
        }
    }

    void LoadNamThang()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSach_LoadNam_Thang";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
       
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv", "@Nam" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue, rnNam.Text };
        Obj.SpName = "SP_CHIPHIKEHOACH_LOAD_29112016";
        //Obj.SpName = "SP_CHIPHIKEHOACH_LOAD_040515";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

       

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { };
        //Obj.ValueParameter = new object[] {  };
        //Obj.SpName = "sp_ChiPhiKeHoach_Load";
        //Sql.fGetData(Obj);
        //RG.DataSource = Obj.Dt;
        //RG.DataBind();

    }
    void fLoadMaDV()
    {       
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaNV" };
            Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
            Obj.SpName = "sp_KeHoachChiPhi_LoadMaDV_ByMaNV";
            Sql.fGetData(Obj);
            ddlMaDV.DataSource = Obj.Dt;
            ddlMaDV.DataBind();
            ddlMaDV.SelectedIndex = 0;

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        //Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            //TxtTenDV.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
            TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();
           
        }
        else
        {
           // TxtTenDV.Text = "Không tìm thấy";
        }

       
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        string nam = rnNam.Text;
        string madv = ddlMaDV.SelectedValue;
        string IDMaCS = txtIDMaCS.Text;
        string[] IDMaDV = ddlMaDV.SelectedItem.Text.Split(new char[] { ':' });
        string IDCS = IDMaDV[0].ToString();


        string masochiphi = cbMaSoChiPhi.SelectedValue;
        string khoa_chiphi = IDCS + "-" + nam + masochiphi;


        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@MSChiPhi", "@ChiPhiDaDuyet", "@Khoa_chiphi" };
        Obj.ValueParameter = new object[] { nam, madv, masochiphi, rnChiPhiDuyet.Value, khoa_chiphi };

        Obj.SpName = "sp_ChiPhiKeHoach_Insert";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Đã có chi phí kế hoạch <b><font color='black'>" + khoa_chiphi + "</font></b> trong danh sách.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thêm chi phí kế hoạch <b><font color='black'>" + khoa_chiphi + "</font></b> thành công.</font>";
        }
        #endregion
        fLoad();
    }
  
    protected void cbMaSoChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@key" };
        Obj.ValueParameter = new object[] { e.Text };
        //Obj.SpName = "sp_LoadCb_DmChiPhi";
        Obj.SpName = "sp_KEHOACHCHIPHI_LOAD_MANS";
        Sql.fGetData(Obj);
        cbMaSoChiPhi.DataSource = Obj.Dt;
        cbMaSoChiPhi.DataBind();
    }
   
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string Khoa_chiphi = RG.Items[e.Item.ItemIndex]["Khoa_chiphi"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Khoa_chiphi" };
        Obj.ValueParameter = new object[] { Khoa_chiphi };
        Obj.SpName = "sp_ChiPhiKeHoach_Delete";
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
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            fLoad();
        }
    }

    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoad();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }
}