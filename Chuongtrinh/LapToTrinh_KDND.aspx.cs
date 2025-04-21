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

public partial class Chuongtrinh_LapToTrinh_KDND : clsPhanQuyenCaoCap
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
           
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();
            fLoadMaDV();
            FLoadMaBPByIDCS();
       
            fLoadDonVi();
            LoadNguoiPheDuyetTheoPhongBan();
       
         
            fLoad();

          //  fLoadLoaiTien();

            //fLoadTiGia();

        }
        if (Session["ReloadChiTietToTrinh"] != null)
        {
            FLoadMaBPByIDCS();
            fLoad();
            Session["ReloadChiTietToTrinh"] = null;
        }
    }

    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@NguoiGoi" };
        Obj.ValueParameter = new object[] { mabp, Session["UserID"].ToString() };
        Obj.SpName = "[sp_ToTrinh_KDND_Load]";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }

    void fLoadMaDV()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] {  };
        Obj.ValueParameter = new object[] {  };     
        Obj.SpName = "sp_ToTrinh_KDND_GetMaBP";
        Sql.fGetData(Obj);
        ddlMaDV.DataSource = Obj.Dt;
        ddlMaDV.DataBind();
       
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
              

                txtChucVuNguoiGui.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
              //  txtNguoiGui.Text = Obj.Dt.Rows[0]["Hoten"].ToString();               
                Session["MaDV"] = TxtMaDV.Text;
            }
            catch { }

        }
        else
        {
           
        }

    }

    //void fLoadLoaiTien()
    //{
    //    Obj = new clsObj();
    //    Obj.Parameter = new string[] { };
    //    Obj.ValueParameter = new object[] { };
    //    Obj.SpName = "sp_CbLoaiTien_Load";
    //    Sql.fGetData(Obj);
    //    cbLoaiTien.DataSource = Obj.Dt;
    //    cbLoaiTien.DataBind();
    //}
    //void fLoadTiGia()
    //{
    //    if (cbLoaiTien.SelectedValue == "VND" || cbLoaiTien.SelectedValue=="")
    //    {
    //        rnTyGia.Value = 1;
    //    }
    //    else
    //    {
    //        string TiGia = gtg.ExchangeRates(cbLoaiTien.SelectedValue);
    //        if (TiGia != "")
    //        {
    //            rnTyGia.Value = double.Parse(gtg.ExchangeRates(cbLoaiTien.SelectedValue));
    //        }
    //        else
    //        {
    //            rnTyGia.Text = "";
    //        }

    //    }
    //}

  
    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDv" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
       
        Obj.SpName = "sp_ToTrinh_KDND_NguoiPheDuyet";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                cbNguoiPheDuyet.DataSource = Obj.Dt;
                cbNguoiPheDuyet.DataBind();
                txtChucVuNguoiNhan.Text = Obj.Dt.Rows[0]["ChucVu"].ToString();
               
              
                txtBoPhanNhan.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            }
            catch { }
        }
        else
        {

        }


    }
  
    string countTT;
   
    protected void cbNguoiPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
    }
    string mabp;
    void FLoadMaBPByIDCS()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@IDMaCS" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };

        Obj.SpName = "sp_ToTrinh_KeToan_GetIDCoSo2";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                mabp = Obj.Dt.Rows[0]["MaBP"].ToString();

            }
            catch { }

        }
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        FLoadMaBPByIDCS();
        string sototrinh;
        string veviec = txtVeViec.Text;
       
     
        string nguoigui = Session["UserID"].ToString();    
     
        string chucvunguoigui = txtChucVuNguoiGui.Text;     
       

       // string tigia = rnTyGia.Text;
        
        #region Tạo to trinh

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { ddlMaDV.SelectedValue };
        Obj.SpName = "sp_TaoToTrinh";
        Sql.fGetData(Obj);

        if (Obj.Dt.Rows.Count < 1)
        {
            lbLoi.Text = "<font color='red'>Không tạo được tờ trình.</font>";
            return;
        }
        else
        {
            sototrinh = Obj.Dt.Rows[0]["ToTrinh"].ToString();
        }
        #endregion

        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh", "@Nam", "@Thang", "@VeViec", "@NguoiGoi", "@ChucVuNG", "@MaDV", "@MaNVXemXet", "@NguoiNhan", "@BoPhanNhan", "@ChucVuNN", "@LoaiTien", "@TiGia" };
        Obj.ValueParameter = new object[] { sototrinh, int.Parse(rnNam.Text), int.Parse(rnThang.Text), veviec, nguoigui, chucvunguoigui, mabp, nguoigui, cbNguoiPheDuyet.SelectedValue, txtBoPhanNhan.Text, txtChucVuNguoiNhan.Text, "VND", 1 };



        Obj.SpName = "sp_ToTrinh_KDND_Insert";

            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Đã có tờ trình <b><font color='black'>" + sototrinh + "</font></b> trong danh sách.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Thêm tờ trình <b><font color='black'>" + sototrinh + "</font></b> thành công.</font>";
            }

      
        #endregion
        fLoad();
    }
    //string countTT;
    string emailthuky, email;
    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        lbLoi.Text = "";
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {

            RG.MasterTableView.IsItemInserted = false;
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/LapToTrinh_Update.ascx";
            fLoad();
        }

        switch (e.CommandName)
        {
            case RadGrid.FilterCommandName:
                fLoad();
                break;
            case RadGrid.RebindGridCommandName:
                fLoad();
                break;

            case "Email":
                lbLoi.Text = "";
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh" };
                Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
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
                    FLoadMaBPByIDCS();
                    fLoad();
                }
                else
                {
                    #region Email

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                    Obj.SpName = "sp_ToTrinh_GuiEmail_GetMaNVPheDuyet";
                    Sql.fGetData(Obj);
                    string manvNguoiNhan = Obj.Dt.Rows[0]["NguoiNhan"].ToString();

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                    Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
                    Sql.fGetData(Obj);
                    bool xemxet = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["KiemTra"].ToString());

                    if (xemxet == false)
                    {
                        lbLoi.Text = "<font color='Red'>Tờ trình chưa xem xét nên không gửi được email.</font>";
                        fLoad();
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

                                string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET TO TRINH " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
                                string noidung = "";
                                noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                                noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt to trinh " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text + "%0D%0A";
                                noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/LapToTrinh_PheDuyet.aspx";

                                noidung += "%0D%0ATran Trong ! %0D%0A ";
                                noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                                noidung += "";
                                clssys clss = new clssys();
                                noidung = clss.RemoveSign4VietnameseString(noidung);
                                clss.SendMail(email, "", SB, noidung);

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
                Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
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
                    fLoad();
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


                    // report.Load(Server.MapPath(@"~\Reports\rptToTrinh.rpt"));
                    report.SetParameterValue("@SoToTrinh", RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text);

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
  
    int demtotrinh;
    string manv;
    bool ktkiemtra;
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };

        Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                manv = Obj.Dt.Rows[0]["NguoiGoi"].ToString();

            }
            catch { }
        }
        else
        {

        }
        if (manv == Session["UserID"].ToString())
        {
            //if (clsConvertHelper.Tobool(RG.Items[e.Item.ItemIndex]["KiemTra"].Text) == true)
            //{
            //    lbLoi.Text = "<font color='red'>Tờ trình  <b><font color='black'> " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text + "</font></b> đã được phê duyệt nên không xóa được.</font>";
            //    fLoad();
            //}
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh" };
            Obj.ValueParameter = new object[] { RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text };

            Obj.SpName = "sp_ToTrinh_KeToan_LayThongTinPheDuyetBySoToTrinh";
            Sql.fGetData(Obj);
            if (Obj.KetQua < 1)
            {
                try
                {
                    ktkiemtra = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["HieuLucPD"].ToString());

                }
                catch { }
            }
            else
            {

            }
            if (ktkiemtra == true)
            {
                lbLoi.Text = "<font color='red'>Tờ trình  <b><font color='black'> " + RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text + "</font></b> đã được xác nhận nên không xóa được.</font>";
                FLoadMaBPByIDCS();
                fLoad();
            }

            else
            {

                string SoToTrinh = RG.Items[e.Item.ItemIndex]["SoToTrinh"].Text;
                string MaDV = RG.Items[e.Item.ItemIndex]["MaDV"].Text;
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@MaDV" };
                Obj.ValueParameter = new object[] { SoToTrinh, MaDV };
                Obj.SpName = "sp_ToTrinh_DemChiTietToTrinh";
                Sql.fGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    try
                    {
                        demtotrinh = int.Parse(Obj.Dt.Rows[0]["DemChiTietToTrinh"].ToString());

                    }
                    catch { }
                }
                else
                {

                }
                if (demtotrinh == 0)
                {
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { SoToTrinh };
                    Obj.SpName = "sp_ToTrinh_Delete";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
                    }
                    FLoadMaBPByIDCS();
                    fLoad();
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Đã có chi tiết tờ trình nên không xóa được.</font>";
                    FLoadMaBPByIDCS();
                    fLoad();
                }
            }
        }
        else
        {
            lbLoi.Text = "<font color='red'>Không xóa được tờ trình của người khác.</font>";
            FLoadMaBPByIDCS();
            fLoad();
        }


    }
    protected void RG_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        fLoad();
    } 


    protected void cbLoaiTien_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
       // fLoadTiGia();
    }
    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }
    protected void ddlMaDV_SelectedIndexChanged(object sender, EventArgs e)
    {
      
        cbNguoiPheDuyet.Text = "";
        txtBoPhanNhan.Text = "";
        txtChucVuNguoiNhan.Text = "";      
        FLoadMaBPByIDCS();
     
        LoadNguoiPheDuyetTheoPhongBan();
        fLoad();
    }   
}