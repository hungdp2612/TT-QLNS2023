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
using System.Data;


public partial class Chuongtrinh_KeHoachNganSach : clsPhanQuyenCaoCap
{

    clsObj Obj;
    clsSql Sql = new clsSql();
    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region kế hoạch ngân sach
            fLoadDonVi();
            //rnThang.Text = DateTime.Now.AddMonths(1).Month.ToString();
            //rnNam.Text = DateTime.Now.AddMonths(0).Year.ToString();
            LoadNamThang();
            fLoad();
           
            fLoadNguoiKT();
            fLoadThoiGianLapNganSach();
            #endregion

            #region xuất Excel
            //rnNam_Xem.Text = DateTime.Now.AddMonths(0).Year.ToString();
            LoadNamQui();
            #endregion   
        }
        if (Session["ReloadKHNS"] != null)
        {
            fLoad();
            Session["ReloadKHNS"] = null;           
        }
         
    }
 
    private void Split(string s)
    {
        string pattern = "/";
        Regex myRegex = new Regex(pattern);
        string[] ketqua = myRegex.Split(s);
       
    }

    public string ConvertDatedmy(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = nam + "/" + thang + "/" + ngay;
        return strbao;     
       
    }

    void LoadNamThang()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSach_LoadNam_Thang";
        Sql.fGetData(Obj);
        rnNam.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnThang.Value = int.Parse(Obj.Dt.Rows[0]["Thang"].ToString());
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
            txtTenDV.Text = Obj.Dt.Rows[0]["HienThi"].ToString();
            TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            if (Obj.Dt.Rows[0]["IDMaCS"].ToString() == "100")
            {
                txtIDMaCS.Text = "49";
                txtMaBP.Text = "CONGSO";
            }
            else
            {
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
                txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();
            }
            Session["MaDV"] = TxtMaDV.Text;
        }
        else
        {
            txtTenDV.Text = "Không tìm thấy";
        }
    }
    void fLoad()
    {
        //string IDMaCS;

        //if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        //{
        //    IDMaCS = txtIDMaCS.Text;
        //}
        //else
        //{
        //    IDMaCS = txtMaBP.Text;
        //}

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MABP" };
        Obj.ValueParameter = new object[] { rnNam.Text, txtIDMaCS.Text };
        Obj.SpName = "sp_KeHochNganSach_Load_ByMaBP";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    void fLoadNguoiKT()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@madv" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text };
        Obj.SpName = "sp_LoadGiamDocDVKiemTraNS";
        Sql.fGetData(Obj);
        ddlEmailNguoiKiemTra.DataSource = Obj.Dt;
        ddlEmailNguoiKiemTra.DataBind();
    }
    void fLoadEmail()
    {
        lbEmail.Text = "";
        hlEmail.NavigateUrl = "";

        #region Kiểm tra
      
        if (rcEmailNguoiKiemTra.SelectedValue == "")
        {
            lbEmail.Text = "<font color='red'>Chưa chọn người xem xét.</font>";
            return;
        }
        if (RG.Items.Count < 1)
        {
            lbEmail.Text = "<font color='red'>Không có ngân sách để gửi mail.</font>";
            return;
        }
        #endregion

        #region Email

        Obj = new clsObj
        {
            Parameter = new string[] {"@MaDV", "@MaNV"},
            ValueParameter = new object[] {TxtMaDV.Text, rcEmailNguoiKiemTra.SelectedValue},
            SpName = "sp_LoadGiamDocDVKiemTraNS_ByMaNV"
        };

        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            string SB = "KINH CHUYEN GIAM DOC DON VI KIEM TRA NGAN SACH THANG " + rnThang.Text + "/" + rnNam.Text;
            string noidung = "";
            noidung += "Kinh gui Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + "%0D%0A %0D%0A";
            noidung += "Kinh chuyen anh chị xem xet ngan sach thang " + rnThang.Text + "/" + rnNam.Text + "%0D%0A";
            noidung += "http://www.thaituangarment.com/QLNganSach2013/Chuongtrinh/KeHoachNganSach_XemXet.aspx";
            noidung += "%0D%0ATran Trong ! %0D%0A ";
            noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
            noidung += "";
            clssys clss = new clssys();
            noidung = clss.RemoveSign4VietnameseString(noidung);
            hlEmail.NavigateUrl = "mailto:" + Obj.Dt.Rows[0]["Email"].ToString() + "?subject=" + SB + "&body=" + noidung;
            lbEmail.Text = "<font color='blue'>Vui lòng click nút gửi mail.</font>";
        }
        else
        {
            lbEmail.Text = "<font color='red'>Không lấy được email người kiểm tra.</font>";
        }
        #endregion
    }

    protected void ddlEmailNguoiKiemTra_SelectedIndexChanged(object sender, EventArgs e)
    {
        fLoadEmail();
    }
    public string ConvertDatedmy2(string str)
    {
        string ngay = str.Substring(0, 2);
        string thang = str.Substring(3, 2);
        string nam = str.Substring(6, 4);
        string strbao = ngay + "/" + thang + "/" + nam;
        return strbao;
    }

    void fLoadThoiGianLapNganSach()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_MacDinhLapNS_GetNgayThangNam";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                lbThoiGianLapNganSach.Text = "Thời gian lập ngân sách tháng  " + rnThang.Text +"/"+ rnNam.Text + " trước ngày:" +Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Day + "/"+Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Month +"/"+Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Year;
               
            }
            catch { }
        }
        else
        {
            lbThoiGianLapNganSach.Text = "";
        }
    }

 

    protected void RG_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            fLoad();
        }
    }
    int countNS;
    protected void RG_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        int index = e.Item.ItemIndex;
        string ID_Khoa = RG.Items[index]["ID_Khoa"].Text.Trim();
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_Khoa" };
        Obj.ValueParameter = new object[] { ID_Khoa };
        Obj.SpName = "sp_KeHoachNganSach_CountChiTiet";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                countNS = int.Parse(Obj.Dt.Rows[0]["CountNS"].ToString());

            }
            catch { }
        }
        else { }

        if (countNS > 0)
        {
            lbLoi.Text = "<font color='red'>Đã có chi tiết ngân sách nên không xóa đươc.</font>";
            fLoad();

            fLoadThoiGianLapNganSach();
            //fLoadEmail();
        }
        else
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_Khoa" };
            Obj.ValueParameter = new object[] { ID_Khoa };
            Obj.SpName = "sp_kehoachngansach_delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
            fLoad();
           
            fLoadThoiGianLapNganSach();
           // fLoadEmail();
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

    int SoNgayHienTai1()
    {
       
        string result = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString("00") + DateTime.Now.Day.ToString("00");
        return Convert.ToInt32(result);
    }
    string item1;
    int SoNgayTuDB()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_MacDinhLapNS_GetNgayThangNam";      
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                //string mm, dd;
                //if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                //{
                //    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                //}
                //else
                //{
                //    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                //}


                //if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                //{
                //    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                //}
                //else
                //{
                //    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                //}

                item1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString("00") + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString("00");
                
            }
            catch { }

        }
        else
        {

        }
        return Convert.ToInt32(item1);

    }
    string songayhieuchinh;
    int SoNgayHieuChinhTuDB()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text, rnNam.Text, rnThang.Text };
        Obj.SpName = "sp_HieuChiNgayLapNS";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {

                //string mm, dd;
                //if (Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month < 10)
                //{
                //    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month.ToString();
                //}
                //else
                //{
                //    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month.ToString();
                //}


                //if (Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day < 10)
                //{
                //    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day.ToString();
                //}
                //else
                //{
                //    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day.ToString();
                //}

                songayhieuchinh = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Year.ToString() + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month.ToString("00") + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day.ToString("00");
               
                
            }
            catch { }

        }
        else
        {

        }
        return Convert.ToInt32(songayhieuchinh);

    }

  
    string mschiphi;
    decimal sotien;

    void fLoadKeHoachNganSach_KeThua()
    {
        string ID_Khoa = txtIDMaCS.Text + "-" + rnNam.Text + rnThang.Text;
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
        //Obj.ValueParameter = new object[] { txtMaBP.Text, rnNam.Text, cbThang.SelectedValue };
        Obj.SpName = "sp_KeHoachNganSach_ChiTietNS_KeThuaMaChiPhi";
        Sql.fGetData(Obj);
        if (Obj.Dt.Rows.Count > 0)
        {
            try
            {
                foreach (DataRow row in Obj.Dt.Rows)
                {
                    mschiphi = row["MSChiphi"].ToString();
                    sotien = decimal.Parse(row["Sotien"].ToString());

                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@ID_Khoa", "@MSChiPhi", "@MaBP", "@MaNV", "@SoTien", "@ID_KhoaCT" };
                    Obj.ValueParameter = new object[] { ID_Khoa, mschiphi, txtMaBP.Text, Session["UserID"].ToString(), sotien, ID_Khoa + mschiphi + txtIDMaCS.Text };
                    Obj.SpName = "sp_KeHoachNganSach_ChiTietNS_KeThua_Insert";
                    Sql.fNonGetData(Obj);
                    
                }              


            }
            catch { }
        }
    }
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        SoNgayHieuChinhTuDB();
        int KiemTraNgayLapNS;        
        string IDMaCS;
        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "49";
        } 
        //else 
        //if (txtIDMaCS.Text == "102" || txtIDMaCS.Text == "105" || txtIDMaCS.Text == "104" || txtIDMaCS.Text == "108" || txtIDMaCS.Text == "107" || txtIDMaCS.Text == "106" || txtIDMaCS.Text == "103" )
          
        //{
        //    IDMaCS = "101";
        //} else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtIDMaCS.Text;
            }
        }

        string nam = rnNam.Text;
        string thang = rnThang.Text;

        string madv = TxtMaDV.Text;
        string nguoilap = Session["UserID"].ToString();

        string ID_Khoa = txtIDMaCS.Text + "-" + nam + thang;
        bool hieuluc_pd = false;
        bool hieuluc_xx = false;
        bool hieulucketoan = false;

        #region Insert
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Thang" };
        Obj.ValueParameter = new object[] { nam, thang };
        Obj.SpName = "sp_MacDinhNgayLapNS_KiemTraNamThang";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                KiemTraNgayLapNS = int.Parse(Obj.Dt.Rows[0]["KiemTraNamThang"].ToString());

                if (KiemTraNgayLapNS == 0)
                {
                    lbLoi.Text = "<font color='red'>Chưa lập ngày lập ngân sách nên không thể thêm kế hoạch ngân sách được.</font>";
                    fLoad();
                }
                else
                {
                   
                    if (songayhieuchinh == null || songayhieuchinh == "")
                    {
                        //if (SoNgayHienTai1() >= SoNgayTuDB())
                        //{
                        //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";

                          
                        //}
                        //else
                        //{

                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa" };
                            Obj.ValueParameter = new object[] { nam, thang, madv, Session["UserID"].ToString(), DateTime.Now, hieuluc_xx, hieuluc_pd, hieulucketoan, ID_Khoa };
                            Obj.SpName = "sp_KeHoachNganSach_Insert";

                            Sql.fNonGetData(Obj);

                            if (Obj.KetQua < 1)
                            {
                                lbLoi.Text = "<font color='red'>Đã có kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> trong danh sách.</font>";
                            }
                            else
                            {
                                lbLoi.Text = "<font color='blue'>Thêm kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> thành công.</font>";
                                
                                fLoad();
                             
                            }
                       // }
                    }

                    else
                    {
                        //if (SoNgayHienTai1() >= int.Parse(songayhieuchinh))
                        //{
                        //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";
                            
                        //}
                        //else
                        //{

                            Obj = new clsObj();
                            Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa" };
                            Obj.ValueParameter = new object[] { nam, thang, madv, Session["UserID"].ToString(), DateTime.Now, hieuluc_xx, hieuluc_pd, hieulucketoan, ID_Khoa };
                            Obj.SpName = "sp_KeHoachNganSach_Insert";

                            Sql.fNonGetData(Obj);
                            if (Obj.KetQua < 1)
                            {
                                lbLoi.Text = "<font color='red'>Đã có kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> trong danh sách.</font>";
                               
                            }
                            else
                            {
                                lbLoi.Text = "<font color='blue'>Thêm kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> thành công.</font>";
                               
                            }

                       // }
                    }
                }
            }
            catch (Exception ex)
            {
                lbLoi.Text = ex.Message;
            }
            finally
            {
                fLoadThoiGianLapNganSach();
              
                fLoad();
               // fLoadEmail();
              
            }
        }
        #endregion
    }
   
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoadThoiGianLapNganSach();
      
        lbLoi.Text = "";

        if (rnNam.Text == "")
        {
            rnNam.Text = DateTime.Now.AddMonths(1).Year.ToString();
            lbLoi.Text = "<font color='red'>Vui lòng nhập năm ngân sách.</font>";
        }
        fLoad();
        fLoadDonVi();
        SoNgayHienTai1();
       
    }
  
    protected void rnThang_TextChanged(object sender, EventArgs e)
    {      
        fLoadThoiGianLapNganSach();
    }

    protected void RadTabStrip1_TabClick(object sender, Telerik.Web.UI.RadTabStripEventArgs e)
    {
        lbLoi.Text = "";
    }  
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
    {
        string IDMaCS;
        if (txtIDMaCS.Text == "100")
        {
            IDMaCS = "CONGSO";
        }
        else
        {
            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtMaBP.Text;
            }
        }
        ExcelQui1.Visible = true;
        ExcelQui2.Visible = false;
        ExcelQui3.Visible = false;
        ExcelQui4.Visible = false;

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), IDMaCS, int.Parse(rnQui_Xem.Text) };
        Obj.SpName = "sp_KeHoachNganSach_ExeclNguoiLap_040515";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    ExcelQui1.Columns[3].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[3].Visible = false;
                }
               
            }

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
          
        }
        else if (rnQui_Xem.Value == 2)
        {
            ExcelQui1.Visible = false;
            ExcelQui2.Visible = true;
            ExcelQui3.Visible = false;
            ExcelQui4.Visible = false;
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui2.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[3].Visible = false;
                }
               
            }
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
         
        }
        else if (rnQui_Xem.Value == 3)
        {
            ExcelQui1.Visible = false;
            ExcelQui2.Visible = false;
            ExcelQui3.Visible = true;
            ExcelQui4.Visible = false;

            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui3.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[3].Visible = false;
                }
               
            }

            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
           
        }
        else if (rnQui_Xem.Value == 4)
        {

            ExcelQui1.Visible = false;
            ExcelQui2.Visible = false;
            ExcelQui3.Visible = false;
            ExcelQui4.Visible = true;
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui4.Columns[3].Visible = true;
                }
                else
                {

                   ExcelQui4.Columns[3].Visible = false;
                }               
            }

            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();           
        }
    }
    protected void btExcel_Click(object sender, ImageClickEventArgs e)
    {
        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui" };
        Obj.ValueParameter = new object[] { int.Parse(rnNam_Xem.Text), IDMaCS, int.Parse(rnQui_Xem.Text) };
        //Obj.SpName = "sp_KeHoachNganSach_ExeclNguoiLap";
        Obj.SpName = "sp_KeHoachNganSach_ExeclNguoiLap_040515";
        Sql.fGetData(Obj);

        if (rnQui_Xem.Value == 1)
        {


            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui1.Columns[1].Visible = true;
                ExcelQui1.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {
                    ExcelQui1.Columns[3].Visible = true;
                }
                else
                {
                    ExcelQui1.Columns[3].Visible = false;
                }            
            }

            ExcelQui1.GridLines = GridLines.Both;

            ExcelQui1.DataSource = Obj.Dt;
            ExcelQui1.DataBind();
            ExcelQui1.ExportSettings.ExportOnlyData = true;
            ExcelQui1.ExportSettings.IgnorePaging = true;
            ExcelQui1.ExportSettings.OpenInNewWindow = true;
            ExcelQui1.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui1.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 2)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui2.Columns[1].Visible = true;
                ExcelQui2.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui2.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui2.Columns[3].Visible = false;
                }
              
            }
            ExcelQui2.GridLines = GridLines.Both;
            ExcelQui2.DataSource = Obj.Dt;
            ExcelQui2.DataBind();
            ExcelQui2.ExportSettings.ExportOnlyData = true;
            ExcelQui2.ExportSettings.IgnorePaging = true;
            ExcelQui2.ExportSettings.OpenInNewWindow = true;
            ExcelQui2.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui2.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 3)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui3.Columns[1].Visible = true;
                ExcelQui3.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui3.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui3.Columns[3].Visible = false;
                }
             
            }
            ExcelQui3.GridLines = GridLines.Both;
            ExcelQui3.DataSource = Obj.Dt;
            ExcelQui3.DataBind();
            ExcelQui3.ExportSettings.ExportOnlyData = true;
            ExcelQui3.ExportSettings.IgnorePaging = true;
            ExcelQui3.ExportSettings.OpenInNewWindow = true;
            ExcelQui3.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui3.MasterTableView.ExportToExcel();
        }
        else if (rnQui_Xem.Value == 4)
        {
            if (TxtMaDV.Text == "KDND")
            {
                ExcelQui4.Columns[1].Visible = true;
                ExcelQui4.Columns[3].Visible = false;
            }
            else
            {
                if (TxtMaDV.Text == "P.CU" || TxtMaDV.Text == "P.HCQT")
                {

                    ExcelQui4.Columns[3].Visible = true;
                }
                else
                {

                    ExcelQui4.Columns[3].Visible = false;
                }
              
            }
            ExcelQui4.GridLines = GridLines.Both;
            ExcelQui4.DataSource = Obj.Dt;
            ExcelQui4.DataBind();
            ExcelQui4.ExportSettings.ExportOnlyData = true;
            ExcelQui4.ExportSettings.IgnorePaging = true;
            ExcelQui4.ExportSettings.OpenInNewWindow = true;
            ExcelQui4.ExportSettings.FileName = " Kế hoạch ngân sách quí " + rnQui_Xem.Value;
            ExcelQui4.MasterTableView.ExportToExcel();
        }
    }
    void LoadNamQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { };
        Obj.ValueParameter = new object[] { };
        Obj.SpName = "sp_KeHoachNganSachXemXet_LoadNam_Qui";
        Sql.fGetData(Obj);
        rnNam_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Nam"].ToString());
        rnQui_Xem.Value = int.Parse(Obj.Dt.Rows[0]["Qui"].ToString());
    }

    void fLoadNguoiKT_ver2()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@madv", "@mabp" };
        Obj.ValueParameter = new object[] { TxtMaDV.Text, txtMaBP.Text };
        Obj.SpName = "sp_LoadGiamDocDVKiemTraNS";
        Sql.fGetData(Obj);
        rcEmailNguoiKiemTra.DataSource = Obj.Dt;
        rcEmailNguoiKiemTra.DataBind();
    }

    protected void rcEmailNguoiKiemTra_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadNguoiKT_ver2();
    }

    protected void rcEmailNguoiKiemTra_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadEmail();
    }
}