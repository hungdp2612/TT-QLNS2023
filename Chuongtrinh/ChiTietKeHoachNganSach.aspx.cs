using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.Configuration;
using System.Xml.Linq;
using Telerik.Web.UI;
using Data;
public partial class ChiTietKeHoachNganSach : clsPhanQuyen
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    QLNS2013DBDataContext db_ = new QLNS2013DBDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["ID_Khoa"] != null)
            {
                txtKHCP_ID.Text = Request.QueryString["ID_Khoa"].ToString();              
            }
            if (Request.QueryString["Nam"] != null)
            {
                txtNam.Text = Request.QueryString["Nam"].ToString();
               
                rnNamMoi.Text = Request.QueryString["Nam"].ToString();
            }
            if (Request.QueryString["Thang"] != null)
            {
                txtThang.Text = Request.QueryString["Thang"].ToString();
                rnThangMoi.Text = Request.QueryString["Thang"].ToString();
            }
            fLoadDonVi();
            fLoad();
         
            fLoadChiPhiTheoMaDV();


            fLoadTienNSByMaChiPhi();
           
            Session["ReloadKHNS"] = "";

            #region Chọn kế thừa
            FLoadMaBP();
            fLoadThangTruoc();
            fLoadNSThangTruoc();
            fLoadNSThangLapNS();
            if (Session["MaBP"].ToString() == "P.CU")
            {
                btnChuyenNSdu.Visible = true;
            }
            #endregion

        }
    }
    
    #region Nhập ngân sách chi tiết

    public double fInt(object Value)
    {
        return Convert.ToDouble(Value.ToString());
    }
    void fLoad()
    {

        if (txtMaBP.Text == "P.CU" || txtMaBP.Text == "P.HCQT")
        {
            RG.Columns[4].Visible = true;
            
        }
        else
        {
            RG.Columns[4].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Key" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_chitietkehoachngansach_load";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();

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
                txtMaDV.Text = Obj.Dt.Rows[0]["MADV"].ToString();
                txtMaBP.Text = Obj.Dt.Rows[0]["MaBP"].ToString();
                txtIDMaCS.Text = Obj.Dt.Rows[0]["IDMaCS"].ToString();
                
            }
            catch { }

        }
        else
        {

        }
    }
  
    protected void RG_InsertCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void RG_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //switch (e.CommandName)
        //{
        //    case RadGrid.FilterCommandName:
        //        fLoad();
        //        break;
        //    case RadGrid.RebindGridCommandName:
        //        fLoad();
        //        break;
        //    case "SUA":

        //        //DropDownListThang.Text = RG.Items[e.Item.ItemIndex]["Thang"].Text;
        //        cbMaSoChiPhi.Text = RG.Items[e.Item.ItemIndex]["MSChiphi"].Text;
        //        cbMaSoChiPhi.SelectedValue = RG.Items[e.Item.ItemIndex]["MSChiphi"].Text;
        //        rnChiPhi.Text = RG.Items[e.Item.ItemIndex]["Sotien"].Text;
        //        txtGhichu.Text = RG.Items[e.Item.ItemIndex]["Ghichu"].Text;
        //        Session["sukienbutton"] = "";
        //        break;
        //}
        if (e.CommandName == Telerik.Web.UI.RadGrid.EditCommandName)
        {
            lbLoi.Text = "";
            e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChiTietKeHoachNganSach_Update.ascx";
            fLoad();

        }
        if (e.CommandName == RadGrid.FilterCommandName)
        {
            fLoad();
        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.CancelCommandName)
        {
            fLoad();
        }
    }
    protected void RG_EditCommand(object sender, GridCommandEventArgs e)
    {

    }
   
    protected void btnLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";      

        string IDMaCS;

        if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
        {
            IDMaCS = txtIDMaCS.Text;
        }
        else
        {
            IDMaCS = txtMaBP.Text;
        }


        try
        {
            if (cbMaSoChiPhi.Text != cbMaSoChiPhi.SelectedValue)
            {
                throw new Exception("Mã số chi phí không đúng.....");
            }
            else
            {
                if (rnChiPhi.Value.Value <= 0)
                {
                    lbLoi.Text = "<font color='red'>Chi phí ngân sách <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> phải lớn hơn 0.</font>";
                }
                else
                {

                    //if (rnChiPhi.Value > rnSoTienDuocLap.Value + (rnSoTienDuocLap.Value * dungsai / 100))
                    //{

                    //    lbLoi.Text = "<font color='red'>Vươt quá " +dungsai+ "% số tiền được lập </font>";
                    //    return;
                    //}
                 
                    string Chiphi = rnChiPhi.Text;
                    string ghichu = txtGhichu.Text;
                    string Khoa_chiphi = txtKHCP_ID.Text;
                    string khoact = Khoa_chiphi + cbMaSoChiPhi.SelectedValue + txtIDMaCS.Text;
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@Sotien", "@Ghichu", "@ID_khoaCT" };
                    Obj.ValueParameter = new object[] { Khoa_chiphi, cbMaSoChiPhi.SelectedValue, IDMaCS, Session["UserID"].ToString(), Chiphi, ghichu, khoact };
                    Obj.SpName = "sp_chitietkehoachngansach_insert";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua < 1)
                    {
                        lbLoi.Text = "<font color='red'>Đã có chi phí <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='blue'>Thêm chi phí <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> thành công.</font>";
                    }
                }
                
                fLoad();
                fLoadNSThangTruoc();
                fLoadNSThangLapNS();
                //}
                //else
                //{
                //    lbLoi.Text = "<font color='red'>Đã có chi phí <b><font color='black'>" + cbMaSoChiPhi.SelectedValue + "</font></b> trong danh sách.</font>";
                //    fLoad();
                //}
            }
        }
        catch (Exception ex)
        {
            lbLoi.Text = "<font color='red'>" + ex.Message + "</font>";
        }




    }
  
    protected void RG_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        fLoad();
    }


    protected void RG_CancelCommand(object sender, GridCommandEventArgs e)
    {
        fLoad();
    }
    
    protected void RG_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        fLoad();
    }
    int tiepnhanKDND;
    int TiepNhan()
    {


        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_LoginByMaNV_GetThongTin";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                tiepnhanKDND = int.Parse(Obj.Dt.Rows[0]["TiepNhan"].ToString());

            }
            catch { }

        }
        else
        {

        }
        return tiepnhanKDND;

    }
   
    protected void RG_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string ID_KhoaCT = RG.Items[e.Item.ItemIndex]["ID_khoaCT"].Text;
        string ID_Khoa = RG.Items[e.Item.ItemIndex]["ID_Khoa"].Text;
        string MSChiphi = RG.Items[e.Item.ItemIndex]["MSChiphi"].Text;
        string MaNV = RG.Items[e.Item.ItemIndex]["MaNV"].Text;
        string MaBP = RG.Items[e.Item.ItemIndex]["MaBP"].Text;
        string ghichu = RG.Items[e.Item.ItemIndex]["Ghichu"].Text;

        decimal sotien;

        if (RG.Items[e.Item.ItemIndex]["Sotien"].Text == "&nbsp;")
        {
            sotien = 0;
        }
        else
        {
            sotien = decimal.Parse(RG.Items[e.Item.ItemIndex]["Sotien"].Text);
        }
        if (TiepNhan() == 1)
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { ID_KhoaCT };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";

                #region thêm vào chitietngansach_bk để biết nhân viên nào xóa
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@SoTien", "@Ghichu", "@MaNVCapNhat", "@SoTienCapNhat", "@GhiChuCapNhat", "@HoatDong" };
                Obj.ValueParameter = new object[] { ID_Khoa, MSChiphi, MaBP, MaNV, sotien, ghichu, Session["UserID"].ToString(), Convert.DBNull, Convert.DBNull, "Delete" };
                Obj.SpName = "sp_tblChitiet_Kehoachngansach_bk_Insert";
                Sql.fNonGetData(Obj);
                #endregion

            }
            fLoad();
        }
        else
        {

            if (MaNV != Session["UserID"].ToString())
            {
                lbLoi.Text = "<font color='Red'>Bạn không xóa được chi phí của người khác.</font>";
                fLoad();
            }
            else
            {

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_KhoaCT" };
                Obj.ValueParameter = new object[] { ID_KhoaCT };
                Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
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
            fLoadNSThangTruoc();
            fLoadNSThangLapNS();
        }
    }

    protected void RG_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        fLoad();
    }

  

    protected void RG_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        lbLoi.Text = "";
       
        UserControl userControl = (UserControl)e.Item.FindControl(Telerik.Web.UI.GridEditFormItem.EditFormUserControlID);
        TextBox txtMaNV = userControl.FindControl("txtMaNV") as TextBox;
        TextBox txtMaBP = userControl.FindControl("txtMaBP") as TextBox;
        TextBox txtIDKhoaCT = userControl.FindControl("txtIDKhoaCT") as TextBox;
        TextBox UCtxtKhoaKHNS = userControl.FindControl("UCtxtKhoaKHNS") as TextBox;
        TextBox UCtxtMSChiPhi = userControl.FindControl("UCtxtMSChiPhi") as TextBox;

        Telerik.Web.UI.RadNumericTextBox rnSoTienDuocLap = userControl.FindControl("rnSoTienDuocLap") as Telerik.Web.UI.RadNumericTextBox;

        TextBox txtSoTienCapNhat = userControl.FindControl("txtSoTienCapNhat") as TextBox;
      
        Telerik.Web.UI.RadNumericTextBox ucChiphi = userControl.FindControl("UCrnChiPhi") as Telerik.Web.UI.RadNumericTextBox;
        TextBox UCtxtGhiChu = userControl.FindControl("UCtxtGhiChu") as TextBox;
        TextBox txtGhiChuCapNhat = userControl.FindControl("txtGhiChuCapNhat") as TextBox;

        if (TiepNhan() == 1)
        {
           
                #region Luu
                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_KhoaCT", "@ID_khoa", "@MSChiphi", "@Sotien", "@MaNV", "@Ghichu" };
                Obj.ValueParameter = new object[] { txtIDKhoaCT.Text, UCtxtKhoaKHNS.Text, UCtxtMSChiPhi.Text, ucChiphi.Text, Session["UserID"].ToString(), UCtxtGhiChu.Text };
                Obj.SpName = "sp_chitietkehoachngansach_Update";
                Sql.fNonGetData(Obj);
                if (Obj.KetQua > 0)
                {
                    lbLoi.Text = "<font color='blue'>Cập nhật thành công chi phí kế hoạch ngân sách <b><font color='black'>" + UCtxtMSChiPhi.Text + "</font></b>.</font>";


                    #region thêm vào chitietngansach_bk để biết nhân viên nào hiệu chỉnh
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@SoTien", "@Ghichu", "@MaNVCapNhat", "@SoTienCapNhat", "@GhiChuCapNhat", "@HoatDong" };
                    Obj.ValueParameter = new object[] { UCtxtKhoaKHNS.Text, UCtxtMSChiPhi.Text, txtMaBP.Text, txtMaNV.Text, decimal.Parse(txtSoTienCapNhat.Text), txtGhiChuCapNhat.Text, Session["UserID"].ToString(),
                    decimal.Parse(ucChiphi.Text), UCtxtGhiChu.Text,"Update" };
                    Obj.SpName = "sp_tblChitiet_Kehoachngansach_bk_Insert";
                    Sql.fNonGetData(Obj);
                    #endregion
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                }
                #endregion
                fLoad();
       
        }
        else
        {

            //if (txtMaNV.Text != Session["UserID"].ToString())
            //{
            //    lbLoi.Text = "<font color='red'>Bạn không cập nhật được chi phí kế hoạch của người khác.</font>";
            //    fLoad();
            //}
            //else
            //{

                if (ucChiphi.Value.Value <= 0)
                {
                    lbLoi.Text = "<font color='red'>Chi phí ngân sách <b><font color='black'>" + UCtxtMSChiPhi.Text + "</font></b> phải lớn hơn 0.</font>";
                    fLoad();
                    return;
                }
                else
                {

                    //if (ucChiphi.Value > rnSoTienDuocLap.Value + (rnSoTienDuocLap.Value * dungsai / 100))
                    //{

                    //    lbLoi.Text = "<font color='red'>Vươt quá " + dungsai + "% số tiền được lập </font>";
                    //    fLoad();
                    //    return;
                    //}

                    #region Luu
                    Obj = new clsObj();
                    Obj.Parameter = new string[] { "@ID_KhoaCT", "@ID_khoa", "@MSChiphi", "@Sotien", "@MaNV", "@Ghichu" };
                    Obj.ValueParameter = new object[] { txtIDKhoaCT.Text, UCtxtKhoaKHNS.Text, UCtxtMSChiPhi.Text, ucChiphi.Text, Session["UserID"].ToString(), UCtxtGhiChu.Text };
                    Obj.SpName = "sp_chitietkehoachngansach_Update";
                    Sql.fNonGetData(Obj);
                    if (Obj.KetQua > 0)
                    {
                        lbLoi.Text = "<font color='blue'>Cập nhật thành công <b><font color='black'>" + UCtxtMSChiPhi.Text + "</font></b>.</font>";
                    }
                    else
                    {
                        lbLoi.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                    }
                    #endregion
                    fLoad();
                }
            //}
        }
        fLoadNSThangTruoc();
        fLoadNSThangLapNS();
    }
    protected void RG_GroupsChanging(object sender, GridGroupsChangingEventArgs e)
    {
        fLoad();
    }
  
    void fLoadChiPhiTheoMaDV()
    {
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaCP" };
        //Obj.ValueParameter = new object[] { };
        //Obj.SpName = "sp_DmChiPhi_KeHoachNganSach";       
        //Sql.fGetData(Obj);
        //cbMaSoChiPhi.DataSource = Obj.Dt;
        //cbMaSoChiPhi.DataBind();
    }

    void fLoadMaCP(string Key)
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaCP" };
        Obj.ValueParameter = new object[] {Key };
        Obj.SpName = "SP_DMCHIPHI_LOAD_MANGANSACH";
        Sql.fGetData(Obj);
        cbMaSoChiPhi.DataSource = Obj.Dt;
        cbMaSoChiPhi.DataBind();
        //Obj = new clsObj();
        //Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Thang", "@MCP" };
        //Obj.ValueParameter = new object[] {  txtMaDV.Text,int.Parse(txtNam.Text), int.Parse(txtThang.Text) ,Key };
        //Obj.SpName = "sp_DmChiPhi_ByChiPhiKeHoach";
        //Sql.fGetData(Obj);
        //cbMaSoChiPhi.DataSource = Obj.Dt;
        //cbMaSoChiPhi.DataBind();
    }
    protected void cbMaSoChiPhi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
    {
        fLoadMaCP(e.Text);
    }
    protected void cbMaSoChiPhi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        fLoadTienNSByMaChiPhi();
    }

    void fLoadTienNSByMaChiPhi()
    {
        if (cbMaSoChiPhi.SelectedValue != "")
        {

            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaDV", "@MSChiPhi", "@Nam", "@Thang" };
            Obj.ValueParameter = new object[] { txtMaDV.Text, cbMaSoChiPhi.SelectedValue, int.Parse(txtNam.Text), int.Parse(txtThang.Text) };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_ChiPhiKeHoach_GetSoTienChiPhi";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count < 1)
            {

            }
            else
            {
                try
                {
                    //rnSoTienDuocLap.Text = Obj.Dt.Rows[0]["ChiPhiChoNS"].ToString();
                    // rnChiPhiConLaiAn.Text = Obj.Dt.Rows[0]["ChiPhiConLai"].ToString();

                }
                catch { }
            }
        }

    }
    #endregion

    #region Chọn kế thừa
    void FLoadMaBP()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaNV" };
        Obj.ValueParameter = new object[] { Session["UserID"].ToString() };
        Obj.SpName = "sp_KeThuaNganSach_ByMaNV";
        Sql.fGetData(Obj);

        if (Obj.KetQua < 1)
        {
            try
            {              
                txtMaBPKeThua.Text = Obj.Dt.Rows[0]["MaBP"].ToString();              

            }
            catch { }

        }
        else
        {

        }
    }

    void fLoadThangTruoc()
    {
        if (rnNamMoi.Text != "" || rnThangMoi.Text != "")
        {

            DateTime Moi = new DateTime(int.Parse(rnNamMoi.Text), int.Parse(rnThangMoi.Text), 01);
            DateTime Cu = Moi.AddMonths(-1);
            rnThangCu.Value = Cu.Month;
            rnNamCu.Value = Cu.Year;
        }
    }

    void fLoadNSThangTruoc()
    {
        if (rnNamMoi.Text != "" || rnThangMoi.Text != "")
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@MaBP", "@Nam", "@Thang", "@ThangMoi", "@NamMoi" };
            Obj.ValueParameter = new object[] { txtMaBPKeThua.Text, int.Parse(rnNamCu.Text), int.Parse(rnThangCu.Text), int.Parse(rnThangMoi.Text), int.Parse(rnNamMoi.Text) };
            //Obj.SpName = "sp_KeHoachNganSach_LoadThangTruoc_KeThua";
            Obj.SpName = "sp_KeHoachNganSach_LoadThangTruoc_KeThua_040515";
            Sql.fGetData(Obj);
            RG_ThangTruoc.DataSource = Obj.Dt;
            RG_ThangTruoc.DataBind();
        }

    }

    void fLoadNSThangLapNS()
    {
        if (txtMaBPKeThua.Text == "P.CU" || txtMaBPKeThua.Text == "P.HCQT")
        {
            RG_NSHienTai.Columns[4].Visible = true;

        }
        else
        {
            RG_NSHienTai.Columns[4].Visible = false;
        }

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@ID_Khoa" };
        Obj.ValueParameter = new object[] { txtKHCP_ID.Text };
        Obj.SpName = "sp_KeHoachNganSach_LoadThangLapNS_KeThua";
        Sql.fGetData(Obj);
        RG_NSHienTai.DataSource = Obj.Dt;
        RG_NSHienTai.DataBind();

    }
    protected void rnThangCu_TextChanged(object sender, EventArgs e)
    {
        fLoadNSThangTruoc();
    }
    protected void rnNamCu_TextChanged(object sender, EventArgs e)
    {
        fLoadNSThangTruoc();
    }
    protected void btLay_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";
        for (int i = 0; i < RG_ThangTruoc.Items.Count; i++)
        {
            CheckBox chkSelect = RG_ThangTruoc.Items[i].FindControl("chkSelect") as CheckBox;

            double SOTIENNS = double.Parse(RG_ThangTruoc.Items[i]["Sotien"].Text);

            RadNumericTextBox rnNSLAP = RG_ThangTruoc.Items[i].FindControl("rnNSLAP") as RadNumericTextBox;

            string GhiChu = RG_ThangTruoc.Items[i]["Ghichu"].Text == "&nbsp;" ? "" : RG_ThangTruoc.Items[i]["Ghichu"].Text;
            if (chkSelect.Checked)
            {
                string khoact = txtKHCP_ID.Text + RG_ThangTruoc.Items[i]["MSCHIPHI"].Text + txtIDMaCS.Text;

                Obj = new clsObj();
                Obj.Parameter = new string[] { "@ID_khoa", "@MSChiphi", "@MaBP", "@MaNV", "@Sotien", "@Ghichu", "@ID_khoaCT" };
                Obj.ValueParameter = new object[] { txtKHCP_ID.Text, RG_ThangTruoc.Items[i]["MSCHIPHI"].Text, txtMaBPKeThua.Text, 
                    Session["UserID"].ToString(), rnNSLAP.Value, GhiChu, khoact };
                Obj.SpName = "sp_chitietkehoachngansach_insert";
                Sql.fNonGetData(Obj);
            }
        }
        fLoad();
        fLoadNSThangTruoc();
        fLoadNSThangLapNS();
    }
    protected void RG_NSHienTai_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        if (RG_NSHienTai.Items[e.Item.ItemIndex]["MaNV"].Text != Session["UserID"].ToString())
        {
            lbLoi.Text = "<font color='Red'>Bạn không xóa được ngân sách của người khác.</font>";
           
        }
        else
        {
            Obj = new clsObj();
            Obj.Parameter = new string[] { "@ID_KhoaCT" };
            Obj.ValueParameter = new object[] { RG_NSHienTai.Items[e.Item.ItemIndex]["ID_khoaCT"].Text };
            Obj.SpName = "sp_ChiTietKeHoachNganSach_Delete";
            Sql.fNonGetData(Obj);
            if (Obj.KetQua < 1)
            {
                lbLoi.Text = "<font color='red'>Xóa thất bại. Vui lòng thử lại sau.</font>";
            }
            else
            {
                lbLoi.Text = "<font color='blue'>Xóa thành công.</font>";
            }
        }
        fLoad();
        fLoadNSThangTruoc();
        fLoadNSThangLapNS();
    }
    #endregion   


    protected void btnChuyenNSdu_Click(object sender, EventArgs e)
    {
        if (cbMaSoChiPhi.Text != "")
        {
            var result_1 = db_.sp_ChuyenNganSachThuaCuaThangTruoc(txtKHCP_ID.Text, cbMaSoChiPhi.SelectedValue, Session["UserID"].ToString()).FirstOrDefault();
            if (result_1.KetQua == 1)
            {
                var result_2 = db_.Sp_KiemTraNganSachDu(txtKHCP_ID.Text, cbMaSoChiPhi.SelectedValue).ToList();
                if (result_2.Count() > 0)
                {
                    foreach (var i in result_2)
                    {
                        var result_3 = db_.Sp_UpdateNganSachSauKhiChuyenThua(txtKHCP_ID.Text, cbMaSoChiPhi.SelectedValue, Convert.ToInt32(i.Thang)).FirstOrDefault();
                        if (result_3.KetQua == 1)
                        {
                            lbLoi.Text = "<font color='blue'>Chuyển ngân sách dư thành công.</font>";
                        }
                        else
                        {
                            lbLoi.Text = "<font color='red'>Chuyển ngân sách dư thất bại.</font>";
                        }
                    }
                }
                else
                {
                    lbLoi.Text = "<font color='red'>Mã chi phí "+ cbMaSoChiPhi.SelectedValue + "không có ngân sách dư.</font>";
                }    
            }
            else
            {
                lbLoi.Text = "<font color='red'>Chuyển ngân sách dư thất bại.</font>";
            }
        }
        else
        {
            lbLoi.Text = "<font color='red'>Bạn chưa chọn mã chi phí.</font>";
        }
        fLoad();
    }
}