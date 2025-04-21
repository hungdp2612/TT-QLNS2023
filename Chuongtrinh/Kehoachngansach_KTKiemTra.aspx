<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Kehoachngansach_KTKiemTra.aspx.cs" Inherits="Chuongtrinh_Kehoachngansach_KTKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
    <style type="text/css">
        .test
        {
            color: Blue;
        }
    </style>
    <script type="text/javascript">

        function OnClientClose() {
            __doPostBack('fLoad', '');
        }

    
    </script>
    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
    </telerik:RadWindowManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                VisibleTitlebar="False" Width="998px">
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
            <fieldset style="width: 97%; margin-left: 5px">
                <legend>Chọn đơn vị</legend>
                <center>
                    <table cellpadding="1" cellspacing="0" style="margin-top: 10px;">
                        <tr>
                            <td align="left">
                                Năm:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    Enabled="true" OnTextChanged="rnNam_TextChanged">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="left">
                                Qui:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnQui" runat="server" Width="70px" AutoPostBack="True"
                                    MaxValue="4" MinValue="1" Enabled="true" OnTextChanged="rnQui_TextChanged">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnQui"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="left">
                                Đơn vị:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="CboMaDV" runat="server" Width="227px" DataTextField="MaDV_DISPLAY"
                                    DataValueField="MaDV" DropDownWidth="227px" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                    AutoPostBack="true" Height='150px' OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                                    <ItemTemplate>
                                        <%#Eval("MaDV_DISPLAY")%>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                    ValidationGroup="gIn" OnClick="btExcel_Click" />
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 97%; margin-left: 5px">
                <legend>Kế hoạch ngân sách </legend>
                <telerik:RadGrid ID="RadGDNganSach" runat="server" Height="400px" Width="100%" AllowAutomaticDeletes="True"
                    AllowAutomaticUpdates="True" AllowMultiRowEdit="True" AllowAutomaticInserts="True"
                    GridLines="None" Skin="Windows7" AutoGenerateColumns="False" CellSpacing="0"
                    OnItemCommand="RadGDNganSach_ItemCommand" ShowFooter="true" AllowFilteringByColumn="True"
                    Visible="true">
                    <GroupingSettings CaseSensitive="False" />
                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
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
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                ShowFilterIcon="false" AllowFiltering="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MÃ PB" HeaderText="Mã BP" ReadOnly="True" SortExpression="MaBP"
                                UniqueName="MaBP" CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="true" FilterControlWidth="40px">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="ĐV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                AllowFiltering="true" ShowFilterIcon="false" AutoPostBackOnFilter="true" Groupable="False">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemTemplate>
                                    <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                FooterStyle-CssClass="test" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                <FooterStyle CssClass="test" />
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Ghichu" HeaderText="GHI CHÚ" ReadOnly="True"
                                SortExpression="Ghichu" UniqueName="Ghichu" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridCheckBoxColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                AllowFiltering="False">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridCheckBoxColumn>
                            <telerik:GridCheckBoxColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                AllowFiltering="False">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridCheckBoxColumn>
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
                                    <telerik:GridGroupByField FieldAlias="MaBP" FieldName="MaBP" HeaderText="MaBP" />
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldName="MaBP" HeaderText="MaBP" />
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
                        <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FooterStyle CssClass="test" />
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
                                <telerik:GridBoundColumn DataField="TongQui1" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui1"
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
                                <telerik:GridBoundColumn DataField="TongQui2" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui2"
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
                                <telerik:GridBoundColumn DataField="TongQui3" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui3"
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
                                <telerik:GridBoundColumn DataField="TongQui4" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui4"
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
