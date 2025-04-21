<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ThanhToanHopDong.aspx.cs" Inherits="Chuongtrinh_ThanhToanHopDong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript">




                function openRadWindowShow2(sophieu, LoaiTien, TiGia) {
                    var manager2 = $find("<%= RadWindowManager2.ClientID %>");
                    var oWnd2 = manager2.open("ChiTietThanhToanHopDong.aspx?sophieu=" + sophieu + "&LoaiTien=" + LoaiTien + "&TiGia=" + TiGia, "RadWindowManager2");
                    oWnd2.Center();
                }
                function OnClientClose2() {
                    __doPostBack('fLoad', '');
                }
              
            </script>
            <br />
            <center>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
            </center>
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
                                <asp:DropDownList Enabled="false" ID="ddlNguoiDuocThanhToan2" runat="server" DataValueField="MaNV"
                                    DataTextField="Ten" Width="180px" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlNguoiDuocThanhToan2"
                                    Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Hình thức thanh toán:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlHinhThucThanhToan2" runat="server" Width="180px" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddlHinhThucThanhToan2_SelectedIndexChanged">
                                    <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                                    <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlHinhThucThanhToan2"
                                    Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
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
                                <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi2" runat="server" DataValueField="MaNV"
                                    DataTextField="Ten" Width="180px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td align="right">
                                Phương thức thanh toán:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlPhuongThucThanhToan2" runat="server" Width="180px" AutoPostBack="True">
                                    <asp:ListItem Value="TTML">Thanh toán một lần</asp:ListItem>
                                    <asp:ListItem Value="TTTP">Thanh toán từng phần</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlPhuongThucThanhToan2"
                                    Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Ngân hàng:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtNganHang2" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Loại tiền:
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLoaiTien2" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                                    Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien2_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlLoaiTien2"
                                    Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td align="right">
                                Hạn thanh toán:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <telerik:RadDatePicker ID="rdHanThanhToan2" runat="server" Width="180px" Culture="Vietnamese (Vietnam)">
                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                        ViewSelectorText="x" runat="server">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                        runat="server">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="rdHanThanhToan2"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Tên tài khoản:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtTenTaiKhoan2" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Tỉ giá:
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnTiGia2" runat="server" Culture="Vietnamese (Vietnam)"
                                    Width="70px" Enabled="false">
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="rnTiGia2"
                                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="right">
                                Số tài khoản:
                            </td>
                            <td width="10px">
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtSoTaiKhoan2" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Ghi chú:
                            </td>
                            <td style="width: 10px">
                                &nbsp;
                            </td>
                            <td align="left" colspan="10">
                                <asp:TextBox ID="txtNoiDung2" runat="server" Height="25px" Width="99%"></asp:TextBox>
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
                    <table cellpadding="2" cellspacing="2" border="0">
                        <tr>
                            <td align="center">
                                <asp:ImageButton ID="btnLuu2" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                    ValidationGroup="GInsert" OnClick="btnLuu2_Click" />
                            </td>
                        </tr>
                    </table>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bgtieudebox">
                                <center>
                                    GIẤY THANH TOÁN HỢP ĐỒNG
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <telerik:RadGrid ID="RGKhongTamUng" runat="server" Width="1000px" AutoGenerateColumns="False"
                                    EnableLinqExpressions="False" GridLines="None" AllowFilteringByColumn="True"
                                    AllowPaging="True" AllowSorting="True" PageSize="10" Skin="Windows7" OnDeleteCommand="RGKhongTamUng_DeleteCommand"
                                    OnPageIndexChanged="RGKhongTamUng_PageIndexChanged" OnPageSizeChanged="RGKhongTamUng_PageSizeChanged"
                                    OnItemCommand="RGKhongTamUng_ItemCommand" OnCancelCommand="RGKhongTamUng_CancelCommand"
                                    OnUpdateCommand="RGKhongTamUng_UpdateCommand">
                                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <MasterTableView>
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                Groupable="False">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemTemplate>
                                                    <%# Container.DataSetIndex  + 1%>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                                HeaderText="Sửa" EditText="Sửa">
                                                <ItemStyle />
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                                ConfirmText="Bạn có chắc muốn xóa không?" Text="Xóa">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="Chi tiết" UniqueName="ChiTiet"
                                                AllowFiltering="False" Groupable="False">
                                                <ItemTemplate>
                                                    <a onclick="openRadWindowShow2('<%#Eval("SoPhieu") %>','<%#Eval("LoaiTien") %>','<%#Eval("Tigia") %>')">
                                                        <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("BPTCKTKiemtra")) %>' />
                                                    </a>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="In" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                        CommandName="PRINT" /></ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="Phiếu chứng từ" UniqueName="SoPhieu"
                                                FilterControlWidth="60px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Mã BP" UniqueName="MADV" DataField="MADV" FilterControlWidth="50px"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="LaTienmat" HeaderText="HTTT" UniqueName="LaTienmat"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="PhuongThucTT" HeaderText="PTTT" UniqueName="PhuongThucTT"
                                                FilterControlWidth="40px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="NganHang" HeaderText="Ngân hàng" UniqueName="NganHang"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TenTaiKhoan" HeaderText="Tên TK" UniqueName="TenTaiKhoan"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="SoTaiKhoan" HeaderText="Số TK" UniqueName="SoTaiKhoan"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="Loại tiền" UniqueName="LoaiTien"
                                                AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="Tigia" HeaderText="Tỉ giá" UniqueName="Tigia"
                                                AllowFiltering="false">
                                                <ItemTemplate>
                                                    <%# String.Format("{0:0,0}", Eval("Tigia"))%>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="SoTien" HeaderText="Số tiền TT(VND)" UniqueName="SoTien"
                                                AllowFiltering="false" ShowFilterIcon="false">
                                                <ItemTemplate>
                                                    <%# String.Format("{0:0,0}", Eval("SoTien")) %>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="Hạn thanh toán" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Ghi chú" DataField="NoiDung" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                            </telerik:GridBoundColumn>
                                            <%-- <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="ĐV Kiểm tra" UniqueName="KiemTra"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                </telerik:GridTemplateColumn>--%>
                                            <telerik:GridTemplateColumn DataField="BPTCKTKiemtra" HeaderText="Kế toán KT" UniqueName="BPTCKTKiemtra"
                                                AllowFiltering="False">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbhieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("BPTCKTKiemtra")) %>' />
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
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
