using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Data;

public partial class Controls_ChiTietKeHoachNganSach_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
       
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
            }
            catch { }

        }
        else
        {

        }
    }
    int nam, thang;
    void GetNamThangByIDKhoa()
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_Khoa" };
        Obj.ValueParameter = new object[] { UCtxtKhoaKHNS.Text };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_GetNamThangByIDKhoa";

        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
                thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());     
               

            }
            catch { }
        }
    }

    void fLoadTienNSByMaChiPhi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaDV.Text, UCtxtMSChiPhi.Text, nam, thang };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ChiPhiKeHoach_GetSoTienChiPhi";

        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
              //  rnSoTienDuocLap.Text = Obj.Dt.Rows[0]["ChiPhiChoNS"].ToString();
                // rnChiPhiConLaiAn.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();

            }
            catch { }
        }

    }
    public string fGet(object SoTien)
    {
        fLoadDonVi();
        GetNamThangByIDKhoa();
        //  fLoadTienNSByMaChiPhi();
        UCrnChiPhi.Value = double.Parse(SoTien.ToString());
      
        return "";
    }
   
}
