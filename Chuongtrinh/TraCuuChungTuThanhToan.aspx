<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TraCuuChungTuThanhToan.aspx.cs" Inherits="Chuongtrinh_TraCuuChungTuThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function fConfirm(str) {
            if (confirm(str)) {
                return true;
            }
            else {
                return false;
            };
        };
    
     
    
    </script>
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
            <center>
                <table width="100%" cellpadding="0" cellspacing="0" id="topp">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                TRA CỨU CHỨNG TỪ THANH TOÁN
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
                <table>
                    <tr>
                        <td align="right">
                            Từ ngày:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdTuNgay" runat="server" Width="180px" Culture="Vietnamese (Vietnam)">
                                <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                    runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdTuNgay"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="right">
                            Đến ngày:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdDenNgay" runat="server" Width="180px" Culture="Vietnamese (Vietnam)">
                                <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                    runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rdDenNgay"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Thanh toán:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlThanhToan" runat="server" DataValueField="MaNV"
                                DataTextField="Ten" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlThanhToan_SelectedIndexChanged">
                                <asp:ListItem Value="0">Chưa thanh toán</asp:ListItem>
                                <asp:ListItem Value="1">Đã thanh toán</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlThanhToan"
                                Display="Dynamic" ErrorMessage="*." ValidationGroup="GInsert" ForeColor="Red">*</asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="right">
                            Chứng từ TM/NH:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlChungTu" runat="server" Width="180px" AutoPostBack="True"
                                OnSelectedIndexChanged="ddlChungTu_SelectedIndexChanged">
                                <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                                <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlChungTu"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="GInsert" ForeColor="Red">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Đơn vị:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlDonVi" runat="server" DataValueField="IDMaDV"
                                DataTextField="TenDonVi" Width="180px" AutoPostBack="True" 
                                onselectedindexchanged="ddlDonVi_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlDonVi"
                                Display="Dynamic" ErrorMessage="*" ValidationGroup="GInsert" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="11" align="center">
                            <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                ValidationGroup="GInsert" OnClick="btnXem_Click" />
                            &nbsp;<asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                Style="height: 23px" OnClick="btnLuu_Click" Visible="false" />
                            &nbsp;
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </center>
            <telerik:RadGrid ID="RG" Width="99%" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                GridLines="None" AllowFilteringByColumn="true" AllowPaging="True" AllowSorting="false"
                EnableLinqExpressions="false" Skin="Windows7" PageSize="10" AllowAutomaticInserts="True"
                AllowAutomaticUpdates="True" OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged"
                OnPageSizeChanged="RG_PageSizeChanged">
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
                    <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Người thanh toán" UniqueName="Hoten" DataField="Hoten"
                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="SoTien" DataField="SoTien"
                            FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                            FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                            FilterControlWidth="240px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="240px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="240px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Hạn thanh toán" UniqueName="HanThanhToan" DataField="HanThanhToan"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="KTKT" HeaderText="KT kiểm tra" UniqueName="KTKT"
                            AllowFiltering="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="ch_ThanhToan" Enabled="false" runat="server" Checked='<%# clsConvertHelper.Tobool(Eval("KTKT")) %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Chi tiết" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnChiTiet" runat="server" ImageUrl="~/images/Nutchuanweb/X.gif"
                                    CommandName="ChiTiet" CommandArgument='<%# Eval("SoPhieu")%>' /></ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Trả phiếu" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnTraPhieu" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                    CommandName="TraPhieu" CommandArgument='<%# Eval("SoPhieu")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings EditFormType="WebUserControl">
                        <EditColumn UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
            </telerik:RadGrid>
            <div>
                <telerik:RadGrid ID="RGQuaNganHang" Width="100%" runat="server" AutoGenerateColumns="False"
                    CellSpacing="0" GridLines="None" AllowFilteringByColumn="true" AllowPaging="True"
                    AllowSorting="false" EnableLinqExpressions="false" Skin="Windows7" PageSize="10"
                    AllowAutomaticInserts="True" AllowAutomaticUpdates="True" 
                    OnItemDataBound="RGQuaNganHang_ItemDataBound" 
                    onitemcommand="RGQuaNganHang_ItemCommand" 
                    onpageindexchanged="RGQuaNganHang_PageIndexChanged" 
                    onpagesizechanged="RGQuaNganHang_PageSizeChanged" 
                    onselectedcellchanged="RGQuaNganHang_SelectedCellChanged">
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
                        <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Người thanh toán" UniqueName="Hoten" DataField="Hoten"
                                FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="SoTien" DataField="SoTien"
                                FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                                FilterControlWidth="140px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Hạn thanh toán" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                    
                             <telerik:GridBoundColumn HeaderText="Ngân hàng" UniqueName="TenNH" DataField="TenNH"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <headerstyle horizontalalign="Left" verticalalign="Middle" width="100px" />
                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="100px" />
                                    </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Tên tài khoản" UniqueName="TenTaiKhoan" DataField="TenTaiKhoan"
                                        FilterControlWidth="140px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <headerstyle horizontalalign="Left" verticalalign="Middle" width="70px" />
                                        <itemstyle horizontalalign="Left" verticalalign="Middle" width="70px" />
                                    </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Số tài khoản" UniqueName="SoTaiKhoan" DataField="SoTaiKhoan"
                                        FilterControlWidth="140px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <headerstyle horizontalalign="Left" verticalalign="Middle" width="120px" />
                                        <itemstyle horizontalalign="Center" verticalalign="Middle" width="120px" />
                                    </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="KTKT" HeaderText="KT kiểm tra" UniqueName="KTKT"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ch_ThanhToan" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KTKT")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Chi tiết" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnChiTiet" runat="server" ImageUrl="~/images/Nutchuanweb/X.gif"
                                        CommandName="ChiTiet" CommandArgument='<%# Eval("SoPhieu")%>' /></ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn HeaderText="Trả phiếu" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnTraPhieu" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                    CommandName="TraPhieu" CommandArgument='<%# Eval("SoPhieu")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
            <asp:Label ID="LabelChiTietPTU" runat="server" Font-Size="Larger" ForeColor="#912E49"
                Text="CHI TIẾT CHỨNG TỪ THANH TOÁN" Visible="False" Width="403px"></asp:Label>
            <asp:Label ID="lbSoPhieu" runat="server" Font-Size="Larger" ForeColor="#912E49" Visible="False"
                Width="174px"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                CellPadding="3" Font-Bold="False" Font-Size="Smaller" PageSize="50" Width="99%">
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MCP" InsertVisible="False">
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="lbl_MCP" runat="server" Text='<%# Eval("MSChiPhi")%>' Width="90px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="T&#234;n v&#224; qui c&#225;ch">
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="lbl_diengiai" runat="server" Text='<%# Eval("TenvaQuiCach")%>' Width="280px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Số tiền">
                        <ItemStyle HorizontalAlign="Right" />
                        <ItemTemplate>
                            <asp:Label ID="txt_Tien" runat="server" Text='<%# Eval("TienThanhToan","{0:###,###,###}")%>'
                                Width="140px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Loại tiền">
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="lbl_LoaiTien" runat="server" Text='<%# Eval("LoaiTien")%>' Width="60px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ghi ch&#250;">
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:Label ID="lbl_Ghichu" runat="server" Text='<%# Eval("GhiChu")%>' Width="200px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#912E49" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
