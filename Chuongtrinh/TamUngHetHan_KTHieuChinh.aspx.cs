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

public partial class TamUngHetHan_KTHieuChinh : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
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
        
            fLoadDonVi();
         
           fLoadPhieuTUChuaThanhToanDaHetHan();
            FLoadHanThanhToanByPhieuTU();
            FLoadPhieuTUHetHanChuaThanhToan();
           


        }

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_HieuChinhHanThanhToan_KTHieuChinh_LoadMaDV";       
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        if (CboMaDV.SelectedIndex == -1)
        {
            CboMaDV.Text = "";
        }
        
    }
  
    void fLoadPhieuTUChuaThanhToanDaHetHan()
    {
       

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.SpName = "sp_HieuChinhHanThanhToanTU_KTHieuChinh_LoadPhieuTU_ByMaDV";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {

                    cbPhieuTU.DataSource = Obj.Dt;
                    cbPhieuTU.DataBind();
                    cbPhieuTU.SelectedIndex = 0;
                    //  cbPhieuTU.Items.Insert(0, new RadComboBoxItem());

                }
                catch { }
            }
            else
            {
                

            }
      
    }
    void FLoadHanThanhToanByPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@PhieuTU" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue,  cbPhieuTU.SelectedValue };
        Obj.SpName = "sp_HieuChinhHanThanhToanTU_KTHieuChinh_LoadHanThanhToan_PhieuTU";
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
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue};
        Obj.SpName = "sp_PhieuTamUngHetHanChuaThanhToan_KTHieuChinh_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
 
    protected void cbPhieuTU_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        FLoadHanThanhToanByPhieuTU();
    }

    void UpdateHanThanhToanPhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@HanThanhToan" };
        Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue, rdHieuChinhNgay.SelectedDate};
        Obj.SpName = "sp_HieuChinhHanThanhToanTu_PhieuTU_UpdateHanThanhToan";
        Sql.fNonGetData(Obj);
       
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        if (rdHanThanhToan.SelectedDate.Value >= rdHieuChinhNgay.SelectedDate.Value)
        {
            lbLoi.Text = "<font color='red'>Ngày hiệu chỉnh phải lớn hơn hạn thanh toán.</font>";
        }
        else
        {
            if (rdHieuChinhNgay.SelectedDate.Value <= DateTime.Parse(DateTime.Now.ToShortDateString()))
            {
                lbLoi.Text = "<font color='red'>Ngày hiệu chỉnh phải lớn hơn ngày hiện tại.</font>";
            }
            else
            {
                int hieuluc = 0;
                if (chkhieuluc.Checked)
                {
                    hieuluc = 1;
                }
                else
                {
                    hieuluc = 0;
                }

                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU", "@HieuChinhHanThanhToan", "@MaNVKT", "@HieuLuc" };
                Obj.ValueParameter = new object[] { cbPhieuTU.SelectedValue, rdHieuChinhNgay.SelectedDate, Session["UserID"].ToString(), hieuluc };

                Obj.SpName = "sp_HieuChinhHanThanhToanTU_KTHieuChinh_Update";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua > 0)
                {
                    lbLoi.Text = "<font color='blue'>Hiệu chỉnh thành công phiếu tạm ứng <b><font color='black'>" + cbPhieuTU.SelectedValue + "</font></b>.</font>";
                    // fLoadDonVi();
                    UpdateHanThanhToanPhieuTU();
                    fLoadPhieuTUChuaThanhToanDaHetHan();
                    FLoadHanThanhToanByPhieuTU();
                    FLoadPhieuTUHetHanChuaThanhToan();

                }
                else
                {
                    lbLoi.Text = "<font color='red'>Hiệu chỉnh thất bại. Vui lòng thử lại sau.</font>";
                }
            }

                #endregion
        }


    }



    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cbPhieuTU.Text = "";
      
        fLoadPhieuTUChuaThanhToanDaHetHan();
        FLoadHanThanhToanByPhieuTU();
        FLoadPhieuTUHetHanChuaThanhToan();
      
    }
}