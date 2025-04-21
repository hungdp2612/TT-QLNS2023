using System;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using Data;
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
            rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang.Text = DateTime.Now.AddMonths(0).Month.ToString();

            fLoadDonVi();
            LoadNguoiPheDuyetTheoPhongBan();
            FLOAD_CBO_TOTRINH();
            fLoadChiTietToTrinh();

            #region TAB 2


            rnNam2.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang2.Text = DateTime.Now.AddMonths(0).Month.ToString();

            FLOAD_CBO_TOTRINH2();
            fLoadChiTietToTrinh2();
            #endregion


            rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            rnThang_Xem.Text = DateTime.Now.AddMonths(0).Month.ToString();

            fLoadToTrinh_XemLai();
        }
    }
    #region TAB1
    void fLoadDonVi()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaNV" },
            ValueParameter = new object[] { Session["UserID"].ToString() },
            SpName = "SP_LoadNVIDMaDV"
        };
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {
                TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();

                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
            catch { }

        }
        else
        {

        }
    }

    void FLOAD_CBO_TOTRINH()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@MADV", "@NAM", "@THANG" },
            ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) },
            SpName = "SP_TOTRINH_XEMXET_LOAD_BY_MADV_NAM_THANG"
        };

        Sql.fGetData(Obj);
        cboToTrinh.DataSource = Obj.Dt;
        cboToTrinh.DataBind();
        cboToTrinh.SelectedIndex = 0;
    }

    void fLoadChiTietToTrinh()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@SoToTrinh" },
            ValueParameter = new object[] { cboToTrinh.SelectedValue },
            SpName = "SP_PHEDUYET_CHITIETTOTRINH_BY_SOTOTRINH"
        };
        Sql.fGetData(Obj);
        RGChiTietToTrinh.DataSource = Obj.Dt;
        RGChiTietToTrinh.DataBind();
    }
    void LoadNguoiPheDuyetTheoPhongBan()
    {
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaDv" },
            ValueParameter = new object[] { TxtMaDV.Text },
            Connectionstring = wqlvattu,
            SpName = "sp_NhanVien_NguoiNhan_Load"
        };
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

    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        lbLoi2.Text = "";
        cboToTrinh.Text = "";

        FLOAD_CBO_TOTRINH();
        fLoadChiTietToTrinh();
    }
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {
        lbLoi2.Text = "";
        cboToTrinh.Text = "";
        FLOAD_CBO_TOTRINH();
        fLoadChiTietToTrinh();
    }
    protected void cboToTrinh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi2.Text = "";
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
            if (rnSoTien.Value == rnSoTienRG.Value)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
        TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[Dem].FindControl("txtGhiChu");
        Obj = new clsObj
        {
            Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIENDN", "@GHICHU" },
            ValueParameter = new object[] { cboToTrinh.SelectedValue, MSChiPhi, rnSoTien.Value, txtGhiChuDuyet.Text },
            SpName = "SP_CHITIETTOTRINH_GIAMDOCDV_HIEUCHINH"
        };
        Sql.fNonGetData(Obj);

        fLoadChiTietToTrinh();
    }

    protected void txtGhiChu_TextChanged(object sender, EventArgs e)
    {
        TextBox tbGhiChu = (TextBox)sender;

        int Dem = 0;

        for (int i = 0; i < RGChiTietToTrinh.Items.Count; i++)
        {

            TextBox txtGhiChuDuyet = (TextBox)RGChiTietToTrinh.Items[i].FindControl("txtGhiChu");
            if (tbGhiChu == txtGhiChuDuyet)
            {
                break;
            }
            Dem += 1;

        }

        string MSChiPhi = RGChiTietToTrinh.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RGChiTietToTrinh.Items[Dem].FindControl("rnSoTien_PD");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIENDN", "@GHICHU" };
        Obj.ValueParameter = new object[] { cboToTrinh.SelectedValue, MSChiPhi, Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_GIAMDOCDV_HIEUCHINH";
        Sql.fNonGetData(Obj);

        fLoadChiTietToTrinh();
    }

    protected void cbXemXet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            lbLoi.Text = "";
            string emailthuky = "", email = "";

            string nguoinhan = cbNguoiPheDuyet.SelectedValue;
            string bophannhan = txtBoPhanNhan.Text;
            string chucvunguoinhan = txtChucVuNguoiNhan.Text;

            txtToTrinh.Text = cboToTrinh.SelectedValue;

            Obj = new clsObj
            {
                Parameter =
                    new string[] { "@SoToTrinh", "@NguoiNhan", "@BoPhanNhan", "@ChucVuNN", "@NgayXX", "@KiemTra" },
                ValueParameter = new object[]
                {
                    txtToTrinh.Text, nguoinhan, bophannhan, chucvunguoinhan, DateTime.Now, cbXemXet.SelectedValue
                },
                SpName = "sp_ToTrinh_UpdateXemXet"
            };

            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xem xét tờ trình <b><font color='black'>" + txtToTrinh.Text + "</font></b> thất bại.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xem xét tờ trình <b><font color='black'>" + txtToTrinh.Text + "</font></b> thành công.</font>";
                #region Email              

                Obj = new clsObj
                {
                    Parameter = new string[] { "@MaNV" },
                    ValueParameter = new object[] { Session["UserID"].ToString() },
                    SpName = "SP_LoadNVIDMaDV"
                };
                Sql.fGetData(Obj);
                string kyHieuDonVi = Obj.Dt.Rows[0]["KiHieuDonVi"].ToString();

                Obj = new clsObj
                {
                    Connectionstring = wqlvattu,
                    Parameter = new string[] { "@manv", "@kyHieuDonVi" },
                    ValueParameter = new object[] { cbNguoiPheDuyet.SelectedValue, kyHieuDonVi },
                    SpName = "Sp_GuiEmailDenBanTGD"
                };
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

                      
                        string SB = "CHUYEN BAN TONG GIAM DOC PHE DUYET TO TRINH " + txtToTrinh.Text;
                        string noidung = "";
                        noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
                        noidung += "Kính chuyên Ban Tổng Giám đốc phê duyệt to trinh " + txtToTrinh.Text + " cua " + TxtMaDV.Text + "%0D%0A";
                        noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/LapToTrinh_PheDuyet.aspx";

                        noidung += "%0D%0ATran Trong ! %0D%0A ";
                        noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                        noidung += "";
                        clssys clss = new clssys();
                        noidung = clss.RemoveSign4VietnameseString(noidung);
                        hlEmail.NavigateUrl = "mailto:" + email + "?cc=" + emailthuky + "&subject=" + SB + "&body=" + noidung;
                        lbEmail.Text = "<font color='blue'>Vui lòng click nút Email.</font>";

                    }
                    catch { }
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Gửi email thất bại.</font>";
                }

                #endregion
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'> " + ex.Message + "</font>";

        }
        finally
        {
            cboToTrinh.Text = "";
            lbLoi2.Text = "";
            cbXemXet.SelectedValue = "False";
            FLOAD_CBO_TOTRINH();
            fLoadChiTietToTrinh();

            FLOAD_CBO_TOTRINH2();
            fLoadChiTietToTrinh2();
        }
    }


    #endregion


    #region TAB2

    void FLOAD_CBO_TOTRINH2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MADV", "@NAM", "@THANG" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam2.Text), int.Parse(rnThang2.Text) };

        Obj.SpName = "SP_TOTRINH_DAXEMXET_LOAD_BY_MADV_NAM_THANG";
        Sql.fGetData(Obj);
        cboToTrinh2.DataSource = Obj.Dt;
        cboToTrinh2.DataBind();
        cboToTrinh2.SelectedIndex = 0;
    }
    void fLoadChiTietToTrinh2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SoToTrinh" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue };
        Obj.SpName = "SP_PHEDUYET_CHITIETTOTRINH_BY_SOTOTRINH";
        Sql.fGetData(Obj);
        RG2.DataSource = Obj.Dt;
        RG2.DataBind();
    }


    protected void rnNam2_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        cboToTrinh2.Text = "";
        FLOAD_CBO_TOTRINH2();
        fLoadChiTietToTrinh2();
    }
    protected void rnThang2_TextChanged(object sender, EventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        cboToTrinh2.Text = "";
        FLOAD_CBO_TOTRINH2();
        fLoadChiTietToTrinh2();
    }
    protected void cboToTrinh2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        lbEmail.Text = "";
        fLoadChiTietToTrinh2();
    }

    protected void rnSoTien_PD2_TextChanged(object sender, EventArgs e)
    {

        Telerik.Web.UI.RadNumericTextBox rnSoTien = (Telerik.Web.UI.RadNumericTextBox)sender;

        if (rnSoTien.Text == "")
        {
            rnSoTien.Text = "0";
        }

        int Dem = 0;

        for (int i = 0; i < RG2.Items.Count; i++)
        {
            Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RG2.Items[i].FindControl("rnSoTien_PD2");
            if (rnSoTien.Value == rnSoTienRG.Value)
            {
                break;
            }
            Dem += 1;
        }

        string MSChiPhi = RG2.Items[Dem]["MSChiPhi"].Text;
        TextBox txtGhiChuDuyet = (TextBox)RG2.Items[Dem].FindControl("txtGhiChu2");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIENDN", "@GHICHU" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue, MSChiPhi, rnSoTien.Value, txtGhiChuDuyet.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_GIAMDOCDV_HIEUCHINH";
        Sql.fNonGetData(Obj);

        fLoadChiTietToTrinh2();
    }

    protected void txtGhiChu2_TextChanged(object sender, EventArgs e)
    {
        TextBox tbGhiChu = (TextBox)sender;

        int Dem = 0;

        for (int i = 0; i < RG2.Items.Count; i++)
        {

            TextBox txtGhiChuDuyet = (TextBox)RG2.Items[i].FindControl("txtGhiChu2");
            if (tbGhiChu == txtGhiChuDuyet)
            {
                break;
            }
            Dem += 1;

        }

        string MSChiPhi = RG2.Items[Dem]["MSChiPhi"].Text;
        Telerik.Web.UI.RadNumericTextBox rnSoTienRG = (Telerik.Web.UI.RadNumericTextBox)RG2.Items[Dem].FindControl("rnSoTien_PD2");
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@SOTOTRINH", "@MSCHIPHI", "@SOTIENDN", "@GHICHU" };
        Obj.ValueParameter = new object[] { cboToTrinh2.SelectedValue, MSChiPhi, Convert.ToDouble(rnSoTienRG.Value), tbGhiChu.Text };
        Obj.SpName = "SP_CHITIETTOTRINH_GIAMDOCDV_HIEUCHINH";
        Sql.fNonGetData(Obj);

        fLoadChiTietToTrinh2();
    }
    protected void cbXemXet2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            lbLoi2.Text = "";

            txtToTrinh2.Text = cboToTrinh2.SelectedValue;

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@SoToTrinh", "@KiemTra" };
            Obj.ValueParameter = new object[] { txtToTrinh2.Text, cbXemXet2.SelectedValue };


            Obj.SpName = "SP_TOTRINH_UPDATE_BOXEMXET";

            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi2.Text = "<font color='red'>Bỏ xem xét tờ trình <b><font color='black'>" + txtToTrinh2.Text + "</font></b> thất bại.</font>";
            }
            else
            {
                lbLoi2.Text = "<font color='blue'>Đã bỏ xem xét tờ trình <b><font color='black'>" + txtToTrinh2.Text + "</font></b> thành công.</font>";

            }
        }
        catch (Exception ex)
        {
            lbLoi2.Text = "<font color='red'> " + ex.Message + "</font>";

        }
        finally
        {
            lbLoi.Text = "";
            lbEmail.Text = "";
            cboToTrinh2.Text = "";
            cbXemXet2.SelectedValue = "True";
            FLOAD_CBO_TOTRINH2();
            fLoadChiTietToTrinh2();

            FLOAD_CBO_TOTRINH();
            fLoadChiTietToTrinh();
        }
    }

    #endregion






    protected void cbNguoiPheDuyet_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        Obj = new clsObj
        {
            Parameter = new string[] { "@MaNV" },
            ValueParameter = new object[] { cbNguoiPheDuyet.SelectedValue },
            Connectionstring = wqlvattu,
            SpName = "sp_NhanVien_NguoiNhan_GetChucVu_ByMaNV"
        };
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



    #region Xem lại tờ trình
    void fLoadToTrinh_XemLai()
    {
        if (TxtMaDV.Text == "KDND")
        {
            RG_XemToTrinh.Columns[5].Visible = true;
        }
        else
        {
            RG_XemToTrinh.Columns[5].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam_Xem.Text), int.Parse(rnThang_Xem.Text) };
        Obj.SpName = "sp_XemXetToTrinh_XemLaiToTrinh";

        Sql.fGetData(Obj);
        RG_XemToTrinh.DataSource = Obj.Dt;
        RG_XemToTrinh.DataBind();
    }
    protected void rnNam_Xem_TextChanged(object sender, EventArgs e)
    {
        fLoadToTrinh_XemLai();
    }
    protected void rnThang_Xem_TextChanged(object sender, EventArgs e)
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
                //string countTT = "";
                //lbLoi.Text = "";
                //Obj = new clsObj();
                //Obj.Parameter = new string[] { "@SoToTrinh" };
                //Obj.ValueParameter = new object[] { RG_XemToTrinh.Items[e.Item.ItemIndex]["SoToTrinh"].Text };
                //Obj.SpName = "sp_ToTrinh_ChiTietToTrinh_Count";
                //Sql.fGetData(Obj);
                //if (Obj.KetQua < 1)
                //{
                //    try
                //    {
                //        countTT = Obj.Dt.Rows[0]["CountToTrinh"].ToString();

                //    }
                //    catch { }
                //}
                //else { }
                //if (int.Parse(countTT) == 0)
                //{
                //    lbLoi.Text = "<font color='Red'>Chưa có chi tiết tờ trình nên không in được.</font>";

                //}
                //else
                //{


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
                // }
                break;
        }
    }

    #endregion

    protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
        lbLoi2.Text = "";
        lbEmail.Text = "";
    }

}