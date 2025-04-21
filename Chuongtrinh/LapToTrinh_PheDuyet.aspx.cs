using System;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Data;
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
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();          
       
            FLoadIDMaCS();
            fLoadMaDV("");
            FLOAD_CBO_TOTRINH();          
            fLoadChiTietToTrinh();



            rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang_Xem.Text = DateTime.Now.AddMonths(0).Month.ToString();

            fLoadMaDV_XemLai("");
            FLOAD_CBO_TOTRINH2("");
         
            fLoadToTrinh_XemLai();
                       

        }
        if (Session["ChiTietPDToTrinh"] != null)
        {
         
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

   
    void fLoadMaDV(string KEY)
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@KEY" };
        //Obj.ValueParameter = new object[] { KEY};   
        //Obj.SpName = "sp_ToTrinh_LoadMaDV_PheDuyet_TGD";
        //Sql.fGetData(Obj);
        //cbDonVi.DataSource = Obj.Dt;
        //cbDonVi.DataBind();
        //cbDonVi.SelectedIndex = 0;       

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MANV", "@KEY" };
        Obj.ValueParameter = new object[] {Session["UserID"].ToString() ,KEY };
        Obj.SpName = "SP_PHEDUYETTOTRINH_BY_MANVPD_LOAD_PHONGBAN";
        Sql.fGetData(Obj);
        cbDonVi.DataSource = Obj.Dt;
        cbDonVi.DataBind();
        cbDonVi.SelectedIndex = 0;       
    }

    void FLOAD_CBO_TOTRINH()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV", "@NAM", "@THANG" };
        Obj.ValueParameter = new object[] { cbDonVi.SelectedValue , int.Parse(rnNam.Text), int.Parse(rnThang.Text)};
        Obj.SpName = "SP_TOTRINH_PHEDUYET_LOAD_BY_MADV_NAM_THANG";
        Sql.fGetData(Obj);
        cboToTrinh.DataSource = Obj.Dt;
        cboToTrinh.DataBind();
        cboToTrinh.SelectedIndex = 0;
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

    protected void cbDonVi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaDV(e.Text);

    }
    protected void cbDonVi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        cboToTrinh.Text = "";
        FLOAD_CBO_TOTRINH();

        FLoadIDMaCS();
     
      
     
        fLoadChiTietToTrinh();


    }
    protected void cboToTrinh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadChiTietToTrinh();
    }
   

    void fLoadChiTietToTrinh()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { cboToTrinh.SelectedValue };
        Obj.SpName = "SP_PHEDUYET_CHITIETTOTRINH_BY_SOTOTRINH";
        Sql.fGetData(Obj);
        RGChiTietToTrinh.DataSource = Obj.Dt;
        RGChiTietToTrinh.DataBind();
    }

  
   
    public void UpdateSoTien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { txtToTrinh.Text };
        Obj.SpName = "sp_ToTrinh_PheDuyet_GetMaNguoiLap_ByToTrinh";
        Sql.fGetData(Obj);
        string nguoigui  = Obj.Dt.Rows[0]["NguoiGoi"].ToString();
        string NVXemXet = Obj.Dt.Rows[0]["MaNVXemXet"].ToString();
        string NVPheDuyet = Obj.Dt.Rows[0]["NguoiNhan"].ToString();
        int nam = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        int thang = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
        string sototrinh = txtToTrinh.Text;
        string MaBP = Obj.Dt.Rows[0]["MaDV"].ToString();
        string IDMaCS = Obj.Dt.Rows[0]["IDMaCS"].ToString();
       

        foreach (GridDataItem item in RGChiTietToTrinh.Items)
        {

            string mschiphi = item["MSChiphi"].Text;
            double sotien = double.Parse(item["Sotien"].Text);
           
            string idkhoa = IDMaCS + "-" + nam + thang;
            string idkhoact = IDMaCS + "-" + nam + thang + mschiphi + sototrinh;
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_Khoa", "@MaDV", "@MaBP", "@MaNV", "@MaNVXX", "@MaNVPD", "@MSChiPhi", "@Nam", "@Thang", "@SoTien", "@SoToTrinh", "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { idkhoa, cbDonVi.SelectedValue, MaBP, nguoigui, NVXemXet, NVPheDuyet, mschiphi, nam, thang, sotien, sototrinh, idkhoact };
           
            Obj.SpName = "sp_PheDuyetToTrinh_InsertKeHoachNganSach";
            Sql.fNonGetData(Obj);
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
    
    protected void RadCBoPD_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        txtToTrinh.Text = "";
        txtToTrinh.Text = cboToTrinh.SelectedValue;

        try
        {

            Obj = new clsObj
            {
                Parameter = new string[] {"@SoToTrinh", "@HieuLucPD", "@GhiChuCuaLanhDao"},
                //ValueParameter = new object[] {txtToTrinh.Text, RadCBoPD.SelectedValue, "Đồng ý"},
                ValueParameter = new object[] {txtToTrinh.Text, RadCBoPD.SelectedValue, "Đồng ý" },
                SpName = "sp_ToTrinh_BanTongGiamDoc_PheDuyet"
            };
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Phê duyệt tờ trình <b><font color='black'>" + txtToTrinh.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Đã phê duyệt tờ trình <b><font color='black'>" + txtToTrinh.Text + "</font></b> thành công.</font>";
                UpdateSoTien();


                FLOAD_CBO_TOTRINH();
                fLoadChiTietToTrinh();

                #region Email

                Obj = new clsObj
                {
                    Parameter = new string[] {"@MaDv"},
                    ValueParameter = new object[] {cbDonVi.SelectedValue},
                    Connectionstring = wqlvattu,
                    SpName = "sp_NguoiPD_GuiMailChoDV"
                };

                Sql.fGetData(Obj);
                if (Obj.Dt.Rows.Count > 0)
                {

                    string email = Obj.Dt.Rows[0]["EmailXX"].ToString();

                    string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string SB = "BAN TONG GIAM DOC PHE DUYET TO TRINH ";
                    string noidung = "";

                    noidung += "Ban tong giam doc da phe duyet to trinh " + txtToTrinh.Text;

                    noidung += "%0A" + "" + Session["Name"].ToString();
                    noidung += "";
                    clssys clss = new clssys();
                    noidung = clss.RemoveSign4VietnameseString(noidung);
                    hlEmail.NavigateUrl = "mailto:" + email + "?subject=" + SB + "&body=" + noidung;
                    lbEmail.Text = "<font color='blue'>Vui lòng click nút Email.</font>";
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Không gửi được email.</font>";
                }

                #endregion

                FLOAD_CBO_TOTRINH2("");
                fLoadToTrinh_XemLai();

                RadCBoPD.SelectedValue = "FALSE";

            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }
    }
    
    
    public double fInt(object Value)
    {
        return Convert.ToDouble(Value.ToString());
    }


    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        cboToTrinh.Text = "";
        FLOAD_CBO_TOTRINH();
        fLoadChiTietToTrinh();
    }
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        cboToTrinh.Text = "";
        FLOAD_CBO_TOTRINH();
        fLoadChiTietToTrinh();
    }

    protected void rnSoTien_PD_TextChanged(object sender, EventArgs e)
    {

        Telerik.Web.UI.RadNumericTextBox rnSoTien = (Telerik.Web.UI.RadNumericTextBox)sender;

        if (rnSoTien.Text == "")
        {
            rnSoTien.Text = "0";
        }

        int Dem = 0;

        for (int i = 0; i < RGChiTietToTrinh.Items.Count; i++)
        {
            Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGChiTietToTrinh.Items[i].FindControl("rnSoTien_PD");
             //TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[i].FindControl("txtGhiChuDuyet");
            if (rnSoTien.Value == rnSoTienRG.Value)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { cboToTrinh.SelectedValue, MSChiPhi, rnSoTien.Value, "" };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);
        //if (Obj.KetQua > 0)
        //{
        //    lbLoi.Text = "<font color='blue'>Cập nhật thành công.</font>";
        //}
        //else
        //{
        //    lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
        //}

        fLoadChiTietToTrinh();
    }

    protected void txtGhiChuDuyet_TextChanged(object sender, EventArgs e)
    {
        TextBox tbGhiChu = (TextBox)sender;

        int Dem = 0;

        for (int i = 0; i < RGChiTietToTrinh.Items.Count; i++)
        {

            TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[i].FindControl("txtGhiChuDuyet");
            if (tbGhiChu == txtGhiChuDuyet)
            {
                break;
            }
            Dem += 1;

        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGChiTietToTrinh.Items[Dem].FindControl("rnSoTien_PD");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { cboToTrinh.SelectedValue, MSChiPhi, Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);

        fLoadChiTietToTrinh();
    }
    #endregion
    #region xem lại tờ trinh
    void fLoadMaDV_XemLai( string KEY)
    {
       
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MANV", "@KEY" };
        Obj.ValueParameter = new object[] {Session["UserID"].ToString() ,KEY };
        Obj.SpName = "SP_PHEDUYETTOTRINH_BY_MANVPD_LOAD_PHONGBAN";
        Sql.fGetData(Obj);
        ddlDonVi_XemLai.DataSource = Obj.Dt;
        ddlDonVi_XemLai.DataBind();
        ddlDonVi_XemLai.SelectedIndex = 0;
    }
    void fLoadToTrinh_XemLai()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue };
        Obj.SpName = "SP_PHEDUYET_CHITIETTOTRINH_BY_SOTOTRINH";
        Sql.fGetData(Obj);
        RG_XemLai.DataSource = Obj.Dt;
        RG_XemLai.DataBind();
    }
    protected void RG_ToTrinh_XemLai_ItemCommand(object sender, GridCommandEventArgs e)
    {       
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
     protected void chkPheDuyet_CheckedChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        txtToTrinh.Text = "";

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

        FLOAD_CBO_TOTRINH();
        fLoadChiTietToTrinh();
        #endregion


    }
    void FLOAD_CBO_TOTRINH2(string KEY)
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV", "@NAM", "@THANG", "@MANV", "@KEY" };
        Obj.ValueParameter = new object[] { ddlDonVi_XemLai.SelectedValue, int.Parse(rnNam_Xem.Text), int.Parse(rnThang_Xem.Text), Session["UserID"].ToString(),KEY };

        Obj.SpName = "SP_TOTRINH_DAPHEDUYET_LOAD_BY_MADV_NAM_THANG";
        Sql.fGetData(Obj);
        cboToTrinh2.DataSource = Obj.Dt;
        cboToTrinh2.DataBind();
        cboToTrinh2.SelectedIndex = 0;
    }
    protected void ddlDonVi_XemLai_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaDV_XemLai(e.Text);
      
    }
    protected void ddlDonVi_XemLai_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        cboToTrinh2.Text = "";
        FLOAD_CBO_TOTRINH2("");
        fLoadToTrinh_XemLai();
        
    }
    protected void rnNam_Xem_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        cboToTrinh2.Text = "";
        FLOAD_CBO_TOTRINH2("");
        fLoadToTrinh_XemLai();
        
    }
    protected void rnThang_Xem_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        cboToTrinh2.Text = "";
        FLOAD_CBO_TOTRINH2("");
        fLoadToTrinh_XemLai();
        
    }
    protected void cboToTrinh2_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        FLOAD_CBO_TOTRINH2(e.Text);
    }
    protected void cboToTrinh2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        fLoadToTrinh_XemLai();
    }
    protected void cboBoPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLaiToTrinh.Text = "";
        lbXemLai_Email.Text = "";
        txtToTrinh2.Text = cboToTrinh2.SelectedValue;

        try
        {
            if (cboBoPheDuyet.SelectedValue == "TRUE")
            {
                throw new Exception("Đã phê duyệt");
            }

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh" };
            Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue };
            Obj.SpName = "sp_ToTrinh_BoPheDuyet_Delele_ChiTietNS";
            Sql.fNonGetData(Obj);

            if (Obj.KetQua < 1)
            {
                lbXemLaiToTrinh.Text = "<font color='red'>Phê duyệt tờ trình <b><font color='black'>" + txtToTrinh2.Text + "</font></b> thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbXemLaiToTrinh.Text = "<font color='blue'>Đã bỏ phê duyệt tờ trình <b><font color='black'>" + txtToTrinh2.Text + "</font></b> thành công.</font>";

                #region Email
                Obj = new clsObj();

                Obj.Parameter = new string[] { "@MaDv" };
                Obj.ValueParameter = new object[] { ddlDonVi_XemLai.SelectedValue };
                Obj.Connectionstring = wqlvattu;
                Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
                Sql.fGetData(Obj);
                if (Obj.Dt.Rows.Count > 0)
                {
                    try
                    {
                        string email = Obj.Dt.Rows[0]["EmailXX"].ToString();

                        string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                        string SB = "BAN TONG GIAM DOC DA BO PHE DUYET TO TRINH " + txtToTrinh2.Text;
                        string noidung = "";

                        noidung += "Ban tong giam doc da bo phe duyet to trinh " + txtToTrinh2.Text;

                        noidung += "%0A" + "" + Session["Name"].ToString();
                        noidung += "";
                        clssys clss = new clssys();
                        noidung = clss.RemoveSign4VietnameseString(noidung);
                        hl_EmailBoDuyet.NavigateUrl = "mailto:" + email + "?subject=" + SB + "&body=" + noidung;
                        lbXemLai_Email.Text = "<font color='blue'>Vui lòng click nút Email.</font>";


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
        }
        catch (Exception ex)
        {
            lbXemLaiToTrinh.Text = "<font style='color:Red'>" + ex.Message + "</font>";
        }

        finally
        {
            FLOAD_CBO_TOTRINH2("");
            fLoadToTrinh_XemLai();

            FLOAD_CBO_TOTRINH();
            fLoadChiTietToTrinh();

            cboBoPheDuyet.SelectedValue = "TRUE";
            cboToTrinh2.Text = "";
        }

       
    }
    protected void rnSoTien_PD2_TextChanged(object sender, EventArgs e)
    {
        Telerik.Web.UI.RadNumericTextBox rnSoTien = (Telerik.Web.UI.RadNumericTextBox)sender;

        if (rnSoTien.Text == "")
        {
            rnSoTien.Text = "0";
        }

        int Dem = 0;

        for (int i = 0; i < RG_XemLai.Items.Count; i++)
        {
            Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RG_XemLai.Items[i].FindControl("rnSoTien_PD2");
            if (rnSoTien.Value == rnSoTienRG.Value)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RG_XemLai.Items[Dem]["MSChiPhi"].Text;
        TextBox txtGhiChuDuyet = (TextBox)RG_XemLai.Items[Dem].FindControl("txtGhiChuDuyet2");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue, MSChiPhi, rnSoTien.Value, txtGhiChuDuyet.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);
       

        fLoadToTrinh_XemLai();
    }
    protected void txtGhiChuDuyet2_TextChanged(object sender, EventArgs e)
    {
        TextBox tbGhiChu = (TextBox)sender;

        int Dem = 0;

        for (int i = 0; i < RG_XemLai.Items.Count; i++)
        {

            TextBox txtGhiChuDuyet = (TextBox)RG_XemLai.Items[i].FindControl("txtGhiChuDuyet2");
            if (tbGhiChu == txtGhiChuDuyet)
            {
                break;
            }
            Dem += 1;

        }

        string MSChiPhi = RG_XemLai.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RG_XemLai.Items[Dem].FindControl("rnSoTien_PD2");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIEN", "@GHICHUDUYET" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue, MSChiPhi, Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_BANTGD_HIEUCHINH";
        Sql.fNonGetData(Obj);

        fLoadToTrinh_XemLai();
    }
    #endregion
    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        lbXemLai_Email.Text = "";
        lbXemLaiToTrinh.Text = "";

        RadCBoPD.SelectedValue = "FALSE";
        cboBoPheDuyet.SelectedValue = "True";
    }
}