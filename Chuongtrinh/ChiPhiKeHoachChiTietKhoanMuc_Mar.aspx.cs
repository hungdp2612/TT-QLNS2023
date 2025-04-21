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


public partial class Chuongtrinh_ChiPhiKeHoachChiTietKhoanMuc_Mar : clsPhanQuyenCaoCap
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
            fLoadChuongTrinh();
            fLoad();   
        }
       
    }
    void fLoad()
    {       

        Obj = new clsObj();
        Obj.Parameter = new string[] {"@Nam" };
        Obj.ValueParameter = new object[] {int.Parse(rnNam.Text)};
        Obj.SpName = "sp_KHChiTietKhoanMuc_Load_ByNam";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    } 
   
  
   
    void fLoadMaCP(string Key)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key","@Nam" };
        Obj.ValueParameter = new object[] { Key, int.Parse(rnNam.Text) };
        Obj.SpName = "sp_KHchitietkhoanmuc_Mar_LoadMaCP";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
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
            string IDKhoa = RG.Items[e.Item.ItemIndex]["Khoa_Chitiet_KM"].Text;


            #region Kiem tra có thanh toán hay chưa

            int CountThanhToan;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_Chitiet_KM" };
            Obj.ValueParameter = new object[] { IDKhoa };
            Obj.SpName = "sp_ChiTietChiPhiKhoanMuc_Delete_KiemTra";
            Sql.fGetData(Obj);
            CountThanhToan = int.Parse(Obj.Dt.Rows[0]["CountThanhToan"].ToString());
            if (CountThanhToan > 0)
            {
                fLoad();
                throw new Exception("Khoản mục này đã thanh toán, nên không xóa được. Vui lòng kiểm tra lại!!!");

            }
            #endregion

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_Chitiet_KM" };
            Obj.ValueParameter = new object[] { IDKhoa };
            Obj.SpName = "sp_KHChiTietKhoanMuc_Mar_Delete";
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
    void fLoadChuongTrinh()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] {  };
        Obj.SpName = "sp_DanhMucLoaiChuongTrinh_Mar_Load";
        Sql.fGetData(Obj);
        cbChuongTrinh.DataSource = Obj.Dt;
        cbChuongTrinh.DataBind();

    }
 
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Khoa_khoanmuc", "@Loaichuongtrinh", "@Noidung", "@Sotienkehoach", "@Ghichu","@Khoa_Chitiet_KM" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam.Text), cboKhoaKhoanMuc.SelectedValue, cbChuongTrinh.SelectedValue, txtNoiDung.Text, rnSoTienChiTiet.Value,txtGhiChu.Text, rnNam.Text + cboKhoaKhoanMuc.SelectedValue + cbChuongTrinh.SelectedValue };
        Obj.SpName = "sp_KHChiTietKhoanMuc_Mar_Insert";

        Sql.fNonGetData(Obj);

        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Đã có <b><font color='black'> " + cboKhoaKhoanMuc.SelectedValue + cbChuongTrinh.SelectedValue + "</font></b> trong danh sách.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Thành công.</font>";
            fLoad();
        }
      

    }
   
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        cbMaChiPhi.Text = "";
        fLoad();      
        fLoadMaCP("");
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
        
    }
}