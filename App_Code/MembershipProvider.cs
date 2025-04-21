using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data;

/// <summary>
/// Summary description for MembershipProvider
/// </summary>
public class MembershipProvider : System.Web.UI.Page
{
    public string ConnectDB_GiaThanhSPM =
        WebConfigurationManager.ConnectionStrings["ConnectDB_GiaThanhSPM"].ConnectionString;

    public MembershipProvider()
	{
		
	}

    protected override void OnPreInit(EventArgs e)
    {
        string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0];

        string path = Request.Url.Segments[Request.Url.Segments.Length - 2].ToString().Trim();

        if (Session.Contents["UserID"] == null)
        {
        
        
            //Session["WebID"] = "~/" + path + site + ".aspx";
            Session["WebID"] = "~/" + site + ".aspx";
            Response.Redirect("~/Sites/Login.aspx", "_self", "");
        }
        else
        {
            MembershipProviderCustommer(site);
        }
    }

    protected void MembershipProviderCustommer(string site)
    {
        //Session["UserID"].ToString().Trim() MaNV
        site += ".aspx";
        SqlServerProvider provider = new SqlServerProvider(ConnectDB_GiaThanhSPM);
        bool kt = false;
        try
        {
            provider.CommandText = "SP_GetMembershipProvider_GIATHANH_SPM";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MANV", "@SITES" };
            provider.ValueCollection = new object[] { Session["UserID"].ToString().Trim(), site };

            kt = provider.GetboolExist();

            if (kt == false)    // khong ton tai, no record
            {
                string loi_ChuaPhanQuyen = GiaThanhSanPhamMay.ErrorMessage.ChuaPhanQuyen;
                Response.Redirect("~/Error.aspx?strloi=" + loi_ChuaPhanQuyen + "", "_self", "");
            }
            else
            {
                DataTable dt = new DataTable();

                dt = provider.GetDataTable();

                string Quyen = dt.Rows[0]["Quyen"].ToString().Trim();

                //int Quyen_NoAccess = Convert.ToInt16(dt.Rows[0]["NoAccess"].ToString().Trim());

                //int Quyen_OnlyRead = Convert.ToInt16(dt.Rows[0]["OnlyRead"].ToString().Trim());

                //int Quyen_AccessAll = Convert.ToInt16(dt.Rows[0]["AccessAll"].ToString().Trim());

                if (Quyen == "NoAccess")
                {
                    string loi_KhongDuocPhep = GiaThanhSanPhamMay.ErrorMessage.KhongDuocPhep;
                    Response.Redirect("~/Error.aspx?strloi=" + loi_KhongDuocPhep + "", "_self", "");
                }
            }
        }
        catch
        {
            kt = false;
        }
        finally
        {
            provider.CloseConnection();
        }

        if (kt == false)
        {
            Response.Redirect("~/Error.aspx?strloi=" + "Có lỗi trong khi xác thực người dùng. Vui lòng thông báo lỗi về TTTH" + "", "_self", "");
        }
    }

    public bool GetMembershipProviderReadOnly(string site)
    {
        bool kq = false;

        SqlServerProvider provider = new SqlServerProvider(ConnectDB_GiaThanhSPM);
        try
        {
            provider.CommandText = "SP_GetMembershipProvider_GIATHANH_SPM";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MANV", "@SITES" };
            provider.ValueCollection = new object[] { Session["UserID"].ToString().Trim(), site };
            DataTable dt = new DataTable();

            dt = provider.GetDataTable();

            string Quyen = dt.Rows[0]["Quyen"].ToString().Trim();

            if (Quyen == "OnlyRead")
            {
                kq = true;
            }

        }
        catch
        {
            kq = false;
        }
        finally
        {
            provider.CloseConnection();
        }

        return kq;
    }

    public bool KiemtraReadOnly(string site)
    {
        bool readonly_ = false;
        //string site = Request.Url.Segments[Request.Url.Segments.Length - 1].ToString().Split('.')[0] + ".aspx";
        MembershipProvider memprovider = new MembershipProvider();
        readonly_ = memprovider.GetMembershipProviderReadOnly(site);

        return readonly_;
    }
}