<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh_XemXet.aspx.cs" Inherits="Chuongtrinh_LapToTrinh_XemXet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(SoToTrinh) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh_XemXet.aspx?SoToTrinh=" + SoToTrinh, "RadWindowManager1");
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
                MultiPageID="MultiPage" Skin="Windows7" OnTabClick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Xem xét tờ trình" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem lại tờ trình đã xem xét">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem tờ trình đã duyệt">
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
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Chọn tờ trình cần xem xét</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="true"
                                            Skin="Windows7" MinValue="2000" OnTextChanged="rnNam_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rnNam"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET"
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
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnThang"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET"
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
                                            Skin="Windows7" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="185px" DataTextField="MaTen"
                                            Visible="true" Skin="Windows7" DataValueField="MAPD" DropDownWidth="185px" HighlightTemplatedItems="true"
                                            EnableLoadOnDemand="true" AutoPostBack="true" OnSelectedIndexChanged="cbNguoiPheDuyet_SelectedIndexChanged">
                                            <ItemTemplate>
                                                <%#Eval("MaTen")%>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cbNguoiPheDuyet"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Xem xét:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbXemXet" runat="server" Width="100px" Skin="Windows7" ValidationGroup="GXEMXET"
                                            AutoPostBack="true" OnSelectedIndexChanged="cbXemXet_SelectedIndexChanged">
                                            <Items>
                                                <telerik:RadComboBoxItem Value="False" Text="Chưa xem xét" />
                                                <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td colspan="20" align="center">
                                        <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtPheDuyet" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtToTrinh" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                    <td colspan="20" align="center">
                                        <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:TextBox ID="txtChucVuNguoiNhan" runat="server" Width="180px" Enabled="false"
                                            Visible="false"></asp:TextBox>
                                    </td>
                                    <td colspan="20" align="center">
                                        <asp:TextBox ID="txtBoPhanNhan" runat="server" Width="180px" Enabled="false" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Chi tiết tờ trình</legend>
                            <telerik:RadGrid ID="RGChiTietToTrinh" runat="server" AutoGenerateColumns="False"
                                Width="100%" CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                Skin="Windows7" ShowFooter="True">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                        </telerik:GridBoundColumn>
                                        <%-- <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                            HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" FilterControlWidth="100px" DataFormatString="{0:###,###.##}"
                                            AllowFiltering="false">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn DataField="SoTien" HeaderText="S.TIỀN" UniqueName="SoTien">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="rnSoTien_PD" runat="server" Value='<%#clsConvertHelper.ToDouble(Eval("SoTien")) %>'
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
                                        <%--<telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="300px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="300px" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn DataField="GhiChu" HeaderText="GHI CHÚ" UniqueName="GhiChu">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtGhiChu" Text='<%# Eval("GhiChu") %>' runat="server" Width="250px"
                                                    Height="25px" AutoPostBack="True" OnTextChanged="txtGhiChu_TextChanged"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="280px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="280px" />
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
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Chọn tờ trình cần xem </legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam2" runat="server" Width="70px" AutoPostBack="true"
                                            Skin="Windows7" MinValue="2000" OnTextChanged="rnNam2_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rnNam2"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Tháng:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnThang2" runat="server" Width="60px" MaxValue="12"
                                            Skin="Windows7" MinValue="1" AutoPostBack="true" OnTextChanged="rnThang2_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="rnThang2"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Tờ trình:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cboToTrinh2" runat="server" Width="150px" DataTextField="HT"
                                            Height="200px" DropDownWidth="200px" Skin="Windows7" DataValueField="SoToTrinh"
                                            HighlightTemplatedItems="true" EnableLoadOnDemand="true" AutoPostBack="true"
                                            OnSelectedIndexChanged="cboToTrinh2_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="cboToTrinh2"
                                            Skin="Windows7" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXEMXET2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Xem xét:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbXemXet2" runat="server" Width="100px" Skin="Windows7"
                                            ValidationGroup="GXEMXET2" AutoPostBack="true" OnSelectedIndexChanged="cbXemXet2_SelectedIndexChanged">
                                            <Items>
                                                <telerik:RadComboBoxItem Value="True" Text="Đã xem xét" />
                                                <telerik:RadComboBoxItem Value="False" Text="Bỏ xem xét" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:Label ID="lbLoi2" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="20" align="center">
                                        <asp:TextBox ID="txtToTrinh2" runat="server" Width="180px" Enabled="false" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Chi tiết tờ trình</legend>
                            <telerik:RadGrid ID="RG2" runat="server" AutoGenerateColumns="False" Width="100%"
                                CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                                Skin="Windows7" ShowFooter="True">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="SoTien" HeaderText="S.TIỀN" UniqueName="SoTien">
                                            <ItemTemplate>
                                                <telerik:RadNumericTextBox ID="rnSoTien_PD2" runat="server" Value='<%#clsConvertHelper.ToDouble(Eval("SoTien")) %>'
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
                                        <telerik:GridTemplateColumn DataField="GhiChu" HeaderText="GHI CHÚ" UniqueName="GhiChu">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtGhiChu2" Text='<%# Eval("GhiChu") %>' runat="server" Width="250px"
                                                    Height="25px" AutoPostBack="True" OnTextChanged="txtGhiChu2_TextChanged"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="280px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="280px" />
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
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Chọn năm - tháng cần xem</legend>
                            <center>
                                <table border="0">
                                    <tr>
                                        <td align="right">
                                            Năm:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="true"
                                                Skin="Windows7" ontextchanged="rnNam_Xem_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnNam_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tháng:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnThang_Xem" runat="server" Width="70px" MaxValue="12"
                                                Skin="Windows7" MinValue="1" AutoPostBack="true" 
                                                ontextchanged="rnThang_Xem_TextChanged">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnThang_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                       <%-- <td>
                                            <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                                ValidationGroup="GExcel" OnClick="btnXem_Click" />
                                        </td>--%>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                    </div>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Danh sách tờ trình</legend>
                            <telerik:RadGrid ID="RG_XemToTrinh" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                Skin="Windows7" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0" GridLines="None"
                                AllowFilteringByColumn="true" OnItemCommand="RG_XemToTrinh_ItemCommand">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Selecting AllowRowSelect="false" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None">
                                    <CommandItemSettings AddNewRecordText="Thêm mới" />
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                    CommandName="PRINT" /></ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                            <ItemTemplate>
                                                <a style="cursor: pointer" onclick="openRadWindowShow('<%#Eval("SoToTrinh") %>')">
                                                    <img id="Img1" runat="server" alt="" border="0" height="16" src="../images/detail.png" /></a>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                            FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                            HeaderText="NĂM" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px"
                                            Visible="false" AllowFiltering="false">
                                            <HeaderStyle Width="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="30px" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                            Visible="false" CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="30px" AllowFiltering="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ BP" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiGoi" FilterControlAltText="Filter NguoiGoi column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="NguoiGoi" UniqueName="NguoiGoi" AllowFiltering="false"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px">
                                            <HeaderStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongTien" FilterControlAltText="Filter TongTien column"
                                            HeaderText="TỔNG TIỀN" ReadOnly="True" SortExpression="SoTien" UniqueName="TongTien"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="VeViec" FilterControlAltText="Filter VeViec column"
                                            HeaderText="GHI CHÚ" ReadOnly="True" SortExpression="VeViec" UniqueName="VeViec"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" AllowFiltering="false">
                                            <HeaderStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="HL-XX" UniqueName="KiemTra"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="HieuLucPD" HeaderText="HL-PD" UniqueName="HieuLucPD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="PheDuyet" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLucPD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
