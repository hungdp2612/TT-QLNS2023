using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;

public partial class Baocao_Tonghopngansachtheophongban : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //rdTuThang.SelectedDate = DateTime.Now;
            //rdDenThang.SelectedDate = DateTime.Now;
           
            fLoadDonVi();
            FLoadMaBPByIDCS();
        }
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        //Obj.SpName = "spLayBoPhan_TraCuuKeHoachNganSachTheoQui2";
        Obj.SpName = "sp_TongHopNganSachTheoPhongBan_GetDonVi";
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
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@tuthang", 
            "@tunam", "@denthang", 
            "@dennam", "@madv" };
        Obj.ValueParameter = new object[] { rdTuThang.SelectedDate.Value.Month.ToString(),
            rdTuThang.SelectedDate.Value.Year.ToString(), rdDenThang.SelectedDate.Value.Month.ToString(),
            rdDenThang.SelectedDate.Value.Year.ToString(), ddlDonVi.SelectedValue
        };
       
            //Obj.SpName = "sp_BaoCaoTinhHinhThucHienNganSachTheoPhongBan";
            //Obj.SpName = "sp_TongHopNganSachTheoPhongBan_BaoCao";

            if (ddlDonVi.SelectedValue == "KDND")
            {
                //Obj.SpName = "sp_TongHopNganSachTheoPhongBan_BaoCao_KDND";
                Obj.SpName = "sp_TongHopNganSachTheoPhongBan_BaoCao_KDND_040515";
                
            }
            else
            {
               // Obj.SpName = "sp_TongHopNganSachTheoPhongBan_BaoCao";
                Obj.SpName = "sp_TongHopNganSachTheoPhongBan_BaoCao_040515";
                
           }
       
        Obj.Cm.CommandTimeout = 50000;
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void btIn_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }

    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
        RG.ExportSettings.ExportOnlyData = true;
        RG.ExportSettings.IgnorePaging = true;
        RG.ExportSettings.OpenInNewWindow = true;
        RG.ExportSettings.FileName = "Tong Hop Tinh Hinh Thuc Hien Ngan Sach " + (rdTuThang.SelectedDate.Value.Month.ToString().Length == 1 ?
                "0" + rdTuThang.SelectedDate.Value.Month.ToString() : rdTuThang.SelectedDate.Value.Month.ToString()) +
            rdTuThang.SelectedDate.Value.Year.ToString() +
            (rdDenThang.SelectedDate.Value.Month.ToString().Length == 1 ?
                "0" + rdDenThang.SelectedDate.Value.Month.ToString() : rdDenThang.SelectedDate.Value.Month.ToString()) +
            rdDenThang.SelectedDate.Value.Year.ToString() + ddlDonVi.SelectedItem;
        RG.MasterTableView.ExportToExcel();
    }

    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
    protected void RG_ExcelExportCellFormatting(object sender, Telerik.Web.UI.ExcelExportCellFormattingEventArgs e)
    {

    }
}