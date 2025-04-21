using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;

public partial class Tracuu_TraCuuChungTuNopTien : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DateTime Next = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            Next = Next.AddMonths(1).AddDays(-1);
            rdTuNgay.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            rdDenNgay.SelectedDate = Next;


            fLoadDonVi();
            fLoadMaDV();
            FLoadMaBPByIDCS();
            fLoad();
            fLoadChiTiet();
                      
        }
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        // Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            if (Obj.Dt.Rows[0]["IDMaCS"].ToString() == "100")
            {
                txtMaBP.Text = "CONGSO";
            }
            else
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();
            }
        }
        else
        {

        }
    }    
    void fLoadMaDV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaBP" };
        Obj.ValueParameter = new object[] { txtMaBP.Text };
        Obj.SpName = "sp_TraCuuChungTuNopTien_By_MaDV";
        Sql.fGetData(Obj);
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();
    }
    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonVi.SelectedValue };

        Obj.SpName = "sp_TraCuuKeHoachNSQui_MaBPByIDCS";
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
        Obj.Parameter = new string[] {"@MaDV", "@TuNgay", "@DenNgay"};
        Obj.ValueParameter = new object[] { txtMaBP.Text,rdTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
            rdDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy")};
        Obj.SpName = "sp_TraCuuChungTuNopTien_Load_By_MaDV";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }

    void fLoadChiTiet()
    {       

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@TuNgay", "@DenNgay" };
        Obj.ValueParameter = new object[] { txtMaBP.Text,rdTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
            rdDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy")};
        Obj.SpName = "sp_TraCuuChungTuChiTietNopTien_Load_By_MaDV";
        Sql.fGetData(Obj);
        RG2.DataSource = Obj.Dt;
        RG2.DataBind();

    }
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
       
        fLoad();
        fLoadChiTiet();
    }
    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void RG2_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoadChiTiet();
    }
    protected void RG2_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoadChiTiet();
    }
    protected void RG2_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        fLoadChiTiet();
    }
}