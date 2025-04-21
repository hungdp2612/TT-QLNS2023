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

public partial class Chuongtrinh_LapToTrinh_XemXet : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    GetTyGia gtg = new GetTyGia();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    
    ReportDocument report = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {           
            fLoadDonVi();

            Session["SoToTrinh"] = String.Empty;
           
            LoadNguoiPheDuyetTheoPhongBan();
            
            fLoadToTrinh();
            rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang_Xem.Text = DateTime.Now.AddMonths(0).Month.ToString();
          
            fLoadToTrinh_XemLai();
        }      
    }
  
   
    void fLoadToTrinh()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RGToTrinh.Columns[7].Visible = true;
        }
        else
        {
            RGToTrinh.Columns[7].Visible = false;
        }

        Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV","@MaNVXemXet" };
        //Obj.ValueParameter = new object[] { txtMaBP.Text, Session["UserID"].ToString() };
        //Obj.SpName = "sp_ToTrinh_Load_XemXet";

        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text };
        Obj.SpName = "sp_ToTrinh_Load_XemXet_ByMaDV";

        Sql.fGetData(Obj);
        RGToTrinh.DataSource = Obj.Dt;
        RGToTrinh.DataBind();
    }   
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };    
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
                //txtBoPhanGui.Text = Obj.Dt.Rows[0]["TenGoi"].ToString();
                
               // txtChucVuNguoiGui.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
                txtNguoiGui.Text = Obj.Dt.Rows[0]["Hoten"].ToString();
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
                Session["MaDV"] = TxtMaDV.Text;
            }
            catch { }
                
        }
        else
        {
          
        }
    }

 
    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text };
        Obj.Connectionstring = wqlvattu;
        Obj.SpName = "sp_NhanVien_NguoiNhan_Load";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
                txtBoPhanNhan.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
                cbNguoiPheDuyet.DataSource = Obj.Dt;
                cbNguoiPheDuyet.DataBind();
            }
            catch { }
        }
        else
        {
            
        }

        
    }

  

    protected void cbNguoiPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { cbNguoiPheDuyet.SelectedValue };
        Obj.Connectionstring = wqlvattu;
        Obj.SpName = "sp_NhanVien_NguoiNhan_GetChucVu_ByMaNV";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
                txtBoPhanNhan.Text = Obj.Dt.Rows[0]["TenDonVi"].ToString();
            }
            catch { }

        }
        else
        {
            txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
        }

    }
   
    void fLoadXX()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString() };
        Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                cbXemXet.Text = Obj.Dt.Rows[0]["KiemTra"].ToString();
                cbXemXet.SelectedValue = Obj.Dt.Rows[0]["KiemTra"].ToString();
                txtPheDuyet.Text = Obj.Dt.Rows[0]["HieuLucPD"].ToString();
            }
            catch { }
        }
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {      

        try
        {
            if (txtPheDuyet.Text == "True")
            {
                throw new Exception("Tờ trình đã phê duyệt nên không xem xét được nữa ...");
              
            }
            string nguoinhan = cbNguoiPheDuyet.SelectedValue;
            string bophannhan = txtBoPhanNhan.Text;
            string chucvunguoinhan = txtChucVuNguoiNhan.Text;

            #region Xem xét

            if (Session["SoToTrinh"].ToString() == "" || Session["SoToTrinh"].ToString() == null)
            {
                lbLoi.Text = "<font color='red'>Chưa chọn tờ trình.</font>";
                fLoadToTrinh();
                return;
            }         

            if (cbXemXet.SelectedValue == "False")
            {
                lbLoi.Text = "";
                lbEmail.Text = "";

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@NguoiNhan", "@BoPhanNhan", "@ChucVuNN","@NgayXX", "@KiemTra" };
                Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString(), Convert.DBNull, Convert.DBNull, Convert.DBNull, Convert.DBNull, cbXemXet.SelectedValue };

                Obj.SpName = "sp_ToTrinh_UpdateXemXet";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {

                    lbLoi.Text = "<font color='red'>Xem xét tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";

                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Bỏ xem xét.</font>";
                   
                  
                }

                fLoadToTrinh();
            }
            else
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@NguoiNhan", "@BoPhanNhan", "@ChucVuNN","@NgayXX", "@KiemTra" };
                Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString(), nguoinhan, bophannhan, chucvunguoinhan, DateTime.Now, cbXemXet.SelectedValue };


                Obj.SpName = "sp_ToTrinh_UpdateXemXet";

                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Xem xét tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thất bại.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Xem xét tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thành công.</font>";
                    #region Email

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString() };
                    Obj.SpName = "sp_ToTrinh_GuiEmail_GetMaNVPheDuyet";
                    Sql.fGetData(Obj);
                    string manvNguoiNhan = Obj.Dt.Rows[0]["NguoiNhan"].ToString();

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString() };
                    Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
                    Sql.fGetData(Obj);
                    bool xemxet = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["KiemTra"].ToString());

                    if (xemxet == false)
                    {
                        lbLoi.Text = "<font color='Red'>Tờ trình chưa xem xét nên không gửi được email.</font>";
                        fLoadToTrinh();
                    }
                    else
                    {
                        Obj = new clsObj();
                        Obj.Connectionstring = wqlvattu;
                        Obj.Parameter = new string[] { "@manv" };
                        Obj.ValueParameter = new object[] { manvNguoiNhan };
                        Obj.SpName = "Sp_GuiEmailDenBanTGD";
                        Sql.fGetData(Obj);
                        if (Obj.Dt.Rows.Count > 0)
                        {
                            try
                            {
                                foreach (DataRow row in Obj.Dt.Rows)
                                {

                                    emailthuky = row["EMAILTHUKY"].ToString();
                                    email = row["Email"].ToString();
                                }

                                string email1 = emailthuky + ";" + email;

                                // string cc = Obj.Dt.Rows[0]["Email"].ToString();

                                string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET TO TRINH " + Session["SoToTrinh"].ToString();
                                string noidung = "";
                                noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                                noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt to trinh " + Session["SoToTrinh"].ToString() + " cua " + TxtMaDV.Text + "%0D%0A";
                                noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/LapToTrinh_PheDuyet.aspx";

                                noidung += "%0D%0ATran Trong ! %0D%0A ";
                                noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                                noidung += "";
                                clssys clss = new clssys();
                                noidung = clss.RemoveSign4VietnameseString(noidung);
                                hlEmail.NavigateUrl = "mailto:" + email + "?cc=" + emailthuky + "&subject=" + SB + "&body=" + noidung;
                                lbEmail.Text = "<font color='blue'>Vui lòng click nút Email.</font>";
                                //clss.SendMail(email, emailthuky, SB, noidung);

                            }
                            catch { }
                        }
                        else
                        {
                            lbLoi.Text = "<font color='red'>Gửi email thất bại.</font>";
                        }
                    }
                    #endregion
                }

                fLoadToTrinh();
            }
            #endregion
        }
        catch (Exception ex)
        {
            lbLoi.Text ="<font color='red'> "+ex.Message + "</font>";
        }

    }



    protected void RGToTrinh_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadToTrinh();
    }
    protected void RGToTrinh_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadToTrinh();
    }
   
    string countTT;
    string emailthuky, email;
    protected void RGToTrinh_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            lbLoi.Text = "";
            lbEmail.Text = "";
           // txtToTrinh.Text = RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
            Session["SoToTrinh"] = RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
            //txtPheDuyet.Text = clsConvertHelper.Tobool(RGToTrinh.Items[e.Item.ItemIndex]["KiemTra"].Text).ToString();
         
            fLoadXX();

            if (e.Item.Selected == false)
            {
                Session["SoToTrinh"] = String.Empty;
                //txtToTrinh.Text = String.Empty;
            }
           

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadToTrinh();
        }
        switch (e.CommandName)
        {
            case "Email":
                lbLoi.Text = "";
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh" };
                Obj.ValueParameter = new object[] { RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                Obj.SpName = "sp_ToTrinh_ChiTietToTrinh_Count";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTT = Obj.Dt.Rows[0]["CountToTrinh"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTT) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tờ trình nên không gửi được email.</font>";
                    fLoadToTrinh();
                }
                else
                {
                    #region Email

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                    Obj.SpName = "sp_ToTrinh_GuiEmail_GetMaNVPheDuyet";
                    Sql.fGetData(Obj);
                    string manvNguoiNhan = Obj.Dt.Rows[0]["NguoiNhan"].ToString();

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                    Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
                    Sql.fGetData(Obj);
                    bool xemxet = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["KiemTra"].ToString());

                    if (xemxet == false)
                    {
                        lbLoi.Text = "<font color='Red'>Tờ trình chưa xem xét nên không gửi được email.</font>";
                        fLoadToTrinh();
                    }
                    else
                    {
                        Obj = new clsObj();
                        Obj.Connectionstring = wqlvattu;
                        Obj.Parameter = new string[] { "@manv" };
                        Obj.ValueParameter = new object[] { manvNguoiNhan };
                        Obj.SpName = "Sp_GuiEmailDenBanTGD";
                        Sql.fGetData(Obj);
                        if (Obj.Dt.Rows.Count > 0)
                        {
                            try
                            {
                                foreach (DataRow row in Obj.Dt.Rows)
                                {

                                    emailthuky = row["EMAILTHUKY"].ToString();
                                    email = row["Email"].ToString();
                                }

                                string email1 = emailthuky + ";" + email;

                                // string cc = Obj.Dt.Rows[0]["Email"].ToString();

                                string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET TO TRINH " + RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
                                string noidung = "";
                                noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                                noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt to trinh " + RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text + " cua " + TxtMaDV.Text + "%0D%0A";
                                noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/LapToTrinh_PheDuyet.aspx";

                                noidung += "%0D%0ATran Trong ! %0D%0A ";
                                noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                                noidung += "";
                                clssys clss = new clssys();
                                noidung = clss.RemoveSign4VietnameseString(noidung);
                                clss.SendMail(email, emailthuky, SB, noidung);

                            }
                            catch { }
                        }
                        else
                        {
                            lbLoi.Text = "<font color='red'>Gửi email thất bại.</font>";
                        }
                    }
                    #endregion
                }
                break;
            case "PRINT":
                lbLoi.Text = "";
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh" };
                Obj.ValueParameter = new object[] { RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                Obj.SpName = "sp_ToTrinh_ChiTietToTrinh_Count";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTT = Obj.Dt.Rows[0]["CountToTrinh"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTT) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tờ trình nên không in được.</font>";
                    // fLoad();
                }
                else
                {


                    #region Lấy report
                    report = ReportFactory.GetReport(report.GetType());

                    if (TxtMaDV.Text == "TT.TH-TK")
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptToTrinh_TinHoc.rpt"));
                    }
                    else
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptToTrinh.rpt"));
                    }

                  //  report.Load(Server.MapPath(@"~\Reports\rptToTrinh.rpt"));
                    report.SetParameterValue("@SoToTrinh", RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text);

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

    #region Xem lại tờ trình
    void fLoadToTrinh_XemLai()
    {
        Obj = new clsObj();
              Obj.Parameter = new string[] { "@MaDV","@Nam","@Thang" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text,int.Parse(rnNam_Xem.Text),int.Parse(rnThang_Xem.Text) };
        Obj.SpName = "sp_XemXetToTrinh_XemLaiToTrinh";

        Sql.fGetData(Obj);
        RG_XemToTrinh.DataSource = Obj.Dt;
        RG_XemToTrinh.DataBind();
    }   
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        fLoadToTrinh_XemLai();
    }
  
    protected void RG_XemToTrinh_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadToTrinh_XemLai();
        }
        switch (e.CommandName)
        {
            case "PRINT":
                lbLoi.Text = "";
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh" };
                Obj.ValueParameter = new object[] { RG_XemToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                Obj.SpName = "sp_ToTrinh_ChiTietToTrinh_Count";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        countTT = Obj.Dt.Rows[0]["CountToTrinh"].ToString();

                    }
                    catch { }
                }
                else { }
                if (int.Parse(countTT) == 0)
                {
                    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tờ trình nên không in được.</font>";
                  
                }
                else
                {


                    #region Lấy report
                    report = ReportFactory.GetReport(report.GetType());
                    if (TxtMaDV.Text == "TT.TH-TK")
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptToTrinh_TinHoc.rpt"));
                    }
                    else
                    {
                        report.Load(Server.MapPath(@"~\Reports\rptToTrinh.rpt"));
                    }
                    report.SetParameterValue("@SoToTrinh", RG_XemToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text);

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

    #endregion
}