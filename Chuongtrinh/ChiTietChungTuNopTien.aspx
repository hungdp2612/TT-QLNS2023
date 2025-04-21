<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietChungTuNopTien.aspx.cs"
    Inherits="ChiTietChungTuNopTien" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết chứng từ nộp tiền::.</title>
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
            rdThanhTien = $find("<%= rdThanhTien.ClientID %>");
            rnTiGia = $find("<%= rnTiGia.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");
            var txtLoaiTien = document.getElementById("txtLoaiTien");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value());


        }
    </script>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Chứng từ nộp tiền" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Phiếu TU ">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <div style="margin-top: 10px">
                </div>
                <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                    Height="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập chi tiết chứng
                                từ nộp tiền</legend>
                            <center>
                                <table cellpadding="2" cellspacing="2">
                                    <tr>
                                        <td align="right">
                                            Số phiếu:
                                        </td>
                                        <td width="10">
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                Skin="Windows7"></asp:TextBox>
                                        </td>
                                        <td width="10">
                                        </td>
                                        <td align="right">
                                            Loại tiền:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtLoaiTien" runat="server" Enabled="False" Width="140px" Skin="Windows7"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Phiếu tạm ứng:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbPhieuTU" runat="server" AutoPostBack="True" DataTextField="PhieuTU"
                                                Skin="Windows7" DataValueField="PhieuTU" HighlightTemplatedItems="true" Enabled="true"
                                                EnableLoadOnDemand="true" DropDownWidth="550px" Height="220px" Width="165px"
                                                OnSelectedIndexChanged="cbPhieuTU_SelectedIndexChanged" OnItemsRequested="cbPhieuTU_ItemsRequested">
                                                <HeaderTemplate>
                                                    <table width="520px">
                                                        <tr>
                                                            <td style="width: 120px">
                                                                Phiếu TU
                                                            </td>
                                                            <td style="width: 100px">
                                                                Tạm ứng
                                                            </td>
                                                            <td style="width: 100px">
                                                                Loại tiền
                                                            </td>
                                                            <td style="width: 100px">
                                                                Thanh toán
                                                            </td>
                                                            <td style="width: 100px">
                                                                Tiền đã nộp
                                                            </td>
                                                            <td style="width: 100px">
                                                                Tiền còn lại
                                                                <br />
                                                                phải nộp
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table width="520px">
                                                        <tr>
                                                            <td style="width: 120px">
                                                                <%# Eval("PhieuTU")%>
                                                            </td>
                                                            <td style="width: 100px">
                                                                <%# Eval("TienTU")%>
                                                            </td>
                                                            <td style="width: 100px">
                                                                <%# Eval("LoaiTien")%>
                                                            </td>
                                                            <td style="width: 100px">
                                                                <%# Eval("TienTT")%>
                                                            </td>
                                                            <td style="width: 100px">
                                                                <%# Eval("TIENNOP")%>
                                                            </td>
                                                            <td style="width: 100px">
                                                                <%# Eval("TIENCONLAI")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbPhieuTU"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Số tiền còn lại:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" AutoPostBack="false"
                                                Skin="Windows7" ReadOnly="True" Width="145px" Enabled="false">
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Mã chi phí:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="MSChiPhi"
                                                Skin="Windows7" DataValueField="MSChiPhi" Enabled="true" HighlightTemplatedItems="true"
                                                DropDownWidth="350px" Height="170px" Width="165px" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged1">
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cbMaChiPhi"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Số tiền nộp:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rdThanhTien" runat="server" AutoPostBack="false" Width="145px"
                                                Skin="Windows7" Value="0" onkeyup="onkeyupEvent()">
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Ghi chú:
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left" colspan="5">
                                            <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="99%" Skin="Windows7"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="7">
                                            <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" AutoPostBack="True"
                                                ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                                                <NumberFormat ZeroPattern="n"></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="7">
                                            <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                                ValidationGroup="gLuu" OnClick="btLuu_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Enabled="False" ReadOnly="True"
                                                Width="160px" Display="false">
                                                <NumberFormat ZeroPattern="n"></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtMaDV" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Enabled="False" Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtLoaiTienPhieuTU" runat="server" ReadOnly="True" Width="160px"
                                                Enabled="False" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                                chứng từ nộp tiền</legend>
                            <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                                Skin="Windows7" CellSpacing="0" GridLines="None" AllowFilteringByColumn="false"
                                AllowPaging="true" AllowSorting="false" ShowStatusBar="True" EnableLinqExpressions="false"
                                OnCancelCommand="RG_CancelCommand" OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging"
                                OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                                OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="10">
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
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ PHIẾU" UniqueName="SoPhieu" DataField="SoPhieu"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="LẦN THỨ" UniqueName="Lanthu" DataField="Lanthu"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="TienThanhToan" DataField="TienThanhToan"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="THÀNH TIỀN (VND)" UniqueName="TongTien" DataField="TongTien"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                            Visible="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN CÒN LẠI" UniqueName="TienConLai" DataField="TienConLai"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                            HeaderText="SỬA" EditText="SỬA">
                                            <ItemStyle />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                            ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                        <EditColumn UniqueName="EditCommandColumn1">
                                        </EditColumn>
                                    </EditFormSettings>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <div style="float: left">
                            <telerik:RadGrid ID="rgPhieuTUDaTT" runat="server" AutoGenerateColumns="False" GridLines="None"
                                Skin="Windows7" AllowPaging="True" AllowSorting="false" Width="100%" PageSize="10"
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
                                        <telerik:GridTemplateColumn DataField="TienTU" HeaderText="TIỀN TU" UniqueName="TienTU"
                                            SortExpression="TienTU">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemTemplate>
                                                <%# String.Format("{0:0,0}", Eval("TienTU"))%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN ĐÃ TT" UniqueName="TienTT" DataField="TienTT"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN NỘP" UniqueName="TienNop" DataField="TienNop"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TIỀN CÒN LẠI" UniqueName="TienConLai" DataField="TienConLai"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="KetThucThanhToan" HeaderText="KẾT THÚC TT"
                                            UniqueName="KetThucThanhToan" AllowFiltering="false" AutoPostBackOnFilter="true"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThucTT" runat="server" AutoPostBack="true" OnCheckedChanged="cbketThucTT_CheckedChanged"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("KetThucThanhToan")) %>' Enabled="true" />
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
