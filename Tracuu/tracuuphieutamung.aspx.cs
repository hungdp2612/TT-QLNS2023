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
using Telerik.Web.UI;
using CrystalDecisions.CrystalReports.Engine;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Tracuu_tracuuphieutamung : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
    ReportDocument report = new ReportDocument();
    public static string ConnectionString
    {
        get
        {
            return ConfigurationManager.ConnectionStrings["ConnectDB_QLNS2013"].ConnectionString;
        }
    }
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fLoadDonVi();
            Session["MSChiphi"] = String.Empty;
            Session["PhieuTU"] = String.Empty;
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();

                     
            fLoadPhieuTU();
            fLoadChiTietPhieuTU();

            fLoadNganSach();
        }      

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "SP_LoadNVIDMaDV";
       // Obj.Connectionstring = wqlvattu;
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count < 1)
        {
         
        }
        else
        {
         
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();          

        }
        if (txtIDMaCS.Text == "100")
        {
            txtMaBP.Text = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
            else
            {
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
            }
        }
    }
   
    void fLoadNganSach()
    {
        Obj = new clsObj();
       
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, rnNam.Text, rnThang.Text };
        //Obj.SpName = "sp_TraCuuPhieuTamUng_KeHoachNganSach";
        Obj.SpName = "sp_TraCuuPhieuTamUng_KeHoachNganSach040515";
        
        Sql.fGetData(Obj);
        RGNganSach.DataSource = Obj.Dt;
        RGNganSach.DataBind();
    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {

        fLoadChiTietPhieuTU();


    }
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {

        fLoadChiTietPhieuTU();
    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChiTietPhieuTU();
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadChiTietPhieuTU();
    }
    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoadChiTietPhieuTU();
        
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
      
    }
    protected void ddlNguoiThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {  
        fLoadChiTietPhieuTU();      
        fLoadPhieuTU();
        
       
    }
  
    #region Load Phieu tam ưng
    void fLoadPhieuTU()
    {
        
        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };
        //Obj.ValueParameter = new object[] { cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_TamUng_CTPTU_ByMaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                RDPhieuTU.DataSource = Obj.Dt;
                RDPhieuTU.DataBind();
            }
            catch { }
        }
       
    }
    void fLoadChiTietPhieuTU()
    {
        Obj = new clsObj();
      
        Obj.Parameter = new string[] {  "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, rnNam.Text, rnThang.Text };

        Obj.SpName = "sp_ChiTietPhieuTU_ByMaNV";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

    }
    string countTU;
    protected void RDPhieuTU_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            
            if (e.Item.Selected == false)
            {
                Session["PhieuTU"] = String.Empty;
                //LOAD_RadGDNganSach();
                FLoadChiPhieuTUBySessionMCP();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadPhieuTU();
        }
        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                fLoadPhieuTU();
                break;
            case RadGrid.RebindGridCommandName:
                fLoadPhieuTU();
                break;
            case "PRINT":

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@PhieuTU" };
                Obj.ValueParameter = new object[] { RDPhieuTU.Items[e.Item.ItemIndex]["PhieuTU"].Text };
                Obj.SpName = "sp_PhieuTamUng_Count_Delete";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTU = Obj.Dt.Rows[0]["CountTU"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTU) == 0)
                {
                   // lbLoi.Text = "<font color='Red'>Chưa có chi tiết tạm ứng nên không in được.</font>";
                    fLoadPhieuTU();
                }
                else
                {
                   

                  
                    #region Lấy report
                    report = ReportFactory.GetReport(report.GetType());
                    report.Load(Server.MapPath(@"~\Reports\rptPhieuTamUng.rpt"));
                    report.SetParameterValue("@PhieuTU", RDPhieuTU.Items[e.Item.ItemIndex]["PhieuTU"].Text);

                    Session["report"] = report;


                    #endregion

                    #region Gọi file report
                    //Response.Redirect("~/Report/rptBaoCao.aspx", "_blank", "");
                    DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                    DialogWindow.VisibleOnPageLoad = true;
                 
                    #endregion

                }
                break;
        }
    }
    protected void RDPhieuTU_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadPhieuTU();
      
        //foreach (GridDataItem item in RDPhieuTU.MasterTableView.Items)
        //{
        //    if (item.Selected)
        //    {
        //        Session["PhieuTU"] = item["PhieuTU"].Text.Trim();
        //    }
        //}
        //LOAD_RadGDNganSach();
    }
    protected void RDPhieuTU_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["PhieuTU"] = RDPhieuTU.SelectedValue == null ? "" : RDPhieuTU.SelectedValue;



        if (Session["MSChiphi"].ToString() != "" && Session["PhieuTU"].ToString() != "")
        {
            FLoadChiPhieuTUBySessionMCP_PhieuTU();

        }
        if (Session["MSChiphi"].ToString() != "" && Session["PhieuTU"].ToString() == "")
        {
           FLoadChiPhieuTUBySessionMCP();
        
        }
        if (Session["MSChiphi"].ToString() == "" && Session["PhieuTU"].ToString() != "")
        {
           
            LOAD_RadGDNganSach();
        }

    }
    #endregion
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "sp_TraCuu_ChiTietTamUng_ByPhieuTU";

            provider.CommandType = CommandType.StoredProcedure;

            //provider.ParameterCollection = new string[] { "@PhieuTU", "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };

            //provider.ValueCollection = new object[] { Session["PhieuTU"].ToString().Trim(), cbMaChiPhi.SelectedValue, txtMaDV.Text, rnNam.Text, rnThang.Text };

            provider.ParameterCollection = new string[] { "@PhieuTU",  "@MaDV", "@Nam", "@Thang" };

            provider.ValueCollection = new object[] { Session["PhieuTU"].ToString().Trim(), txtMaBP.Text, rnNam.Text, rnThang.Text };

            dt = provider.GetDataTable();

        }
        catch (SqlException ex)
        {
            throw new Exception(ex.Message);
        }
        finally
        {
            provider.CloseConnection();
            RG.DataSource = dt;
            RG.DataBind();
        }


    }
    protected void RDPhieuTU_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //foreach (GridDataItem item in RDPhieuTU.Items)
        //{
        //    (item["DVKiemTra"].FindControl("cbXemXet1") as RadComboBox).Text = (item["DVKiemTra"].FindControl("hfXemXet") as HiddenField).Value;
        //    (item["DVKiemTra"].FindControl("cbXemXet1") as RadComboBox).SelectedValue = (item["DVKiemTra"].FindControl("hfXemXet") as HiddenField).Value;
        //}
    }
    protected void RDPhieuTU_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadPhieuTU();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
       fLoadNganSach();
       fLoadPhieuTU();
       fLoadChiTietPhieuTU();
       
    }
    protected void cbMaChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();      
        
    }
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        //fLoadChiPhiTamUngXemXet();
        fLoadNganSach();
        fLoadPhieuTU();
        fLoadChiTietPhieuTU();
       
       
    }
    void FLoadPhieuTUBySession()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { txtMaBP.Text, Session["MSChiphi"].ToString(), int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_PhieuTamUng_ByMaCP_TraCuu";
        Sql.fGetData(Obj);
        RDPhieuTU.DataSource = Obj.Dt;
        RDPhieuTU.DataBind();
    }
    void FLoadChiPhieuTUBySessionMCP_PhieuTU()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@PhieuTU", "@MSChiPhi","@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { Session["PhieuTU"].ToString(), Session["MSChiphi"].ToString(), txtMaBP.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_NganSach_PhieuTU_ChiTietTU";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void FLoadChiPhieuTUBySessionMCP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] {  "@MSChiPhi", "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { Session["MSChiphi"].ToString(), txtMaBP.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
        Obj.SpName = "sp_PhieuTU_ChiTietTU_ByMSChiPhi";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    protected void RGNganSach_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        Session["MSChiphi"] = RGNganSach.SelectedValue == null ? "" : RGNganSach.SelectedValue;
       
       
        FLoadPhieuTUBySession();
        FLoadChiPhieuTUBySessionMCP();
       
    }
    protected void RGNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
       
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                FLoadPhieuTUBySession();
                FLoadChiPhieuTUBySessionMCP();
                //lbLoi.Text = Session["MSChiphi"].ToString();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadNganSach();
        }
    }
    protected void RGNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadNganSach();
    }
    protected void RGNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadNganSach();
        //FLoadChiTietNS();
    }
  
}