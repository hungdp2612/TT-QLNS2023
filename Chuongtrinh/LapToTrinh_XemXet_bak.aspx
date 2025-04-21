<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh_XemXet_bak.aspx.cs" Inherits="Chuongtrinh_LapToTrinh_XemXet" %>

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
                MultiPageID="MultiPage">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Xem xét tờ trình" Selected="True">
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
                        <legend>Chọn tờ trình cần xem xét bằng cách chọn 1 dòng trên lưới</legend>
                        <center>
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="right">
                                                    Người xem xét:
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtNguoiGui" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                                </td>
                                                <td align="right">
                                                    Người nhận:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="185px" DataTextField="MaTen"
                                                        Skin="Windows7" DataValueField="MAPD" DropDownWidth="185px" HighlightTemplatedItems="true"
                                                        EnableLoadOnDemand="true" AutoPostBack="true" OnSelectedIndexChanged="cbNguoiPheDuyet_SelectedIndexChanged">
                                                        <ItemTemplate>
                                                            <%#Eval("MaTen")%>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cbNguoiPheDuyet"
                                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Xem xét:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadComboBox ID="cbXemXet" runat="server" Width="185px" Skin="Windows7">
                                                        <Items>
                                                            <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                                            <telerik:RadComboBoxItem Value="False" Text="Bỏ xem xét" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td align="right">
                                                    Bộ phận nhận:
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtBoPhanNhan" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                    </td>
                                </tr>
                            </table>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                    <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="10">
                                    <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="10">
                                    <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtPheDuyet" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtChucVuNguoiNhan" runat="server" Width="180px" Enabled="false"
                                        Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            </table>
                        </center>
                    </fieldset>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Danh sách tờ trình</legend>
                            <telerik:RadGrid ID="RGToTrinh" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                AllowFilteringByColumn="true" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0"
                                Skin="Windows7" GridLines="None" OnItemCommand="RGToTrinh_ItemCommand">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoToTrinh">
                                    <CommandItemSettings AddNewRecordText="Thêm mới" />
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderText="CHỌN">
                                            <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridTemplateColumn HeaderText="EMAIL" AllowFiltering="false" Visible="false">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnEmail" runat="server" ImageUrl="~/images/Nutchuanweb/icon_email.png"
                                                    Visible='<%#!clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' CommandName="Email" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                    CommandName="PRINT" Visible='<%#clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' /></ItemTemplate>
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
                                            Visible="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="30px" Visible="true" AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ BP" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiGoi" FilterControlAltText="Filter NguoiGoi column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="NguoiGoi" UniqueName="NguoiGoi"
                                            AllowFiltering="false" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
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
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
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
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
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
                                            <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="false"
                                                Skin="Windows7">
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
                                                Skin="Windows7" MinValue="1" AutoPostBack="false">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnThang_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                                ValidationGroup="GExcel" OnClick="btnXem_Click" />
                                        </td>
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
                                            Visible="true" AllowFiltering="false">
                                            <HeaderStyle Width="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="30px" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="30px" Visible="true" AllowFiltering="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="30px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ BP" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiGoi" FilterControlAltText="Filter NguoiGoi column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="NguoiGoi" UniqueName="NguoiGoi"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px">
                                            <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
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
