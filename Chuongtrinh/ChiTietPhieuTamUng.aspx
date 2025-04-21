<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietPhieuTamUng.aspx.cs"
    Inherits="ChiTietPhieuTamUng" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết phiếu tạm ứng::.</title>
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
    <div>
        <script type="text/javascript" defer="defer" language="javascript">
            function onkeyupEvent() {

                rnTiGia = $find("<%= rnTiGia.ClientID %>");

                rdThanhTien = $find("<%= rdThanhTien.ClientID %>");

                rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

                var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");

                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

            }  
        </script>
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
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập chi tiết tạm
                        ứng</legend>
                    <center>
                        <table cellpadding="2" cellspacing="2">
                            <tr>
                                <td align="right">
                                    Phiếu tạm ứng:
                                </td>
                                <td width="10">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="tbPTU" runat="server" ReadOnly="True" Width="160px" Enabled="False"
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
                                    <asp:TextBox ID="tbLoaiTien" runat="server" Enabled="False" Width="155px" Skin="Windows7"></asp:TextBox>
                                </td>
                                <td>
                                    &nbsp;
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
                                    <telerik:RadComboBox ID="cbMaChiPhi" runat="server" Width="165px" DataTextField="MSChiPhi"
                                        Skin="Windows7" AutoPostBack="True" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
                                        EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px" Enabled="true"
                                        OnItemsRequested="cbMaChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <table width="300px">
                                                <tr>
                                                    <td style="width: 100px">
                                                        Mã CP
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbMaChiPhi"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Tỉ giá:
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Enabled="False" ReadOnly="True"
                                        Skin="Windows7" Width="160px">
                                        <NumberFormat ZeroPattern="n"></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Ngân sách còn lại:
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" ReadOnly="True" Width="165px"
                                        Skin="Windows7" Enabled="False" Value="0">
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Tạm ứng:
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rdThanhTien" runat="server" Width="160px" Value="0"
                                        Skin="Windows7" MinValue="0" onkeyup="onkeyupEvent()">
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
                                    <asp:TextBox ID="tbGhiChu" runat="server" Height="25px" Width="420px" Skin="Windows7"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" ReadOnly="True"
                                        Width="160px" Enabled="false" Value="0" Display="false" Skin="Windows7">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="gLuu" OnClick="btLuu_Click" />
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="tbMaDV" runat="server" ReadOnly="True" Width="160px" Enabled="false"
                                        Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="false"
                                        Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Enabled="false" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                        Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                        Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </center>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                        phiếu tạm ứng</legend>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        Skin="Windows7" CellSpacing="0" GridLines="None" AllowPaging="True" AllowSorting="false"
                        ShowStatusBar="True" EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="10">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings AllowKeyboardNavigation="true">
                            <Selecting AllowRowSelect="true" />
                        </ClientSettings>
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
                                <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Id" UniqueName="id_chitiet" DataField="id_chitiet"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="true"
                                    AutoPostBackOnFilter="true" Visible="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TỈ GIÁ" UniqueName="TiGia" DataField="TiGia"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TẠM ỨNG" UniqueName="SoTien" DataField="SoTien"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="CÒN LẠI" UniqueName="SotienTinh" DataField="SotienTinh"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Lydo" DataField="Lydo"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="SỬA" EditText="Sửa">
                                    <ItemStyle />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="XÓA">
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
