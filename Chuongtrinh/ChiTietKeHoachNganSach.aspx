<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSach.aspx.cs"
    Inherits="ChiTietKeHoachNganSach" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết kế hoạch ngân sách</title>
    <script src="../js/Common.js" type="text/javascript"></script>
    <script type="text/javascript">
        function stopRKey(evt) {
            var evt = (evt) ? evt : ((event) ? event : null);
            var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
            if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
        }

        document.onkeypress = stopRKey;

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
                window.location = "../TruyCapTraiPhep.aspx";
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


            function SelectAll(CheckBox) {
                var TargetBaseControl = document.getElementById('<%= this.RG_ThangTruoc.ClientID %>');
                var TargetChildControl = "chkSelect";
                var Inputs = TargetBaseControl.getElementsByTagName("input");
                for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                    if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                        Inputs[iCount].checked = CheckBox.checked;
                }
            }
        </script>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                        <Tabs>
                            <telerik:RadTab runat="server" Text="Nhập chi tiết" Selected="True">
                            </telerik:RadTab>
                            <telerik:RadTab runat="server" Text="Chọn kế thừa">
                            </telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>
                    <div style="margin-top: 10px">
                    </div>
                    <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                        Height="100%">
                        <telerik:RadPageView ID="RadPageView1" runat="server">
                            <fieldset>
                                <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập thông tin
                                chi tiết kế hoạch ngân sách</legend>
                                <center>
                                    <table>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td align="right">Khóa NS:
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="left">
                                                            <telerik:RadTextBox ID="txtKHCP_ID" runat="server" Width="150px" Enabled="false"
                                                                Skin="Windows7">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="right">MS chi phí:
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="left">
                                                            <telerik:RadComboBox ID="cbMaSoChiPhi" runat="server" Width="150px" DataTextField="MSCHIPHI"
                                                                Skin="Windows7" DataValueField="MSCHIPHI" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                                                Height='150px' DropDownWidth="350px" Enabled="true" OnItemsRequested="cbMaSoChiPhi_ItemsRequested"
                                                                OnSelectedIndexChanged="cbMaSoChiPhi_SelectedIndexChanged" AutoPostBack="true">
                                                                <HeaderTemplate>
                                                                    <table>
                                                                        <tr>
                                                                            <td width="150px">Mã CP
                                                                            </td>
                                                                            <td width="190px">Tên CP
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <table>
                                                                        <tr>
                                                                            <td width="150px">
                                                                                <%#Eval("MSChiPhi")%>
                                                                            </td>
                                                                            <td width="190px">
                                                                                <%#Eval("DienGiai")%>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMSCHIPHI" runat="server" ControlToValidate="cbMaSoChiPhi"
                                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                                        </td>
                                                        <td width="5px"></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">Ghi chú:
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="left">
                                                            <telerik:RadTextBox ID="txtGhichu" runat="server" Width="150px" Skin="Windows7">
                                                            </telerik:RadTextBox>
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="right">Chi phí:
                                                        </td>
                                                        <td width="5px"></td>
                                                        <td align="left">
                                                            <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" MinValue="0" Value="0" Width="150px"
                                                                Skin="Windows7">
                                                                <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                                            </telerik:RadNumericTextBox>
                                                        </td>
                                                        <td width="5px"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <telerik:RadButton ID="btnChuyenNSdu" runat="server" Text="Chuyển NS dư" Font-Bold="true" Visible="false" OnClick="btnChuyenNSdu_Click">
                                                </telerik:RadButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadTextBox ID="txtMaDV" runat="server" Visible="false">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                                    Visible="false"></asp:TextBox>
                                                <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Width="160px" Enabled="false"
                                                    Visible="false"></asp:TextBox>
                                                <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Enabled="true" Visible="false"></asp:TextBox>
                                                <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Enabled="true" Visible="false"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </center>
                            </fieldset>
                            <fieldset>
                                <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                                chi phí kế hoạch</legend>
                                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                                    CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" Skin="Windows7"
                                    AllowSorting="True" ShowStatusBar="True" EnableLinqExpressions="False" OnCancelCommand="RG_CancelCommand"
                                    OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                                    OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand">
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu EnableTheming="True">
                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                    </HeaderContextMenu>
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="true" />
                                        <Selecting AllowRowSelect="false" />
                                    </ClientSettings>
                                    <MasterTableView CommandItemDisplay="None">
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemTemplate>
                                                    <%# Container.DataSetIndex  + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="Khóa CT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" Visible="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="50px"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ĐV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="MaNV" DataField="MaNV" FilterControlWidth="50px"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Ghichu" HeaderText="GHI CHÚ" ReadOnly="True"
                                                UniqueName="Ghichu" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="60px"
                                                Visible="true" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn3 column"
                                                HeaderText="SỬA" UniqueName="EditCommandColumn" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/images/edit.png"
                                                        CommandName="Edit" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="SỬA" HeaderText="SỬA"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridEditCommandColumn>--%>
                                            <%-- <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridButtonColumn>--%>
                                            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" HeaderText="Xóa"
                                                AllowFiltering="false" UniqueName="Delete">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnDelete" OnClientClick="return fConfirm('Bạn chắc muốn xóa?')"
                                                        ImageUrl="~/images/xoa.gif" CommandName="Delete" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="35px" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                                            <EditColumn UniqueName="EditCommandColumn1">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                        </telerik:RadPageView>
                        <telerik:RadPageView ID="RadPageView2" runat="server">
                            <asp:TextBox ID="txtMaBPKeThua" runat="server" ReadOnly="True" Enabled="False" Visible="false"></asp:TextBox>
                            <div style="float: left; width: 100%">
                                <div style="float: left; width: 45%">
                                    <fieldset>
                                        <legend style="font-size: 9pt; font-family: Tahoma; color: #982849; text-align: left">1. Ngân sách tháng trước</legend>
                                        <center>
                                            <table width="100%">
                                                <tr>
                                                    <td align="right">Tháng:
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="left">
                                                        <telerik:RadNumericTextBox ID="rnThangCu" runat="server" Width="70px" AutoPostBack="True"
                                                            Skin="Windows7" AllowOutOfRangeAutoCorrect="False" MaxValue="12" MinValue="1"
                                                            OnTextChanged="rnThangCu_TextChanged">
                                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rnThangCu"
                                                            Display="Dynamic" ErrorMessage="Nhập tháng ngân sách trước." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="right">Năm:
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="left">
                                                        <telerik:RadNumericTextBox ID="rnNamCu" runat="server" Enabled="true" Width="70px"
                                                            Skin="Windows7" AutoPostBack="True" OnTextChanged="rnNamCu_TextChanged">
                                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="rnNamCu"
                                                            Display="Dynamic" ErrorMessage="Nhập năm ngân sách trước." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </center>
                                        <telerik:RadGrid ID="RG_ThangTruoc" Height="370px" runat="server" AllowAutomaticDeletes="True"
                                            Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True"
                                            CellSpacing="0" GridLines="None" AllowFilteringByColumn="false">
                                            <GroupingSettings CaseSensitive="False" />
                                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                                <Selecting AllowRowSelect="True" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowGroupFooter="true"
                                                TableLayout="Fixed">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                        Groupable="False">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                        <ItemTemplate>
                                                            <%# Container.DataSetIndex  + 1%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                                        HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        FilterControlWidth="60px" Visible="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                                        HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                                        ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                                        AllowFiltering="false" Aggregate="Sum">
                                                        <FooterStyle ForeColor="Blue" />
                                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="Sotien" HeaderText="NS LẬP" UniqueName="Sotien"
                                                        AllowFiltering="false" ShowFilterIcon="false">
                                                        <ItemTemplate>
                                                            <telerik:RadNumericTextBox ID="rnNSLAP" Width="80px" runat="server" Value='<%#fInt(Eval("Sotien")) %>'
                                                                Culture="Vietnamese (Vietnam)" AutoPostBack="false">
                                                                <NumberFormat DecimalDigits="0" />
                                                            </telerik:RadNumericTextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="Ghichu" HeaderText="GHI CHÚ" ReadOnly="True"
                                                        UniqueName="Ghichu" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="60px"
                                                        Visible="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn UniqueName="All" ReadOnly="True" AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" onclick="SelectAll(this);" />
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </telerik:GridTemplateColumn>
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
                                            <FooterStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </fieldset>
                                </div>
                                <div style="float: left; margin-top: 150px;">
                                    <asp:ImageButton ID="btLay" runat="server" ImageUrl="~/images/Nutchuanweb/lay.jpg"
                                        ValidationGroup="gLay" OnClick="btLay_Click" />
                                </div>
                                <div style="float: left; width: 45%;">
                                    <fieldset>
                                        <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Ngân sách tháng
                                        cần lập </legend>
                                        <center>
                                            <table width="100%">
                                                <tr>
                                                    <td align="right">Tháng:
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="left">
                                                        <telerik:RadNumericTextBox ID="rnThangMoi" runat="server" Width="70px" AutoPostBack="True"
                                                            Skin="Windows7" Enabled="false">
                                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="rnThangMoi"
                                                            Display="Dynamic" ErrorMessage="Chưa lấy được ngân sách hiện tại." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="right">Năm:
                                                    </td>
                                                    <td style="width: 10px"></td>
                                                    <td align="left">
                                                        <telerik:RadNumericTextBox ID="rnNamMoi" runat="server" Width="70px" AutoPostBack="True"
                                                            Skin="Windows7" Enabled="false">
                                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="rnNamMoi"
                                                            Display="Dynamic" ErrorMessage="Chưa lấy được ngân sách hiện tại." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </center>
                                        <telerik:RadGrid ID="RG_NSHienTai" runat="server" Height="370px" AllowFilteringByColumn="false"
                                            Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="True"
                                            GridLines="None" AutoGenerateColumns="False" ShowFooter="True" CellSpacing="0"
                                            OnDeleteCommand="RG_NSHienTai_DeleteCommand">
                                            <GroupingSettings CaseSensitive="False" />
                                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                                <Selecting AllowRowSelect="false" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                        Groupable="False">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                        <ItemTemplate>
                                                            <%# Container.DataSetIndex  + 1%>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="ID_khoaCT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" Visible="false">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" Visible="false" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="50px"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        AllowFiltering="false" Visible="false">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="DV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="MaNV" DataField="MaNV" FilterControlWidth="60px"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        Visible="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                                        HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        FilterControlWidth="40px" Visible="true" AllowFiltering="true">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN" DataField="Sotien" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                                        FooterStyle-HorizontalAlign="Right" Aggregate="Sum" FooterStyle-CssClass="test"
                                                        AllowFiltering="false">
                                                        <FooterStyle ForeColor="Blue" />
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Ghichu" HeaderText="GHI CHÚ" ReadOnly="True"
                                                        UniqueName="Ghichu" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlWidth="60px"
                                                        Visible="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <GroupByExpressions>
                                                    <telerik:GridGroupByExpression>
                                                        <SelectFields>
                                                            <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP" HeaderText="Mã CP" />
                                                        </SelectFields>
                                                        <GroupByFields>
                                                            <telerik:GridGroupByField FieldName="GroupMaCP" HeaderText="Mã CP" />
                                                        </GroupByFields>
                                                    </telerik:GridGroupByExpression>
                                                </GroupByExpressions>
                                                <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                                    <EditColumn UniqueName="EditCommandColumn1">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </MasterTableView>
                                            <FooterStyle CssClass="color" />
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                        </telerik:RadGrid>
                                    </fieldset>
                                </div>
                            </div>
                        </telerik:RadPageView>
                    </telerik:RadMultiPage>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
