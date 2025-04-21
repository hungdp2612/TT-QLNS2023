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


public partial class Chuongtrinh_ChuyenPhuongThucThanhToan : clsPhanQuyenCaoCap
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
            fLoadDonVi();
            rdLapTuNgay.SelectedDate = DateTime.Now.AddYears(0).AddMonths(-5);
            rdLapDenNgay.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
         
        }


    }
    public void fLoadDonVi()
    {

        if (ddlPTTT.SelectedValue == "TMSNH")
        {
            string TT = "TM";

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@TM" };
            Obj.ValueParameter = new object[] { TT };
            Obj.SpName = "SP_LoadMaDVChuyenPTTT";
            Sql.fGetData(Obj);
            CboMaDV.DataSource = Obj.Dt;
            CboMaDV.DataBind();
            CboMaDV.SelectedIndex = 0;
            if (CboMaDV.SelectedIndex == -1)
            {
                CboMaDV.Text = "";
            }


        }
        else if (ddlPTTT.SelectedValue == "NHSTM")
        {
            string TT = "NH";
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@TM" };
            Obj.ValueParameter = new object[] { TT };
            Obj.SpName = "SP_LoadMaDVChuyenPTTT";
            Sql.fGetData(Obj);
            CboMaDV.DataSource = Obj.Dt;
            CboMaDV.DataBind();
            CboMaDV.SelectedIndex = 0;
            if (CboMaDV.SelectedIndex == -1)
            {
                CboMaDV.Text = "";
            }
        }
    }
    public void LoadChuyenPhuongThucThanhToan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@TuNgay", "@DenNgay", "@LaTienMat", "@LoaiPhieu" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rdLapTuNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),
        rdLapDenNgay.SelectedDate.Value.ToString("dd/MM/yyyy"),ddlPTTT.SelectedValue, ddlLoaiPhieu.SelectedValue
        };
        Obj.SpName = "SP_ChuyenTraCuuChungTuThanhToan";
        Sql.fGetData(Obj);
        RGChuyenPTTT.DataSource = Obj.Dt;
        RGChuyenPTTT.DataBind();       
    }

    protected void ddlPTTT_SelectedIndexChanged(object sender, EventArgs e)
    {
        CboMaDV.Text = "";
        lbLoi.Text = "";
        fLoadDonVi();
    }
    protected void BtnTracuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        LoadChuyenPhuongThucThanhToan();
        BtnChuyen.Visible = true;
    }
    protected void BtnChuyen_Click(object sender, ImageClickEventArgs e)
    {
       
        if (ddlPTTT.SelectedValue == "TMSNH")
        {
            foreach (GridViewRow rowItem in RGChuyenPTTT.Rows)
            {

                Label SoPhieu = (Label)rowItem.FindControl("lbl_SoPhieu");
                CheckBox Ch_Chuyen = (CheckBox)rowItem.FindControl("check_Chuyen");
                if (Ch_Chuyen.Checked == true)
                {
                    UpdateLaTienmatCTTT(SoPhieu.Text, "NH");
                }
            }
        }
        else if (ddlPTTT.SelectedValue == "NHSTM")
        {
            foreach (GridViewRow rowItem in RGChuyenPTTT.Rows)
            {

                Label SoPhieu = (Label)rowItem.FindControl("lbl_SoPhieu");
                CheckBox Ch_Chuyen = (CheckBox)rowItem.FindControl("check_Chuyen");
                if (Ch_Chuyen.Checked == true)
                {
                    UpdateLaTienmatCTTT(SoPhieu.Text, "TM");
                }
            }
        }
        fLoadDonVi();
        LoadChuyenPhuongThucThanhToan();
    }
    public void UpdateLaTienmatCTTT(string SoPhieu, string LaTienMat)
    {
       


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu", "@LaTienMat" };
        Obj.ValueParameter = new object[] { SoPhieu, LaTienMat };
        Obj.SpName = "SP_UpdateLaTienMatCTTT";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='blue'>Chuyển thành công.</font>";
            fLoadDonVi();
            LoadChuyenPhuongThucThanhToan();
        }
        else
        {
            lbLoi.Text = "<font color='red'>Chuyển thất bại.</font>";
        }


    }
    protected void RGChuyenPTTT_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}