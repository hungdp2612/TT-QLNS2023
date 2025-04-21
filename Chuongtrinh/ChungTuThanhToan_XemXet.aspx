<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChungTuThanhToan_XemXet.aspx.cs" Inherits="Chuongtrinh_ChungTuThanhToan_XemXet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript">


                function openRadWindowShow(sophieu, MaDV) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd = manager.open("ChiTietThanhToanTamUng.aspx?sophieu=" + sophieu + "&MaDV=" + MaDV, "RadWindowManager1");
                    oWnd.Center();
                }

                function OnClientClose() {
                    __doPostBack('fLoad', '');
                }


                function openRadWindowShow2(sophieu, LoaiTien, TiGia) {
                    var manager2 = $find("<%= RadWindowManager2.ClientID %>");
                    var oWnd2 = manager2.open("ChiTietThanhToanKhongTamUng.aspx?sophieu=" + sophieu + "&LoaiTien=" + LoaiTien + "&TiGia=" + TiGia, "RadWindowManager2");
                    oWnd2.Center();
                }
                function OnClientClose2() {
                    __doPostBack('fLoad', '');
                }
               

            </script>
            <br />
            <telerik:radtabstrip id="RadTabStrip1" runat="server" selectedindex="0" multipageid="MultiPage"
                autopostback="True" ontabclick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Xem xét thanh toán tạm ứng" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem xét thanh toán không tạm ứng">
                    </telerik:RadTab>
                  
                </Tabs>
            </telerik:radtabstrip>
            <div style="height: 20px;">
            </div>
            <center>
                <telerik:radnotification id="RadNotification1" runat="server" autoclosedelay="0"
                    height="40px" position="BottomCenter" showclosebutton="False" visibleonpageload="True"
                    visibletitlebar="False" width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:radnotification>
            </center>
            <telerik:radwindowmanager style="z-index: 7001" showcontentduringload="false" autosize="false"
                enableshadow="true" id="RadWindowManager3" runat="server" keepinscreenbounds="True"
                width="1050px" height="700px" visiblestatusbar="false" destroyonclose="True"
                enableviewstate="False" initialbehaviors="Maximize">
                <Shortcuts>
                    <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                </Shortcuts>
                <Windows>
                    <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize" VisibleStatusbar="false"
                        ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True" KeepInScreenBounds="true"
                        InitialBehaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:radwindowmanager>
            <telerik:radmultipage id="MultiPage" runat="server" width="100%" selectedindex="0"
                height="100%">
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
                                    Tên đơn vị:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTenDonVi" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Người được thanh toán:
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <asp:DropDownList Enabled="true" ID="ddlNguoiThanhToan" runat="server" DataValueField="MaNV"
                                        DataTextField="HoTen" Width="180px" AutoPostBack="True" 
                                        onselectedindexchanged="ddlNguoiThanhToan_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlNguoiThanhToan"
                                        Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Phụ trách đơn vị:
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <asp:DropDownList Enabled="false" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                        DataTextField="Ten" Width="180px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Ngày xem xét:
                                </td>
                                <td width="10px">
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdNgayXemXet" runat="server" Width="180px" Culture="Vietnamese (Vietnam)" Enabled="false">
                                        <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            ViewSelectorText="x" runat="server">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                            runat="server">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rdNgayXemXet"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td align="left">
                                    <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtMaDV"
                                        Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <div style="float: left; width: 1000px;">
                            <div style="float: left; width: 500px;">
                                <fieldset style="width: 500px">
                                    <legend>Phiếu thanh toán tạm ứng</legend>
                                    <telerik:RadGrid ID="RGTTTU" runat="server" Height="300px" AllowPaging="True" AllowFilteringByColumn="True"
                                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                        Skin="Windows7" PageSize="6" ShowFooter="True" CellSpacing="0" 
                                        GridLines="None" onitemcommand="RGTTTU_ItemCommand" 
                                        onpageindexchanged="RGTTTU_PageIndexChanged" 
                                        onpagesizechanged="RGTTTU_PageSizeChanged" 
                                        onselectedindexchanged="RGTTTU_SelectedIndexChanged" 
                                        onitemdatabound="RGTTTU_ItemDataBound">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoPhieu">
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
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" >
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false" 
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                       <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Số tiền (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Xem xét" UniqueName="KiemTra" ShowFilterIcon="false"
                                                    AllowFiltering="false" FilterControlWidth="60px">
                                                    <HeaderStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="cbKiemTra" Width="100px" runat="server" AutoPostBack="true"
                                                            OnSelectedIndexChanged="cbKiemTra_SelectedIndexChanged">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Value="false" Text="Chưa xem xét" />
                                                                <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        <asp:HiddenField ID="hfKiemTra" runat="server" Value='<%# Eval("KiemTra") %>' />
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
                                    <legend>Chi tiết phiếu thanh toán tạm ứng</legend>
                                    <telerik:RadGrid ID="RGCTTTTU" runat="server" Width="450px" Height="300px" AutoGenerateColumns="False"
                                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                                        AllowSorting="false" ShowStatusBar="True" EnableLinqExpressions="False" ShowFooter="true"
                                        Skin="Windows7" PageSize="10">
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                        <HeaderContextMenu EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </HeaderContextMenu>
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
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
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                   <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                               
                                                <telerik:GridBoundColumn DataField="TienThanhToan" FilterControlAltText="Filter TienThanhToan column"
                                                    HeaderText="Số tiền" ReadOnly="True" SortExpression="Sotien" UniqueName="TienThanhToan"
                                                    FooterStyle-Font-Bold="true" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                                    <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle"/>
                                                    <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
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
                    </center>
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
                                    Tên đơn vị:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTenDonVi2" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Người được thanh toán:
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <asp:DropDownList Enabled="true" ID="ddlNguoiThanhToan2" runat="server" DataValueField="MaNV"
                                        DataTextField="HoTen" Width="180px" AutoPostBack="True" 
                                        onselectedindexchanged="ddlNguoiThanhToan2_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlNguoiThanhToan2"
                                        Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Phụ trách đơn vị:
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <asp:DropDownList Enabled="false" ID="ddlPhuTrachDonVi2" runat="server" DataValueField="MaNV"
                                        DataTextField="Ten" Width="180px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="right">
                                    Ngày xem xét:
                                </td>
                                <td width="10px">
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdNgayXemXet2" runat="server" Width="180px" Culture="Vietnamese (Vietnam)" Enabled="false">
                                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            ViewSelectorText="x" runat="server">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                            runat="server">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="rdNgayXemXet2"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td align="left">
                                    <asp:TextBox ID="txtMaDV2" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtMaDV2"
                                        Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIDMaCS2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtMaBP2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <div style="float: left; width: 1000px;">
                            <div style="float: left; width: 500px;">
                                <fieldset style="width: 500px">
                                    <legend>Phiếu thanh toán không tạm ứng</legend>
                                    <telerik:RadGrid ID="RGTTKTU" runat="server" Height="300px" AllowPaging="True" AllowFilteringByColumn="True"
                                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                        Skin="Windows7" PageSize="6" ShowFooter="True" CellSpacing="0" 
                                        GridLines="None" onitemcommand="RGTTKTU_ItemCommand" 
                                        onitemdatabound="RGTTKTU_ItemDataBound" 
                                        onpageindexchanged="RGTTKTU_PageIndexChanged" 
                                        onpagesizechanged="RGTTKTU_PageSizeChanged" 
                                        onselectedindexchanged="RGTTKTU_SelectedIndexChanged">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                        </ClientSettings>
                                          <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoPhieu">
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
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" >
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false" 
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                       <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Số tiền (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Xem xét" UniqueName="KiemTra" ShowFilterIcon="false"
                                                    AllowFiltering="false" FilterControlWidth="60px">
                                                    <HeaderStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemTemplate>
                                                        <telerik:RadComboBox ID="cbKiemTraKTU" Width="100px" runat="server" AutoPostBack="true"
                                                            OnSelectedIndexChanged="cbKiemTraKTU_SelectedIndexChanged">
                                                            <Items>
                                                                <telerik:RadComboBoxItem Value="false" Text="Chưa xem xét" />
                                                                <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        <asp:HiddenField ID="hfKiemTraKTU" runat="server" Value='<%# Eval("KiemTra") %>' />
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
                                    <legend>Chi tiết phiếu thanh toán không tạm ứng</legend>
                                    <telerik:RadGrid ID="RGCTTTKTU" runat="server" Width="450px" Height="300px" AutoGenerateColumns="False"
                                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                                        AllowSorting="false" ShowStatusBar="True" EnableLinqExpressions="False" ShowFooter="true"
                                        Skin="Windows7" PageSize="10">
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                        <HeaderContextMenu EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </HeaderContextMenu>
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
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
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                  <%-- <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                               
                                                <telerik:GridBoundColumn DataField="TienThanhToan" FilterControlAltText="Filter TienThanhToan column"
                                                    HeaderText="Số tiền" ReadOnly="True" SortExpression="Sotien" UniqueName="TienThanhToan"
                                                    FooterStyle-Font-Bold="true" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                                    <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle"/>
                                                    <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
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
                    </center>
                </telerik:RadPageView>
         
            </telerik:radmultipage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
