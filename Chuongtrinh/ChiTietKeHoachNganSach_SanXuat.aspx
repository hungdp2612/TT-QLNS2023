<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSach_SanXuat.aspx.cs"
    Inherits="ChiTietKeHoachNganSach_SanXuat" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết kế hoạch ngân sách</title>
    <style type="text/css">
        .color
        {
            color: Blue;
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
                window.location = "../TruyCapTraiPhep.aspx";
            }
        }
        CheckWnd();
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
            function SelectAll2(CheckBox) {
                var TargetBaseControl = document.getElementById('<%= this.RGChiPhiUQ.ClientID %>');
                var TargetChildControl = "chkSelect";
                var Inputs = TargetBaseControl.getElementsByTagName("input");
                for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                    if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                        Inputs[iCount].checked = CheckBox.checked;
                }
            }
        </script>
        <telerik:RadNotification ID="RadNotification2" runat="server" AutoCloseDelay="0"
            Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
            VisibleTitlebar="False" Width="998px">
            <ContentTemplate>
                <center>
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                    </asp:UpdateProgress>
                </center>
            </ContentTemplate>
        </telerik:RadNotification>
        <table>
            <tr>
                <td>
                    <asp:TextBox ID="txtIDKhoa" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtNam" runat="server" Width="180px" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtThang" runat="server" Width="180px" Visible="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtMaBP" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                </td>
            </tr>
        </table>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="MultiPage">
            <Tabs>
                <telerik:RadTab runat="server" Text="Xử lý từng đơn vị" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Tất cả các đơn vị">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
            Height="100%">
            <telerik:RadPageView ID="RadPageView1" runat="server">
                <table style="width: 70%">
                    <tr align="center">
                        <td align="right" style="width: 35%">
                            ĐV ủy quyền:
                        </td>
                        <td align="left" style="width: 35%">
                            <asp:DropDownList ID="ddlDonVi" runat="server" Width="300px" DataTextField="TenDonVi"
                                Skin="Windows7" DataValueField="MaDonVi" Height="25px" AutoPostBack="true" OnSelectedIndexChanged="ddlDonVi_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <div style="float: left; width: 100%">
                    <div style="float: left; width: 45%">
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849; text-align: left">
                                1. Kế hoạch chi phí</legend>
                            <telerik:RadGrid ID="RD_ChiPhi" runat="server" Height="360px" Width="100%" AllowAutomaticDeletes="True"
                                AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0"
                                Skin="Windows7" GridLines="None" OnPageIndexChanged="RD_ChiPhi_PageIndexChanged"
                                OnPageSizeChanged="RD_ChiPhi_PageSizeChanged" PageSize="5" OnItemCommand="RD_ChiPhi_ItemCommand">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowGroupFooter="true"
                                    TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="THANG" UniqueName="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                            Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                            HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="60px" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TenChiPhi" FilterControlAltText="Filter TenChiPhi column"
                                            HeaderText="MÃ NS" ReadOnly="True" SortExpression="TenChiPhi" UniqueName="TenChiPhi"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="60px" Visible="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TienSD" FilterControlAltText="Filter TienSD column"
                                            HeaderText="SỐ TIỀN SD" ReadOnly="True" SortExpression="TienSD" UniqueName="TienSD"
                                            ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                            AllowFiltering="false" Aggregate="Sum">
                                            <FooterStyle ForeColor="Blue" />
                                            <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TienUyQuyen" FilterControlAltText="Filter TienUyQuyen column"
                                            HeaderText="SỐ TIỀN UQ" ReadOnly="True" SortExpression="TienUyQuyen" UniqueName="TienUyQuyen"
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
                                            HeaderText="ĐV NHẬN UQ" ReadOnly="True" SortExpression="DVNhanUQ" UniqueName="DVNhanUQ"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" FilterControlWidth="60px">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90" />
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
                                Skin="Windows7" AllowAutomaticInserts="True" GridLines="None" AutoGenerateColumns="False"
                                ShowFooter="True" OnDeleteCommand="RGNganSach_DeleteCommand" OnItemCommand="RGNganSach_ItemCommand"
                                OnPageIndexChanged="RGNganSach_PageIndexChanged" OnPageSizeChanged="RGNganSach_PageSizeChanged">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
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
                                        <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="maBP" DataField="maBP" FilterControlWidth="50px"
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
                                        <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                            HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ TIỀN" DataField="Sotien" CurrentFilterFunction="Contains"
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
                                            ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
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
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <div style="margin-top: 30px">
                </div>
                <div style="float: left; width: 100%">
                    <div style="float: left; width: 45%">
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849; text-align: left">
                                1. Kế hoạch chi phí</legend>
                            <telerik:RadGrid ID="RGChiPhiUQ" runat="server" Height="360px" Width="100%" AllowAutomaticDeletes="True"
                                AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0"
                                Skin="Windows7" GridLines="None">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowGroupFooter="true"
                                    TableLayout="Fixed">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="THANG" UniqueName="NAM" CurrentFilterFunction="Contains"
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
                                            HeaderText="MÃ NS" ReadOnly="True" SortExpression="TenChiPhi" UniqueName="TenChiPhi"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="60px" Visible="true">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TienSD" FilterControlAltText="Filter TienSD column"
                                            HeaderText="SỐ TIỀN SD" ReadOnly="True" SortExpression="TienSD" UniqueName="TienSD"
                                            ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                            AllowFiltering="false" Aggregate="Sum">
                                            <FooterStyle ForeColor="Blue" />
                                            <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TienUyQuyen" FilterControlAltText="Filter TienUyQuyen column"
                                            HeaderText="SỐ TIỀN UQ" ReadOnly="True" SortExpression="TienUyQuyen" UniqueName="TienUyQuyen"
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
                                            HeaderText="ĐV NHẬN UQ" ReadOnly="True" SortExpression="DVNhanUQ" UniqueName="DVNhanUQ"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" FilterControlWidth="60px">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="All" ReadOnly="True" AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect2" runat="server" />
                                            </ItemTemplate>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkSelectAll2" runat="server" Text="" onclick="SelectAll2(this);" />
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
                        <asp:ImageButton ID="btnGetAll" runat="server" ImageUrl="~/images/Nutchuanweb/lay.jpg"
                            OnClick="btnGetAll_Click" />
                    </div>
                    <div style="float: left; width: 45%;">
                        <fieldset>
                            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Kế hoạch ngân
                                sách</legend>
                            <telerik:RadGrid ID="RGNS" runat="server" Height="360px" Width="100%" AllowFilteringByColumn="True"
                                AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                Skin="Windows7" AllowAutomaticInserts="True" GridLines="None" AutoGenerateColumns="False"
                                ShowFooter="True" OnDeleteCommand="RGNS_DeleteCommand" OnItemCommand="RGNS_ItemCommand">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
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
                                        <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ DV" UniqueName="maBP" DataField="maBP" FilterControlWidth="50px"
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
                                        <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                            HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="SỐ TIỀN" DataField="Sotien" CurrentFilterFunction="Contains"
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
            </telerik:RadPageView>
        </telerik:RadMultiPage>
        <div style="clear: both">
            <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                VisibleTitlebar="False" Width="100%">
                <ContentTemplate>
                    <center>
                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>
        </div>
    </div>
    </form>
</body>
</html>
