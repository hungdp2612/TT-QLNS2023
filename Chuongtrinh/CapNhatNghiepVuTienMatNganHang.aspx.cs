using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data;

public partial class Chuongtrinh_CapNhatNghiepVuTienMatNganHang : clsPhanQuyenCaoCap
{
    clsObj Obj;
    clsSql Sql = new clsSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rnThang.Value = DateTime.Now.Month;
            rnNam.Value = DateTime.Now.Year;
            fLoad();
        }
    }
    void fLoad()
    {
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam" };
        Obj.ValueParameter = new object[] { rnThang.Text, rnNam.Text };
        Obj.SpName = "spNghiepVuTienMatNganHang";
        Sql.fGetData(Obj);
        RG.DataSource = Obj.Dt;
        RG.DataBind();
    }
    protected void tbXem_Click(object sender, ImageClickEventArgs e)
    {
        fLoad();
    }
    protected void btLuu_Click(object sender, ImageClickEventArgs e)
    {
        lbLoi.Text = "";

        #region xoá trước khi lưu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@MaDV", "@Thang", "@Nam" };
        Obj.ValueParameter = new object[] { "82", rnThang.Text, rnNam.Text };
        Obj.SpName = "spXoaChiPhiTH_Lemon";
        Sql.fNonGetData(Obj);
        #endregion

        #region lấy dữ liệu
        Obj = new clsObj();
        Obj.Parameter = new string[] { "@Thang", "@Nam" };
        Obj.ValueParameter = new object[] { rnThang.Text, rnNam.Text };
        Obj.SpName = "spNghiepVuTienMatNganHang";
        Sql.fGetData(Obj);
        #endregion

        int Dem = 0;

        for (int i = 0; i < Obj.Dt.Rows.Count; i++)
        {
            clsObj Obj1 = new clsObj();
            Obj1.Parameter = new string[] { "@MSChiPhi",
                "@MaDV", "@Thang", "@Nam", "@SoTien" };
            Obj1.ValueParameter = new object[] { Obj.Dt.Rows[i]["MaNS"].ToString(), 
                "82", rnThang.Text, rnNam.Text, Obj.Dt.Rows[i]["ChiPhi"].ToString()};
            Obj1.SpName = "spLuuChiPhiTH_Lemon";
            Sql.fNonGetData(Obj1);
            if (Obj1.KetQua > 0)
            {
                Dem += 1;
            }
        }
        if (Dem == Obj.Dt.Rows.Count)
        {
            lbLoi.Text = "<font color='blue'>Lưu thành công.</font>";
        }
        else
        {
            lbLoi.Text = "<font color='red'>Lưu thất bại. Vui lòng thử lại.</font>";
        }
    }
}