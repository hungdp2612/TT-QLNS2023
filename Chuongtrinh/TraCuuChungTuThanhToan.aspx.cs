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


public partial class Chuongtrinh_TraCuuChungTuThanhToan : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fLoadDonVi();
            rdTuNgay.SelectedDate = DateTime.Now.AddYears(0).AddMonths(-5);
            rdDenNgay.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
           // FloadTraCuuChungTuThanhToan();
            FLoadMaBPByIDCS();

        }       

    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_LayBoPhan_TraCuuChungTuThanhToan";
        Sql.fGetData(Obj);       
        ddlDonVi.DataSource = Obj.Dt;
        ddlDonVi.DataBind();
       // ddlDonVi.Items.RemoveAt(0);
    }
    void FLoadMaBPByIDCS()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlDonVi.SelectedValue };

        Obj.SpName = "sp_TraCuuChungTuThanhToan_MaBPByIDMaCS";
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
    void FloadTraCuuChungTuThanhToan()
    {
        if (ddlChungTu.SelectedValue == "NH")
        {
            RG.Visible = false;
           // GridView1.Visible = false;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@tungay", "@denngay", "@MaDV", "@TienMat", "@KT", "@Noidung" };
            Obj.ValueParameter = new object[] { rdTuNgay.SelectedDate, rdDenNgay.SelectedDate,
                txtMaBP.Text, ddlChungTu.SelectedValue, ddlThanhToan.SelectedValue, "" };
            Obj.SpName = "SP_TracuuChungTuThanhToan";
            Sql.fGetData(Obj);
            if (Obj.KetQua == 0)
            {
                if (ddlThanhToan.SelectedValue == "0")// chưa kiểm tra
                {
                   // btnLuu.Visible = true;
                    //RGQuaNganHang.Columns[6].Visible = true;                 
                    //RGQuaNganHang.Columns[7].Visible = true;
                    RGQuaNganHang.Columns[11].Visible = false;
                    RGQuaNganHang.DataSource = Obj.Dt;
                    RGQuaNganHang.DataBind();
                    RGQuaNganHang.Visible = true;
                   
                  //  RG.Visible = false;
                }
                else
                {
                   // RGQuaNganHang.Columns[6].Visible = false;
                    //RGQuaNganHang.Columns[7].Visible = true;
                    RGQuaNganHang.Visible = true;
                    RGQuaNganHang.Columns[11].Visible = true;
                    btnLuu.Visible = false;
                    RGQuaNganHang.DataSource = Obj.Dt;
                    RGQuaNganHang.DataBind();
                   
                  //  RG.Visible = false;
                }
            }
            else
            {
               
            }
        }
        else if (ddlChungTu.SelectedValue == "TM")
        {
            RGQuaNganHang.Visible = false;
            //GridView1.Visible = false;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@tungay", "@denngay", "@MaDV", "@TienMat", "@KT", "@Noidung" };
            Obj.ValueParameter = new object[] { rdTuNgay.SelectedDate, rdDenNgay.SelectedDate, txtMaBP.Text, ddlChungTu.SelectedValue, ddlThanhToan.SelectedValue, "" };
            Obj.SpName = "SP_TracuuChungTuThanhToan";
            Sql.fGetData(Obj);
            if (Obj.KetQua == 0)
            {

                //Label8.Visible = false;
                if (ddlThanhToan.SelectedValue == "1")
                {
                    RG.Visible = true;
                    RG.Columns[8].Visible = true;
                    btnLuu.Visible = false;
                   
                    RG.DataSource = Obj.Dt;
                    RG.DataBind();
                  
                }
                else
                {
                    RG.Columns[8].Visible = false;
                   // btnLuu.Visible = true;
                    RG.Visible = true;
                    RG.DataSource = Obj.Dt;
                    RG.DataBind();
                    //RGQuaNganHang.Visible = false;
                }
                
            }
            else
            {
                lbLoi.Text = "Không có chứng từ thanh toán";
                RG.Visible = false;
                LabelChiTietPTU.Visible = false;
                lbSoPhieu.Visible = false;
                GridView1.Visible = false;
               // btnLuu.Visible = false;
            }
        }
        //RG.DataSource = Obj.Dt;
        //RG.DataBind();
    }
    void FLoadChiTiet(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu"};
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "SP_LoadTraCuuChiTietCTTT";
        Sql.fGetData(Obj);
        GridView1.DataSource = Obj.Dt;
        GridView1.DataBind();
    }

    void UpdateTraCuuCTT(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu"};
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "SP_UpdatetracuuCTTT";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='blue'>Thanh toán thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Thanh toán thất bại.</font>";
        }

        
    }

    void UpdateTraPhieu(string sophieu)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoPhieu" };
        Obj.ValueParameter = new object[] { sophieu };
        Obj.SpName = "SP_UpdateTraPhieuThanhToan";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            lbLoi.Text = "<font color='blue'>Trả phiếu thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Trả phiếu thất bại.</font>";
        }


    }

  
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ChiTiet")
        {
            LabelChiTietPTU.Visible = true;
            lbSoPhieu.Visible = true;
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            lbSoPhieu.Text = commandArgsAccept[0].ToString();
            FLoadChiTiet(commandArgsAccept[0].ToString());
          
        }
        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateTraPhieu(commandArgsAccept[0].ToString());
            FloadTraCuuChungTuThanhToan();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FloadTraCuuChungTuThanhToan();
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }
  
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }

    protected void cbNganHang_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        RadComboBox cbNganHang = (RadComboBox)sender;
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_DanhMucNganHang_TraCuuCTTT";
        Sql.fGetData(Obj);
        cbNganHang.DataSource = Obj.Dt;
        cbNganHang.DataBind();
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlChungTu.SelectedValue == "TM")
        {
            foreach (GridDataItem item in RG.Items)
            {
              
                string sophieu = item["SoPhieu"].Text;
                CheckBox Ch_ThanhToan = (CheckBox)item.FindControl("ch_ThanhToan");
                if (Ch_ThanhToan.Checked == true)
                {
                    UpdateTraCuuCTT(sophieu);
                    FloadTraCuuChungTuThanhToan();
                }
            }
        }
        else if (ddlChungTu.SelectedValue == "NH")
        {
            foreach (GridDataItem item in RGQuaNganHang.Items)
            {

                string sophieu = item["SoPhieu"].Text;
                CheckBox Ch_ThanhToan = (CheckBox)item.FindControl("ch_ThanhToan");
               // RadComboBox cbNganHang = (RadComboBox)item.FindControl("cbNganHang");
                if (Ch_ThanhToan.Checked == true)
                {
                    UpdateTraCuuCTT(sophieu);
                    FloadTraCuuChungTuThanhToan();
                }
            }           
        }      
    }

    protected void ddlThanhToan_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LabelChiTietPTU.Visible = false;
        //lbSoPhieu.Visible = false;
        //GridView1.Visible = false;
    }
    protected void ddlChungTu_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LabelChiTietPTU.Visible = false;
        //lbSoPhieu.Visible = false;
        //GridView1.Visible = false;
    }
    protected void RGQuaNganHang_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //foreach (GridDataItem item in RGQuaNganHang.Items)
        //{
        //    (item["TenTaiKhoan"].FindControl("cbNganHang") as RadComboBox).Text = (item["TenTaiKhoan"].FindControl("hfNganHang") as HiddenField).Value;
        //    (item["TenTaiKhoan"].FindControl("cbNganHang") as RadComboBox).SelectedValue = (item["TenTaiKhoan"].FindControl("hfNganHang") as HiddenField).Value;
        //}
    }
    protected void RGQuaNganHang_SelectedCellChanged(object sender, EventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }
    protected void RGQuaNganHang_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }
    protected void RGQuaNganHang_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        FloadTraCuuChungTuThanhToan();
    }
    protected void RGQuaNganHang_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "ChiTiet")
        {
            LabelChiTietPTU.Visible = true;
            lbSoPhieu.Visible = true;
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            lbSoPhieu.Text = commandArgsAccept[0].ToString();
            FLoadChiTiet(commandArgsAccept[0].ToString());

        }
        if (e.CommandName == "TraPhieu")
        {
            string[] commandArgsAccept = e.CommandArgument.ToString().Split(new char[] { ',' });
            UpdateTraPhieu(commandArgsAccept[0].ToString());
            FloadTraCuuChungTuThanhToan();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            FloadTraCuuChungTuThanhToan();
        }
    }
    protected void ddlDonVi_SelectedIndexChanged(object sender, EventArgs e)
    {
        FLoadMaBPByIDCS();
    }
}