<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanTamUng1.aspx.cs"
    Inherits="ChiTietThanhToanTamUng1" %>

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


            rnNganSachConLaiAn2 = $find("<%= rnNganSachConLaiAn2.ClientID %>");


            var loaiTienTU = document.getElementById("txtLoaiTienTU");
            var loaiTienTT = document.getElementById("txtLoaiTien");

            var InputNganSachConLai2 = $find("<%= rnNganSachConLaiTrongThang.ClientID %>");

            if (loaiTienTT.value == loaiTienTU.value) {
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value());

                if (InputNganSachConLai.get_value() < 0) {
                    InputNganSachConLai2.set_value(rnNganSachConLaiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
                }
                else {
                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());

                }
            }
            else {

                //Loại tiền tạm ứng và loại tiền thanh toán khác nhau. nên không thanh toán được
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

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

            var InputNganSachConLai2 = $find("<%= rnNganSachConLaiTrongThang.ClientID %>");


            var loaiTienTU = document.getElementById("txtLoaiTienTU");
            var loaiTienTT = document.getElementById("txtLoaiTien");

            if (loaiTienTT.value == loaiTienTU.value) {
                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value());

                if (InputNganSachConLai.get_value() < 0) {
                  
                    InputNganSachConLai2.set_value(rnNganSachConLaiAn.get_value() * rnTiGia.get_value() + rnNganSachConLaiAn2.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

                }
                else {


                    InputNganSachConLai2.set_value(rnNganSachConLaiAn2.get_value());
                }
            }
            else {

                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
            }


            



        }
    </script>
    <div>
        <asp:Label ID="itemsClientSide" runat="server" BorderStyle="None" CssClass="text"
            Visible="false"></asp:Label>
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
                        AllowPaging="True" AllowSorting="false" OnItemCommand="rgChiTietTU_ItemCommand"
                        OnPageIndexChanged="rgChiTietTU_PageIndexChanged" OnPageSizeChanged="rgChiTietTU_PageSizeChanged"
                        Width="100%" PageSize="5">
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
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="Phiếu TU" UniqueName="PhieuTU">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="Loại tiền" UniqueName="LoaiTien">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <%--   
                                <telerik:GridTemplateColumn DataField="TienTU" HeaderText="Tiền TU" UniqueName="TienTU"
                                    SortExpression="TienTU">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# String.Format("{0:0,0}", Eval("TienTU"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                <telerik:GridBoundColumn HeaderText="Tiền Tạm ứng" UniqueName="TienTU" DataField="TienTU"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tiền thanh toán" UniqueName="TienTT" DataField="TienTT"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tiền nộp" UniqueName="TienNop" DataField="TienNop"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tiền Còn lại" UniqueName="TienConLai" DataField="TienConLai"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Chọn phiếu TU" UniqueName="TemplateColumn"
                                    Groupable="False">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btChon" runat="server" CommandName="chon" ImageUrl="~/images/Nutchuanweb/btChon.png" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="KetThucThanhToan" HeaderText="Kết thúc TT"
                                    UniqueName="KetThucThanhToan" AllowFiltering="false" AutoPostBackOnFilter="true"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThucTT" runat="server" AutoPostBack="true" OnCheckedChanged="cbketThucTT_CheckedChanged"
                                            Checked='<%# clsConvertHelper.Tobool(Eval("KetThucThanhToan")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="KetThucNopTien" HeaderText="Kết thúc nộp tiền"
                                    UniqueName="KetThucNopTien" AllowFiltering="false" AutoPostBackOnFilter="true"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThucNT" runat="server" AutoPostBack="true" OnCheckedChanged="KetThucNopTien_CheckedChanged"
                                            Checked='<%# clsConvertHelper.Tobool(Eval("KetThucNopTien")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <GroupingSettings GroupContinuedFormatString="" GroupContinuesFormatString="" GroupSplitDisplayFormat="" />
                        <ClientSettings AllowDragToGroup="True">
                        </ClientSettings>
                    </telerik:RadGrid>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Nhập thông tin
                        chi tiết</legend>
                    <table>
                        <tr>
                            <td align="right">
                                Số phiếu:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="160px" Enabled="False"></asp:TextBox>
                            </td>
                            <td align="right">
                                Phiếu TU:
                            </td>
                            <td>
                                <asp:TextBox ID="txtPhieuTU" runat="server" Width="155px" Enabled="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhieuTU"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Số hóa đơn:
                            </td>
                            <td>
                                <asp:TextBox ID="txtSoHoaDon" runat="server" Width="160px" Enabled="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Mã chi phí:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="MSChiPhi"
                                    DataValueField="MSChiPhi" DropDownWidth="320px" Height="170px" Width="165px"
                                    HighlightTemplatedItems="true" EnableLoadOnDemand="true" OnItemsRequested="cbMaChiPhi_ItemsRequested"
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
                                Ngân sách còn lại:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNganSachConLaiTrongThang" runat="server" ReadOnly="True"
                                    Width="160px" Enabled="False" Value="0">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td align="right">
                                Tạm ứng còn lại:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnThanhToanTamUngConLai" runat="server" AutoPostBack="false"
                                    ReadOnly="True" Width="165px" Enabled="False">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Số lượng:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnSoLuong" runat="server" Width="165px" Enabled="true"
                                    Value="0" onkeyup="onkeyUpEvent2()">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td align="right">
                                Đơn giá:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnDonGia" runat="server" Width="160px" Enabled="true"
                                    Value="0" onkeyup="onkeyUpEvent2()">
                                </telerik:RadNumericTextBox>
                            </td>
                            <td align="right">
                                Số tiền thanh toán:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rdSoTienThanhToan" runat="server" AutoPostBack="false"
                                    Width="165px" onkeyup="onkeyupEvent()">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Tên và qui cách:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtQuiCach" runat="server" Enabled="true" Width="160px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuiCach"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Đơn vị tính:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDVT" runat="server" Enabled="true" Width="155px"></asp:TextBox>
                            </td>
                            <td align="right">
                                VAT:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnVAT" runat="server" Width="165px" Enabled="true"
                                    Value="0">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Loại tiền:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtLoaiTien" runat="server" Enabled="False" Width="160px"></asp:TextBox>
                            </td>
                            <td align="right">
                                Tỉ giá:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Enabled="False" ReadOnly="True"
                                    Width="160px">
                                    <NumberFormat ZeroPattern="n"></NumberFormat>
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Ghi chú:
                            </td>
                            <td align="left" colspan="5">
                                <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="99%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="6">
                                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" AutoPostBack="True"
                                    ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                    <NumberFormat ZeroPattern="n"></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn2" runat="server" AutoPostBack="true"
                                    ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                </telerik:RadNumericTextBox>
                                <telerik:RadNumericTextBox ID="rnTongTamUngAn" runat="server" AutoPostBack="True"
                                    ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                </telerik:RadNumericTextBox>
                              <%--  <asp:TextBox ID="txtLoaiTienTU" runat="server" Enabled="False"  Visible="false"></asp:TextBox>--%>
                                   <telerik:RadTextBox ID="txtLoaiTienTU" runat="server" Display="false"></telerik:RadTextBox>
                                
                                
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
                                <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                    Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                    Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">3. Thông tin chi
                        tiết thanh toán tạm ứng</legend>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        GridLines="None" AllowPaging="True" AllowSorting="false" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="8"
                        AllowAutomaticUpdates="True">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <%-- <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>--%>
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
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" Visible="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Phiếu tạm ứng" UniqueName="PhieuTU" DataField="PhieuTU"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tên - Qui cách" UniqueName="TenvaQuiCach" DataField="TenvaQuiCach"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Số hóa đơn" UniqueName="SoHoaDon" DataField="SoHoaDon"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Số lượng" UniqueName="SoLuong" DataField="SoLuong"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Đơn giá" UniqueName="DonGia" DataField="DonGia"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn HeaderText="Tiền thanh toán" UniqueName="TienThanhToan"
                                    DataField="TienThanhToan" FilterControlWidth="70px" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tiền còn lại" UniqueName="TienConLai" DataField="TienConLai"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="Sửa" EditText="Sửa">
                                    <ItemStyle />
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                            <%--   <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>--%>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <%-- <div style="float: left">
                    <table>
                        <tr>
                            <td align="left">
                                <u>Để thanh toán:</u>
                            </td>
                        </tr>                        
                        <tr>
                            <td align="left">
                                _ Cột [Kết thúc thanh toán] phải <b>bỏ tick</b>.
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                _ Cột [Kết thúc nộp tiền] phải <b>bỏ tick</b>.
                            </td>
                        </tr>
                    </table>
                </div>--%>
                <div style="float: left">
                    <telerik:RadGrid ID="rgPhieuTUDaTT" runat="server" AutoGenerateColumns="False" GridLines="None"
                        AllowPaging="True" AllowSorting="false" Width="100%" PageSize="10" OnPageIndexChanged="rgPhieuTUDaTT_PageIndexChanged"
                        OnPageSizeChanged="rgPhieuTUDaTT_PageSizeChanged">
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
                                <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="Phiếu TU" UniqueName="PhieuTU">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                </telerik:GridBoundColumn>
                                  <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="Loại tiền" UniqueName="LoaiTien">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="100px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="100px"/>
                                </telerik:GridBoundColumn>
                           <%--     <telerik:GridTemplateColumn DataField="TienTU" HeaderText="Tiền TU" UniqueName="TienTU"
                                    SortExpression="TienTU">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemTemplate>
                                        <%# String.Format("{0:0,0}", Eval("TienTU"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                 <telerik:GridBoundColumn HeaderText="Tiền TU" UniqueName="TienTU" DataField="TienTU"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                </telerik:GridBoundColumn>


                                 <telerik:GridBoundColumn HeaderText="Tiền đã TT" UniqueName="TienTT" DataField="TienTT"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                </telerik:GridBoundColumn>

                              <%--  <telerik:GridTemplateColumn DataField="ThucHien" HeaderText="Tiền đã TT" UniqueName="TienTT"
                                    SortExpression="TienTT">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemTemplate>
                                        <%# String.Format("{0:0,0}", Eval("TienTT"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                     <%--           <telerik:GridTemplateColumn DataField="TienNop" HeaderText="Tiền nộp" UniqueName="TienNop"
                                    SortExpression="TienNop">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemTemplate>
                                        <%# String.Format("{0:0,0}", Eval("TienNop"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
                                 <telerik:GridBoundColumn HeaderText="Tiền nộp" UniqueName="TienNop" DataField="TienNop"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                </telerik:GridBoundColumn>

                                  <telerik:GridBoundColumn HeaderText="Tiền còn lại" UniqueName="TienConLai" DataField="TienConLai"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                </telerik:GridBoundColumn>                              
                                <telerik:GridTemplateColumn DataField="KetThucThanhToan" HeaderText="Kết thúc TT"
                                    UniqueName="KetThucThanhToan" AllowFiltering="false" AutoPostBackOnFilter="true"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThucTT" runat="server" AutoPostBack="true" OnCheckedChanged="cbketThucTT_CheckedChanged"
                                            Checked='<%# clsConvertHelper.Tobool(Eval("KetThucThanhToan")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="KetThucNopTien" HeaderText="Kết thúc nộp tiền"
                                    UniqueName="KetThucNopTien" AllowFiltering="false" AutoPostBackOnFilter="true"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThucNT" runat="server" AutoPostBack="true" OnCheckedChanged="KetThucNopTien_CheckedChanged"
                                            Checked='<%# clsConvertHelper.Tobool(Eval("KetThucNopTien")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
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
    </div>
    </form>
</body>
</html>
