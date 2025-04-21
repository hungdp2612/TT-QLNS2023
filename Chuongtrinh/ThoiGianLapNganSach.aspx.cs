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
using Telerik.Web.UI;

public partial class Chuongtrinh_ThoiGianLapNganSach : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {          
            fLoad();
        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_ThoiGianLapKeHoach_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void cbMaDV_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] { };
        Obj.Connectionstring = wqlvattu;
        Obj.SpName = "[SP_LoadDMDonVi]";
        Sql.fGetData(Obj);
        cbMaDV.DataSource = Obj.Dt;
        cbMaDV.DataBind();
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        string mvdv = cbMaDV.Text;
        #region
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Ten", "@SoNgay", "@MaDV" };
        Obj.ValueParameter = new object[] { txtTen.Text, rnSoNgay.Text, mvdv };
        Obj.SpName = "sp_ThoiGianLapKeHoach_InsertUpdate";

        Sql.fNonGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='red'>Cập nhật thời gian lập ngân sách cho đơn vị <b><font color='black'>" + mvdv + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thời gian lập ngân sách cho đơn vị  <b><font color='black'>" + mvdv + "</font></b> thành công.</font>";
        }
        fLoad();

        #endregion
    }
    protected void btnLamMoi_Click(object sender, ImageClickEventArgs e)
    {
        txtTen.Text = "";
        cbMaDV.Enabled = true;
        rnSoNgay.Text = "";
      

    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                fLoad();
                break;
            case RadGrid.RebindGridCommandName:
                fLoad();
                break;
            case "SUA":


                cbMaDV.Text = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
                cbMaDV.Enabled = false;
                txtTen.Text = RG.Items[e.Item.ItemIndex]["Ten"].Text;
                rnSoNgay.Text = RG.Items[e.Item.ItemIndex]["SoNgay"].Text;

                break;
        }
    }
}