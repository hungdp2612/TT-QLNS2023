<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_XemXet_bak110615.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_XemXet_bak110615" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .color
        {
            color: Blue;
        }
    </style>
    <script src="../js/Common.js" type="text/javascript"></script>
    <script type="text/javascript">

        function openRadWindowShow(ID_Khoa) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa, "RadWindowManager1");
            oWnd.Center();
        }

        function OnClientClose() {
            __doPostBack('fLoad', '');
        }

    
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                <Shortcuts>
                    <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                </Shortcuts>
                <Windows>
                    <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize, Reload"
                        VisibleStatusbar="false" ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True"
                        KeepInScreenBounds="True" InitialBehaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Xem xét kế hoạch ngân sách</legend>
                <center>
                    <table>
                        <tr>
                            <td align="right">
                                Năm:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    Skin="Windows7" Enabled="true" OnTextChanged="rnNam_TextChanged">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Người xem xét:
                            </td>
                            <td>
                                <asp:TextBox ID="TxtNguoiLap" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtMaDV"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Người phê duyệt:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="180px" DataTextField="MaTen"
                                    Skin="Windows7" DataValueField="MAPD" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                    Enabled="true">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMSCHIPHI" runat="server" ControlToValidate="cbNguoiPheDuyet"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Quí
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnQui" runat="server" Width="70px" AutoPostBack="True"
                                    Skin="Windows7" MaxValue="4" MinValue="1" Enabled="true" OnTextChanged="rnQui_TextChanged">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnQui"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Tên ĐV:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTenDV" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                            </td>
                            <td align="right">
                                Xem xét:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbXemXet" runat="server" Width="180px" Skin="Windows7">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                        <telerik:RadComboBoxItem Value="false" Text="Bỏ xem xét" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="11" align="center">
                                <%
                                    if (HieuLucPD() == false)
                                    {%>
                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png" /></asp:HyperLink>
                                <%}
                                %>
                                <asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excelDV.png"
                                    ValidationGroup="GInsert" OnClick="btExcel_Click" />
                                <asp:ImageButton ID="btnReport" runat="server" ImageUrl="~/images/Nutchuanweb/PrintUyQuyen.png"
                                    ValidationGroup="GInsert" OnClick="btnReport_Click" />
                                <asp:ImageButton ID="btnReportPCU" runat="server" ImageUrl="~/images/Nutchuanweb/PrintUyQuyen.png"
                                    ValidationGroup="GInsert" OnClick="btnReportPCU_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="9">
                                <asp:Label ID="lbEmail" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="9" style="color: Blue">
                                <asp:Label ID="lbThoiGianLapNganSach" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="9">
                                <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend style="">Kế hoạch ngân sách </legend>
                <telerik:RadGrid ID="RadGDNganSach" runat="server" Height="360px" Width="100%" AllowFilteringByColumn="True"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                    Skin="Windows7" AllowAutomaticInserts="True" GridLines="None" AutoGenerateColumns="False"
                    OnCancelCommand="RadGDNganSach_CancelCommand" OnPageIndexChanged="RadGDNganSach_PageIndexChanged"
                    OnPageSizeChanged="RadGDNganSach_PageSizeChanged" CellSpacing="0" OnItemCommand="RadGDNganSach_ItemCommand"
                    ShowFooter="True">
                    <GroupingSettings CaseSensitive="False" />
                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="none" ShowGroupFooter="true"
                        TableLayout="Fixed">
                        <Columns>
                            <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="true" AllowFiltering="false"
                                FilterControlWidth="40px">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="40px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="SỐ TIỀN" DataField="Sotien" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                Aggregate="Sum" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="GHI CHÚ" DataField="GHICHU" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbHieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Hieuluc" HeaderText="HL-KT" UniqueName="Hieuluc"
                                AllowFiltering="False" Visible="false">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbHieuluc3" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="NAM" FieldName="NAM" HeaderText="Nam" />
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="NAM" HeaderText="NAM" />
                                </GroupByFields>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang" HeaderText="Thang" />
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="Thang" HeaderText="Thang" />
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
            <div>
                <div>
                    <telerik:RadGrid ID="ExcelQui1" runat="server" Width="970px" AutoGenerateColumns="False"
                        EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                        AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                            <Selecting AllowRowSelect="True" />
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
                                <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TongQui1" HeaderText="Số tiền quí 1 (VNĐ)" UniqueName="TongQui1"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang1" HeaderText="Tháng 1" UniqueName="Thang1"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang2" HeaderText="Tháng 2" UniqueName="Thang2"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang3" HeaderText="Tháng 3" UniqueName="Thang3"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </div>
                <div>
                    <telerik:RadGrid ID="ExcelQui2" runat="server" Width="970px" AutoGenerateColumns="False"
                        EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                        AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                            <Selecting AllowRowSelect="True" />
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
                                <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TongQui2" HeaderText="Số tiền quí 2 (VNĐ)" UniqueName="TongQui2"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang4" HeaderText="Tháng 4" UniqueName="Thang4"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang5" HeaderText="Tháng 5" UniqueName="Thang5"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang6" HeaderText="Tháng 6" UniqueName="Thang6"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </div>
                <div>
                    <telerik:RadGrid ID="ExcelQui3" runat="server" Width="970px" AutoGenerateColumns="False"
                        EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                        AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                            <Selecting AllowRowSelect="True" />
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
                                <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TongQui3" HeaderText="Số tiền quí 3 (VNĐ)" UniqueName="TongQui3"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang7" HeaderText="Tháng 7" UniqueName="Thang7"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang8" HeaderText="Tháng 8" UniqueName="Thang8"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang9" HeaderText="Tháng 9" UniqueName="Thang9"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </div>
                <div>
                    <telerik:RadGrid ID="ExcelQui4" runat="server" Width="970px" AutoGenerateColumns="False"
                        EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                        AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                            <Selecting AllowRowSelect="True" />
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
                                <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" Visible="true">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TongQui4" HeaderText="Số tiền quí 4 (VNĐ)" UniqueName="TongQui4"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang10" HeaderText="Tháng 10" UniqueName="Thang10"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang11" HeaderText="Tháng 11" UniqueName="Thang11"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang12" HeaderText="Tháng 12" UniqueName="Thang12"
                                    FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
