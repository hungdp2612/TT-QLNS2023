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
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class TamUngHetHan : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    clssys clss = new clssys();
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["MSChiphi"] = String.Empty;
            Session["PhieuTU"] = String.Empty;

            fLoadDonVi();
            fLoadPhuTrachDonVi();
            fLoadPhieuTUChuaThanhToanDaHetHan();
            FLoadPhieuTUHetHanChuaThanhToan();
            FLoadHanThanhToanByPhieuTU();


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
            txtMaDV.Text = "Không tìm thấy";
            txtTenDonVi.Text = "Không tìm thấy";
        }
        else
        {
            txtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            txtTenDonVi.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();

        }
    }
    void fLoadPhuTrachDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text };
        Obj.SpName = "sp_GetGD_ByMaDV";
        Sql.fGetData(Obj);
        ddlPhuTrachDonVi.DataSource = Obj.Dt;
        ddlPhuTrachDonVi.DataBind();
    }

    void fLoadPhieuTUChuaThanhToanDaHetHan()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_PhieuTamUngHetHanChuaThanhToan_LoadCB";
        Sql.fGetData(Obj);      
        if (Obj.Dt.Rows.Count < 1)
        {

            cbPhieuTU.Text = "";
            FLoadPhieuTUHetHanChuaThanhToan();
        }
        else
        {
           // rdHanThanhToan.SelectedDate = DateTime.Parse(Obj.Dt.Rows[0]["HanThanhToan"].ToString());
            cbPhieuTU.DataSource = Obj.Dt;
            cbPhieuTU.DataBind();
            cbPhieuTU.SelectedIndex = 0;
            if (cbPhieuTU.SelectedIndex == -1)
            {
                cbPhieuTU.Text = "";
            }
        }
        
    }
    void FLoadHanThanhToanByPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV", "@PhieuTU" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["UserID"].ToString(), cbPhieuTU.SelectedValue };
        Obj.SpName = "sp_PhieuTamUngHetHanChuaThanhToan_LoadHanThanhToan_ByPhieuTU";
        Sql.fGetData(Obj);


        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            rdHanThanhToan.SelectedDate = DateTime.Parse(Obj.Dt.Rows[0]["HanThanhToan"].ToString());
        }
    }
    void FLoadPhieuTUHetHanChuaThanhToan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MaNV" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_PhieuTamUngHetHanChuaThanhToan_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void cbPhieuTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadHanThanhToanByPhieuTU();
        lbEmail.Text = "";
        lbLoi.Text = "";
    }
    string countTU;
    string email;
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU" };
                Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue};
                Obj.SpName = "sp_HieuChinhHanThanhToanTU_CountTU";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTU = Obj.Dt.Rows[0]["CoutPhieuTU"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTU) == 0)
                {
                    #region Luu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@PhieuTU", "@MaBP", "@MaNV", "@HanThanhToan", "@GhiChu" };
                    Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue, txtMaDV.Text, Session["UserID"].ToString(), rdHanThanhToan.SelectedDate, txtGhiChu.Text };

                    Obj.SpName = "sp_HieuChinhHanThanhToanTU_Insert";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua > 0)
                    {
                        lbLoi.Text = "<font color='blue'>Lưu thành phiếu tạm ứng hết hạn thanh toán <b><font color='black'>" + cbPhieuTU.SelectedValue + "</font></b>.</font>";
                        fLoadPhieuTUChuaThanhToanDaHetHan();
                        FLoadPhieuTUHetHanChuaThanhToan();
                        FLoadHanThanhToanByPhieuTU();
                        SendEmail();
                    }
                    else
                    {
                        lbLoi.Text = "<font color='red'>Lưu thất bại. Vui lòng thử lại sau.</font>";
                    }

                    #endregion
                    
                }
                else
                {
                    lbLoi.Text = "<font color='Red'>Đã lập phiếu tạm ứng hết hạn chưa thanh toán này rồi.</font>";
                    fLoadPhieuTUChuaThanhToanDaHetHan();
                    FLoadPhieuTUHetHanChuaThanhToan();
                    FLoadHanThanhToanByPhieuTU();
                   
                }
    }

 
   public void SendEmail()
    {
       
        lbEmail.Text = "";
        #region Email
        Obj = new clsObj();      
      
        Email email_ = new Email();
        DataTable dt = new DataTable();
        dt = email_.GetEmailTCKT();
        if (dt.Rows.Count > 0)
        {
            try
            {              
                foreach (DataRow row in dt.Rows)
                {                   
                        email += row["Email"].ToString().Trim() + ";";                   
                }            

                string SB = "KE TOAN HIEU CHINH HAN THANH TOAN PHIEU TAM UNG ";
                string noidung = "";

                noidung += txtTenDonVi.Text + " Kinh chuyen P.TCKT hieu chinh han thanh toán phieu tam ung " + cbPhieuTU.SelectedValue;
              
                noidung += "%0A" + "" + Session["Name"].ToString();
                noidung += "";

                noidung = clss.RemoveSign4VietnameseString(noidung);

                hlEmail.NavigateUrl = "mailto:" + email + "?subject=" + SB + "&body=" + noidung;

                lbEmail.Text = "<font color='blue'>Vui lòng click nút gửi mail.</font>";
            }
            catch
            {

            }
            
        }
        else
        {
            lbEmail.Text = "<font color='red'>Không gửi được email.</font>";
        }

        #endregion
    }   
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FLoadPhieuTUHetHanChuaThanhToan();
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FLoadPhieuTUHetHanChuaThanhToan();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FLoadPhieuTUHetHanChuaThanhToan();
    }
    bool hieuluc;
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        lbEmail.Text = "";
        string PhieuTU = RG.Items[e.Item.ItemIndex]["PhieuTU"].Text;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { PhieuTU };
        Obj.SpName = "sp_HieuChinhHanThanhToanTU_KTHieuChinh_Delete";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                hieuluc = bool.Parse(Obj.Dt.Rows[0]["HieuLuc"].ToString());

            }
            catch { }
        }
        else { }
        
        if (clsConvertHelper.Tobool(hieuluc) == true)
        {
            lbLoi.Text = "<font color='red'>Kế toán đã hiệu chỉnh nên không xóa được.</font>";
            FLoadPhieuTUHetHanChuaThanhToan();
        }
        else
        {           

            #region Xoá
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@PhieuTU" };
            Obj.ValueParameter = new object[] { PhieuTU };
            Obj.SpName = "sp_HieuChinhHanThanhToanTU_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua > 0)
            {
                lbLoi.Text = "<font color='blue'>Xoá thành công .</font>";
               
            }
            else
            {
                lbLoi.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
            }
            #endregion
            fLoadPhieuTUChuaThanhToanDaHetHan();
            FLoadPhieuTUHetHanChuaThanhToan();
            FLoadHanThanhToanByPhieuTU();
        }

    }       
    
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }
}