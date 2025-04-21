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


public partial class DanhMuc_DanhMucKhoanMuc_Mar : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region kế hoạch ngân sach
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            cboKhoaKhoanMuc.Visible = false;
            fLoad();          
         
          
            #endregion          


        }
        if (Session["ReloadKHNS"] != null)
        {
            fLoad();
            Session["ReloadKHNS"] = null;
           
        }
         
    }   
  
    void fLoad()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] {int.Parse(rnNam.Text)};
        Obj.SpName = "sp_DanhMucKhoanMuc_Mar_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    } 
   
  
  
    void fLoadMaCP(string Key)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP","@Nam","@MaDV" };
        Obj.ValueParameter = new object[] { Key,int.Parse(rnNam.Text),"P.MAR" };
        Obj.SpName = "sp_Mar_DmChiPhi_GetAll_ByNam";
        Sql.fGetData(Obj);
        cbMaChiPhi.DataSource = Obj.Dt;
        cbMaChiPhi.DataBind();
       
    }
    void fLoadKhoa_ByMaCP()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP" };
        Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue };
        Obj.SpName = "sp_DanhMucKhoanMuc_Mar_GetKhoa_ByMaCP";
        Sql.fGetData(Obj);
        cboKhoaKhoanMuc.DataSource = Obj.Dt;
        cboKhoaKhoanMuc.DataBind();

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


            string Khoa_khoanmuc = RG.Items[e.Item.ItemIndex]["Khoa_khoanmuc"].Text;         

            #region Kiem tra trong phieu tam ung co ma chi phi can xoa hay khong

            //int CountMaCP_CT;
            //Obj = new clsObj();
            //Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MSChiPhi" };
            //Obj.ValueParameter = new object[] { MaDV, Nam, Thang, MSChiPhi };
            //Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Delete_KiemTraPhieuTU";
            //Sql.fGetData(Obj);
            //CountMaCP_CT = int.Parse(Obj.Dt.Rows[0]["CountMaCP_CT"].ToString());
            //if (CountMaCP_CT > 0)
            //{
            //    fLoad();
            //    throw new Exception("Chi tiết mã ns này đã lập phiếu TU, nên không xóa được. Vui lòng kiểm tra lại!!!");
               
            //}
            #endregion

            #region Kiem tra trong giấy đề nghị thanh toán co ma chi phi can xoa hay khong

            //int CountMaCP_CT2;
            //Obj = new clsObj();
            //Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MSChiPhi" };
            //Obj.ValueParameter = new object[] { MaDV, Nam, Thang, MSChiPhi };
            //Obj.SpName = "sp_KeHoachNganSach_ChiTiet_Delete_KiemTraChungTuThanhToan";
            //Sql.fGetData(Obj);
            //CountMaCP_CT2 = int.Parse(Obj.Dt.Rows[0]["CountMaCP_CT"].ToString());
            //if (CountMaCP_CT2 > 0)
            //{
            //    fLoad();
            //    throw new Exception("Chi tiết mã ns này đã lập giấy đề nghị thanh toán, nên không xóa được. Vui lòng kiểm tra lại!!!");

            //}


            #endregion

            #region Kiem tra khóa khoản mục có trong chi phí kế hoạch

            int CountKhoanMuc;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@KhoaKhoanMuc" };
            Obj.ValueParameter = new object[] { Khoa_khoanmuc };
            Obj.SpName = "sp_Mar_DanhMucKhoanMuc_KiemTraTrongChiTietKhoanMuc";
            Sql.fGetData(Obj);
            CountKhoanMuc = int.Parse(Obj.Dt.Rows[0]["CountKhoanMuc"].ToString());
            if (CountKhoanMuc > 0)
            {
                fLoad();
                throw new Exception("Khoá khoản mục này đã có trong chi phí KH. <Br>Nên xóa hết chi phí KH của khoản mục này mới xóa được !!!");

            }
            #endregion

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Khoa_khoanmuc" };
            Obj.ValueParameter = new object[] { Khoa_khoanmuc };
            Obj.SpName = "sp_DanhMucKhoanMuc_Mar_Delete";
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
            fLoadKhoa_ByMaCP();
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
    protected void radioKhoanMuc_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radioKhoanMuc.SelectedItem.Value == "KhoanMuc")
        {
            cboKhoaKhoanMuc.Visible = false;
            cboKhoaKhoanMuc.SelectedValue = "";
            cboKhoaKhoanMuc.Text = "";
            txtTenKhoanMuc.Text = "";
        }
        else
        {
            cboKhoaKhoanMuc.Visible = true;
            txtTenKhoanMuc.Text = "Công tác phí";
            
        }
        cboKhoaKhoanMuc.SelectedValue = "";
        cboKhoaKhoanMuc.Text = "";
        fLoadKhoa_ByMaCP();
    }
  
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        if (radioKhoanMuc.SelectedItem.Value == "KhoanMuc")
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] {"@Nam", "@MaCP", "@TenKhoanMuc", "@HieuLuc"};
            Obj.ValueParameter = new object[] {int.Parse(rnNam.Text), cbMaChiPhi.SelectedValue, txtTenKhoanMuc.Text, chkhieuluc.Checked };
            Obj.SpName = "sp_DanhMucKhoanMuc_Insert";

            Sql.fNonGetData(Obj);

            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Thất bại.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thành công.</font>";
                fLoad();
            }
        }
        else if (radioKhoanMuc.SelectedItem.Value == "B001")
        {
            string khoakhoanmuc;
            if (cboKhoaKhoanMuc.SelectedValue == "")
            {
                khoakhoanmuc = cbMaChiPhi.SelectedValue;
            }
            else
            {
                khoakhoanmuc = cboKhoaKhoanMuc.SelectedValue;
            }

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@Nam","@Khoa_KhoanMuc", "@TenKhoanMuc", "@HieuLuc" };
            Obj.ValueParameter = new object[] { int.Parse(rnNam.Text),khoakhoanmuc, txtTenKhoanMuc.Text, chkhieuluc.Checked };
            Obj.SpName = "sp_DanhMucKhoanMuc_CongTacPhi_Insert";

            Sql.fNonGetData(Obj);

            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Thất bại.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thành công.</font>";
                fLoad();
            }
        }


    }  
     

    protected void cbMaChiPhi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cboKhoaKhoanMuc.SelectedValue = "";
        cboKhoaKhoanMuc.Text = "";
        fLoadKhoa_ByMaCP();
    }

    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();     
    }
}