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


public partial class Chuongtrinh_ChiPhiKeHoachKhoanMuc : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
          
           
            //rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            fLoadThuongHieu();
            fLoad();   
        }
       
    }
    void fLoad()
    {       

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@Nam" };
        Obj.ValueParameter = new object[] {int.Parse(rnNam.Text)};
        Obj.SpName = "sp_ChiPhiKeHoach_Load_ByNam";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    } 
   
  
   
    void fLoadMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key","@Nam" };
        Obj.ValueParameter = new object[] { Key,int.Parse(rnNam.Text) };
        //Obj.SpName = "sp_ChiTietChiPhiKeHoach_Mar_LoadMaCP";
        Obj.SpName = "sp_ChiPhiKeHoachKhoanMuc_Mar_LoadMaCP";
        
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
    }

    void fLoadSoTienDuyetConLai()
    {        

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@MSChiPhi", "@Nam" };
        Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, int.Parse(rnNam.Text) };
        Obj.SpName = "sp_ChiPhiKeHoach_SoTienDuyet_By_MaCP_Nam";
        Sql.fGetData(Obj);
        rnNganSachConLai.Text = Obj.Dt.Rows[0]["TienConLai"].ToString();
        rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["TienConLai"].ToString();
             
    }

    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
    }

    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            string IDKhoa = RG.Items[e.Item.ItemIndex]["Khoa_ID"].Text;
            string Khoa_khoanmuc = RG.Items[e.Item.ItemIndex]["Khoa_khoanmuc"].Text;


            #region Kiem tra có chi tiết khoản mục hay chưa

            int CountKhoanmuc;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_khoanmuc" };
            Obj.ValueParameter = new object[] { Khoa_khoanmuc };
            Obj.SpName = "sp_ChiTietKhoanMuc_Delete_KiemTra";
            Sql.fGetData(Obj);
            CountKhoanmuc = int.Parse(Obj.Dt.Rows[0]["CountKhoanmuc"].ToString());
            if (CountKhoanmuc > 0)
            {
                fLoad();
                throw new Exception("Khoản mục này đã có chi tiết, phải xóa hết chi tiết KH mới xóa được. !!!");

            }
            #endregion

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_ID" };
            Obj.ValueParameter = new object[] { IDKhoa };
            Obj.SpName = "sp_ChiPhiKeHoach_Mar_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
            
            rnSoTienChiTiet.Value = 0;
            fLoad();
            if (cbMaChiPhi.SelectedValue == cbMaChiPhi.Text && cbMaChiPhi.Text != "")
            {
                fLoadSoTienDuyetConLai();
            }          

        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message.ToString() + "</font>";
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

    void fLoadKhoanMuc_ByMaCP()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP" };
        Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_DanhMucKhoanMuc_Mar_GetKhoa_ByMaCP";
        Sql.fGetData(Obj);
        cboKhoaKhoanMuc.DataSource = Obj.Dt;
        cboKhoaKhoanMuc.DataBind();

    }
    void fLoadThuongHieu()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] {  };
        Obj.SpName = "sp_LoaiChiPhi_Mar_Load";
        Sql.fGetData(Obj);
        cbThuongHieu.DataSource = Obj.Dt;
        cbThuongHieu.DataBind();

    }
 
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        try
        {

            if (rnSoTienChiTiet.Value == 0)
            {
                fLoad();
                throw new Exception("Số tiền phải khác 0!!!");

            }

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam", "@Khoa_khoanmuc", "@LoaiCP", "@SoTien", "@Khoa_ID" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), cboKhoaKhoanMuc.SelectedValue, cbThuongHieu.SelectedValue, rnSoTienChiTiet.Value, rnNam.Text + cboKhoaKhoanMuc.SelectedValue + cbThuongHieu.SelectedValue };
            Obj.SpName = "sp_ChiPhiKeHoach_Mar_Insert";

            Sql.fNonGetData(Obj);

            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Đã có <b><font color='black'> " + cboKhoaKhoanMuc.SelectedValue + cbThuongHieu.SelectedValue + "</font></b> trong danh sách.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thành công.</font>";
                fLoad();
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message.ToString() + "</font>";
        }
      

    }
   
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {

        fLoad();

    }


    protected void cbMaChiPhi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cboKhoaKhoanMuc.SelectedValue = "";
        cboKhoaKhoanMuc.Text = "";
        fLoadKhoanMuc_ByMaCP();

        rnNganSachConLai.Text = "";
        fLoadSoTienDuyetConLai();
    }
}