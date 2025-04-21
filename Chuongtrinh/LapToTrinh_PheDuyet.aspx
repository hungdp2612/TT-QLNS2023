<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh_PheDuyet.aspx.cs" Inherits="Chuongtrinh_LapToTrinh_PheDuyet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(SoToTrinh) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh_PheDuyet.aspx?SoToTrinh=" + SoToTrinh, "RadWindowManager1");
            oWnd.Center();
        }
        function openRadWindowShow2(SoToTrinh) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh_PheDuyet.aspx?SoToTrinh=" + SoToTrinh, "RadWindowManager1");
            oWnd.Center();
        }

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
            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" AutoPostBack="true"
                Skin="Windows7" MultiPageID="MultiPage" OnTabClick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Phê duyệt tờ trình" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem tờ trình đã phê duyệt">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="margin-top: 10px">
            </div>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="false" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
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
                    <div>
                        <fieldset style="margin-left: 5px; width: 970px;">
                            <legend>Chọn đơn vị</legend>
                            <center>
                                <table style="margin: 10px 0 10px 0">
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbDonVi" runat="server" Width="180px" DataTextField="TenDonVi"
                                                DropDownWidth="220px" Skin="Windows7" DataValueField="MaDonVi" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" AutoPostBack="true" Height='150px' OnSelectedIndexChanged="cbDonVi_SelectedIndexChanged"
                                                OnItemsRequested="cbDonVi_ItemsRequested">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="cbDonVi"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GPheDuyet"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Năm:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="true"
                                                Skin="Windows7" MinValue="2000" OnTextChanged="rnNam_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rnNam"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GPheDuyet"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tháng:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="60px" MaxValue="12"
                                                Skin="Windows7" MinValue="1" AutoPostBack="true" OnTextChanged="rnThang_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rnThang"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GPheDuyet"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tờ trình:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cboToTrinh" runat="server" Width="150px" DataTextField="HT"
                                                DropDownWidth="200px" Skin="Windows7" DataValueField="SoToTrinh" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="false" AutoPostBack="true" OnSelectedIndexChanged="cboToTrinh_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboToTrinh"
                                                Skin="Windows7" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GPheDuyet"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="RadCBoPD" Skin="Windows7" runat="server" AutoPostBack="true"
                                                Width="100px" ValidationGroup="GPheDuyet" OnSelectedIndexChanged="RadCBoPD_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Chưa duyệt" Value="False" />
                                                    <telerik:RadComboBoxItem Text="Duyệt" Value="True" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="20">
                                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="20">
                                            <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtToTrinh" runat="server" Visible="false" Width="180px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                    </div>
                    <div>
                        <fieldset style="margin-left: 5px; width: 970px;">
                            <legend>Chi tiết tờ trình</legend>
                            <telerik:RadGrid ID="RGChiTietToTrinh" runat="server" AutoGenerateColumns="False"
                                Skin="Windows7" CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                ShowFooter="True" Visible="true">
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
                                        <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                            HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                            <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="SoTien" HeaderText="S.TIỀN PD" UniqueName="SoTienPD">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="rnSoTien_PD" runat="server" Value='<%#fInt(Eval("SoTien")) %>'
                                                    AutoPostBack="True" OnTextChanged="rnSoTien_PD_TextChanged" Width="100px">
                                                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="GhichuDuyet" HeaderText="GHI CHÚ BTGĐ" UniqueName="GhichuDuyet">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtGhiChuDuyet" Text='<%# Eval("GhichuDuyet") %>' runat="server"
                                                    Width="180px" AutoPostBack="True" OnTextChanged="txtGhiChuDuyet_TextChanged"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Chọn đơn vị, năm - tháng cần xem</legend>
                            <center>
                                <table border="0">
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="ddlDonVi_XemLai" runat="server" Width="200px" DataTextField="TenDonVi"
                                                Skin="Windows7" DataValueField="MaDonVi" DropDownWidth="220px" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" AutoPostBack="true" Height='150px' OnItemsRequested="ddlDonVi_XemLai_ItemsRequested"
                                                OnSelectedIndexChanged="ddlDonVi_XemLai_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlDonVi_XemLai"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Năm:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="true"
                                                Skin="Windows7" OnTextChanged="rnNam_Xem_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnNam_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tháng:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnThang_Xem" runat="server" Width="60px" MaxValue="12"
                                                Skin="Windows7" MinValue="1" AutoPostBack="true" OnTextChanged="rnThang_Xem_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rnThang_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tờ trình:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cboToTrinh2" runat="server" Width="150px" Height="200px"
                                                DataTextField="HT" DropDownWidth="200px" Skin="Windows7" DataValueField="SoToTrinh"
                                                HighlightTemplatedItems="true" EnableLoadOnDemand="true" AutoPostBack="true"
                                                OnSelectedIndexChanged="cboToTrinh2_SelectedIndexChanged" OnItemsRequested="cboToTrinh2_ItemsRequested">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="cboToTrinh2"
                                                Skin="Windows7" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cboBoPheDuyet" Skin="Windows7" runat="server" AutoPostBack="true"
                                                Width="100px" ValidationGroup="GXem" OnSelectedIndexChanged="cboBoPheDuyet_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Đã duyệt" Value="True" />
                                                    <telerik:RadComboBoxItem Text="Bỏ duyệt" Value="False" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="hl_EmailBoDuyet" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="20" align="center">
                                            <asp:Label runat="server" ID="lbXemLaiToTrinh"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="20" align="center">
                                            <asp:Label runat="server" ID="lbXemLai_Email"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="20" align="center">
                                            <asp:TextBox ID="txtToTrinh2" runat="server" Visible="false" Width="180px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                    </div>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Tờ trình</legend>
                            <telerik:RadGrid ID="RG_XemLai" runat="server" AutoGenerateColumns="False" Skin="Windows7"
                                CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                ShowFooter="True" Visible="true">
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
                                        <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                            HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                            Visible="false">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                            <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="SoTien" HeaderText="S.TIỀN PD" UniqueName="SoTien">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="rnSoTien_PD2" runat="server" Value='<%#fInt(Eval("SoTien")) %>'
                                                    AutoPostBack="True" OnTextChanged="rnSoTien_PD2_TextChanged" Width="100px">
                                                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                                </telerik:RadNumericTextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="GhichuDuyet" HeaderText="GHI CHÚ BTGĐ" UniqueName="GhichuDuyet">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtGhiChuDuyet2" Text='<%# Eval("GhichuDuyet") %>' runat="server"
                                                    Width="180px" AutoPostBack="True" OnTextChanged="txtGhiChuDuyet2_TextChanged"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
