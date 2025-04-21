<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachChiPhi.aspx.cs"
    Inherits="ChiTietKeHoachChiPhi" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết chi phí kế hoạch</title>
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
        function onkeyupEvent() {

            // alert("kaka");

            rnChiPhi = $find("<%= rnChiPhi.ClientID %>");

            rnChiPhiConLaiAn = $find("<%= rnChiPhiConLaiAn.ClientID %>");

            InputChiPhiConLai = $find("<%= rnChiPhiConLai.ClientID %>");

            InputChiPhiConLai.set_value(rnChiPhiConLaiAn.get_value() - rnChiPhi.get_value());

        }  
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi phí
                        kế hoạch</legend>
                    <center>
                        <table>
                            <tr>
                                <td align="right">
                                    ID_Khóa:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <telerik:RadTextBox ID="txtKHCP_ID" runat="server" Width="150px" Enabled="false"
                                        Skin="Windows7" Display="true">
                                    </telerik:RadTextBox>
                                </td>
                                <td width="5px">
                                </td>
                                <td align="right">
                                    Chi phí được duyệt:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnChiPhiConLai" runat="server" Value="0" Width="150px"
                                        Skin="Windows7" Enabled="false">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Tháng:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="DropDownListThang" runat="server" AutoPostBack="false" ForeColor="Black"
                                        Skin="Windows7" Width="150px">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Value="1">Tháng 1</asp:ListItem>
                                        <asp:ListItem Value="2">Tháng 2</asp:ListItem>
                                        <asp:ListItem Value="3">Tháng 3</asp:ListItem>
                                        <asp:ListItem Value="4">Tháng 4</asp:ListItem>
                                        <asp:ListItem Value="5">Tháng 5</asp:ListItem>
                                        <asp:ListItem Value="6">Tháng 6</asp:ListItem>
                                        <asp:ListItem Value="7">Tháng 7</asp:ListItem>
                                        <asp:ListItem Value="8">Tháng 8</asp:ListItem>
                                        <asp:ListItem Value="9">Tháng 9</asp:ListItem>
                                        <asp:ListItem Value="10">Tháng 10</asp:ListItem>
                                        <asp:ListItem Value="11">Tháng 11</asp:ListItem>
                                        <asp:ListItem Value="12">Tháng 12</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="DropDownListThang"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                                <td width="5px">
                                </td>
                                <td align="right">
                                    Chi phí:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" Value="0" Width="150px" onkeyup="onkeyupEvent()"
                                        Skin="Windows7">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    ĐV nhận ủy quyền:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="ddlDonVi" DropDownWidth="200px" runat="server" Skin="Windows7" Width="150px" AutoPostBack="true"
                                        MarkFirstMatch="true" Filter="Contains" AllowCustomText="true" DataValueField="MaDonVi"
                                        DataTextField="TenDonVi">
                                    </telerik:RadComboBox>
                                    
                                </td>
                                <td width="5px">
                                </td>
                                <td align="right">
                                    Tỉ lệ ĐV:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnTiLeDV" runat="server" MinValue="0" Value="100"
                                        Skin="Windows7" MaxValue="100" Width="150px">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Ghi chú:
                                </td>
                                <td width="5px">
                                </td>
                                <td align="left" colspan="10">
                                    <asp:TextBox ID="txtGhiChu" runat="server" Height="20px" Width="98%" Skin="Windows7"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="11" align="center">
                                    <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadNumericTextBox ID="rnChiPhiConLaiAn" runat="server" ReadOnly="True" Width="165px"
                                        Enabled="False" Value="0" Display="false">
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10" align="center">
                                    <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </center>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                        chi phí kế hoạch</legend>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        Skin="Windows7" CellSpacing="0" GridLines="None" AllowFilteringByColumn="false"
                        AllowPaging="True" ShowFooter="true" AllowSorting="True" ShowStatusBar="True"
                        EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand" OnDeleteCommand="RG_DeleteCommand"
                        OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged"
                        OnPageSizeChanged="RG_PageSizeChanged" OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand"
                        PageSize="12">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            <Selecting AllowRowSelect="true" />
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
                                <telerik:GridBoundColumn HeaderText="IDkhoa_chitietKH" UniqueName="IDkhoa_chitietKH"
                                    DataField="IDkhoa_chitietKH" FilterControlWidth="70px" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Khoa_chiphi" UniqueName="Khoa_chiphi" DataField="Khoa_chiphi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="CHI PHÍ" UniqueName="Chiphi" DataField="Chiphi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    Aggregate="Sum" FooterStyle-ForeColor="Blue" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="NGÀY CN" UniqueName="ngaymodify" DataField="ngaymodify"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="ManvCN" DataField="ManvCN"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TỈ LỆ DV" UniqueName="TileDvi" DataField="TileDvi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TỈ LỆ NHẬN UQ" UniqueName="TileUyQuyen" DataField="TileUyQuyen"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="ĐV NHẬN UQ" UniqueName="MaDVduocUQ" DataField="MaDVduocUQ"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GHICHU" DataField="GHICHU"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="SỬA" HeaderText="SỬA"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%-- <asp:SqlDataSource ID="sql_ChiTiet_ChiPhiKeHoach" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectQLNS %>"
        SelectCommand="spLoad_ChiTiet_ChiPhiKeHoach" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
    </form>
</body>
</html>
