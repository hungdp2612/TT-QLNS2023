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
using CrystalDecisions.CrystalReports.Engine;
using Telerik.Web.UI;


public partial class Chuongtrinh_HieuChinhHanThanhToan : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    ReportDocument report = new ReportDocument();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            DateTime Next = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            Next = Next.AddMonths(1).AddDays(-1);


            fLoadDonVi();


            rdTuNgay.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            rdDenNgay.SelectedDate = Next;
            fLoad();

        }

    }

    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_LayBoPhan_TraCuuChungTu";
        Sql.fGetData(Obj);


        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();

    }
    void FLoadDV2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonVi.SelectedValue };

        Obj.SpName = "sp_TraCuuChungTu_MaBPByIDMaCS";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }

    void fLoad()
    {
        //DateTime Next = new DateTime(rdDenThangThanhToan.SelectedDate.Value.Year, rdDenThangThanhToan.SelectedDate.Value.Month, 1);
        //Next = Next.AddMonths(1).AddDays(-1);

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@TuNgay", 
            "@DenNgay","@MaDV","@LoaiPhieu"};
        Obj.ValueParameter = new object[] { rdTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
            rdDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),  txtMaBP.Text,ddlLoaiThanhToan.SelectedValue
        };
        Obj.SpName = "sp_HieuChinhHanThanhToanGiayDNTT_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        FLoadDV2();
        fLoad();
    }


    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }

    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            RG.MasterTableView.IsItemInserted = false;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/HieuChinhHanThanhToan_Update.ascx";
            fLoad();
        }
    }

    protected void dlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadDV2();
    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";

        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);

        string txtSoPhieu = (userControl.FindControl("txtSoPhieu") as TextBox).Text;
        Telerik.Web.UI.RadDatePicker rdHanThanhToan = userControl.FindControl("rdHanThanhToan") as Telerik.Web.UI.RadDatePicker;
        Telerik.Web.UI.RadDatePicker rdNgayIn = userControl.FindControl("rdNgayIn") as Telerik.Web.UI.RadDatePicker;
        string txtNoiDung = (userControl.FindControl("txtNoiDung") as TextBox).Text;

       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@HanThanhToan","@NgayIn","@NoiDung" };
        Obj.ValueParameter = new object[] { txtSoPhieu, rdHanThanhToan.SelectedDate, rdNgayIn.SelectedDate, txtNoiDung };
        Obj.SpName = "sp_HieuChinhHanThanhToan_Update";
        Sql.fNonGetData(Obj);
        if (Obj.KetQua > 0)
        {
            lbLoi.Text = "<font color='blue'>Cập nhật thành công .</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        }
        
        fLoad();
    }
}