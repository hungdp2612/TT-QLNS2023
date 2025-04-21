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
using Data;

public partial class Controls_ChiTietThanhToanTamUng_Mar_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    protected void Page_Load(object sender, EventArgs e)
    {
        //fLoadDonVi();
        //fLoadNganSachConLai();
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void btnClose_Click(object sender, ImageClickEventArgs e)
    {

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            
            txtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
        }
    }   
    void fLoadNganSachConLai()
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi" };
        //Obj.ValueParameter = new object[] { txtMaDV.Text, txtMSCHiPhi.Text };
        //Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi";
        //Sql.fGetData(Obj);
        //if (Obj.Dt.Rows.Count < 1)
        //{

        //}
        //else
        //{
        //    try
        //    {
        //        rnSoTienConLai.Value =Convert.ToDouble(Obj.Dt.Rows[0]["STCON"].ToString());
        //        rnNganSachConLaiAn.Value = Convert.ToDouble(Obj.Dt.Rows[0]["STCON"].ToString());
        //    }
        //    catch { }
        //}
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text };
        Obj.SpName = "sp_PhieuTU_LayNgayThangNam_ByPhieuTU";
        Sql.fGetData(Obj);

        int nam, thang;
        nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { IDMaCS, txtMSCHiPhi.Text, nam, thang };
        //Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi2";
        Obj.SpName = "sp_NganSachConLai_ThucHien_MaChiPhi";
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi" };
        //Obj.ValueParameter = new object[] { txtMaDV.Text, txtMSChiPhi.Text };
        //Obj.SpName = "sp_ChungTuThanhToanTamUng_NganSachConLai_ByMaDV_MSChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnSoTienConLai.Text = Obj.Dt.Rows[0]["ThieuThua"].ToString();
                rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["ThieuThua"].ToString();

                rnTongNganSach.Value = Convert.ToDouble(Obj.Dt.Rows[0]["TongNSThang"].ToString());//5.400.000
                rnNganSachThucHien.Value = Convert.ToDouble(Obj.Dt.Rows[0]["NSThucHien"].ToString());//3.800.000

            }
            catch { }
        }

    }
    void FLoadNganSachChiTietConLai()
    {

        Obj = new clsObj();

        Obj.Parameter = new string[] { "@PhieuTU", "@MaCP_CT" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, txtMaCP_CT.Text };

        Obj.SpName = "sp_TamUngChiTietConLai_Mar_ByMaCP";


        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                rnTienChiTietConLai.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());
                rnTienChiTietConLaiAn.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());

            }
            catch { }
        }
    }
    void fLoadSoTienConLaiTungMaChiPhi_ByPhieuTU()
    {
        Obj = new clsObj();

        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, txtMSCHiPhi.Text };

        Obj.SpName = "sp_ThanhToanTamUng_SoTienConLai_ByMaCP_PhieuTU";


        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                rnTamUngConLaiCuaMaChiPhi.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());
                rnTamUngConLai_ByMaChiPhiAn.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());              
            }
            catch { }
        }

    }
    void fLoadSoTienConLaiCuaPhieuTU()
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MaNV" };
        Obj.ValueParameter = new object[] { txtPhieuTU.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_ThanhToanTamUng_SumTienPhieuTU_ByPhieuTU";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                rnTienPhieuTU.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());
                rnTienPhieuTUAn.Value = double.Parse(Obj.Dt.Rows[0]["ConLai"].ToString());

            }
            catch { }
        }

    }
    public string fGet(object TienThanhToan, object SoLuong, object DonGia, object VAT)
    {
        fLoadDonVi();
        fLoadNganSachConLai();
        fLoadSoTienConLaiCuaPhieuTU();
        fLoadSoTienConLaiTungMaChiPhi_ByPhieuTU();
        rnSoTienThanhToan.Value = double.Parse(TienThanhToan.ToString());
        rnTienThanhToanAn.Value = double.Parse(TienThanhToan.ToString());
        rnSoLuong.Value = double.Parse(SoLuong.ToString());
        rnDonGia.Value = double.Parse(DonGia.ToString());
        rnVAT.Value = double.Parse(VAT.ToString());
       // rnSoTienConLai.Value = double.Parse(TienConLai.ToString());

        rdThanhTienAn.Value = double.Parse(TienThanhToan.ToString());

       // rnNganSachConLaiAn.Value = double.Parse(TienConLai.ToString());
        FLoadNganSachChiTietConLai();
        return "";
    }
   
    //protected void UCrdSoTien_TextChanged(object sender, EventArgs e)
    //{
    //    if (UCrdSoTien.Text != "")
    //    {
    //        rnNganSachConLai.Value = rnNganSachConLaiAn.Value + (rdThanhTienAn.Value - UCrdSoTien.Value) * rnTiGia.Value;
    //    }
    //}
    protected void rnSoTienThanhToan_TextChanged(object sender, EventArgs e)
    {
        if (rnSoTienThanhToan.Text != "")
        {
            rnSoTienConLai.Value = rnNganSachConLaiAn.Value + (rdThanhTienAn.Value - rnSoTienThanhToan.Value);
        }
    }
}
