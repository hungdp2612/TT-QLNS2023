<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapTamUng_KTKiemTra.aspx.cs" Inherits="Chuongtrinh_LapTamUng_KTKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script src="../js/Common.js" type="text/javascript"></script>
            <script type="text/javascript">

                function openRadWindowShow(ID_Khoa) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa, "RadWindowManager1");
                    oWnd.Center();
                }

                function OnClientClose() {
                    __doPostBack('fLoadChiTietTamUng', '');
                }


                function openRadWindowShow2(sophieu, LoaiTien, TiGia) {
                    var manager2 = $find("<%= RadWindowManager2.ClientID %>");
                    var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa, "RadWindowManager2");
                    oWnd2.Center();
                }
                function OnClientClose2() {
                    __doPostBack('fLoad', '');
                }

    
            </script>
           
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage"
                AutoPostBack="True" OnTabClick="RadTabStrip1_TabClick" Skin="Windows7">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Kế toán xác nhận phiếu tạm ứng" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Kế toán trả phiếu tạm ứng">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="height: 20px;">
            </div>
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
            <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="false" AutoSize="false"
                EnableShadow="true" ID="RadWindowManager3" runat="server" KeepInScreenBounds="True"
                Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                EnableViewState="False" InitialBehaviors="Maximize">
                <Shortcuts>
                    <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                </Shortcuts>
                <Windows>
                    <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize" VisibleStatusbar="false"
                        ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True" KeepInScreenBounds="true"
                        InitialBehaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                    </telerik:RadWindowManager>
                    <center>
                        <table>
                            <tr>
                                <td align="right">
                                    Bộ phận:
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                        DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True" Filter="Contains"
                                        Height="200px" MarkFirstMatch="true" Skin="Windows7" Width="220px" OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </center>
                    <div style="float: left; width: 1000px;">
                        <div style="float: left; width: 500px;">
                            <fieldset style="width: 500px">
                                <legend>Phiếu TU</legend>
                                <telerik:RadGrid ID="RDPhieuTU" runat="server" Height="350px" AllowAutomaticDeletes="True"
                                    Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" OnPageIndexChanged="RDPhieuTU_PageIndexChanged"
                                    OnSelectedIndexChanged="RDPhieuTU_SelectedIndexChanged" OnItemCommand="RDPhieuTU_ItemCommand"
                                    OnItemDataBound="RDPhieuTU_ItemDataBound" OnPageSizeChanged="RDPhieuTU_PageSizeChanged"
                                    ShowFooter="True" CellSpacing="0" GridLines="None" AllowFilteringByColumn="True">
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="PhieuTU">
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
                                            <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MANV" FilterControlAltText="Filter MaNV column"
                                                HeaderText="MÃ NV" ReadOnly="True" SortExpression="MaNV" UniqueName="MaNV" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                                <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                <ItemStyle Width="50px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                HeaderText="TỔNG TIỀN" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn HeaderText="XÁC NHẬN" UniqueName="KTKiemTra" ShowFilterIcon="false"
                                                AllowFiltering="false" FilterControlWidth="60px">
                                                <HeaderStyle Width="80px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemStyle Width="80px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <telerik:RadComboBox ID="cbKTKiemTra" Width="100px" runat="server" AutoPostBack="true"
                                                        OnSelectedIndexChanged="cbKTKiemTra_SelectedIndexChanged">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Value="false" Text="Chưa xác nhận" />
                                                            <telerik:RadComboBoxItem Value="True" Text="Xác nhận" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:HiddenField ID="hfKiemTra" runat="server" Value='<%# Eval("KTKiemTra") %>' />
                                                </ItemTemplate>
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
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                    </HeaderContextMenu>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                        <div style="float: left; width: 450px; margin-left: 25px;">
                            <fieldset style="width: 450px">
                                <legend>Chi tiết phiếu TU</legend>
                                <telerik:RadGrid ID="RG" runat="server" Width="450px" Height="350px" Skin="Windows7"
                                    CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                    OnCancelCommand="RG_CancelCommand" OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging"
                                    OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                                    ShowFooter="True" OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand"
                                    AutoGenerateColumns="False">
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView>
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                Groupable="False">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemTemplate>
                                                    <%# Container.DataSetIndex  + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="MÃ CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="TỈ GIÁ" UniqueName="TiGia" DataField="TiGia"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                                HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                                Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                <HeaderStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Lydo" DataField="Lydo"
                                                FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose2">
                    </telerik:RadWindowManager>
                    <center>
                        <table>
                            <tr>
                                <td align="right">
                                    Bộ phận:
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="CboMaDV2" runat="server" AllowCustomText="true" AutoPostBack="True"
                                        DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True" Filter="Contains"
                                        Height="200px" MarkFirstMatch="true" Skin="Windows7" Width="220px" OnSelectedIndexChanged="CboMaDV2_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CboMaDV2"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtMaBP2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </center>
                    <div style="float: left; width: 1000px;">
                        <div style="float: left; width: 500px;">
                            <fieldset style="width: 500px">
                                <legend>Phiếu TU</legend>
                                <telerik:RadGrid ID="RGPhieuTU2" runat="server" Width="500px" Height="350px" AutoGenerateColumns="False"
                                    CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                    Skin="Windows7" OnItemCommand="RGPhieuTU2_ItemCommand" OnPageIndexChanged="RGPhieuTU2_PageIndexChanged"
                                    OnPageSizeChanged="RGPhieuTU2_PageSizeChanged" ShowFooter="true" AllowFilteringByColumn="True">
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu EnableTheming="True">
                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                    </HeaderContextMenu>
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView>
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" AllowFiltering="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="MaNV" FilterControlAltText="Filter MaNV column"
                                                HeaderText="MÃ NV" ReadOnly="True" SortExpression="MaNV" UniqueName="MaNV" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px"
                                                AllowFiltering="true">
                                                <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                <ItemStyle Width="50px" HorizontalAlign="Center" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                HeaderText="TỔNG TIỀN" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                <HeaderStyle Width="70px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="70px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="KTKiemTra" HeaderText="KTKT" UniqueName="KTKiemTra"
                                                AllowFiltering="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KTKiemTra")) %>' />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="TRẢ PHIẾU" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnTraPhieu" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                                        CommandName="TraPhieu" CommandArgument='<%# Eval("PhieuTU")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                        <div style="float: left; width: 450px; margin-left: 25px;">
                            <fieldset style="width: 450px">
                                <legend>Chi tiết phiếu TU</legend>
                                <telerik:RadGrid ID="RGChiTietPhieuTU2" runat="server" Width="450px" Height="350px"
                                    Skin="Windows7" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                    ShowStatusBar="True" EnableLinqExpressions="False" ShowFooter="true" OnItemCommand="RGChiTietPhieuTU2_ItemCommand"
                                    OnPageIndexChanged="RGChiTietPhieuTU2_PageIndexChanged" OnPageSizeChanged="RGChiTietPhieuTU2_PageSizeChanged">
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu EnableTheming="True">
                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                    </HeaderContextMenu>
                                    <GroupingSettings CaseSensitive="False" />
                                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView>
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                Groupable="False">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                <ItemTemplate>
                                                    <%# Container.DataSetIndex  + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="MÃ CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="TỈ GIÁ" UniqueName="TiGia" DataField="TiGia"
                                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                                HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                                Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" FilterControlWidth="100px" DataFormatString="{0:###,###.##}"
                                                AllowFiltering="false">
                                                <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Lydo" DataField="Lydo"
                                                FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
