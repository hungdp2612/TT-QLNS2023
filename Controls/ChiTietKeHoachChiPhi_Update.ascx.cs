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

public partial class Controls_ChiTietKeHoachChiPhi_Update : System.Web.UI.UserControl
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        //Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
        Obj.SpName = "sp_ChiPhiKeHoach_LoadDVUyQuyen";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();
    }

    public string fGet(object SoTien,  object TiLeDV,object DVUQ )
    {
        UCrnChiPhi.Value = double.Parse(SoTien.ToString());
        rdThanhTienAn.Value = double.Parse(SoTien.ToString());
        rnTiLeDV.Value = double.Parse(TiLeDV.ToString());
        rdThanhTienAn.Value = double.Parse(SoTien.ToString());
        ddlDonVi.SelectedValue = DVUQ.ToString();
        fLoadNganSachConLai();
        fLoadDonVi();
        return "";
    }

    void fLoadNganSachConLai()
    {      

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Khoa_ChiPhi" };
        Obj.ValueParameter = new object[] { UCtxtKhoaCP.Text };
        Obj.SpName = "sp_ChiPhiKeHoach_GetChiPhiDuocDuyet_ByKhoaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {

        }
        else
        {
            try
            {
                rnChiPhiConLai.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();
                rnNganSachConLaiAn.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();

            }
            catch { }
        }
    }
  
}
