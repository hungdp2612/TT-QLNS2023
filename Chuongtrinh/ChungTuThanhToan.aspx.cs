using System;
using System.Collections.Generic;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;
using CrystalDecisions.CrystalReports.Engine;
using Data;
using Telerik.Web.UI;

namespace Chuongtrinh
{
    public partial class Chuongtrinh_ChungTuThanhToan : clsPhanQuyenCaoCap
    {

        clsObj _obj;
        private readonly clsSql _sql = new clsSql();
        readonly GetTyGia _gtg = new GetTyGia();
        ReportDocument _report = new ReportDocument();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                #region thanh toán tạm ứng

                LoadTienTe();
                LoadTiGia();
                LoadDonVi();
                LoadNguoiDuocThanhToan();
                LoadPhuTrachDonVi();

                LoadChungTuThanhToan();
                rdHanThanhToan.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);

                #endregion

                #region khong tam ung

                LoadTienTe2();
                LoadTiGia2();
                LoadDonVi2();
                LoadNguoiDuocThanhToan2();
                LoadPhuTrachDonVi2();

                rdHanThanhToan2.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
                LoadThanhToanKhongTamUng();

                #endregion

                #region Giấy nộp tiền

                rdHanThanhToan3.SelectedDate = DateTime.Now.AddYears(0).AddMonths(0);
                LoadPhieuNopTien();
                LoadDonVi3();
                LoadNguoiNopTien();
                LoadPhuTrachDonVi3();
                LoadTienTe3();
                LoadTiGia3();

                #endregion

            }

            if (Session["ReloadChungTuThanhToan"] != null)
            {
                LoadChungTuThanhToan();
                Session["ReloadChungTuThanhToan"] = null;

            }

            if (Session["ReloadThanhToanKhongTamUng"] != null)
            {
                LoadThanhToanKhongTamUng();
                Session["ReloadThanhToanKhongTamUng"] = null;
            }

            if (Session["ReloadChungTuNopTien"] != null)
            {
                LoadPhieuNopTien();
                Session["ReloadChungTuNopTien"] = null;
            }

        }

        protected void RadTabStrip1_TabClick(object sender, RadTabStripEventArgs e)
        {
            lbLoiTU.Text = "";
            lbLoiDN.Text = "";
            lbLoiNT.Text = "";
        }

        #region Chứng từ thanh toán tạm ứng (RadPageView1)

        void LoadDonVi()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "SP_LoadNVIDMaDV"
            };

            _sql.fGetData(_obj);
            if (_obj.Dt.Rows.Count < 1)
            {
                txtMaDV.Text = "Không tìm thấy";
                txtTenDonVi.Text = "Không tìm thấy";
            }
            else
            {
                txtMaDV.Text = _obj.Dt.Rows[0]["MaDV"].ToString();
                txtMaBP.Text = _obj.Dt.Rows[0]["MaBP"].ToString();
                txtTenDonVi.Text = _obj.Dt.Rows[0]["TenGoi"].ToString();
                txtIDMaCS.Text = _obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
        }

        string ExchangeRates(string LoaiTien)
        {
            string TiGia = "";
            try
            {
                XmlDocument xmlDocument = new XmlDocument();
                String xmlSourceUrl = "https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1";
                xmlDocument.Load(xmlSourceUrl);

                //từ đây hoàn toàn có thể thao tác dữ liệu xml bằng đối tượng xmlDocument
                //lấy ví zụ chuyển từ XmlDocument thành tập các đối tượng Generic dạng List<Exrate>
                XmlNodeList nodeList = xmlDocument.GetElementsByTagName("Exrate");
                List<Exrate> listExrate = null;
                if (nodeList != null && nodeList.Count > 0)
                {
                    listExrate = new List<Exrate>();
                    foreach (XmlNode xmlNode in nodeList)
                    {
                        Exrate entityExrate = new Exrate();

                        if (xmlNode.Attributes["CurrencyCode"].InnerText == LoaiTien)
                        {
                            TiGia = xmlNode.Attributes["Buy"].InnerText;
                            return TiGia;
                        }

                        //entityExrate.CurrencyCode = xmlNode.Attributes["CurrencyCode"].InnerText;
                        //entityExrate.CurrencyName = xmlNode.Attributes["CurrencyName"].InnerText;
                        //entityExrate.Buy = float.Parse(xmlNode.Attributes["Buy"].InnerText);
                        //entityExrate.Transfer = float.Parse(xmlNode.Attributes["Transfer"].InnerText);
                        //entityExrate.Sell = float.Parse(xmlNode.Attributes["Sell"].InnerText);

                        //listExrate.Add(entityExrate);
                    }

                    //thực hiện việc bind dữ liệu vào GridView


                }

                //DataSet ds = new DataSet();
                //ds.ReadXml(new XmlNodeReader(xmlDocument));
                ////hoặc có thể chuyển XmlDocument thành DataSet để hiển thị dữ liệu trên các đối tượng trình bày dữ liệu một cách dễ dàng hơn
                ////ở đây lấy ví zụ là GridView
                //gridViewTyGia.DataSource = ds;
                //gridViewTyGia.DataBind();
            }
            catch (Exception ex)
            {
                return "";
            }
            return TiGia;
        }

        void LoadNguoiDuocThanhToan()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "sp_NhanVien_ByMaNV"
            };
            _sql.fGetData(_obj);
            ddlNguoiThanhToan.DataSource = _obj.Dt;
            ddlNguoiThanhToan.DataBind();

        }

        void LoadPhuTrachDonVi()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaBP" },
                ValueParameter = new object[] { txtMaBP.Text },
                SpName = "sp_PhuTrachDonVi_GetAll_ByMaBP"
            };

            _sql.fGetData(_obj);
            ddlPhuTrachDonVi.DataSource = _obj.Dt;
            ddlPhuTrachDonVi.DataBind();
        }

        void LoadTienTe()
        {
            _obj = new clsObj
            {
                Parameter = new string[] { },
                ValueParameter = new object[] { },
                SpName = "sp_CbLoaiTien_Load"
            };
            _sql.fGetData(_obj);
            ddlLoaiTien.DataSource = _obj.Dt;
            ddlLoaiTien.DataBind();
        }

        void LoadTiGia()
        {
            if (ddlLoaiTien.SelectedValue == "VND")
            {
                rnTiGia.Value = 1;
            }
            else
            {
                //string tiGia = _gtg.ExchangeRates(ddlLoaiTien.SelectedValue);
                string tiGia = ExchangeRates(ddlLoaiTien.SelectedValue);
                if (tiGia != "")
                {
                    //rnTiGia.Value = double.Parse(_gtg.ExchangeRates(ddlLoaiTien.SelectedValue));
                    rnTiGia.Text = tiGia;
                }
                else
                {
                    rnTiGia.Text = "";
                }

            }
        }

        void LoadChungTuThanhToan()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@NguoiThanhToan" },
                ValueParameter = new object[] { ddlNguoiThanhToan.SelectedValue },
                SpName = "sp_ChungTuThanhToan_Load"
            };

            _sql.fGetData(_obj);
            rgChungTuThanhToan.DataSource = _obj.Dt;
            rgChungTuThanhToan.DataBind();
        }

        protected void ddlLoaiTien_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTiGia();
            if (ddlLoaiTien.SelectedValue != "VND")
            {

                rnTiGia.Enabled = true;
            }
            else
            {
                rnTiGia.Enabled = false;
            }
        }

        protected void ddlHinhThucThanhToan_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlHinhThucThanhToan.SelectedValue == "NH")
            {
                txtTenTaiKhoan.Enabled = true;
                txtSoTaiKhoan.Enabled = true;
                txtNganHang.Enabled = true;
            }
            else
            {
                txtTenTaiKhoan.Text = "";
                txtSoTaiKhoan.Text = "";
                txtNganHang.Text = "";
                txtTenTaiKhoan.Enabled = false;
                txtSoTaiKhoan.Enabled = false;
                txtNganHang.Enabled = false;
            }

      
        }
        protected void btnLuu_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                lbLoiTU.Text = "";
                string idmaCs;
                if (txtIDMaCS.Text == "100")
                {
                    idmaCs = "CONGSO";
                }
                else
                {
                    if (txtIDMaCS.Text == "30" || txtIDMaCS.Text == "31")
                    {
                        idmaCs = txtIDMaCS.Text;
                    }
                    else
                    {
                        idmaCs = txtMaBP.Text;
                    }
                }

                if (rdHanThanhToan.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                {
                    lbLoiTU.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                    return;
                }

                #region Kiểm tra điều kiên bắt buộc dành cho HDDT

                if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                {

                    if (string.IsNullOrEmpty(TextBoxSoHoaDon.Text))
                    {
                        throw new Exception("Số hóa đơn không được trống.");
                    }

                    if (string.IsNullOrEmpty(TextBoxMaSoThue.Text))
                    {
                        throw new Exception("Mã số thuế không được trống.");
                    }

                    //if (string.IsNullOrEmpty(TextBoxMaTraCuuHoacTaiKhoan.Text))
                    //{
                    //    throw new Exception("Mã tra cứu hóa đơn không được trống.");
                    //}

                    //if (string.IsNullOrEmpty(TextBoxDuongDanHoaDonDienTu.Text))
                    //{
                    //    throw new Exception("Đường dẫn hóa đơn không được trống.");
                    //}

                    if (string.IsNullOrEmpty(TextBoxTenFile.Text))
                    {
                        throw new Exception("Tên File không được trống.");
                    }

                    if (string.IsNullOrEmpty(Download.HRef) || Download.HRef == "#")
                    {
                        throw new Exception("Bạn chưa tải File lên chương trình");
                    }
                }
                #endregion


                _obj = new clsObj
                {
                    Parameter = new[] { "@IDMaCS",
                    "@MaDV",
                    "@LoaiPhieu" },
                    ValueParameter = new object[] { txtIDMaCS.Text == "100" ? "49" : txtIDMaCS.Text,
                    txtMaBP.Text,
                    "GTTTU" },
                    SpName = "sp_ChungTuThanhToan_TaoPhieu"
                };
                _sql.fGetData(_obj);
                string soPhieu = _obj.Dt.Rows[0]["SoPhieu"].ToString();
                _obj = new clsObj
                {
                    Parameter = new[]
                    {
                    "@SoPhieu",
                    "@MaDV",
                    "@Hanthantoan",
                    "@NguoiKT",
                    "@NoiDung",
                    "@Nguoilap",
                    "@NguoiThanhToan",
                    "@LoaiPhieu",
                    "@LoaiTien",
                    "@Tigia",
                    "@PhuongThucTT",
                    "@LaTienMat",
                    "@TenTaiKhoan",
                    "@SoTaiKhoan",
                    "@NganHang",
                    "@LoaiHoaDon"
                },
                    ValueParameter = new object[]
                    {
                    soPhieu,
                    idmaCs,
                    rdHanThanhToan.SelectedDate,
                    ddlPhuTrachDonVi.SelectedValue,
                    txtNoiDung.Text,
                    Session["UserID"].ToString(),
                    ddlNguoiThanhToan.SelectedValue,
                    "GTTTU",
                    ddlLoaiTien.SelectedValue,
                    decimal.Parse(rnTiGia.Text),
                    ddlPhuongThucThanhToan.SelectedValue,
                    ddlHinhThucThanhToan.SelectedValue,
                    txtTenTaiKhoan.Text,
                    txtSoTaiKhoan.Text,
                    txtNganHang.Text,
                    DropDownListLoaiHoaDon.SelectedValue
                    },
                    SpName = "sp_ChungTuThanhToan_Insert"
                };
                _sql.fGetData(_obj);

                if (_obj.KetQua > 0)
                {
                    lbLoiTU.Text = "<font color='Red'>Thêm thất bại.</font>";
                }
                else
                {
                    lbLoiTU.Text = "<font color = 'Blue'> Thêm thành công.</ font > ";
                    if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                    {
                        _obj = new clsObj
                        {
                            Parameter = new[]
                            {
                                "@SoPhieu",
                                "@SoHoaDon",
                                "@MaSoThue",
                                "@MaTraHoacTaiKhoan",
                                "@MaXacThucHoacMatKhau",
                                "@DuongDanTraCuu",
                                "@TenFile",
                                "@DuongDanLuuFile",
                                "@CreatedBy",
                                "@CreatedDate",
                                "@LastModifiedByID",
                                "@LastModifiedDate"
                        },
                            ValueParameter = new object[]
                            {
                            soPhieu,
                            TextBoxSoHoaDon.Text.Trim(),
                            TextBoxMaSoThue.Text.Trim(),
                            TextBoxMaTraCuuHoacTaiKhoan.Text.Trim(),
                            TextBoxMaXacThucHoacMatKhau.Text.Trim(),
                            TextBoxDuongDanHoaDonDienTu.Text.Trim(),
                            TextBoxTenFile.Text.Trim(),
                            Download.HRef,
                            Session["UserID"].ToString(),
                            DateTime.Now,
                            Session["UserID"].ToString(),
                            DateTime.Now
                            },
                            SpName = "SP_INSERT_HOADONDIENTU"
                        };

                        _sql.fGetData(_obj);

                        if (_obj.KetQua > 0)
                        {
                            lbLoiTU.Text = "<font color='Red'>Thêm thông tin hóa đơn điện tử thất bại.</font>";
                        }
                        Download.HRef = string.Empty;
                    }
                }


                LoadChungTuThanhToan();
            }
            catch (Exception ex)
            {
                lbLoiTU.Text = "<font color='red'>" + ex.Message + ".</font>";
            }
        }

        protected void rgChungTuThanhToan_PageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            LoadChungTuThanhToan();
        }

        protected void rgChungTuThanhToan_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            LoadChungTuThanhToan();
        }

        protected void rgChungTuThanhToan_CancelCommand(object sender, GridCommandEventArgs e)
        {
            LoadChungTuThanhToan();
        }

        int count;
        bool xx;

        protected void rgChungTuThanhToan_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiTU.Text = "";

            string soPhieu = rgChungTuThanhToan.Items[e.Item.ItemIndex]["SoPhieu"].Text;

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietThanhToan_Count"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {
                    count = int.Parse(_obj.Dt.Rows[0]["CountCTTT"].ToString());
                }
                catch
                {
                }
            }

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietThanhToan_GetXX"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {
                    xx = clsConvertHelper.Tobool(_obj.Dt.Rows[0]["KiemTra"].ToString());
                }
                catch
                {
                }
            }


            if (xx)
            {
                lbLoiTU.Text = "<font color='red'>Phiếu này đã kiểm tra nên không xóa được.</font>";
                LoadChungTuThanhToan();
            }
            else
            {

                if (count == 0)
                {
                    _obj = new clsObj
                    {
                        Parameter = new[] { "@SoPhieu" },
                        ValueParameter = new object[] { soPhieu },
                        SpName = "sp_ChungTuThanhToan_Delete"
                    };
                    _sql.fNonGetData(_obj);

                    if (_obj.KetQua > 0)
                    {
                        lbLoiTU.Text = "<font color='blue'>Xoá thành công thanh toán tạm ứng.</font>";

                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu", "@LastModifiedByID" },
                            ValueParameter = new object[] { soPhieu, Session["UserID"].ToString() },
                            SpName = "SP_DELETE_HOADONDIENTU"
                        };
                        _sql.fNonGetData(_obj);
                    }
                    else
                    {
                        lbLoiTU.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
                    }


                    LoadChungTuThanhToan();
                }
                else
                {
                    lbLoiTU.Text = "<font color='Red'>Đã có chi tiết nên không xóa được.</font>";
                    LoadChungTuThanhToan();
                }
            }

        }

        protected void rgChungTuThanhToan_ItemCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiTU.Text = "";
            if (e.CommandName == RadGrid.FilterCommandName)
            {
                LoadChungTuThanhToan();
            }

            if (e.CommandName == RadGrid.EditCommandName)
            {

                rgChungTuThanhToan.MasterTableView.IsItemInserted = false;

                e.Item.OwnerTableView.EditFormSettings.UserControlName =
                    "~/Controls/ChungTuThanhToanTamUng_Update.ascx";
                LoadChungTuThanhToan();
            }

            switch (e.CommandName)
            {
                case RadGrid.FilterCommandName:
                    LoadChungTuThanhToan();
                    break;
                case RadGrid.RebindGridCommandName:
                    LoadChungTuThanhToan();
                    break;

                case "PRINT":


                    #region report KHOI

                    _obj = new clsObj();
                    _obj.Parameter = new[] { "@SoPhieu" };
                    _obj.ValueParameter = new object[] { rgChungTuThanhToan.Items[e.Item.ItemIndex]["SoPhieu"].Text };
                    _obj.SpName = "sp_ChungTuThanhToan_TamUng_Count";
                    _sql.fGetData(_obj);
                    if (_obj.KetQua < 1)
                    {
                        try
                        {
                            countTU = _obj.Dt.Rows[0]["CountSoPhieu"].ToString();
                        }
                        catch
                        {
                        }
                    }

                    if (int.Parse(countTU) == 0)
                    {
                        lbLoiTU.Text = "<font color='Red'>Chưa có chi tiết nên không in được.</font>";
                        LoadThanhToanKhongTamUng();
                    }
                    else
                    {

                        lbLoiTU.Text = "";

                        #region Lấy report

                        _report = ReportFactory.GetReport(_report.GetType());


                        if ((txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.HNO") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.DNA") ||
                           
                            (txtMaDV.Text == "CN.HNO" && txtMaBP.Text == "CN.HNO") ||
                            (txtMaDV.Text == "CN.DNA" && txtMaBP.Text == "CN.DNA") ||
                            (txtMaDV.Text == "CN.CTO" && txtMaBP.Text == "CN.CTO") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNS") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNG") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNH")

                        )
                        {
                            _report.Load(Server.MapPath(@"~\Reports\GiayThanhToanTamUngCNHNO.rpt"));
                        }
                        else if (txtMaDV.Text == "THAITU")
                        {
                            _report.Load(Server.MapPath(@"~\Reports\GiayThanhToanTamUngTT.rpt"));
                        }
                        else
                        {

                            if ((txtMaDV.Text == "KDND") || (txtMaDV.Text == "KDND" && txtMaBP.Text == "CN.CTO") || txtMaDV.Text == "P.MAR")
                            {
                                _report.Load(Server.MapPath(@"~\reports\GiayThanhToanTamUngKDND_MAR.rpt"));
                                //_report.Load(Server.MapPath(@"~\Reports\GiayThanhToanTamUng.rpt"));
                            }
                            else
                            {
                                _report.Load(Server.MapPath(@"~\Reports\GiayThanhToanTamUng.rpt"));
                            }
                        }

                        _report.SetParameterValue("@SoPhieu",
                            rgChungTuThanhToan.Items[e.Item.ItemIndex]["SoPhieu"].Text);

                        Session["report"] = _report;

                        #endregion

                        #region Gọi file report

                        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                        DialogWindow.VisibleOnPageLoad = true;
                        LoadThanhToanKhongTamUng();

                        #endregion

                    }

                    #endregion

                    break;
            }

        }

        protected void rgChungTuThanhToan_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiTU.Text = "";

            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            string hdSoPhieu = (userControl.FindControl("hdSoPhieu") as HiddenField).Value;
            RadNumericTextBox rnTiGia = userControl.FindControl("rnTiGia") as RadNumericTextBox;
            DropDownList ddlLoaiTien = userControl.FindControl("ddlLoaiTien") as DropDownList;
            string txtNoiDung = (userControl.FindControl("txtNoiDung") as TextBox).Text;
            RadDatePicker HanThanhToan = userControl.FindControl("rdHanThanhToan") as RadDatePicker;

            RadNumericTextBox rnTiGiaCu = userControl.FindControl("rnTiGiaCu") as RadNumericTextBox;
            RadDatePicker HanThanhToanCu = userControl.FindControl("rdHanThanhToanCu") as RadDatePicker;
            DropDownList ddlHinhThucThanhToanUpdate = userControl.FindControl("ddlHinhThucThanhToan") as DropDownList;
            string txtNganHang = ((TextBox)userControl.FindControl("txtNganHang")).Text;
            string txtTenTK = ((TextBox)userControl.FindControl("txtTenTK")).Text;
            string txtSoTK = ((TextBox)userControl.FindControl("txtSoTK")).Text;


            DropDownList DropDownListLoaiHoaDon = userControl.FindControl("DropDownListLoaiHoaDon") as DropDownList;

            string PhieuTU = rgChungTuThanhToan.Items[e.Item.ItemIndex]["SoPhieu"].Text;
            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { hdSoPhieu },
                SpName = "sp_ChungTuThanhToanTamUng_KeToanKTBySoPhieu"
            };
            _sql.fGetData(_obj);

            if (_obj.KetQua < 1)
            {
                try
                {
                    xx = bool.Parse(_obj.Dt.Rows[0]["BPTCKTKiemtra"].ToString());
                    if (xx)
                    {
                        lbLoiTU.Text = "<font color='Red'>Số phiếu <b><font color='black'>" + hdSoPhieu +
                                       "</font></b> kế toán đã xác nhận nên không sữa được.</font>";
                        LoadChungTuThanhToan();
                    }
                    else
                    {
                        #region Kiểm tra ko cho đổi tỉ giá khi đã có chi tiết

                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu" },
                            ValueParameter = new object[] { hdSoPhieu },
                            SpName = "sp_ChiTietPhieuDeNghiThanhToan_BySoPhieu"
                        };
                        _sql.fGetData(_obj);
                        if (_obj.Dt.Rows.Count > 0 && rnTiGia.Value > rnTiGiaCu.Value)
                        {
                            LoadChungTuThanhToan();
                            lbLoiTU.Text =
                                "<font color='red'>Không thể tăng <b>tỉ giá</b> khi đã có chi tiết chứng từ.</font>";
                            return;
                        }

                        #endregion

                        #region Kiem tra han thanh toan

                        if (HanThanhToan.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                        {
                            lbLoiTU.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                            LoadChungTuThanhToan();
                            return;
                        }

                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu" },
                            ValueParameter = new object[] { hdSoPhieu },
                            SpName = "sp_ChiTietPhieuDeNghiThanhToan_BySoPhieu"
                        };
                        _sql.fGetData(_obj);
                        if (_obj.Dt.Rows.Count > 0)
                        {
                            if (HanThanhToanCu.SelectedDate.Value.Month != HanThanhToan.SelectedDate.Value.Month
                                || HanThanhToanCu.SelectedDate.Value.Year != HanThanhToan.SelectedDate.Value.Year)
                            {
                                LoadChungTuThanhToan();
                                lbLoiTU.Text =
                                    "<font color='red'>Không thể đổi hạn thanh toán sang tháng khác khi đã có chi tiết thanh toán.</font>";
                                return;
                            }
                        }

                        #endregion

                        #region Luu

                        var maSoThue = ((TextBox)userControl.FindControl("TextBoxMaSoThue")).Text;
                        var maTraCuuHoacTaiKhoan = ((TextBox)userControl.FindControl("TextBoxMaTraCuuHoacTaiKhoan")).Text;
                        var maXacThucHoacMatKhau = ((TextBox)userControl.FindControl("TextBoxSoHoaDonXacThuc")).Text;
                        var soHoaDon = ((TextBox)userControl.FindControl("TextBoxSoHoaDon")).Text;
                        var tenFile = ((TextBox)userControl.FindControl("TextBoxTenFile")).Text;
                        var duongLinkTtruyCap = ((TextBox)userControl.FindControl("TextBoxDuongDan")).Text;
                        var duongDanLuuFile = ((HtmlAnchor)userControl.FindControl("Download")).HRef;

                        if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                        {
                            #region Kiểm tra điều kiên bắt buộc dành cho HDDT

                            if (string.IsNullOrEmpty(soHoaDon))
                            {
                                throw new Exception("Số hóa đơn không được trống.");
                            }

                            if (string.IsNullOrEmpty(maSoThue))
                            {
                                throw new Exception("Mã số thuế không được trống.");
                            }

                            //if (string.IsNullOrEmpty(maTraCuuHoacTaiKhoan))
                            //{
                            //    throw new Exception("Mã tra cứu hóa đơn không được trống.");
                            //}

                            //if (string.IsNullOrEmpty(duongLinkTtruyCap))
                            //{
                            //    throw new Exception("Đường dẫn hóa đơn không được trống.");
                            //}

                            if (string.IsNullOrEmpty(tenFile))
                            {
                                throw new Exception("Tên File không được trống.");
                            }

                            if (string.IsNullOrEmpty(duongDanLuuFile) || duongDanLuuFile == "#")
                            {
                                throw new Exception("Bạn chưa tải File lên chương trình");
                            }

                            #endregion
                        }


                        _obj = new clsObj
                        {
                            Parameter = new[]
                        {
                                "@SoPhieu",
                                "@TiGia",
                                "@LoaiTien",
                                "@HanThanhToan",
                                "@NoiDung",
                                "@HTTT",
                                "@NganHang",
                                "@TenTK",
                                "@SoTK",
                                "@LoaiHoaDon"
                            },
                            ValueParameter = new object[]
                        {
                                hdSoPhieu,
                                rnTiGia.Value,
                                ddlLoaiTien.SelectedValue,
                                HanThanhToan.SelectedDate,
                                txtNoiDung,
                                ddlHinhThucThanhToanUpdate.SelectedValue,
                                txtNganHang,
                                txtTenTK,
                                txtSoTK,
                                DropDownListLoaiHoaDon.SelectedValue
                        },
                            SpName = "sp_GiayThanhToanTamUng_Update"
                        };
                        _sql.fNonGetData(_obj);
                        if (_obj.KetQua > 0)
                        {
                            lbLoiTU.Text =
                                "<font color='blue'>Cập nhật thành công chứng từ thanh toán <b><font color='black'>" +
                                hdSoPhieu + "</font></b>.</font>";


                            if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                            {
                                _obj = new clsObj
                                {
                                    Parameter = new[]
                                    {
                                        "@SoPhieu",
                                        "@SoHoaDon",
                                        "@MaSoThue",
                                        "@MaTraHoacTaiKhoan",
                                        "@MaXacThucHoacMatKhau",
                                        "@DuongDanTraCuu",
                                        "@TenFile",
                                        "@DuongDanLuuFile",
                                        "@CreatedBy",
                                        "@CreatedDate",
                                        "@LastModifiedByID",
                                        "@LastModifiedDate"
                                    },
                                    ValueParameter = new object[]
                                    {
                                        hdSoPhieu,
                                        soHoaDon,
                                        maSoThue,
                                        maTraCuuHoacTaiKhoan,
                                        maXacThucHoacMatKhau,
                                        duongLinkTtruyCap,
                                        tenFile,
                                        duongDanLuuFile,
                                        duongDanLuuFile,
                                        Session["UserID"].ToString(),
                                        DateTime.Now,
                                        Session["UserID"].ToString(),
                                        DateTime.Now
                                    },
                                    SpName = "SP_INSERT_UPDATE_HOADONDIENTU"
                                };
                                _sql.fNonGetData(_obj);
                            }
                            else
                            {
                                _obj = new clsObj
                                {
                                    Parameter = new[] { "@SoPhieu", "@LastModifiedByID" },
                                    ValueParameter = new object[] { hdSoPhieu, Session["UserID"].ToString() },
                                    SpName = "SP_DELETE_HOADONDIENTU"
                                };
                                _sql.fNonGetData(_obj);
                            }
                        }
                        else
                        {
                            lbLoiTU.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                        }

                        #endregion
                    }
                }
                catch (Exception ex)
                {
                    lbLoiTU.Text = "<font color='red'>" + ex.Message + ".</font>";
                    e.Canceled = true;
                }
            }

            LoadChungTuThanhToan();
        }

        #endregion


        #region Chứng từ thanh toán không tạm ứng (RadPageView2)

        void LoadDonVi2()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "SP_LoadNVIDMaDV"
            };

            _sql.fGetData(_obj);
            if (_obj.Dt.Rows.Count < 1)
            {
                txtMaDV2.Text = "Không tìm thấy";
                txtTenDonVi2.Text = "Không tìm thấy";
            }
            else
            {
                txtMaDV2.Text = _obj.Dt.Rows[0]["MaDV"].ToString();
                txtMaBP2.Text = _obj.Dt.Rows[0]["MaBP"].ToString();
                txtTenDonVi2.Text = _obj.Dt.Rows[0]["TenGoi"].ToString();
                txtIDMaCS2.Text = _obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
        }

        void LoadNguoiDuocThanhToan2()
        {

            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "sp_NhanVien_ByMaNV"
            };
            _sql.fGetData(_obj);
            ddlNguoiDuocThanhToan2.DataSource = _obj.Dt;
            ddlNguoiDuocThanhToan2.DataBind();
        }

        void LoadPhuTrachDonVi2()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaBP" },
                ValueParameter = new object[] { txtMaBP2.Text },
                SpName = "sp_PhuTrachDonVi_GetAll_ByMaBP"
            };


            _sql.fGetData(_obj);
            ddlPhuTrachDonVi2.DataSource = _obj.Dt;
            ddlPhuTrachDonVi2.DataBind();
        }

        void LoadTienTe2()
        {
            _obj = new clsObj
            {
                Parameter = new string[] { },
                ValueParameter = new object[] { },
                SpName = "sp_CbLoaiTien_Load"
            };
            _sql.fGetData(_obj);
            ddlLoaiTien2.DataSource = _obj.Dt;
            ddlLoaiTien2.DataBind();
        }

        void LoadTiGia2()
        {
            if (ddlLoaiTien2.SelectedValue == "VND")
            {
                rnTiGia2.Value = 1;
           
            }
            else
            {
                string tiGia = _gtg.ExchangeRates(ddlLoaiTien2.SelectedValue);
                if (tiGia != "")
                {
                    rnTiGia2.Value = double.Parse(_gtg.ExchangeRates(ddlLoaiTien2.SelectedValue));
         
                }
                else
                {
                    rnTiGia2.Text = "";
                  
                }

            }
   
        }

        void LoadThanhToanKhongTamUng()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@NguoiThanhToan", "@LoaiPhieu" },
                ValueParameter = new object[] { ddlNguoiThanhToan.SelectedValue, "GDNTT" },
                SpName = "sp_ChungTuThanhToan_LoadGiayThanhToanKhongTamUng"
            };
            _sql.fGetData(_obj);
            RGKhongTamUng.DataSource = _obj.Dt;
            RGKhongTamUng.DataBind();
        }

        protected void ddlLoaiTien2_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTiGia2();
            if (ddlLoaiTien.SelectedValue != "VND")
            {

                rnTiGia2.Enabled = true;
            }
            else
            {
                rnTiGia2.Enabled = false;
            }
        }

        protected void ddlHinhThucThanhToan2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlHinhThucThanhToan2.SelectedValue == "NH")
            {
                txtTenTaiKhoan2.Enabled = true;
                txtSoTaiKhoan2.Enabled = true;
                txtNganHang2.Enabled = true;
            }
            else
            {
                txtTenTaiKhoan2.Text = "";
                txtSoTaiKhoan2.Text = "";
                txtNganHang2.Text = "";
                txtTenTaiKhoan2.Enabled = false;
                txtSoTaiKhoan2.Enabled = false;
                txtNganHang2.Enabled = false;
            }
        }

        protected void btnLuu2_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                lbLoiDN.Text = "";

                string IDMaCS2;
                if (txtIDMaCS.Text == "100")
                {
                    IDMaCS2 = "CONGSO";
                }
                else
                {
                    if (txtIDMaCS2.Text == "30" || txtIDMaCS2.Text == "31")
                    {
                        IDMaCS2 = txtIDMaCS2.Text;
                    }
                    else
                    {
                        IDMaCS2 = txtMaBP2.Text;
                    }
                }

                if (rdHanThanhToan2.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                {
                    lbLoiDN.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                    return;
                }

                #region Kiểm tra điều kiên bắt buộc dành cho HDDT

                if (DropDownListDNTTLoaiHoaDon.SelectedValue == "DIENTU")
                {

                    if (string.IsNullOrEmpty(TextBoxDNTTSoHoaDon.Text))
                    {
                        throw new Exception("Số hóa đơn không được trống.");
                    }

                    if (string.IsNullOrEmpty(TextBoxDNTTMaSoThue.Text))
                    {
                        throw new Exception("Mã số thuế không được trống.");
                    }

                    //if (string.IsNullOrEmpty(TextBoxDNTTMaTraCuuHoacTaiKhoan.Text))
                    //{
                    //    throw new Exception("Mã tra cứu hóa đơn không được trống.");
                    //}

                    //if (string.IsNullOrEmpty(TextBoxDNTTDuongLinkTruyCap.Text))
                    //{
                    //    throw new Exception("Đường dẫn hóa đơn không được trống.");
                    //}

                    if (string.IsNullOrEmpty(TextBoxDNTTTenFile.Text))
                    {
                        throw new Exception("Tên File không được trống.");
                    }

                    if (string.IsNullOrEmpty(DNTTDownload.HRef) || DNTTDownload.HRef == "#")
                    {
                        throw new Exception("Bạn chưa tải File lên chương trình");
                    }
                }
                #endregion


                _obj = new clsObj
                {
                    Parameter = new[] { "@IDMaCS", "@MaDV", "@LoaiPhieu" },
                    ValueParameter = new object[]
                        {txtIDMaCS2.Text == "100" ? "49" : txtIDMaCS2.Text, txtMaBP2.Text, "GDNTT"},
                    SpName = "sp_ChungTuThanhToan_TaoPhieu"
                };
                _sql.fGetData(_obj);
                string soPhieu = _obj.Dt.Rows[0]["SoPhieu"].ToString();


                _obj = new clsObj
                {
                    Parameter = new[]
                    {
                        "@SoPhieu",
                        "@MaDV",
                        "@Hanthantoan",
                        "@NguoiKT",
                        "@NoiDung",
                        "@Nguoilap",
                        "@NguoiThanhToan",
                        "@LoaiPhieu",
                        "@LoaiTien",
                        "@Tigia",
                        "@PhuongThucTT",
                        "@LaTienMat",
                        "@TenTaiKhoan",
                        "@SoTaiKhoan",
                        "@NganHang",
                        "@LoaiHoaDon"
                    },
                    ValueParameter = new object[]
                    {
                        soPhieu,
                        IDMaCS2,
                        rdHanThanhToan2.SelectedDate,
                        ddlPhuTrachDonVi2.SelectedValue,
                        txtNoiDung2.Text,
                        Session["UserID"].ToString(),
                        ddlNguoiDuocThanhToan2.SelectedValue,
                        "GDNTT",
                        ddlLoaiTien2.SelectedValue,
                        decimal.Parse(rnTiGia2.Text),
                        ddlPhuongThucThanhToan2.SelectedValue,
                        ddlHinhThucThanhToan2.SelectedValue,
                        txtTenTaiKhoan2.Text,
                        txtSoTaiKhoan2.Text,
                        txtNganHang2.Text,
                        DropDownListDNTTLoaiHoaDon.SelectedValue
                    },
                    SpName = "sp_ChungTuThanhToan_Insert"
                };


                _sql.fGetData(_obj);
                if (_obj.KetQua > 0)
                {
                    lbLoiDN.Text = "<font color='Red'>Thêm thất bại.</font>";
                }
                else
                {
                    lbLoiDN.Text = "<font color='Blue'>Thêm thành công.</font>";
                    _obj = new clsObj
                    {
                        Parameter = new[]
                        {
                            "@SoPhieu",
                            "@SoHoaDon",
                            "@MaSoThue",
                            "@MaTraHoacTaiKhoan",
                            "@MaXacThucHoacMatKhau",
                            "@DuongDanTraCuu",
                            "@TenFile",
                            "@DuongDanLuuFile",
                            "@CreatedBy",
                            "@CreatedDate",
                            "@LastModifiedByID",
                            "@LastModifiedDate"
                        },
                        ValueParameter = new object[]
                        {
                            soPhieu,
                            TextBoxDNTTSoHoaDon.Text,
                            TextBoxDNTTMaSoThue.Text,
                            TextBoxDNTTMaTraCuuHoacTaiKhoan.Text,
                            TextBoxDNTTMaXacThucHoacMatKhau.Text,
                            TextBoxDNTTDuongLinkTruyCap.Text,
                            TextBoxDNTTTenFile.Text,
                            DNTTDownload.HRef,
                            Session["UserID"].ToString(),
                            DateTime.Now,
                            Session["UserID"].ToString(),
                            DateTime.Now
                        },
                        SpName = "SP_INSERT_HOADONDIENTU"
                    };

                    _sql.fGetData(_obj);

                    if (_obj.KetQua > 0)
                    {
                        lbLoiDN.Text = "<font color='Red'>Thêm thông tin hóa đơn điện tử thất bại.</font>";
                    }
                    DNTTDownload.HRef = string.Empty;
                }

                LoadThanhToanKhongTamUng();
            }
            catch (Exception ex)
            {
                lbLoiDN.Text = "<font color='Red'>" + ex.Message + ".</font>";
            }
        }


        protected void RGKhongTamUng_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiDN.Text = "";
            string soPhieu = RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text;

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietThanhToan_Count"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {
                    count = int.Parse(_obj.Dt.Rows[0]["CountCTTT"].ToString());
                }
                catch
                {
                }
            }


            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietThanhToan_GetXX"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {
                    xx = clsConvertHelper.Tobool(_obj.Dt.Rows[0]["KiemTra"].ToString());
                }
                catch
                {
                }
            }

            if (xx)
            {
                lbLoiDN.Text = "<font color='red'>Phiếu này đã kiểm tra nên không xóa được.</font>";
                LoadThanhToanKhongTamUng();
            }
            else
            {
                if (count == 0)
                {
                    _obj = new clsObj
                    {
                        Parameter = new[] { "@SoPhieu" },
                        ValueParameter = new object[] { soPhieu },
                        SpName = "sp_ChungTuThanhToan_Delete"
                    };
                    _sql.fNonGetData(_obj);
                    if (_obj.KetQua > 0)
                    {
                        lbLoiDN.Text = "<font color='blue'>Xoá thành công.</font>";
                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu", "@LastModifiedByID" },
                            ValueParameter = new object[] { soPhieu, Session["UserID"].ToString() },
                            SpName = "SP_DELETE_HOADONDIENTU"
                        };
                        _sql.fNonGetData(_obj);
                    }
                    else
                    {
                        lbLoiDN.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
                    }

                    LoadThanhToanKhongTamUng();
                }
                else
                {
                    lbLoiDN.Text = "<font color='red'>Đã có chi tiết nên không xóa được.</font>";
                    LoadThanhToanKhongTamUng();
                }
            }


        }

        protected void RGKhongTamUng_PageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            LoadThanhToanKhongTamUng();
        }

        protected void RGKhongTamUng_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            LoadThanhToanKhongTamUng();
        }

        string countTU;

        protected void RGKhongTamUng_ItemCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiDN.Text = "";
            if (e.CommandName == RadGrid.FilterCommandName)
            {
                LoadThanhToanKhongTamUng();
            }

            if (e.CommandName == RadGrid.EditCommandName)
            {

                RGKhongTamUng.MasterTableView.IsItemInserted = false;

                e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/GiayDeNghiThanhToan_Update.ascx";
                LoadThanhToanKhongTamUng();
            }

            switch (e.CommandName)
            {
                case RadGrid.FilterCommandName:
                    LoadThanhToanKhongTamUng();
                    break;
                case RadGrid.RebindGridCommandName:
                    LoadThanhToanKhongTamUng();
                    break;
                case "PRINT":

                    #region report KHOI

                    _obj = new clsObj();
                    _obj.Parameter = new[] { "@SoPhieu" };
                    _obj.ValueParameter = new object[] { RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text };
                    _obj.SpName = "sp_ChungTuThanhToan_KhongTamUng_Count";
                    _sql.fGetData(_obj);
                    if (_obj.KetQua < 1)
                    {
                        try
                        {
                            countTU = _obj.Dt.Rows[0]["CountSoPhieu"].ToString();
                        }
                        catch
                        {
                        }
                    }

                    if (int.Parse(countTU) == 0)
                    {
                        lbLoiDN.Text = "<font color='Red'>Chưa có chi tiết nên không in được.</font>";
                        LoadThanhToanKhongTamUng();
                    }
                    else
                    {
                        lbLoiDN.Text = "";

                        #region Lấy report

                        _report = ReportFactory.GetReport(_report.GetType());
                        if ((txtMaDV2.Text == "KDND" && txtMaBP2.Text == "CN.HNO")
                            || (txtMaDV2.Text == "KDND" && txtMaBP2.Text == "CN.DNA")
                           
                            || (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNS") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNG") ||
                            (txtMaDV.Text == "KDND" && txtMaBP.Text == "HNH"))
                        {
                            _report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUng.rpt"));
                        }
                        //else if (txtMaDV.Text == "THAITU")
                        //{
                        //    _report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUngTT.rpt"));
                        //}
                        else
                        {
                            //if ((txtMaDV2.Text == "KDND") || (txtMaDV2.Text == "KDND" && txtMaBP2.Text == "CN.CTO") || txtMaDV2.Text == "P.MAR")
                            //{
                            //    if (RGKhongTamUng.Items[e.Item.ItemIndex]["LaTienmat"].Text.ToUpper() == "TM")
                            //    {
                            //        _report.Load(Server.MapPath(@"~\reports\rptDeNghiThanhToan_KDND_MAR.rpt"));
                            //    }
                            //    else
                            //    {
                            //        _report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUng.rpt"));
                            //    }
                            //}
                            //else
                            //{
                                _report.Load(Server.MapPath(@"~\Reports\rptChungTuThanhToanKhongTamUng.rpt"));
                            //}
                        }

                        _report.SetParameterValue("@SoPhieu", RGKhongTamUng.Items[e.Item.ItemIndex]["SoPhieu"].Text);

                        Session["report"] = _report;


                        #endregion

                        #region Gọi file report

                        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                        DialogWindow.VisibleOnPageLoad = true;

                        LoadThanhToanKhongTamUng();

                        #endregion
                    }

                    #endregion

                    break;
            }

        }

        protected void RGKhongTamUng_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiDN.Text = "";

            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            string hdSoPhieu_ct = (userControl.FindControl("hdSoPhieuDeNghiThanhToan") as HiddenField).Value;
            RadNumericTextBox rnTiGia_ct = userControl.FindControl("rnTiGia") as RadNumericTextBox;
            RadNumericTextBox rnTiGiaCu = userControl.FindControl("rnTiGiaCu") as RadNumericTextBox;
            DropDownList ddlLoaiTien_ct = userControl.FindControl("ddlLoaiTien") as DropDownList;
            string txtNoiDung_ct = (userControl.FindControl("txtNoiDung") as TextBox).Text;
            RadDatePicker HanThanhToan_ct = userControl.FindControl("rdHanThanhToan") as RadDatePicker;
            RadDatePicker HanThanhToanCu = userControl.FindControl("rdHanThanhToanCu") as RadDatePicker;

            DropDownList ddlHinhThucThanhToanUpdate = userControl.FindControl("ddlHinhThucThanhToan") as DropDownList;
            DropDownList DropDownListLoaiHoaDon = userControl.FindControl("DropDownListLoaiHoaDon") as DropDownList;
            string txtNganHang = (userControl.FindControl("txtNganHang") as TextBox).Text;
            string txtTenTK = (userControl.FindControl("txtTenTK") as TextBox).Text;
            string txtSoTK = (userControl.FindControl("txtSoTK") as TextBox).Text;

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { hdSoPhieu_ct },
                SpName = "sp_ChungTuThanhToanTamUng_KeToanKTBySoPhieu"
            };
            _sql.fGetData(_obj);

            if (_obj.KetQua < 1)
            {
                try
                {
                    xx = bool.Parse(_obj.Dt.Rows[0]["BPTCKTKiemtra"].ToString());
                    if (xx == true)
                    {
                        lbLoiDN.Text = "<font color='Red'>Số phiếu <b><font color='black'>" + hdSoPhieu_ct +
                                       "</font></b> kế toán đã xác nhận nên không sữa được.</font>";
                        LoadThanhToanKhongTamUng();
                    }
                    else
                    {

                        #region Kiểm tra ko cho đổi tỉ giá khi đã có chi tiết

                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu" },
                            ValueParameter = new object[] { hdSoPhieu_ct },
                            SpName = "sp_ChiTietPhieuDeNghiThanhToan_BySoPhieu"
                        };
                        _sql.fGetData(_obj);
                        if (_obj.Dt.Rows.Count > 0 && rnTiGia_ct.Value > rnTiGiaCu.Value)
                        {
                            LoadThanhToanKhongTamUng();
                            lbLoiDN.Text =
                                "<font color='red'>Không thể tăng <b>tỉ giá</b> khi đã có chi tiết chứng từ.</font>";
                            return;
                        }

                        #endregion

                        #region Kiem tra han thanh toan

                        if (HanThanhToan_ct.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
                        {
                            lbLoiDN.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                            LoadThanhToanKhongTamUng();
                            return;
                        }

                        _obj = new clsObj
                        {
                            Parameter = new[] { "@SoPhieu" },
                            ValueParameter = new object[] { hdSoPhieu_ct },
                            SpName = "sp_ChiTietPhieuDeNghiThanhToan_BySoPhieu"
                        };
                        _sql.fGetData(_obj);
                        if (_obj.Dt.Rows.Count > 0)
                        {
                            if (HanThanhToanCu.SelectedDate.Value.Month != HanThanhToan_ct.SelectedDate.Value.Month
                                || HanThanhToanCu.SelectedDate.Value.Year != HanThanhToan_ct.SelectedDate.Value.Year)
                            {
                                LoadThanhToanKhongTamUng();
                                lbLoiDN.Text =
                                    "<font color='red'>Không thể đổi hạn thanh toán sang tháng khác khi đã có chi tiết thanh toán.</font>";
                                return;
                            }
                        }

                        #endregion

                        #region Luu

                        var maSoThue = ((TextBox)userControl.FindControl("TextBoxMaSoThue")).Text;
                        var maTraCuuHoacTaiKhoan = ((TextBox)userControl.FindControl("TextBoxMaTraCuuHoacTaiKhoan")).Text;
                        var maXacThucHoacMatKhau = ((TextBox)userControl.FindControl("TextBoxSoHoaDonXacThuc")).Text;
                        var soHoaDon = ((TextBox)userControl.FindControl("TextBoxSoHoaDon")).Text;
                        var tenFile = ((TextBox)userControl.FindControl("TextBoxTenFile")).Text;
                        var duongLinkTtruyCap = ((TextBox)userControl.FindControl("TextBoxDuongDan")).Text;
                        var duongDanLuuFile = ((HtmlAnchor)userControl.FindControl("Download")).HRef;

                        if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                        {
                            #region Kiểm tra điều kiên bắt buộc dành cho HDDT

                            if (string.IsNullOrEmpty(soHoaDon))
                            {
                                throw new Exception("Số hóa đơn không được trống.");
                            }

                            if (string.IsNullOrEmpty(maSoThue))
                            {
                                throw new Exception("Mã số thuế không được trống.");
                            }

                            //if (string.IsNullOrEmpty(maTraCuuHoacTaiKhoan))
                            //{
                            //    throw new Exception("Mã tra cứu hóa đơn không được trống.");
                            //}

                            //if (string.IsNullOrEmpty(duongLinkTtruyCap))
                            //{
                            //    throw new Exception("Đường dẫn hóa đơn không được trống.");
                            //}

                            if (string.IsNullOrEmpty(tenFile))
                            {
                                throw new Exception("Tên File không được trống.");
                            }

                            if (string.IsNullOrEmpty(duongDanLuuFile) || duongDanLuuFile == "#")
                            {
                                throw new Exception("Bạn chưa tải File lên chương trình");
                            }

                            #endregion
                        }
                        _obj = new clsObj
                        {
                            Parameter = new[]
                            {
                                "@SoPhieu",
                                "@TiGia",
                                "@LoaiTien",
                                "@HanThanhToan",
                                "@NoiDung",
                                "@HTTT",
                                "@NganHang",
                                "@TenTK",
                                "@SoTK",
                                "@LoaiHoaDon"
                            },
                            ValueParameter = new object[]
                            {
                                hdSoPhieu_ct,
                                rnTiGia_ct.Value,
                                ddlLoaiTien_ct.SelectedValue,
                                HanThanhToan_ct.SelectedDate,
                                txtNoiDung_ct,
                                ddlHinhThucThanhToanUpdate.SelectedValue,
                                txtNganHang,
                                txtTenTK,
                                txtSoTK,
                                DropDownListLoaiHoaDon.SelectedValue
                            },
                            SpName = "sp_GiayDeNghiThanhToan_Update"
                        };
                        _sql.fNonGetData(_obj);
                        if (_obj.KetQua > 0)
                        {
                            lbLoiDN.Text =
                                "<font color='blue'>Cập nhật thành công giấy đề nghị thanh toán <b><font color='black'>" +
                                hdSoPhieu_ct + "</font></b>.</font>";



                            if (DropDownListLoaiHoaDon.SelectedValue == "DIENTU")
                            {


                                _obj = new clsObj
                                {
                                    Parameter = new[]
                                    {
                                        "@SoPhieu",
                                        "@SoHoaDon",
                                        "@MaSoThue",
                                        "@MaTraHoacTaiKhoan",
                                        "@MaXacThucHoacMatKhau",
                                        "@DuongDanTraCuu",
                                        "@TenFile",
                                        "@DuongDanLuuFile",
                                        "@CreatedBy",
                                        "@CreatedDate",
                                        "@LastModifiedByID",
                                        "@LastModifiedDate"
                                    },
                                    ValueParameter = new object[]
                                    {
                                        hdSoPhieu_ct,
                                        soHoaDon,
                                        maSoThue,
                                        maTraCuuHoacTaiKhoan,
                                        maXacThucHoacMatKhau,
                                        duongLinkTtruyCap,
                                        tenFile,
                                        duongDanLuuFile,
                                        duongDanLuuFile,
                                        Session["UserID"].ToString(),
                                        DateTime.Now,
                                        Session["UserID"].ToString(),
                                        DateTime.Now
                                    },
                                    SpName = "SP_INSERT_UPDATE_HOADONDIENTU"
                                };
                                _sql.fNonGetData(_obj);
                            }
                            else
                            {
                                _obj = new clsObj
                                {
                                    Parameter = new[] { "@SoPhieu", "@LastModifiedByID" },
                                    ValueParameter = new object[] { hdSoPhieu_ct, Session["UserID"].ToString() },
                                    SpName = "SP_DELETE_HOADONDIENTU"
                                };
                                _sql.fNonGetData(_obj);
                            }
                        }
                        else
                        {
                            lbLoiDN.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                        }

                        #endregion
                    }
                }
                catch (Exception ex)
                {
                    lbLoiDN.Text = "<font color='red'>" + ex.Message + ".</font>";
                    e.Canceled = true;
                }
            }

            LoadThanhToanKhongTamUng();
        }

        protected void RGKhongTamUng_CancelCommand(object sender, GridCommandEventArgs e)
        {
            LoadThanhToanKhongTamUng();
        }

        #endregion


        #region Giấy nộp tiền (RadPageView3)

        void LoadPhieuNopTien()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "sp_ChungTuNopTien_ByMaNV"
            };
            _sql.fGetData(_obj);
            RGGiayNopTien.DataSource = _obj.Dt;
            RGGiayNopTien.DataBind();
        }

        void LoadDonVi3()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "SP_LoadNVIDMaDV"
            };
            //Obj.Connectionstring = wqlvattu;
            _sql.fGetData(_obj);
            if (_obj.Dt.Rows.Count < 1)
            {
                txtMaDV3.Text = "Không tìm thấy";
                txtTenDV3.Text = "Không tìm thấy";
            }
            else
            {
                txtMaDV3.Text = _obj.Dt.Rows[0]["MaDV"].ToString();
                txtMaBP3.Text = _obj.Dt.Rows[0]["MaBP"].ToString();
                txtTenDV3.Text = _obj.Dt.Rows[0]["TenGoi"].ToString();
                txtIDMaCS3.Text = _obj.Dt.Rows[0]["IDMaCS"].ToString();
            }
        }

        void LoadNguoiNopTien()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaNV" },
                ValueParameter = new object[] { Session["UserID"].ToString() },
                SpName = "sp_NhanVien_ByMaNV"
            };
            _sql.fGetData(_obj);
            ddlNguoiNopTien.DataSource = _obj.Dt;
            ddlNguoiNopTien.DataBind();

        }

        void LoadPhuTrachDonVi3()
        {
            _obj = new clsObj
            {
                Parameter = new[] { "@MaBP" },
                ValueParameter = new object[] { txtMaBP3.Text },
                SpName = "sp_PhuTrachDonVi_GetAll_ByMaBP"
            };

            _sql.fGetData(_obj);
            ddlPhuTrachDonVi3.DataSource = _obj.Dt;
            ddlPhuTrachDonVi3.DataBind();
        }

        void LoadTienTe3()
        {
            _obj = new clsObj
            {
                Parameter = new string[] { },
                ValueParameter = new object[] { },
                SpName = "sp_CbLoaiTien_Load"
            };
            _sql.fGetData(_obj);
            ddlLoaiTien3.DataSource = _obj.Dt;
            ddlLoaiTien3.DataBind();
        }

        void LoadTiGia3()
        {
            if (ddlLoaiTien3.SelectedValue == "VND")
            {
                rnTiGia3.Value = 1;
            }
            else
            {
                string tiGia = _gtg.ExchangeRates(ddlLoaiTien3.SelectedValue);
                if (tiGia != "")
                {
                    rnTiGia3.Value = double.Parse(_gtg.ExchangeRates(ddlLoaiTien3.SelectedValue));
                }
                else
                {
                    rnTiGia3.Text = "";
                }

            }
      
        }

        protected void ddlLoaiTien3_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTiGia3();
            if (ddlLoaiTien.SelectedValue != "VND")
            {

                rnTiGia3.Enabled = true;
            }
            else
            {
                rnTiGia3.Enabled = false;
            }
        }

        protected void btnLuu3_Click(object sender, ImageClickEventArgs e)
        {
            lbLoiNT.Text = "";

            string idmaCs3;
            if (txtIDMaCS3.Text == "100")
            {
                idmaCs3 = "CONGSO";
            }
            else
            {
                if (txtIDMaCS3.Text == "30" || txtIDMaCS3.Text == "31")
                {
                    idmaCs3 = txtIDMaCS3.Text;
                }
                else
                {
                    idmaCs3 = txtMaBP3.Text;
                }
            }

            if (rdHanThanhToan3.SelectedDate.Value < DateTime.Parse(DateTime.Now.ToShortDateString()))
            {
                lbLoiNT.Text = "<font color='red'>Hạn thanh toán không được nhỏ hơn ngày hiện tại.</font>";
                return;
            }

            _obj = new clsObj
            {
                Parameter = new[] { "@MaDV" },
                ValueParameter = new object[] { txtIDMaCS3.Text == "100" ? "49" : txtIDMaCS3.Text, },
                SpName = "sp_ChungTuNopTien_TaoPhieu"
            };
            _sql.fGetData(_obj);
            string soPhieu = _obj.Dt.Rows[0]["SoPhieu"].ToString();
            _obj = new clsObj
            {
                Parameter = new[]
                    {"@SoPhieu",
                        "@MaDV",
                        "@HanThanhToan",
                        "@LoaiTien",
                        "@NoiDung",
                        "@NguoiLap",
                        "@NguoiKT",
                        "@Tigia" },
                ValueParameter = new object[]
                {
                    soPhieu,
                    idmaCs3,
                    rdHanThanhToan3.SelectedDate,
                    ddlLoaiTien3.SelectedValue,
                    txtGhiChu.Text,
                    Session["UserID"].ToString(),
                    ddlPhuTrachDonVi3.SelectedValue,
                    rnTiGia3.Text
                },
                SpName = "sp_ChungTuNopTien_Insert"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua > 0)
            {
                lbLoiNT.Text = "<font color='Red'>Thêm thất bại.</font>";
            }
            else
            {
                lbLoiNT.Text = "<font color='Blue'>Thêm thành công.</font>";
            }

            LoadPhieuNopTien();
        }

        protected void RGGiayNopTien_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.EditCommandName)
            {

                RGGiayNopTien.MasterTableView.IsItemInserted = false;

                e.Item.OwnerTableView.EditFormSettings.UserControlName = "~/Controls/ChungTuNopTien_Update.ascx";
                LoadPhieuNopTien();
            }

            switch (e.CommandName)
            {
                case RadGrid.FilterCommandName:
                    LoadPhieuNopTien();
                    break;
                case RadGrid.RebindGridCommandName:
                    LoadPhieuNopTien();
                    break;
                case "PRINT":



                    #region report KHOI

                    _obj = new clsObj();
                    _obj.Parameter = new[] { "@SoPhieu" };
                    _obj.ValueParameter = new object[] { RGGiayNopTien.Items[e.Item.ItemIndex]["SoPhieu"].Text };
                    _obj.SpName = "sp_ChungTuNopTien_Count";
                    _sql.fGetData(_obj);
                    if (_obj.KetQua < 1)
                    {
                        try
                        {
                            countTU = _obj.Dt.Rows[0]["CountSoPhieu"].ToString();
                        }
                        catch
                        {
                        }
                    }

                    if (int.Parse(countTU) == 0)
                    {
                        lbLoiNT.Text = "<font color='Red'>Chưa có chi tiết nên không in được.</font>";
                        LoadPhieuNopTien();
                    }
                    else
                    {

                        lbLoiNT.Text = "";

                        #region Lấy report

                        _report = ReportFactory.GetReport(_report.GetType());

                        if (txtMaDV2.Text == "THAITU")
                        {
                            _report.Load(Server.MapPath(@"~\Reports\rptGiayNopTienTT.rpt"));

                        }
                        else
                        {
                            _report.Load(Server.MapPath(@"~\Reports\rptGiayNopTien.rpt"));
                        }

                        //  report.Load(Server.MapPath(@"~\Reports\rptGiayNopTien.rpt"));    
                        _report.SetParameterValue("@SoPhieu", RGGiayNopTien.Items[e.Item.ItemIndex]["SoPhieu"].Text);

                        Session["report"] = _report;


                        #endregion

                        #region Gọi file report


                        DialogWindow.NavigateUrl = "~/Reports/rptBaoCao.aspx";
                        DialogWindow.VisibleOnPageLoad = true;
                        LoadPhieuNopTien();

                        #endregion

                    }

                    #endregion

                    break;
            }
        }

        protected void RGGiayNopTien_PageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            LoadPhieuNopTien();
        }

        protected void RGGiayNopTien_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            LoadPhieuNopTien();
        }

        protected void RGGiayNopTien_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiNT.Text = "";

            UserControl userControl = (UserControl)e.Item.FindControl(GridEditFormItem.EditFormUserControlID);

            string hdSoPhieu_ct = (userControl.FindControl("hdSoPhieuDeNghiThanhToan") as HiddenField).Value;
            RadNumericTextBox rnTiGia_ct = userControl.FindControl("rnTiGia") as RadNumericTextBox;
            DropDownList ddlLoaiTien_ct = userControl.FindControl("ddlLoaiTien") as DropDownList;
            string txtNoiDung_ct = (userControl.FindControl("txtNoiDung") as TextBox).Text;
            RadDatePicker HanThanhToan_ct = userControl.FindControl("rdHanThanhToan") as RadDatePicker;

            _obj = new clsObj();
            _obj.Parameter = new[] { "@SoPhieu" };
            _obj.ValueParameter = new object[] { hdSoPhieu_ct };
            _obj.SpName = "sp_ChungTuNopTien_KeToanKTBySoPhieu";
            _sql.fGetData(_obj);

            if (_obj.KetQua < 1)
            {
                try
                {
                    xx = bool.Parse(_obj.Dt.Rows[0]["KiemTra"].ToString());
                    if (xx == true)
                    {
                        lbLoiNT.Text = "<font color='Red'>Số phiếu <b><font color='black'>" + hdSoPhieu_ct +
                                       "</font></b> kế toán đã xác nhận nên không sữa được.</font>";
                        LoadPhieuNopTien();
                    }
                    else
                    {


                        #region Luu

                        _obj = new clsObj
                        {
                            Parameter = new[]
                            {
                                "@SoPhieu",
                                "@TiGia",
                                "@LoaiTien",
                                "@HanThanhToan",
                                "@NoiDung"
                            },
                            ValueParameter = new object[]
                            {
                                hdSoPhieu_ct,
                                rnTiGia_ct.Value,
                                ddlLoaiTien_ct.SelectedValue,
                                HanThanhToan_ct.SelectedDate,
                                txtNoiDung_ct
                            },
                            SpName = "sp_ChungTuNopTien_Update"
                        };
                        _sql.fNonGetData(_obj);
                        if (_obj.KetQua > 0)
                        {
                            lbLoiNT.Text =
                                "<font color='blue'>Cập nhật thành công chứng từ nộp tiền <b><font color='black'>" +
                                hdSoPhieu_ct + "</font></b>.</font>";
                        }
                        else
                        {
                            lbLoiNT.Text = "<font color='red'>Cập nhật thất bại. Vui lòng thử lại sau.</font>";
                        }

                        #endregion
                    }
                }
                catch
                {
                }
            }

            LoadPhieuNopTien();
        }

        protected void RGGiayNopTien_CancelCommand(object sender, GridCommandEventArgs e)
        {
            LoadPhieuNopTien();
        }

        protected void RGGiayNopTien_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            lbLoiNT.Text = "";

            string soPhieu = RGGiayNopTien.Items[e.Item.ItemIndex]["SoPhieu"].Text;

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietNopTien_Count"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {
                    count = int.Parse(_obj.Dt.Rows[0]["CountPNT"].ToString());

                }
                catch
                {
                }
            }
            else
            {
            }

            _obj = new clsObj
            {
                Parameter = new[] { "@SoPhieu" },
                ValueParameter = new object[] { soPhieu },
                SpName = "sp_ChiTietNopTien_GetKTKiemTra"
            };
            _sql.fGetData(_obj);
            if (_obj.KetQua < 1)
            {
                try
                {

                    xx = clsConvertHelper.Tobool(_obj.Dt.Rows[0]["KiemTra"].ToString());

                }
                catch
                {
                }
            }


            if (xx)
            {
                lbLoiNT.Text = "<font color='red'>Phiếu này đã kiểm tra nên không xóa được.</font>";
                LoadPhieuNopTien();
            }
            else
            {


                if (count == 0)
                {
                    _obj = new clsObj
                    {
                        Parameter = new[] { "@SoPhieu" },
                        ValueParameter = new object[] { soPhieu },
                        SpName = "sp_ChungTuNopTien_Delete"
                    };
                    _sql.fNonGetData(_obj);
                    if (_obj.KetQua > 0)
                    {
                        lbLoiNT.Text = "<font color='blue'>Xoá thành công.</font>";
                    }
                    else
                    {
                        lbLoiNT.Text = "<font color='red'>Xoá thất bại. Vui lòng thử lại sau.</font>";
                    }

                    LoadPhieuNopTien();

                }
                else
                {
                    lbLoiNT.Text = "<font color='Red'>Đã có chi tiết nên không xóa được.</font>";
                    LoadPhieuNopTien();
                }
            }
        }

        #endregion

        protected void DropDownListLoaiHoaDon_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListLoaiHoaDon.SelectedValue == "THONGTHUONG")
            {
                trDuongDanLoaiHoaDon.Visible = false;
                trLoaiHoaDon.Visible = false;
                trDuongDanFileLuuHoaDon.Visible = false;
            }
            else
            {
                trDuongDanLoaiHoaDon.Visible = true;
                trLoaiHoaDon.Visible = true;
                trDuongDanFileLuuHoaDon.Visible = true;
            }

        }

        protected void DropDownListDNTTLoaiHoaDon_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownListDNTTLoaiHoaDon.SelectedValue == "THONGTHUONG")
            {
                trDNTTLoaiHoaDon.Visible = false;
                trDNTTDuongDanLoaiHoaDon.Visible = false;
                trDNTTDuongDanFileLuuHoaDon.Visible = false;
            }
            else
            {
                trDNTTLoaiHoaDon.Visible = true;
                trDNTTDuongDanLoaiHoaDon.Visible = true;
                trDNTTDuongDanFileLuuHoaDon.Visible = true;
            }
        }

        protected void RadAsyncUploadFileHoaDonDienTu_OnFileUploaded(object sender, FileUploadedEventArgs e)
        {
            try
            {
                string targetFolder = @"Host Web\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu";
                string id = DateTime.Now.ToString("_yyyyMMdd_HH_mm_ss");
                string targetFileName = Path.Combine(Server.MapPath("~").Split(':')[0] + @":\\", targetFolder,
                    e.File.GetNameWithoutExtension() + id + e.File.GetExtension());
               
                if (RadAsyncUploadFileHoaDonDienTu.UploadedFiles.Count > 0)
                {
                    e.File.SaveAs(targetFileName);

                    string link = Path.Combine(@"http:\\thaituangarment.com.vn\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu",
                        e.File.GetNameWithoutExtension() + id + e.File.GetExtension());
                    Download.HRef = link;
                    lbLoiTU.Text = "<font color='Blue'>Tải file lên thành công</font>";
                    
                }
                else
                {
                    throw new Exception("Không tìm thấy File tải lên.");
                }
            }
            catch (Exception ex)
            {
                lbLoiTU.Text = "<font color='red'>" + ex.Message+"File không vượt quá 10mb" + ".</font>";
            }
        }

        protected void RadButtonXoaHoaDonDienTu_OnClick(object sender, EventArgs e)
        {
            Download.HRef = string.Empty;
            lbLoiTU.Text = "<font color='Blue'>Xóa thành file lưu thành công</font>";
        }

        protected void RadAsyncUploadDNTTFileHoaDonDienTu_OnFileUploaded(object sender, FileUploadedEventArgs e)
        {
            try
            {
                string targetFolder = @"Host Web\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu";
                string id = DateTime.Now.ToString("_yyyyMMdd_HH_mm_ss");
                string targetFileName = Path.Combine(Server.MapPath("~").Split(':')[0] + @":\\", targetFolder,
                    e.File.GetNameWithoutExtension() + id + e.File.GetExtension());

                if (RadAsyncUploadDNTTFileHoaDonDienTu.UploadedFiles.Count > 0)
                {
                    e.File.SaveAs(targetFileName);

                    string link = Path.Combine(@"http:\\thaituangarment.com.vn\HINHANHCHUONGTRINH\QLNganSach\HoaDonDienTu",
                        e.File.GetNameWithoutExtension() + id + e.File.GetExtension());
                    DNTTDownload.HRef = link;
                    lbLoiDN.Text = "<font color='Blue'>Tải file lên thành công</font>";
                }
                else
                {
                    throw new Exception("Không tìm thấy File tải lên.");
                }
            }
            catch (Exception ex)
            {
                lbLoiDN.Text = "<font color='red'>" + ex.Message + ".</font>";
            }
        }

        protected void RadButtonDNTTXoaFile_OnClick(object sender, EventArgs e)
        {
            DNTTDownload.HRef = string.Empty;
            lbLoiDN.Text = "<font color='Blue'>Xóa thành file lưu thành công</font>";
        }
    }
}

