using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

public partial class Controls_PhanQuyen : System.Web.UI.UserControl
{
    public string ConnectDB_GiaThanhSPM =
        WebConfigurationManager.ConnectionStrings["ConnectDB_GiaThanhSPM"].ConnectionString;

    public string ConnectDB_wqlvattu =
        WebConfigurationManager.ConnectionStrings["ConnectDB_wqlvattu"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void RadcboMaNV_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
    {
        SqlServerProvider provider = new SqlServerProvider(ConnectDB_wqlvattu);
        DataTable data = new DataTable();

        e.Text.ToUpper().Trim();
        try
        {
            provider.CommandText = "sp_TTloadnhanvien_PhanQuyen";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@MANV" };
            provider.ValueCollection = new object[] { e.Text.Trim() };

            data = provider.GetDataTable();
        }
        catch (SqlException sqlex)
        {
            lbloi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
        }

        try
        {
            int itemsPerRequest = 500;
            int itemOffset = e.NumberOfItems;
            int endOffset = itemOffset + itemsPerRequest;
            if (endOffset > data.Rows.Count)
            {
                endOffset = data.Rows.Count;
            }
            for (int i = itemOffset; i < endOffset; i++)
            {
                RadcboMaNV.Items.Add(new RadComboBoxItem(data.Rows[i]["TV"].ToString(), data.Rows[i]["MANV"].ToString()));
            }
            if (data.Rows.Count > 0)
            {
                e.Message = String.Format("Dòng <b>1</b> đến <b>{0}</b> của <b>{1}</b> dòng", endOffset.ToString(), data.Rows.Count.ToString());
            }
            else { e.Message = "No matches"; }
        }
        catch
        {
            e.Message = "Không tìm thấy nhân viên";
        }
    }

    protected void imgbtnLuu_Click(object sender, ImageClickEventArgs e)
    {
        //Cap nhat hoac Insert Quyen
        SqlServerProvider provider = new SqlServerProvider(ConnectDB_GiaThanhSPM);
        try
        {
            provider.CommandText = "SP_INSERTMEMBERSHIPPROVIDER_GIATHANH_SPM";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "@SITES", "@MANV", "@QUYEN", "@NGUOIUY" };
            provider.ValueCollection = new object[] { RadCboIDSite.SelectedValue.Trim(), RadcboMaNV.SelectedValue.Trim(), RadcboPhanQuyen.SelectedValue.Trim(), Session["UserID"].ToString().Trim() };

            provider.ExecuteNonQuery();

            RadGridPhanQuyen.DataBind();
            RadGridPhanQuyen.Rebind();

            lbloi.Text = "Thêm phân quyền thành công";
        }
        catch (SqlException sqlex)
        {
            lbloi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
        }

    }

    #region RadGridPhanQuyen
    protected void RadGridPhanQuyen_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int index = e.Item.ItemIndex;

        string ID = RadGridPhanQuyen.Items[index]["ID"].Text.ToString();
        //string MANV = RadGridPhanQuyen.Items[index]["MANV"].Text.ToString();
        //string SITES = RadGridPhanQuyen.Items[index]["SITES"].Text.ToString();

        SqlServerProvider provider = new SqlServerProvider(ConnectDB_GiaThanhSPM);
        try
        {
            provider.CommandText = "SP_DeleteMembershipProvider_GIATHANH_SPM";
            provider.CommandType = CommandType.StoredProcedure;

            provider.ParameterCollection = new string[] { "ID" };
            provider.ValueCollection = new object[] { ID };

            provider.ExecuteNonQuery();

            lbloi.Text = "Xóa phân quyền thành công";
        }
        catch (SqlException sqlex)
        {
            lbloi.Text = sqlex.Message;
        }
        finally
        {
            provider.CloseConnection();
        }
    }
    #endregion
}