<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSach_PCU_HCQT.aspx.cs"
    Inherits="ChiTietKeHoachNganSach_PCU_HCQT" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết kế hoạch ngân sách</title>
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
    <script language="javascript" type="text/javascript">
        function SelectAll(CheckBox) {
            var TargetBaseControl = document.getElementById('<%= this.RD_ChiPhi.ClientID %>');
            var TargetChildControl = "chkSelect";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[iCount].checked = CheckBox.checked;
            }
        }
    </script>
    <div>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
            <Tabs>
                <telerik:RadTab runat="server" Text="Ngân sách được ủy quyền" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Kiểm tra lại ngân sách đơn vị ủy quyền">
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
                                <td align="center">
                                    <asp:Label ID="f" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtKHCP_ID" runat="server" Width="150px" Enabled="false"
                                        Visible="false">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
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
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowSorting="True"
                        ShowStatusBar="True" EnableLinqExpressions="False" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand">
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
                                    AutoPostBackOnFilter="true" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Bộ phận" UniqueName="MaBP" DataField="MaBP"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="DV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="true" FooterStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MaNV" UniqueName="MaNV" DataField="MaNV" FilterControlWidth="50px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MSChiphi" UniqueName="MSChiphi" DataField="MSChiphi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Ghichu" DataField="Ghichu"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridButtonColumn>
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
                <div style="clear: both">
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">               
                <table style="width: 70%">
                    <tr align="center">
                        <td align="right" style="width: 35%">
                            ĐV ủy quyền:
                        </td>
                        <td align="left" style="width: 35%">
                            <asp:DropDownList ID="ddlDonVi" runat="server" Width="300px" DataTextField="TenDonVi"
                                DataValueField="MaDonVi" Height="25px" AutoPostBack="true" OnSelectedIndexChanged="ddlDonVi_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <center>
                    <div style="float: left; width: 100%">
                        <div style="float: left; width: 45%">
                            <fieldset>
                                <legend style="font-size: 9pt; font-family: Tahoma; color: #982849; text-align: left">
                                    1. Kế hoạch chi phí</legend>
                                <telerik:RadGrid ID="RD_ChiPhi" runat="server" Height="360px" Width="100%" AllowAutomaticDeletes="True"
                                    AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0"
                                    GridLines="None">
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowGroupFooter="true"
                                        TableLayout="Fixed">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                                HeaderText="Tháng" ReadOnly="True" SortExpression="THANG" UniqueName="NAM" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                                Visible="true">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                                HeaderText="Mã CP" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                FilterControlWidth="60px" Visible="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TenChiPhi" FilterControlAltText="Filter TenChiPhi column"
                                                HeaderText="Mã CP" ReadOnly="True" SortExpression="TenChiPhi" UniqueName="TenChiPhi"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                FilterControlWidth="60px" Visible="true">
                                                <%--     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />--%>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TienSD" FilterControlAltText="Filter TienSD column"
                                                HeaderText="Số tiền SD" ReadOnly="True" SortExpression="TienSD" UniqueName="TienSD"
                                                ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                                AllowFiltering="false" Aggregate="Sum">
                                                <FooterStyle ForeColor="Blue" />
                                                <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TienUyQuyen" FilterControlAltText="Filter TienUyQuyen column"
                                                HeaderText="Số tiền UQ" ReadOnly="True" SortExpression="TienUyQuyen" UniqueName="TienUyQuyen"
                                                ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                                AllowFiltering="false" Aggregate="Sum">
                                                <FooterStyle ForeColor="Blue" />
                                                <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DVUQ" FilterControlAltText="Filter DVUQ column"
                                                HeaderText="ĐV UQ" ReadOnly="True" SortExpression="DVUQ" UniqueName="DVUQ" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlWidth="60px">
                                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="60" />
                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="60" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DVNhanUQ" FilterControlAltText="Filter DVNhanUQ column"
                                                HeaderText="ĐV nhận UQ" ReadOnly="True" SortExpression="DVNhanUQ" UniqueName="DVNhanUQ"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="false" FilterControlWidth="60px">
                                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="60" />
                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="60" />
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
                                <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Kế hoạch ngân
                                    sách</legend>
                                <telerik:RadGrid ID="RGNganSach" runat="server" Height="360px" Width="100%" AllowFilteringByColumn="True"
                                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                    AllowAutomaticInserts="True" GridLines="None" AutoGenerateColumns="False" 
                                    ShowFooter="True" ondeletecommand="RGNganSach_DeleteCommand" 
                                    onitemcommand="RGNganSach_ItemCommand">
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                        <Selecting AllowRowSelect="false" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="none" ShowGroupFooter="true"
                                        TableLayout="Fixed">
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="ID_khoaCT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Năm" UniqueName="NAM" DataField="NAM" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MaDV" UniqueName="maBP" DataField="maBP" FilterControlWidth="50px"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ĐV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                                HeaderText="Mã CP" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                FilterControlWidth="40px" Visible="true">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Số tiền" DataField="Sotien" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                                Aggregate="Sum" FooterStyle-ForeColor="Red" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                                <FooterStyle ForeColor="Blue" />
                                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                                AllowFiltering="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                                AllowFiltering="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbHieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridButtonColumn>
                                        </Columns>
                                        <GroupByExpressions>
                                            <telerik:GridGroupByExpression>
                                                <SelectFields>
                                                    <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang" HeaderText="Tháng" />
                                                </SelectFields>
                                                <GroupByFields>
                                                    <telerik:GridGroupByField FieldName="Thang" HeaderText="Tháng" />
                                                </GroupByFields>
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
                </center>
            </telerik:RadPageView>

           
        </telerik:RadMultiPage>
          <telerik:RadNotification ID="RadNotification2" runat="server" AutoCloseDelay="0"
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
    </div>
    <%-- <asp:SqlDataSource ID="sql_ChiTiet_ChiPhiKeHoach" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectQLNS %>"
        SelectCommand="spLoad_ChiTiet_ChiPhiKeHoach" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
    </form>
</body>
</html>
