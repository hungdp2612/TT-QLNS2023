using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class Chuongtrinh_Kehoachngansach_KTKiemTra : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["MSChiphi"] = String.Empty;          
            LoadNamQui();
            LoadDVPheDuyet();
       
           
            hieulucketoan();
          
            LoadNganSach();
        }
    }
   
 
  
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }
   
    void LoadDVPheDuyet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Value, rnQui.Value };
        Obj.SpName = "SP_NSMADV_KeToanKiemTra_BYLOAD";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;       
    }


   
    void LoadNganSach()
    {
        if (CboMaDV.SelectedValue == "KDND")
        {
            RadGDNganSach.Columns[3].Visible = false;
            RadGDNganSach.Columns[4].Visible = false;
            RadGDNganSach.GroupingEnabled = true;
            RadGDNganSach.AllowFilteringByColumn = true;
        }
        else
        {
            RadGDNganSach.Columns[3].Visible = false;
            if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
            {
              
                RadGDNganSach.Columns[4].Visible = true;
                RadGDNganSach.GroupingEnabled = true;
               RadGDNganSach.AllowFilteringByColumn = true;
               
            }
            else
            {
                RadGDNganSach.Columns[4].Visible = false;
                RadGDNganSach.GroupingEnabled = false;
                RadGDNganSach.AllowFilteringByColumn = true;
            }          
            
        }
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, rnNam.Value, rnQui.Value };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui_KTKiemTra";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
       
    }
    
    public bool hieulucketoan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, int.Parse(rnNam.Text),int.Parse(rnQui.Text) };
        Obj.SpName = "sp_KeHoachNganSach_KeToanKiemTra_HieuLucKeToan";
        Sql.fGetData(Obj);

        return bool.Parse(Obj.Dt.Rows[0]["HieuLuc"].ToString());

    }
  
    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";    
     
        LoadNganSach();
    }
    
      
    protected void RadGDNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        LoadNganSach();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadNganSach();
    }
 
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LoadNganSach();
        }
    }
  
  
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { rnNam.Value, CboMaDV.SelectedValue, int.Parse(rnQui.Text) };
        Obj.SpName = "sp_KeHoachNganSach_Execl";
        Sql.fGetData(Obj);

        if (rnQui.Value == 1)
        {

            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {
                    ExcelQui1.Columns[5].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[5].Visible = false;
                }
                ExcelQui1.Columns[2].Visible = false;
                ExcelQui1.Columns[1].Visible = false;
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 2)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui2.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[5].Visible = false;
                }
                ExcelQui2.Columns[2].Visible = false;
                ExcelQui2.Columns[1].Visible = false;
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 3)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui3.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[5].Visible = false;
                }
                ExcelQui3.Columns[2].Visible = false;
                ExcelQui3.Columns[1].Visible = false;
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui.Value == 4)
        {
            if (CboMaDV.SelectedValue == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[5].Visible = false;
            }
            else
            {
                if (CboMaDV.SelectedValue == "P.CU" || CboMaDV.SelectedValue == "P.HCQT")
                {

                    ExcelQui4.Columns[5].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[5].Visible = false;
                }
                ExcelQui4.Columns[2].Visible = false;
                ExcelQui4.Columns[1].Visible = false;
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui.Value;
            ExcelQui4.MasterTableView.ExportToExcel();
        }


    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        CboMaDV.Text = "";
        LoadDVPheDuyet();
       
        LoadNganSach();
    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {
        CboMaDV.Text = "";
        LoadDVPheDuyet();     
        LoadNganSach();
    }
}