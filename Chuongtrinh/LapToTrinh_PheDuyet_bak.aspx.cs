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


public partial class Chuongtrinh_LapToTrinh_PheDuyet : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    clssys clss = new clssys();
    ReportDocument report = new ReportDocument();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            Session["SoToTrinh"] = String.Empty;
            Session["SoToTrinh_XemLai"] = String.Empty;
            FLoadIDMaCS();
            fLoadMaDV();
            fLoadToTrinh();
            fLoadChiTietToTrinh();

            rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang_Xem.Text = DateTime.Now.AddMonths(0).Month.ToString();
            fLoadMaDV_XemLai();
            fLoadToTrinh_XemLai();
            fLoadChiTietToTrinh_XemLai();                

        }
        if (Session["ChiTietPDToTrinh"] != null)
        {
            fLoadToTrinh();
            fLoadToTrinh_XemLai();
            Session["ChiTietPDToTrinh"] = null;
        }


    }
    #region Phe Duyet to trình

    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadChiTietToTrinh();
        }
    }  

   
    void fLoadMaDV()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };        
        Obj.SpName = "sp_ToTrinh_LoadMaDV_PheDuyet";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
        cbDonVi.SelectedIndex = 0;       
    }

    void FLoadIDMaCS()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { cbDonVi.SelectedValue };        
        Obj.SpName = "sp_LoadMaCSByMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaDV"].ToString();
            }
            catch { }

        }
        else
        {
            txtIDMaCS.Text = "Không tìm thấy";
        }

    } 
 

    protected void cbDonVi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        Session["SoToTrinh"] = String.Empty;
       
        FLoadIDMaCS();
     
      
        fLoadToTrinh();
        fLoadChiTietToTrinh();


    }
    void fLoadToTrinh()
    {
        if (cbDonVi.SelectedValue == "KDND")
        {
            RGToTrinh.Columns[5].Visible = true;
        }
        else
        {
            RGToTrinh.Columns[5].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { cbDonVi.SelectedValue };
        Obj.SpName = "sp_ToTrinh_PheDuyet_LoadRGToTrinh";
        Sql.fGetData(Obj);
        RGToTrinh.DataSource = Obj.Dt;
        RGToTrinh.DataBind();
    }

    void fLoadChiTietToTrinh()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh","@MaDV" };
        Obj.ValueParameter = new object[] { Session["SoToTrinh"], cbDonVi.SelectedValue };
        Obj.SpName = "sp_ToTrinh_Load_ChiTietToTrinh_PheDuyet";
        Sql.fGetData(Obj);
        RGChiTietToTrinh.DataSource = Obj.Dt;
        RGChiTietToTrinh.DataBind();
    }
    protected void cbPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (Session["SoToTrinh"].ToString() == "" || Session["SoToTrinh"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn tờ trình.</font>";
            fLoadToTrinh();
        }
        else
        {

            RadComboBox cbPD = (RadComboBox)sender;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh", "@HieuLucPD", "@GhiChuCuaLanhDao" };
            Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString(),  cbPD.SelectedValue ,"Đồng ý"};
            Obj.SpName = "sp_ToTrinh_BanTongGiamDoc_PheDuyet";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Phê duyệt tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã phê duyệt tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thành công.</font>";
                UpdateSoTien();               
                fLoadToTrinh();
                fLoadChiTietToTrinh();

                #region Load lại tờ trình cần xem
                fLoadMaDV_XemLai();
                fLoadToTrinh_XemLai();
                fLoadChiTietToTrinh_XemLai();
                #endregion


            }
           
        }

    }
   
    public void UpdateSoTien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { Session["SoToTrinh"] };
        Obj.SpName = "sp_ToTrinh_PheDuyet_GetMaNguoiLap_ByToTrinh";
        Sql.fGetData(Obj);
        string nguoigui  = Obj.Dt.Rows[0]["NguoiGoi"].ToString();
        string NVXemXet = Obj.Dt.Rows[0]["MaNVXemXet"].ToString();
        string NVPheDuyet = Obj.Dt.Rows[0]["NguoiNhan"].ToString();
        int nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        int thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
        string sototrinh = Session["SoToTrinh"].ToString();
        string MaBP = Obj.Dt.Rows[0]["MaDV"].ToString();
        string IDMaCS = Obj.Dt.Rows[0]["IDMaCS"].ToString();

        foreach (GridDataItem item in RGChiTietToTrinh.Items)
        {

            string mschiphi = item["MSChiphi"].Text;
            double sotien = double.Parse(item["Sotien"].Text);
            double tigia = double.Parse(item["TiGia"].Text);
            string idkhoa = IDMaCS + "-" + nam + thang;
            string idkhoact = IDMaCS + "-" + nam + thang + mschiphi + sototrinh;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_Khoa", "@MaDV", "@MaBP", "@MaNV", "@MaNVXX", "@MaNVPD", "@MSChiPhi", "@Nam", "@Thang", "@SoTien", "@SoToTrinh", "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { idkhoa, cbDonVi.SelectedValue, MaBP, nguoigui, NVXemXet, NVPheDuyet, mschiphi, nam, thang, sotien, sototrinh, idkhoact };
            //Obj.SpName = "sp_ChiTiet_NS_PhieuTU_UpdateSoTien";
            Obj.SpName = "sp_PheDuyetToTrinh_InsertKeHoachNganSach";
            Sql.fNonGetData(Obj);
        }
    }

     
    string countTT; 
  
  
    protected void RGToTrinh_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadToTrinh();
    }
    protected void RGToTrinh_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadToTrinh();
    }
    protected void RGToTrinh_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["SoToTrinh"] = RGToTrinh.SelectedValue == null ? "" : RGToTrinh.SelectedValue;
        fLoadChiTietToTrinh();
    }
    protected void RGToTrinh_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            lbLoi.Text = "";
            lbEmail.Text = "";
            lbXemLaiToTrinh.Text = "";
            RadCBoPD.SelectedValue = "False";
            RadCBoPD.Text = "Chưa duyệt";
            // txtToTrinh.Text = RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text;

            //txtPheDuyet.Text = clsConvertHelper.Tobool(RGToTrinh.Items[e.Item.ItemIndex]["KiemTra"].Text).ToString();

            // fLoadXX();



            if (e.Item.Selected == false)
            {
                Session["SoToTrinh"] = String.Empty;
                // txtToTrinh.Text = "";
                fLoadChiTietToTrinh();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadToTrinh();
        }
        switch (e.CommandName)
        {
            case "Email":

                     Obj = new clsObj();
                    Obj.Parameter = new string[] { "@SoToTrinh" };
                    Obj.ValueParameter = new object[] { RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                    Obj.SpName = "sp_ToTrinh_LayThongTin_BySoToTrinh";
                    Sql.fGetData(Obj);
                    bool hieulucpd = clsConvertHelper.Tobool(Obj.Dt.Rows[0]["HieuLucPD"].ToString());

                    if (hieulucpd == false)
                    {
                        lbLoi.Text = "<font color='red'>Chưa phê duyệt nên không gửi được email.</font>";
                    }
                    else
                    {

                    
                        #region Email
                        Obj = new clsObj();

                        Obj.Parameter = new string[] { "@MaDv" };
                        Obj.ValueParameter = new object[] { cbDonVi.SelectedValue };
                        Obj.Connectionstring = wqlvattu;
                        Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
                        Sql.fGetData(Obj);
                        if (Obj.Dt.Rows.Count > 0)
                        {
                            try
                            {
                                string email = Obj.Dt.Rows[0]["EmailXX"].ToString();
                                    //+ ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();
                                //string email = "itcenter@thaituan.com.vn";

                                string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                                string SB = "BAN TONG GIAM DOC PHE DUYET TO TRINH ";
                                string noidung = "";
                                // noidung += "Kinh gui anh(chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                                noidung += "Ban tong giam doc da phe duyet to trinh " + RGToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text;

                                noidung += "%0A" + "" + Session["Name"].ToString();
                                noidung += "";
                                clssys clss = new clssys();
                                noidung = clss.RemoveSign4VietnameseString(noidung);                            
                              
                                clss.SendMail(email,cc, SB, noidung);

                                
                            }
                            catch
                            {

                            }
                            finally
                            {

                            }
                        }
                        else
                        {
                            lbLoi.Text = "<font color='red'>Không gửi được email.</font>";
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
                    report.Load(Server.MapPath(@"~\Reports\rptToTrinh.rpt"));
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
    protected void RGChiTietToTrinh_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoadChiTietToTrinh();
    }
    protected void RGChiTietToTrinh_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoadChiTietToTrinh();
    }
    protected void RGToTrinh_ItemDataBound(object sender, GridItemEventArgs e)
    {
        foreach (GridDataItem item in RGToTrinh.Items)
        {
            (item["HieuLucPD"].FindControl("cbPheDuyet") as RadComboBox).Text = (item["HieuLucPD"].FindControl("hfPheDuyet") as HiddenField).Value;
            (item["HieuLucPD"].FindControl("cbPheDuyet") as RadComboBox).SelectedValue = (item["HieuLucPD"].FindControl("hfPheDuyet") as HiddenField).Value;
        }
    }
  
    protected void RadCBoPD_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        if (Session["SoToTrinh"].ToString() == "" || Session["SoToTrinh"].ToString() == null)
        {
            lbLoi.Text = "<font color='red'>Chưa chọn tờ trình.</font>";
            RadCBoPD.SelectedValue = "False";
            RadCBoPD.Text = "Chưa duyệt";
            fLoadToTrinh();
        }
        else
        {
            if (RadCBoPD.SelectedValue == "False")
            {
                Session["SoToTrinh"] = String.Empty;
               // lbLoi.Text = "<font color='red'>Chưa chọn tờ trình.</font>";
            }
            else
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@SoToTrinh", "@HieuLucPD", "@GhiChuCuaLanhDao" };
                Obj.ValueParameter = new object[] { Session["SoToTrinh"].ToString(), RadCBoPD.SelectedValue, "Đồng ý" };
                Obj.SpName = "sp_ToTrinh_BanTongGiamDoc_PheDuyet";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua < 1)
                {
                    lbLoi.Text = "<font color='red'>Phê duyệt tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='blue'>Đã phê duyệt tờ trình <b><font color='black'>" + Session["SoToTrinh"].ToString() + "</font></b> thành công.</font>";
                    UpdateSoTien();
                    fLoadToTrinh();
                    fLoadChiTietToTrinh();

                    #region Email
                    Obj = new clsObj();

                    Obj.Parameter = new string[] { "@MaDv" };
                    Obj.ValueParameter = new object[] { cbDonVi.SelectedValue };
                    Obj.Connectionstring = wqlvattu;
                    Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
                    Sql.fGetData(Obj);
                    if (Obj.Dt.Rows.Count > 0)
                    {
                        try
                        {
                            string email = Obj.Dt.Rows[0]["EmailXX"].ToString();
                            //+ ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();
                            //string email = "itcenter@thaituan.com.vn";

                            string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                            string SB = "BAN TONG GIAM DOC PHE DUYET TO TRINH ";
                            string noidung = "";
                            // noidung += "Kinh gui anh(chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                            noidung += "Ban tong giam doc da phe duyet to trinh " + Session["SoToTrinh"].ToString();

                            noidung += "%0A" + "" + Session["Name"].ToString();
                            noidung += "";
                            clssys clss = new clssys();
                            noidung = clss.RemoveSign4VietnameseString(noidung);
                            hlEmail.NavigateUrl = "mailto:" + email + "?subject=" + SB + "&body=" + noidung;
                            lbEmail.Text = "<font color='blue'>Vui lòng click nút Email.</font>";
                            // clss.SendMail(email, cc, SB, noidung);


                        }
                        catch
                        {

                        }
                        finally
                        {

                        }
                    }
                    else
                    {
                        lbLoi.Text = "<font color='red'>Không gửi được email.</font>";
                    }

                    #endregion

                    #region Load lại tờ trình cần xem
                   // fLoadMaDV_XemLai();
                    fLoadToTrinh_XemLai();
                    fLoadChiTietToTrinh_XemLai();
                    #endregion


                }
                Session["SoToTrinh"] = String.Empty;
            }

        }

    }
    #endregion
   
    #region xem lại tờ trinh
    void fLoadMaDV_XemLai()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_ToTrinh_LoadMaDV_PheDuyet";
        Sql.fGetData(Obj);
        ddlDonVi_XemLai.DataSource = Obj.Dt;
        ddlDonVi_XemLai.DataBind();
        ddlDonVi_XemLai.SelectedIndex = 0;
    }
    void fLoadToTrinh_XemLai()
    {
        if (ddlDonVi_XemLai.SelectedValue == "KDND")
        {
            RG_ToTrinh_XemLai.Columns[2].Visible = true;
        }
        else
        {          
            RG_ToTrinh_XemLai.Columns[2].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" ,"@Nam","@Thang"};
        Obj.ValueParameter = new object[] { ddlDonVi_XemLai.SelectedValue,int.Parse(rnNam_Xem.Text), int.Parse(rnThang_Xem.Text) };
        Obj.SpName = "sp_ToTrinh_PheDuyet_LoadRGToTrinh_XemLai";
        Sql.fGetData(Obj);
        RG_ToTrinh_XemLai.DataSource = Obj.Dt;
        RG_ToTrinh_XemLai.DataBind();
    }
    void fLoadChiTietToTrinh_XemLai()
    {

        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@SoToTrinh", "@MaDV" };
        //Obj.ValueParameter = new object[] { Session["SoToTrinh_XemLai"], ddlDonVi_XemLai.SelectedValue };
        //Obj.SpName = "sp_ToTrinh_Load_ChiTietToTrinh_XemLai_PheDuyet";
        //Sql.fGetData(Obj);
        //RG_ChiTiet_XemLai.DataSource = Obj.Dt;
        //RG_ChiTiet_XemLai.DataBind();
    }
    //protected void ddlDonVi_XemLai_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    //lbLoi.Text = "";
    //    //Session["SoToTrinh_XemLai"] = String.Empty;
    //    //fLoadToTrinh_XemLai();
    //    //fLoadChiTietToTrinh_XemLai();
    //}
    protected void RG_ToTrinh_XemLai_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            //lbLoi.Text = "";

            //if (e.Item.Selected == false)
            //{
            //    Session["SoToTrinh_XemLai"] = String.Empty;
             
            //    fLoadChiTietToTrinh_XemLai();
            //}
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoadToTrinh_XemLai();
        }
    }
    protected void RG_ToTrinh_XemLai_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Session["SoToTrinh_XemLai"] = RG_ToTrinh_XemLai.SelectedValue == null ? "" : RG_ToTrinh_XemLai.SelectedValue;
        //fLoadChiTietToTrinh_XemLai();
    }
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        fLoadToTrinh_XemLai();

    }
    protected void chkPheDuyet_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox TrangChu = sender as CheckBox;
        GridDataItem item = (GridDataItem)TrangChu.NamingContainer;
        string SoToTrinh = item.GetDataKeyValue("SoToTrinh").ToString();
        #region Luu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { SoToTrinh };
        Obj.SpName = "sp_ToTrinh_BoPheDuyet_Delele_ChiTietNS";
        Sql.fNonGetData(Obj);

        lbXemLaiToTrinh.Text = "<font color='red'>Bỏ phê duyệt.</font>";


        fLoadToTrinh_XemLai();


        fLoadToTrinh();
        fLoadChiTietToTrinh();
        #endregion


    }
    #endregion 

   
}