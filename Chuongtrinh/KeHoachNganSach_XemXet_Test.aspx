<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_XemXet_Test.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_XemXet_Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
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
            <%-- <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                VisibleTitlebar="False" Width="998px">
                <ContentTemplate>
                    <center>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>--%>
            <fieldset>
                <legend style="text-align: center; text-transform: uppercase">Xem xét kế hoạch ngân
                    sách</legend>
                <center>
                    <table>
                        <tr>
                            <td align="right">
                                Năm:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    Enabled="true" OnTextChanged="rnNam_TextChanged">
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
                                <asp:TextBox ID="TxtNguoiLap" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtMaDV"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Người phê duyệt:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="180px" DataTextField="MaTen"
                                    DataValueField="MAPD" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                    Enabled="false">
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
                                    MaxValue="4" MinValue="1" Enabled="true" OnTextChanged="rnQui_TextChanged">
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
                                <asp:TextBox ID="txtTenDV" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                            </td>
                            <td align="right">
                                Xem xét:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbXemXet" runat="server" Width="180px">
                                    <Items>
                                        <telerik:RadComboBoxItem Value="false" Text="Chưa xem xét" />
                                        <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
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
                                <%--    <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" AutoPostBack="True"
                                    MaxValue="12" MinValue="1" Visible="false">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
                <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                    cellspacing="0">
                    <tr>
                        <td style="vertical-align: top; width: 50%;">
                            <table width="100%" style="table-layout: fixed;" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="top">
                                        <telerik:RadGrid ID="RD" runat="server" Height="360px" Width="480px" AllowAutomaticDeletes="True"
                                            AllowAutomaticUpdates="True" AllowMultiRowEdit="True" Skin="Windows7" OnPageIndexChanged="RD_PageIndexChanged"
                                            OnPageSizeChanged="RD_PageSizeChanged" OnItemCommand="RD_ItemCommand" OnSelectedIndexChanged="RD_SelectedIndexChanged"
                                            ShowFooter="True" CellSpacing="0" GridLines="None">
                                            <GroupingSettings CaseSensitive="False" />
                                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                                <Selecting AllowRowSelect="True" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="MSCHIPHI"
                                                ShowGroupFooter="true" TableLayout="Fixed">
                                                <Columns>
                                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                                                        <HeaderStyle HorizontalAlign="Center" Width="30px" />
                                                    </telerik:GridClientSelectColumn>
                                                    <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                                        HeaderText="Năm" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                                        Visible="false">
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Mã NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                                        AllowFiltering="False" Groupable="False">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOnGrid" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn DataField="Chiphikehoach" FilterControlAltText="Filter Chiphikehoach column"
                                                        HeaderText="Chi phí KH" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="Chiphikehoach"
                                                        Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###}" AllowFiltering="false">
                                                        <FooterStyle ForeColor="Blue" />
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" FilterControlAltText="Filter CHIPHI_DATHUCHIEN column"
                                                        HeaderText="Đã sử dụng" ReadOnly="True" SortExpression="CHIPHI_DATHUCHIEN" UniqueName="CHIPHI_DATHUCHIEN"
                                                        Aggregate="Sum" CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        DataFormatString="{0:###,###}" AllowFiltering="false">
                                                        <FooterStyle ForeColor="Blue" />
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                                        HeaderText="Tháng" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        AllowFiltering="false" FilterControlWidth="60px">
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="CHIPHI_CON" FilterControlAltText="Filter CHIPHI_CON column"
                                                        HeaderText="Chi phí còn" ReadOnly="True" SortExpression="CHIPHI_CON" UniqueName="CHIPHI_CON"
                                                        Aggregate="Sum" CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                        DataFormatString="{0:###,###}" AllowFiltering="false">
                                                        <FooterStyle ForeColor="Blue" />
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
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
                                            <FooterStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                            <FilterMenu EnableImageSprites="False">
                                            </FilterMenu>
                                            <%-- <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                            </HeaderContextMenu>--%>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <%--    BUOC 2--%>
                        <td style="vertical-align: top; width: 50%;">
                            <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                                cellspacing="0">
                                <tr>
                                    <td style="top">
                                        <telerik:RadGrid ID="RadGDNganSach" runat="server" Height="360px" Width="480px" AllowFilteringByColumn="True"
                                            AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                            AllowAutomaticInserts="True" GridLines="None" Skin="Windows7" AutoGenerateColumns="False"
                                            OnCancelCommand="RadGDNganSach_CancelCommand" OnPageIndexChanged="RadGDNganSach_PageIndexChanged"
                                            OnPageSizeChanged="RadGDNganSach_PageSizeChanged" CellSpacing="0" OnItemCommand="RadGDNganSach_ItemCommand"
                                            ShowFooter="True" Visible="false">
                                            <GroupingSettings CaseSensitive="False" />
                                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                                <Selecting AllowRowSelect="True" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="none" ShowGroupFooter="true"
                                                TableLayout="Fixed">
                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                <CommandItemSettings AddNewRecordText="Thêm mới" />
                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                </ExpandCollapseColumn>
                                                <Columns>
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
                                                    <telerik:GridBoundColumn HeaderText="MaBP" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="40px"
                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Mã CP" UniqueName="MSChiphi" DataField="MSChiphi"
                                                        AllowFiltering="False" Groupable="False">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="Số tiền" DataField="Sotien" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                                        Aggregate="Sum" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                                        AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                                        AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbHieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="Hieuluc" HeaderText="HL-KT" UniqueName="Hieuluc"
                                                        AllowFiltering="False" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbHieuluc3" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc")) %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn HeaderText="Ghi chú" DataField="GHICHU" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    </telerik:GridBoundColumn>
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
                                        <telerik:RadGrid ID="RadGDNganSach2" ShowStatusBar="True" runat="server" Height="360px"
                                            Width="480px" AutoGenerateColumns="False" AllowSorting="false" AllowPaging="false"
                                            GridLines="None" EnableHierarchyExpandAll="true" ShowFooter="True" CellSpacing="0" AllowFilteringByColumn="true">
                                            <PagerStyle Mode="NumericPages"></PagerStyle>
                                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                                <Selecting AllowRowSelect="True" />
                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            </ClientSettings>
                                            <MasterTableView DataKeyNames="Khoa" AllowMultiColumnSorting="True">
                                                <DetailTables>
                                                    <telerik:GridTableView DataSourceID="SqlDataSource2" Width="100%" runat="server"
                                                        Name="Detail">
                                                        <ParentTableRelation>
                                                            <telerik:GridRelationFields DetailKeyField="Khoa" MasterKeyField="Khoa"></telerik:GridRelationFields>
                                                        </ParentTableRelation>                                                        
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Năm" UniqueName="Nam" DataField="Nam" FilterControlWidth="50px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                AllowFiltering="false" Visible="false">
                                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="MaBP" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="40px"
                                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                Visible="false">
                                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                                AutoPostBackOnFilter="true">
                                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Số tiền" DataField="Sotien" CurrentFilterFunction="Contains"
                                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                                                Aggregate="Sum" AllowFiltering="false" FooterStyle-ForeColor="Blue">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Ghi chú" DataField="GHICHU" CurrentFilterFunction="Contains"
                                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </telerik:GridTableView>
                                                </DetailTables>
                                                <Columns>
                                                    <telerik:GridBoundColumn SortExpression="Khoa" HeaderText="Khoa" HeaderButtonType="TextButton"
                                                        DataField="Khoa" Visible="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn SortExpression="Nam" HeaderText="Năm" HeaderButtonType="TextButton"
                                                        DataField="Nam" UniqueName="Nam">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    </telerik:GridBoundColumn>                                                   
                                                    <telerik:GridBoundColumn SortExpression="Qui" HeaderText="Quí" HeaderButtonType="TextButton"
                                                        DataField="Qui" UniqueName="Qui">
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn SortExpression="MSChiphi" HeaderText="Mã NS" HeaderButtonType="TextButton"
                                                        DataField="MSChiphi" UniqueName="MSChiphi">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn SortExpression="DienGiai" HeaderText="Tên NS" HeaderButtonType="TextButton"
                                                        DataField="DienGiai" UniqueName="DienGiai" ShowFilterIcon="false">
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                                        AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                                        AllowFiltering="False">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbHieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="MSChiphi"></telerik:GridSortExpression>
                                                </SortExpressions>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
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
                <div>                 
                    <asp:SqlDataSource ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:ConnectDB_QLNS2013 %>"
                        ProviderName="System.Data.SqlClient" SelectCommand="Select k.MaDV+k.Nam+f3.QUI+ct.MSChiphi as Khoa, Sum(ct.SoTien) as SoTien,ct.MaBP,ct.MaDVUQ,ct.GhiChu,k.Nam,k.Thang
                        from tblChitiet_Kehoachngansach ct, tblKehoachngansach k, tblDMQui f3, DmChiPhi f4
	                                                where ct.ID_Khoa = k.ID_Khoa 	
	                                                and k.Thang = f3.THANG
	                                                and f4.MSChiPhi = ct.MSChiphi
	                                                and f4.HieuLuc=1 
                                                    and k.MaDV+k.Nam+f3.QUI+ct.MSChiphi = @Khoa
                                                    group by k.Thang,ct.Ghichu,f3.QUI,ct.MSChiphi,
	                                                k.Nam,k.MaDV,ct.MaBP,ct.MaDVUQ" runat="server">
                        <SelectParameters>
                            <asp:SessionParameter Name="Khoa" SessionField="Khoa" Type="string"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
