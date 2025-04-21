using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;
using System.Web.Configuration;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class Chuongtrinh_XemKeHoachNganSachDaDuyet : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
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
            Session["MSChiphi"] = String.Empty;
            //LoadNganSach();          
            LoadNam();
            LoadDVPheDuyet();
          
            LoadCPThucHien();
            LoadNganSach();
            LOAD_RadGDNganSach();
        }
    }
    string item3;
    string LayThangCuaQui()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@Qui", "@MaDV", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, rnQui.Text, CboMaDV.SelectedValue, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_LayThangCuaQui";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item3 = Obj.Dt.Rows[0]["Thang"].ToString();

            }
            catch { }

        }
        else
        {

        }
        return item3;
    }
    string item4;
    int DemChiTietNganSach()
    {

        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.Text, CboMaDV.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_ChiTietKeHoachNganSach_Load";
        Sql.fGetData(Obj);
        if (Obj.KetQua < 1)
        {
            try
            {
                item4 = Obj.Dt.Rows[0]["DemChiTietNganSach"].ToString();

            }
            catch { }
        }
        else
        {

        }
        return Convert.ToInt32(item4);
     }
   
    bool pd;
    bool HieuLucPD()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@MaDV", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, CboMaDV.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_KeHoachNganSach_PheDuyet_GetHieuLucPD_ByQui";
        Sql.fGetData(Obj);


        if (Obj.KetQua < 1)
        {
            try
            {
                pd = bool.Parse(Obj.Dt.Rows[0]["Hieuluc_PD"].ToString());
            }
            catch { }
        }
        else
        {

        }
        return pd;
    }
    #region GET_EMAIL
    public void GET_EMAIL()
    {
        string Address = "";
        string CC = "";
        string Sub = "";
        string Body = "";

        try
        {
            DataTable dt = new DataTable();
            string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];

            Email mail_ = new Email();

            DataTable dtThongtinphieu = new DataTable();

            dt = mail_.GetEmail(site,CboMaDV.SelectedValue);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {

                    if (row["ToCC"].ToString().Trim() == "TO")
                    {
                        Address += row["Email"].ToString().Trim() + ";";
                    }
                    else if (row["ToCC"].ToString().Trim() == "CC")
                    {
                        CC += row["Email"].ToString().Trim() + ";";
                    }
                }
            }

            Sub += "Đã duyệt ngân sách : " + CboMaDV.SelectedValue.Trim();

            Body += "Tôi đã duyệt ngân sách của đơn vị " + CboMaDV.SelectedValue.Trim() + " quí " + rnQui.Text + "/" + CboNam.SelectedValue;

            Body += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();

            clssys clss = new clssys();
            txtAddress.Text = Address;
            txtCC.Text = CC;
            txtSub.Text = Sub;
            txtBody.Text = Body;
            clss.SendMail(Address, CC, Sub, Body);
        }
        catch (Exception ex)
        {
            lbLoi.Text = ex.Message;
            return;
        }
    }
    #endregion
    void LoadNam()
    {
        ClassLibrary lib = new ClassLibrary(ConnectionString);
        DataTable dt = lib.GetDataStore("sp_XemKeHoachNganSachDaDuyet_LoadNam_Qui", new string[] { },
                    new object[] { });
        CboNam.DataSource = dt;
        CboNam.DataBind();
        CboNam.SelectedIndex = 0;
        rnQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;
    }
    void LoadDVPheDuyet()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Nam", "@BanTGD_PD","@QUI" };
        Obj.ValueParameter = new object[] { CboNam.SelectedValue, Session["UserID"].ToString(),rnQui.Text };
        Obj.SpName = "SP_NSMADV_PD_BYLOAD";
        Sql.fGetData(Obj);
        CboMaDV.DataSource = Obj.Dt;
        CboMaDV.DataBind();
        CboMaDV.SelectedIndex = 0;
        if (CboMaDV.SelectedIndex == -1)
        {
            CboMaDV.Text = "";
        }
    }
    void LoadCPThucHien()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
        Obj.SpName = "SP_LoadKHCP";
        Sql.fGetData(Obj);
        RadGDKHCP.DataSource = Obj.Dt;
        RadGDKHCP.DataBind();
       
    }
    void LoadNganSach()
    {     
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Nam", "@Qui", "@BanTGD_PD" };
        Obj.ValueParameter = new object[] { CboMaDV.SelectedValue, CboNam.SelectedValue, rnQui.Text, Session["UserID"].ToString() };
        Obj.SpName = "sp_ChiTietKeHoachNganSach_ByMaDV_Nam_Qui";
        Sql.fGetData(Obj);
        RadGDNganSach.DataSource = Obj.Dt;
        RadGDNganSach.DataBind();
    }
   

    protected void CboMaDV_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lbLoi.Text = "";
        LoadCPThucHien();
        LoadNganSach();
        LOAD_RadGDNganSach();
    }
    string email;
    void SendEmail()
    {

        if (HieuLucPD() == false)
        {
            lbLoi.Text = "<font color='red'>Chưa phê duyệt nên không gửi được email.</font>";
        }
        else
        {

            lbEmail.Text = "";
            #region Email
            Obj = new clsObj();

            Obj.Parameter = new string[] { "@MaDv" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.Connectionstring = wqlvattu;
            Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                try
                {
                    foreach (DataRow row in Obj.Dt.Rows)
                    {
                        email += row["EmailXX"].ToString().Trim() + ";";
                    }

                   // string email = Obj.Dt.Rows[0]["EmailXX"].ToString() + ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string cc = Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string SB = "BAN TONG GIAM DOC PHE DUYET KE HOACH NGAN SACH QUI " + rnQui.Text + "/" + CboNam.Text;
                    string noidung = "";
                    //noidung += "Kính gửi Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                    noidung += "Ban Tổng giám đốc đã phê duyệt kế hoạch ngân sách quí " + rnQui.Text + "/" + CboNam.Text + "%0D%0A";
                    //noidung += "%0D%0ATran Trong ! %0D%0A ";
                    noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                    noidung += "";
                    clssys clss = new clssys();
                    noidung = clss.RemoveSign4VietnameseString(noidung);

                    //hlEmail.NavigateUrl = "mailto:" + email + "&cc=" + cc + "?subject=" + SB + "&body=" + noidung;

                    lbEmail.Text = "<font color='blue'>Vui lòng click nút gửi mail.</font>";

                    //clss.SendMail(email, cc, SB, noidung);

                    //lbLoi.Text = "<font color='red'>Gửi email thành công.</font>";
                }
                catch { }
            }
            else
            {
                lbEmail.Text = "<font color='red'>Gửi email thất bại.</font>";
            }
            #endregion
        }
    }
    protected void btEmail_Click(object sender, ImageClickEventArgs e)
    {
        if (HieuLucPD() == false)
        {
            lbLoi.Text = "<font color='red'>Chưa phê duyệt nên không gửi được email.</font>";
        }
        else
        {

            lbLoi.Text = "";
            #region Email
            Obj = new clsObj();

            Obj.Parameter = new string[] { "@MaDv" };
            Obj.ValueParameter = new object[] { CboMaDV.SelectedValue };
            Obj.Connectionstring = wqlvattu;
            Obj.SpName = "sp_NguoiPD_GuiMailChoDV";
            Sql.fGetData(Obj);
            if (Obj.Dt.Rows.Count > 0)
            {
                try
                {

                    string email = Obj.Dt.Rows[0]["EmailXX"].ToString() + ";" + Obj.Dt.Rows[0]["EMAILTHUKY"].ToString();

                    string cc = Obj.Dt.Rows[0]["EmailPD"].ToString();

                    string SB = "BAN TONG GIAM DOC PHE DUYET KE HOACH NGAN SACH QUI " + rnQui.Text + "/" + CboNam.Text;
                    string noidung = "";
                    //noidung += "Kính gửi Anh(Chi): " + Obj.Dt.Rows[0]["Hoten"].ToString() + " - " + Obj.Dt.Rows[0]["ChucVu"].ToString() + "%0D%0A %0D%0A";
                    noidung += "Ban Tổng giám đốc đã phê duyệt kế hoạch ngân sách quí " + rnQui.Text + "/" + CboNam.Text + "%0D%0A";
                    //noidung += "%0D%0ATran Trong ! %0D%0A ";
                    noidung += "%0A" + "" + Session["UserID"].ToString() + " - " + Session["Name"].ToString();
                    noidung += "";
                    clssys clss = new clssys();
                    noidung = clss.RemoveSign4VietnameseString(noidung);

                    clss.SendMail(email, cc, SB, noidung);

                    lbLoi.Text = "<font color='red'>Gửi email thành công.</font>";
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
    protected void CboNam_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        rnQui.Text = (CboNam.SelectedItem.FindControl("hfQui") as HiddenField).Value;

    }
    #region BUOC1
    protected void RadGDKHCP_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        foreach (GridDataItem item in RadGDKHCP.MasterTableView.Items)
        {
            if (item.Selected)
            {
                Session["MSChiphi"] = item["MSChiphi"].Text.Trim();
            }
        }

        LoadCPThucHien();
    }
    protected void RadGDKHCP_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadCPThucHien();
    }
    protected void RadGDKHCP_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "RowClick")
        {
            if (e.Item.Selected == false)
            {
                Session["MSChiphi"] = String.Empty;
                LOAD_RadGDNganSach();
            }

        }
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LoadCPThucHien();
        }
    }
    #endregion
    #region BUOC2
    protected void LOAD_RadGDNganSach()
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectionString);
        DataTable dt = new DataTable();
        try
        {
            provider.CommandText = "SP_LoadNS_MaCP";

            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MSChiphi","@Nam","@Qui","@MaDV" };
            provider.ValueCollection = new object[] { Session["MSChiphi"].ToString().Trim(),CboNam.SelectedValue,rnQui.Text,CboMaDV.SelectedValue };

            dt = provider.GetDataTable();

        }
        catch (SqlException sqlex)
        {
            lbLoi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
            RadGDNganSach.DataSource = dt;
            RadGDNganSach.DataBind();
        }
    }
    protected void RadGDNganSach_CancelCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LOAD_RadGDNganSach();
    }
    protected void RadGDKHCP_SelectedIndexChanged(object sender, EventArgs e)
    {
                Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
                LOAD_RadGDNganSach();
     }
    protected void RadGDNganSach_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        Session["MSChiphi"] = RadGDKHCP.SelectedValue == null ? "" : RadGDKHCP.SelectedValue;
        LOAD_RadGDNganSach();
    }
    protected void RadGDNganSach_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LOAD_RadGDNganSach();
    }
    #endregion
    protected void RadGDNganSach_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == Telerik.Web.UI.RadGrid.FilterCommandName)
        {
            LOAD_RadGDNganSach();
        }
    }
    protected void rnQui_TextChanged(object sender, EventArgs e)
    {
       
        LoadDVPheDuyet();
        LoadCPThucHien();
        LoadNganSach();
    }
}