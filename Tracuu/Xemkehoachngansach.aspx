<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Xemkehoachngansach.aspx.cs" Inherits="TraCuu_Xemkehoachngansach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Xem kế hoạch ngân sách</legend>
                <center>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Label ID="lblLoi" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="1" cellspacing="0">
                        <tr>
                            <td align="left">
                                Năm:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="CboNam" runat="server" AllowCustomText="true" AutoPostBack="True"
                                    Skin="Windows7" DataTextField="Nam" DataValueField="Nam" Enabled="True" Filter="Contains"
                                    MarkFirstMatch="true" OnSelectedIndexChanged="CboNam_SelectedIndexChanged" Width="100px">
                                </telerik:RadComboBox>
                            </td>
                            <td width="5px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false" Skin="Windows7"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Kế hoạch ngân sách</legend>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="vertical-align: top; width: 50%;">
                            <telerik:RadGrid ID="RadGDPHIEU" Height="450px" runat="server" Skin="Windows7" AllowAutomaticDeletes="True"
                                AllowAutomaticUpdates="True" AllowMultiRowEdit="True" OnSelectedIndexChanged="RadGDPHIEU_SelectedIndexChanged"
                                CellSpacing="0" GridLines="None" OnItemCommand="RadGDPHIEU_ItemCommand">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowFooter="true">
                                    <CommandItemSettings AddNewRecordText="Thêm mới" />
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                                            <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px">
                                            <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ DV" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                            <HeaderStyle Width="70px" HorizontalAlign="right" VerticalAlign="Middle" />
                                            <ItemStyle Width="70px" HorizontalAlign="right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongTien" FilterControlAltText="Filter TongTien column"
                                            HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="TongTien" UniqueName="TongTien"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" DataFormatString="{0:#,#}" Aggregate="Sum" FooterStyle-ForeColor="Blue"
                                            FooterAggregateFormatString="{0:0,0}">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                            <HeaderStyle Width="100px" HorizontalAlign="right" VerticalAlign="Middle" />
                                            <ItemStyle Width="100px" HorizontalAlign="right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaNVNguoiLap" FilterControlAltText="Filter MaNVNguoiLap column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="MaNVNguoiLap" UniqueName="MaNVNguoiLap"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="60px" Visible="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="right" VerticalAlign="Middle" />
                                            <ItemStyle Width="60px" HorizontalAlign="right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbhieulucPD" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="ID_Khoa" FilterControlAltText="Filter ID_Khoa column"
                                            HeaderText="ID" ReadOnly="True" SortExpression="ID_Khoa" UniqueName="ID_Khoa"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            Visible="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" />
                                        </telerik:GridBoundColumn>
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
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                </HeaderContextMenu>
                            </telerik:RadGrid>
                        </td>
                        <td style="width: 50%;">
                            <div style="margin-left: 10px">
                                <telerik:RadGrid ID="RD_Chitiet" Height="450px" runat="server" Width="480px" Skin="Windows7"
                                    AllowFilteringByColumn="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                    AllowMultiRowEdit="True" OnCancelCommand="RD_Chitiet_CancelCommand" OnPageIndexChanged="RD_Chitiet_PageIndexChanged"
                                    OnPageSizeChanged="RD_Chitiet_PageSizeChanged" CellSpacing="0" GridLines="None"
                                    AllowSorting="false" OnItemCommand="RD_Chitiet_ItemCommand">
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowFooter="true">
                                        <CommandItemSettings AddNewRecordText="Thêm mới" />
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="ID_Khoa" FilterControlAltText="Filter ID_Khoa column"
                                                HeaderText="ID" ReadOnly="True" SortExpression="ID_Khoa" UniqueName="ID_Khoa"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                Visible="false">
                                                <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                                <ItemStyle Width="60px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MaBP" FilterControlAltText="Filter MaBP column"
                                                HeaderText="MÃ ĐV" ReadOnly="True" SortExpression="MaBP" UniqueName="MaBP" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle Width="60px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle Width="60px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MaDVUQ" FilterControlAltText="Filter MaDVUQ column"
                                                HeaderText="ĐV UQ" ReadOnly="True" SortExpression="MaDVUQ" UniqueName="MaDVUQ"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="true">
                                                <HeaderStyle Width="60px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle Width="60px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MSChiphi" FilterControlAltText="Filter MSChiphi column"
                                                HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSChiphi" UniqueName="MSChiphi"
                                                FilterControlWidth="50" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                                <HeaderStyle Width="60px" HorizontalAlign="Left" />
                                                <ItemStyle Width="60px" HorizontalAlign="Left" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DienGiai" FilterControlAltText="Filter DienGiai column"
                                                HeaderText="TÊN NS" ReadOnly="True" SortExpression="DienGiai" UniqueName="DienGiai"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                                HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                                Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                                AllowFiltering="false" FooterAggregateFormatString="{0:0,0}">
                                                <FooterStyle ForeColor="blue" HorizontalAlign="Right" />
                                                <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="GhiChu" FilterControlAltText="Filter GhiChu column"
                                                HeaderText="GHI CHÚ" ReadOnly="True" SortExpression="GhiChu" UniqueName="GhiChu"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            </telerik:GridBoundColumn>
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
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                    </HeaderContextMenu>
                                </telerik:RadGrid>
                            </div>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
