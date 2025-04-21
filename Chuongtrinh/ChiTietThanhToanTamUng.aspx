<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanTamUng.aspx.cs"
    Inherits="ChiTietThanhToanTamUng" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết phiếu thanh toán tạm ứng::.</title>
    <style type="text/css">
        .bgtieudebox
        {
            background-image: url("../image/bg_title.png");
            background-repeat: repeat-x;
            height: 40px;
            font-size: 14pt;
            color: White;
            font-weight: bold;
        }
        .RLPhieuTU
        {
            margin: 0 auto !important;
        }
    </style>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement && window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CheckWnd() {
            var wnd = GetRadWindow();
            if (wnd) {

            }
            else {
                window.location = "../Loi.aspx?Strloi=Truy cập không hợp lệ ...";
            }
        }
        CheckWnd();
    </script>
    <script src="../js/Common.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {
            rdThanhTien = $find("<%= rdSoTienThanhToan.ClientID %>");
            rnTiGia = $find("<%= rnTiGia.ClientID %>");
            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnThanhToanTamUngConLai.ClientID %>");

            var InputThanhToanConLai_ByMaChiPhi = $find("<%= rnTamUngConLaiCuaMaChiPhi.ClientID %>");
            rnTamUngConLai_ByMaChiPhiAn = $find("<%= rnTamUngConLai_ByMaChiPhiAn.ClientID %>");

            rnNganSachConLaiAn2 = $find("<%= rnNganSachConLaiAn2.ClientID %>");


            var loaiTienTU = document.getElementById("txtLoaiTienTU");
            var loaiTienTT = document.getElementById("txtLoaiTien");

            var InputNganSachConLai2 = $find("<%= rnNganSachConLaiTrongThang.ClientID %>");




            if (loaiTienTT.value == loaiTienTU.value) {
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value());
                InputThanhToanConLai_ByMaChiPhi.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() - rdThanhTien.get_value());


                //                if (InputNganSachConLai.get_value() < 0) {
                //                    InputNganSachConLai2.set_value(rnNganSachConLaiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
                //                }
                //                else {
                //                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());
                //                }

                if (InputThanhToanConLai_ByMaChiPhi.get_value() < 0) {
                    InputNganSachConLai2.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
                }
                else {
                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());

                }

            }
            else {

                //Loại tiền tạm ứng và loại tiền thanh toán khác nhau. nên không thanh toán được
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

                InputThanhToanConLai_ByMaChiPhi.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

            }

            //            if (InputNganSachConLai.get_value() < 0) {
            //                InputNganSachConLai2.set_value(rnNganSachConLaiAn.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

            //            }
            //            else {


            //                InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());
            //            }

            var rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            var rnDonGia = $find("<%= rnDonGia.ClientID %>");
            rnSoLuong.set_value(0);
            rnDonGia.set_value(0);

        }

        function onkeyUpEvent2() {

            rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            rnDonGia = $find("<%= rnDonGia.ClientID %>");
            var rdSoTienThanhToan = $find("<%= rdSoTienThanhToan.ClientID %>");
            rdSoTienThanhToan.set_value(rnSoLuong.get_value() * rnDonGia.get_value());

            rdThanhTien = $find("<%= rdSoTienThanhToan.ClientID %>");
            rnTiGia = $find("<%= rnTiGia.ClientID %>");
            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnThanhToanTamUngConLai.ClientID %>");

            //InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
            rnNganSachConLaiAn2 = $find("<%= rnNganSachConLaiAn2.ClientID %>");


            var InputThanhToanConLai_ByMaChiPhi = $find("<%= rnTamUngConLaiCuaMaChiPhi.ClientID %>");
            rnTamUngConLai_ByMaChiPhiAn = $find("<%= rnTamUngConLai_ByMaChiPhiAn.ClientID %>");



            var InputNganSachConLai2 = $find("<%= rnNganSachConLaiTrongThang.ClientID %>");


            var loaiTienTU = document.getElementById("txtLoaiTienTU");
            var loaiTienTT = document.getElementById("txtLoaiTien");

            if (loaiTienTT.value == loaiTienTU.value) {
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value());
                InputThanhToanConLai_ByMaChiPhi.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() - rdThanhTien.get_value());
                //                if (InputNganSachConLai.get_value() < 0) {

                //                    InputNganSachConLai2.set_value(rnNganSachConLaiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

                //                }
                //                else {


                //                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());
                //                }
                if (InputThanhToanConLai_ByMaChiPhi.get_value() < 0) {
                    InputNganSachConLai2.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
                }
                else {
                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());

                }
            }
            else {

                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
                InputThanhToanConLai_ByMaChiPhi.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
            }






        }
    </script>
    <div>
        <%--<asp:Label ID="itemsClientSide" runat="server" BorderStyle="None" CssClass="text"
            Visible="false"></asp:Label>--%>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Phiếu TU cần thanh toán" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Phiếu TU đã kết thúc thanh toán và kết thúc nộp tiền">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <div style="margin-top: 10px">
                </div>
                <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                    Height="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">1. Chọn phiếu tạm
                                ứng</legend>
                            <telerik:RadGrid ID="rgChiTietTU" runat="server" AutoGenerateColumns="False" GridLines="None"
                                Skin="Windows7" AllowPaging="true" AllowSorting="false" OnItemCommand="rgChiTietTU_ItemCommand"
                                OnPageIndexChanged="rgChiTietTU_PageIndexChanged" OnPageSizeChanged="rgChiTietTU_PageSizeChanged"
                                Width="100%" Height="230px" PageSize="20">
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="false" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="PhieuTU">
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="STT">
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="PHIẾU TU" UniqueName="PhieuTU">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN TU" UniqueName="TienTU" DataField="TienTU"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN THANH TOÁN" UniqueName="TienTT" DataField="TienTT"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN NỘP" UniqueName="TienNop" DataField="TienNop"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN CÒN LẠI" UniqueName="TienConLai" DataField="TienConLai"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="CHỌN PHIẾU TU" UniqueName="TemplateColumn"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btChon" runat="server" CommandName="chon" ImageUrl="~/images/Nutchuanweb/btChon.png" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="KetThucThanhToan" HeaderText="KẾT THÚC TT"
                                            UniqueName="KetThucThanhToan" AllowFiltering="false" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThucTT" runat="server" AutoPostBack="true" OnCheckedChanged="cbketThucTT_CheckedChanged"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("KetThucThanhToan")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="KetThucNopTien" HeaderText="KẾT THÚC NỘP TIỀN"
                                            UniqueName="KetThucNopTien" AllowFiltering="false" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThucNT" runat="server" AutoPostBack="true" OnCheckedChanged="KetThucNopTien_CheckedChanged"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("KetThucNopTien")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="130px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="130px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Nhập thông tin
                                chi tiết</legend>
                            <table>
                                <tr>
                                    <td align="right">
                                        Phiếu TU:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhieuTU" runat="server" Width="160px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhieuTU"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Tổng TU còn lại:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnThanhToanTamUngConLai" runat="server" AutoPostBack="false"
                                            Skin="Windows7" ReadOnly="True" Width="160px" Enabled="False">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Tháng/năm NS:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtThangNamNS" runat="server" Enabled="False" Width="160px" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Mã chi phí:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="MSChiPhi"
                                            DataValueField="MSChiPhi" DropDownWidth="320px" Height="170px" Width="165px"
                                            Skin="Windows7" HighlightTemplatedItems="true" EnableLoadOnDemand="true" OnItemsRequested="cbMaChiPhi_ItemsRequested"
                                            OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged">
                                            <HeaderTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Mã chi phí
                                                        </td>
                                                        <td style="width: 200px">
                                                            Diễn giải
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            <%# Eval("MSChiphi")%>
                                                        </td>
                                                        <td style="width: 200px">
                                                            <%# Eval("DienGiai")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cbMaChiPhi"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        NS còn lại:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNganSachConLaiTrongThang" runat="server" ReadOnly="True"
                                            Skin="Windows7" Width="160px" Enabled="False" Value="0">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Tạm ứng còn lại:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnTamUngConLaiCuaMaChiPhi" runat="server" AutoPostBack="false"
                                            Skin="Windows7" ReadOnly="True" Width="165px" Enabled="False">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Số lượng:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnSoLuong" runat="server" Width="165px" Enabled="true"
                                            Skin="Windows7" Value="0"  AutoPostBack="true" OnTextChanged="rdThanhTien_TextChanged" ><%--onkeyup="onkeyUpEvent2()"--%> <%--11/10/2019--%>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Đơn giá:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnDonGia" runat="server" Width="160px" Enabled="true"
                                            Skin="Windows7" Value="0"  AutoPostBack="true" OnTextChanged="rdThanhTien_TextChanged" > <%--onkeyup="onkeyUpEvent2()"--%> <%--11/10/2019--%>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Số tiền thanh toán:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rdSoTienThanhToan" runat="server" AutoPostBack="false"
                                            Skin="Windows7" Width="165px" ><%--onkeyup="onkeyupEvent()"--%> <%--11/10/2019--%>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Tên - qui cách:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtQuiCach" runat="server" Enabled="true" Width="160px" Skin="Windows7"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuiCach"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Đơn vị tính:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtDVT" runat="server" Enabled="true" Width="155px" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        VAT:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnVAT" runat="server" Width="165px" Enabled="true"
                                            Skin="Windows7" Value="0">
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Loại tiền:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtLoaiTien" runat="server" Enabled="False" Width="160px" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Tỉ giá:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Enabled="False" ReadOnly="True"
                                            Skin="Windows7" Width="160px">
                                            <NumberFormat ZeroPattern="n"></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Số hóa đơn:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSoHoaDon" runat="server" Width="160px" Enabled="true" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Ghi chú:
                                    </td>
                                    <td align="left" colspan="5">
                                        <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="99%" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="6">
                                        <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" AutoPostBack="false"
                                            ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                            <NumberFormat ZeroPattern="n"></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <telerik:RadNumericTextBox ID="rnNganSachConLaiAn2" runat="server" AutoPostBack="false"
                                            ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                        </telerik:RadNumericTextBox>
                                        <telerik:RadNumericTextBox ID="rnTongTamUngAn" runat="server" AutoPostBack="false"
                                            ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                        </telerik:RadNumericTextBox>
                                        <%--  <asp:TextBox ID="txtLoaiTienTU" runat="server" Enabled="False"  Visible="false"></asp:TextBox>--%>
                                        <telerik:RadTextBox ID="txtLoaiTienTU" runat="server" Display="false">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadNumericTextBox ID="rnTamUngConLai_ByMaChiPhiAn" runat="server" AutoPostBack="false"
                                            ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                            <NumberFormat ZeroPattern="n"></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="gLuu" OnClick="btLuu_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="6">
                                        <asp:Label ID="lbThongBao" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaDV" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                            Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                            Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtPhuTrachDonVi" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                            Visible="false"></asp:TextBox>
                                        <%--  <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                    Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                    Visible="false"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="160px" Visible="false"
                                            Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">3. Thông tin chi
                                tiết thanh toán tạm ứng</legend>
                            <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                                Skin="Windows7" GridLines="None" AllowPaging="true" AllowSorting="false" OnCancelCommand="RG_CancelCommand"
                                OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                                OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                                OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="10"
                                AllowAutomaticUpdates="True">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <HeaderContextMenu EnableTheming="True">
                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                </HeaderContextMenu>
                                <GroupingSettings CaseSensitive="False" />
                                <MasterTableView>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="ID" UniqueName="CTTT_ID" DataField="CTTT_ID"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="true"
                                            AutoPostBackOnFilter="true" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ PHIẾU" UniqueName="SoPhieu" DataField="SoPhieu"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="true"
                                            AutoPostBackOnFilter="true" Visible="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TÊN - QUI CÁCH" UniqueName="TenvaQuiCach" DataField="TenvaQuiCach"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ HÓA ĐƠN" UniqueName="SoHoaDon" DataField="SoHoaDon"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ LƯỢNG" UniqueName="SoLuong" DataField="SoLuong"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="ĐƠN GIÁ" UniqueName="DonGia" DataField="DonGia"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN TT" UniqueName="TienThanhToan" DataField="TienThanhToan"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN CÒN LẠI" UniqueName="TienConLai" DataField="TienConLai"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                            HeaderText="SỬA" EditText="SỬA">
                                            <ItemStyle />
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                            ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                        <EditColumn UniqueName="EditCommandColumn1">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <div style="float: left">
                            <telerik:RadGrid ID="rgPhieuTUDaTT" runat="server" AutoGenerateColumns="False" GridLines="None"
                                Skin="Windows7" AllowPaging="True" AllowSorting="false" Width="100%" PageSize="20"
                                OnPageIndexChanged="rgPhieuTUDaTT_PageIndexChanged" OnPageSizeChanged="rgPhieuTUDaTT_PageSizeChanged">
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView DataKeyNames="PhieuTU">
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="STT">
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="PHIẾU TU" UniqueName="PhieuTU">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN TU" UniqueName="TienTU" DataField="TienTU"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN ĐÃ TT" UniqueName="TienTT" DataField="TienTT"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN NỘP" UniqueName="TienNop" DataField="TienNop"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN CÒN LẠI" UniqueName="TienConLai" DataField="TienConLai"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="KetThucThanhToan" HeaderText="KẾT THÚC TT"
                                            UniqueName="KetThucThanhToan" AllowFiltering="false" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThucTT" runat="server" AutoPostBack="true" OnCheckedChanged="cbketThucTT_CheckedChanged"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("KetThucThanhToan")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="KetThucNopTien" HeaderText="KẾT THÚC NỘP TIỀN"
                                            UniqueName="KetThucNopTien" AllowFiltering="false" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThucNT" runat="server" AutoPostBack="true" OnCheckedChanged="KetThucNopTien_CheckedChanged"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("KetThucNopTien")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="130px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="130px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <GroupingSettings GroupContinuedFormatString="" GroupContinuesFormatString="" GroupSplitDisplayFormat="" />
                                <ClientSettings AllowDragToGroup="True">
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
