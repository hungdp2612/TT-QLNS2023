using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Web.UI.WebControls.WebParts;
using System.Web.Configuration;
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;
using System.Data;

public partial class Chuongtrinh_KeHoachNganSach_SanXuat : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();

    string wqlvattu = WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;
    
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            fLoadDonVi();         
            LoadNamThang();
            rdNgay.SelectedDate = DateTime.Now;        
            TxtNguoiLap.Text = Session["USerID"].ToString();
            fLoad();
            fLoadThoiGianLapNganSach();


            #region xuất Excel          
            LoadNamQui();
            #endregion
          
        }
        if (Session["KHNSSanXua"] != null)
        {
            fLoad();
            Session["KHNSSanXua"] = null;

        }
      
    }
    void fLoadDonVi()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        // Obj.Connectionstring = wqlvattu;
        Obj.SpName = "SP_LoadNVIDMaDV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            txtTenDV.Text = Obj.Dt.Rows[0]["HienThi"].ToString();
            TxtMaDV.Text = Obj.Dt.Rows[0]["MaDV"].ToString();
            txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
            txtMaBP.Text = Obj.Dt.Rows[0]["MABP"].ToString();
            Session["MaDV"] = TxtMaDV.Text;
        }
        else
        {
            txtTenDV.Text = "Không tìm thấy";
        }


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
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV" };
        Obj.ValueParameter = new object[] { rnNam.Text, TxtMaDV.Text };
        Obj.SpName = "sp_KeHochNganSachKhoiSanXuat_Load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
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
                lbThoiGianLapNganSach.Text = "Thời gian lập ngân sách tháng  " + rnThang.Text + "/" + rnNam.Text + " trước ngày:" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Day + "/" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Month + "/" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString()).Year;

            }
            catch { }
        }
        else
        {
            lbThoiGianLapNganSach.Text = "";
        }
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
                string mm, dd;
                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month < 10)
                {
                    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }
                else
                {
                    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Month.ToString();
                }


                if (Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day < 10)
                {
                    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }
                else
                {
                    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Day.ToString();
                }

                item1 = Convert.ToDateTime(Obj.Dt.Rows[0]["Ngaylapngansach"]).Year.ToString() + mm + dd;
                //item1 = ConvertDatedmy(Obj.Dt.Rows[0]["Ngaylapngansach"].ToString());
                //item1 = item1.ToString().Replace("/", "");              

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
                string mm,dd;
                if (Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month < 10)
                {
                    mm = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month.ToString();
                }
                else
                {
                    mm = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Month.ToString();
                }


                if (Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day < 10)
                {
                    dd = "0" + Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day.ToString();
                }
                else
                {
                    dd = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Day.ToString();
                }

                songayhieuchinh = Convert.ToDateTime(Obj.Dt.Rows[0]["NgayHieuChinh"]).Year.ToString() + mm + dd;
                //songayhieuchinh = ConvertDatedmy(Obj.Dt.Rows[0]["NgayHieuChinh"].ToString());
                //songayhieuchinh = songayhieuchinh.ToString().Replace("/", "");

            }
            catch { }

        }
        else
        {

        }
        return Convert.ToInt32(songayhieuchinh);

    }
    int SoNgayHienTai()
    {

        string mm, dd;
        if (DateTime.Now.Month < 10)
        {
            mm = "0" + DateTime.Now.Month.ToString();
        }
        else
        {
            mm = DateTime.Now.Month.ToString();
        }


        if (DateTime.Now.Day < 10)
        {
            dd = "0" + DateTime.Now.Day.ToString();
        }
        else
        {
            dd = DateTime.Now.Day.ToString();
        }
        string result = DateTime.Now.Year.ToString() + mm + dd;
        return Convert.ToInt32(result);
    }
    string IDMaCS;
    double TienUyQuyen;
    string MSChiPhi, DVUQ;
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {

        #region cập nhật bằng tay
       

        if (radioCapNhat.SelectedItem.Value == "BangTay")
        {
            int KiemTraNgayLapNS;

            string nam = rnNam.Text;
            string thang = rnThang.Text;


            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtIDMaCS.Text;
            }
            string ID_Khoa = IDMaCS + "-" + nam + thang;
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
                       // fLoad();
                    }
                    else
                    {

                        if (songayhieuchinh == null || songayhieuchinh == "")
                        {
                            //if (SoNgayHienTai() >= SoNgayTuDB())
                            //{
                            //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";
                            //   // ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã hết thời gian lập ngân sách của tháng.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
                            //}
                            //else
                            //{
                                Obj = new clsObj();
                                Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa" };
                                Obj.ValueParameter = new object[] { nam, thang, TxtMaDV.Text, Session["USerID"].ToString(), rdNgay.SelectedDate, 0, 0, 0, ID_Khoa };
                                Obj.SpName = "sp_KeHoachNganSach_Insert";

                                Sql.fNonGetData(Obj);

                                if (Obj.KetQua < 1)
                                {
                                    lbLoi.Text = "<font color='red'>Đã có kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> trong danh sách.</font>";
                                }
                                else
                                {
                                    lbLoi.Text = "<font color='blue'>Thêm kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> thành công.</font>";
                                    //fLoad();
                                }
                            //}
                        }

                        else
                        {
                            //if (SoNgayHienTai() >= int.Parse(songayhieuchinh))
                            //{
                            //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";
                            //    //ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã hết thời gian lập ngân sách của tháng.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
                            //}
                            //else
                            //{

                                Obj = new clsObj();
                                Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa" };
                                Obj.ValueParameter = new object[] { nam, thang, TxtMaDV.Text, Session["USerID"].ToString(), rdNgay.SelectedDate, 0, 0, 0, ID_Khoa };
                                Obj.SpName = "sp_KeHoachNganSach_Insert";

                                Sql.fNonGetData(Obj);

                                if (Obj.KetQua < 1)
                                {
                                    lbLoi.Text = "<font color='red'>Đã có kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> trong danh sách.</font>";
                                }
                                else
                                {
                                    lbLoi.Text = "<font color='blue'>Thêm kế hoạch ngân sách <b><font color='black'>" + ID_Khoa + "</font></b> thành công.</font>";
                                    // fLoad();
                                }

                            //}
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

                }
            }
            else
            {
            }
        }
        #endregion // Kết thúc cập nhật bằng tay

        #region cập nhật tự động
        else if (radioCapNhat.SelectedItem.Value == "AuTo")
        {
            int KiemTraNgayLapNS;

            string nam = rnNam.Text;
            string thang = rnThang.Text;

            if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
            {
                IDMaCS = txtIDMaCS.Text;
            }
            else
            {
                IDMaCS = txtIDMaCS.Text;
            }
            string ID_Khoa = IDMaCS + "-" + nam + thang;
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
                        //fLoad();
                    }
                    else
                    {

                        if (songayhieuchinh == null || songayhieuchinh == "")
                        {
                            //if (SoNgayHienTai() >= SoNgayTuDB())
                            //{
                            //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";
                               
                            //}
                            //else
                            //{
                                #region Kiểm tra các đơn vị có ủy quyền hay không
                                int demUQ;
                                Obj = new clsObj();
                                Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ_KiemTraCoHayKhong";
                                Sql.fGetData(Obj);
                                demUQ = int.Parse(Obj.Dt.Rows[0]["Dem"].ToString());
                                #endregion

                                if (demUQ == 0)
                                {
                                    lbLoi.Text = "<font color='red'>Không có đơn vị nào ủy quyền, hoặc đã thực hiện rồi.</font>";
                                }
                                else
                                {

                                    #region Kiểm tra đã lập ngân sách hay chưa
                                    int KT_IDKhoa;
                                    Obj = new clsObj();
                                    Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
                                    Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                    Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_KiemTraCoLapNSHayChua";
                                    Sql.fGetData(Obj);
                                    KT_IDKhoa = int.Parse(Obj.Dt.Rows[0]["KT_IDKhoa"].ToString());
                                    #endregion

                                    if (KT_IDKhoa > 0)
                                    {
                                        // Ngan sach thang nay đã lập thì insert vào chi tiết
                                        //lbLoi.Text = "<font color='red'>Ngân sách tháng này đã được lập.</font>";
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                        Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ";
                                        Sql.fGetData(Obj);
                                        // dataCTPHIEUTU = Obj.Dt;

                                        foreach (DataRow dtRow in Obj.Dt.Rows)
                                        {
                                            TienUyQuyen = Convert.ToDouble(dtRow["TienUyQuyen"].ToString());
                                            MSChiPhi = dtRow["MSCHIPHI"].ToString();
                                            DVUQ = dtRow["DVUQ"].ToString();
                                            string idkhoaCT = ID_Khoa + MSChiPhi + txtIDMaCS.Text;


                                            Obj = new clsObj();
                                            Obj.Parameter = new string[] { "@MaDV", "@MaNVNguoiLap", "@ID_Khoa", "@ID_KhoaCT", "@MSChiPhi", "@MaDVUQ", "@MaNV", "@SoTien", "@GhiChu" };
                                            Obj.ValueParameter = new object[] { TxtMaDV.Text, Session["USerID"].ToString(), ID_Khoa, idkhoaCT, MSChiPhi, DVUQ, Session["USerID"].ToString(), TienUyQuyen, "UQ từ ĐV " + DVUQ };
                                            Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_Insert_ChuaLapThangNS";
                                            Sql.fNonGetData(Obj);
                                        }
                                    }
                                    else
                                    {
                                        //NS tháng này chưa được lập. Insert vào NS và chi tiết NS
                                   
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                        Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ";
                                        Sql.fGetData(Obj);
                                        // dataCTPHIEUTU = Obj.Dt;

                                        foreach (DataRow dtRow in Obj.Dt.Rows)
                                        {
                                            TienUyQuyen = Convert.ToDouble(dtRow["TienUyQuyen"].ToString());
                                            MSChiPhi = dtRow["MSCHIPHI"].ToString();
                                            DVUQ = dtRow["DVUQ"].ToString();
                                            string idkhoaCT = ID_Khoa + MSChiPhi + txtIDMaCS.Text;
                                            Obj = new clsObj();
                                            Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa", "@ID_KhoaCT", "@MSChiPhi", "@MaDVUQ", "@MaNV", "@SoTien", "@GhiChu" };
                                            Obj.ValueParameter = new object[] { nam, thang, TxtMaDV.Text, Session["USerID"].ToString(), rdNgay.SelectedDate, 0, 0, 0, ID_Khoa, idkhoaCT, MSChiPhi, DVUQ, Session["USerID"].ToString(), TienUyQuyen, "UQ từ ĐV " + DVUQ };
                                            Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_Insert";
                                            Sql.fNonGetData(Obj);
                                        }
                                    }
                                }

                            //}
                        }

                        else
                        {
                            //if (SoNgayHienTai() >= int.Parse(songayhieuchinh))
                            //{
                            //    lbLoi.Text = "<font color='red'>Đã hết thời gian lập ngân sách của tháng.</font>";
                            //   // ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "alert('Đã hết thời gian lập ngân sách của tháng.');" + Page.ClientScript.GetPostBackEventReference(this, "") + ";", true);
                            //}
                            //else
                            //{
                                #region Kiểm tra các đơn vị có ủy quyền hay không
                                int demUQ;
                                Obj = new clsObj();
                                Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ_KiemTraCoHayKhong";
                                Sql.fGetData(Obj);
                                demUQ = int.Parse(Obj.Dt.Rows[0]["Dem"].ToString());
                                #endregion

                                if (demUQ == 0)
                                {
                                    lbLoi.Text = "<font color='red'>Không có đơn vị nào ủy quyền, hoặc đã thực hiện rồi.</font>";
                                }
                                else
                                {

                                    #region Kiểm tra đã lập ngân sách hay chưa
                                    int KT_IDKhoa;
                                    Obj = new clsObj();
                                    Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang" };
                                    Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                    Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_KiemTraCoLapNSHayChua";
                                    Sql.fGetData(Obj);
                                    KT_IDKhoa = int.Parse(Obj.Dt.Rows[0]["KT_IDKhoa"].ToString());
                                    #endregion

                                    if (KT_IDKhoa > 0)
                                    {

                                        //Ngan sách tháng này đã lập. insert vào chi tiết ngân sách
                                        //lbLoi.Text = "<font color='red'>Ngân sách tháng này đã được lập.</font>";


                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                        Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ";
                                        Sql.fGetData(Obj);
                                        // dataCTPHIEUTU = Obj.Dt;

                                        foreach (DataRow dtRow in Obj.Dt.Rows)
                                        {
                                            TienUyQuyen = Convert.ToDouble(dtRow["TienUyQuyen"].ToString());
                                            MSChiPhi = dtRow["MSCHIPHI"].ToString();
                                            DVUQ = dtRow["DVUQ"].ToString();
                                            string idkhoaCT = ID_Khoa + MSChiPhi + txtIDMaCS.Text;


                                            Obj = new clsObj();
                                            Obj.Parameter = new string[] { "@MaDV", "@MaNVNguoiLap",  "@ID_Khoa", "@ID_KhoaCT", "@MSChiPhi", "@MaDVUQ", "@MaNV", "@SoTien", "@GhiChu" };
                                            Obj.ValueParameter = new object[] {TxtMaDV.Text, Session["USerID"].ToString(), ID_Khoa, idkhoaCT, MSChiPhi, DVUQ, Session["USerID"].ToString(), TienUyQuyen, "UQ từ ĐV " + DVUQ };
                                            Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_Insert_ChuaLapThangNS";
                                            Sql.fNonGetData(Obj);

                                        }
                                    }
                                    else
                                    {
                                        //Insert ke hoạch NS và chi tiết NS
                                        Obj = new clsObj();
                                        Obj.Parameter = new string[] { "@MaDVUserDangNhap", "@Nam", "@Thang" };
                                        Obj.ValueParameter = new object[] { TxtMaDV.Text, int.Parse(rnNam.Text), int.Parse(rnThang.Text) };
                                        Obj.SpName = "sp_Kehoachngansach_PCU_HCQT_GetAllNganSachUQ";
                                        Sql.fGetData(Obj);
                                        // dataCTPHIEUTU = Obj.Dt;

                                        foreach (DataRow dtRow in Obj.Dt.Rows)
                                        {
                                            TienUyQuyen = Convert.ToDouble(dtRow["TienUyQuyen"].ToString());
                                            MSChiPhi = dtRow["MSCHIPHI"].ToString();
                                            DVUQ = dtRow["DVUQ"].ToString();
                                            string idkhoaCT = ID_Khoa + MSChiPhi + txtIDMaCS.Text;


                                            Obj = new clsObj();
                                            Obj.Parameter = new string[] { "@Nam", "@Thang", "@MaDV", "@MaNVNguoiLap", "@NgayLap", "@Hieuluc_XX", "@Hieuluc_PD", "@HieuLuc", "@ID_Khoa", "@ID_KhoaCT", "@MSChiPhi", "@MaDVUQ", "@MaNV", "@SoTien", "@GhiChu" };
                                            Obj.ValueParameter = new object[] { nam, thang, TxtMaDV.Text, Session["USerID"].ToString(), rdNgay.SelectedDate, 0, 0, 0, ID_Khoa, idkhoaCT, MSChiPhi, DVUQ, Session["USerID"].ToString(), TienUyQuyen, "UQ từ ĐV " + DVUQ };
                                            Obj.SpName = "sp_KeHoachNganSach_PCU_HCQT_Insert";
                                            Sql.fNonGetData(Obj);

                                        }
                                    }
                                }
                            }
                        }
                    //}
                }
                catch (Exception ex)
                {
                    lbLoi.Text = ex.Message;
                }
                finally
                {
                    fLoadThoiGianLapNganSach();
                    fLoad();

                }
            }
            else
            {
            }
        }
        #endregion // Kết thúc cập nhật tự động

    }
    protected void RG_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {

    }
    int countNS;
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_Khoa = RG.Items[e.Item.ItemIndex]["ID_Khoa"].Text;


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
         
        }
    }
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    protected void rnNam_TextChanged(object sender, EventArgs e)
    {
        fLoad();
    }

    #region tab2
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
    protected void btnXem_Click(object sender, ImageClickEventArgs e)
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

    #endregion
}