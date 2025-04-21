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

public partial class Chuongtrinh_HESOTRUOTGIA : System.Web.UI.Page
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadNamThang();
            fLoad();
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
        rnThang.Value = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam" };
        Obj.ValueParameter = new object[] { rnNam.Text };
        Obj.SpName = "Load_HESOTRUOTGIA";
        //Obj.SpName = "SP_CHIPHIKEHOACH_LOAD_040515";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }

    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_KHOATRUOTGIA = RG.Items[e.Item.ItemIndex]["ID_KHOATRUOTGIA"].Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_KHOATRUOTGIA" };
        Obj.ValueParameter = new object[] { Guid.Empty };
        Obj.SpName = "Sp_Delete_HESOTRUOTGIA";
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

    }

    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

    }

    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {

    }

    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {

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

}