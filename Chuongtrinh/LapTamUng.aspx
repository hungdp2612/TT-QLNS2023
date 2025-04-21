<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapTamUng.aspx.cs" Inherits="Chuongtrinh_LapTamUng" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(phieutamung, MaDV, nam, thang) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd;

            oWnd = manager.open("ChiTietPhieuTamUng.aspx?PhieuTamUng=" + phieutamung + "&MaDV=" + MaDV + "&nam=" + nam + "&thang=" + thang, "RadWindowManager1");


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
            <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                VisibleTitlebar="False" Width="998px">
                <ContentTemplate>
                    <center>
                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" />
                            </ProgressTemplate>
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
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Nhập thông tin phiếu tạm ứng</legend>
                <center>
                    <table>
                        <tr>
                            <td align="right">Tên đơn vị:
                            </td>
                            <td style="width: 10px"></td>
                            <td align="left">
                                <asp:TextBox ID="txtTenDonVi" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="right">Nhân viên tạm ứng:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left">
                                <asp:DropDownList Enabled="false" ID="ddlNguoiThanhToan" runat="server" DataValueField="MaNV"
                                    DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlNguoiThanhToan"
                                    Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="GInsert"
                                    ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Phụ trách đơn vị:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left">
                                <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                    DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="right">Năm:
                            </td>
                            <td width="10px"></td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    OnTextChanged="rnNam_TextChanged" Enabled="false" Skin="Windows7">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Loại tiền:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLoaiTien" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                                    Skin="Windows7" Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlLoaiTien"
                                    Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="right">Tháng:
                            </td>
                            <td width="10px"></td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" MaxValue="12"
                                    MinValue="1" Enabled="true" Skin="Windows7">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Tỉ giá:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                                    Width="70px" Enabled="false" Skin="Windows7">
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                 <a id="Links" target="_blank" href="https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1" style="color: blue" > Bảng Tỉ Giá </a>
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="right">Hạn thanh toán:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left">
                                <telerik:RadDatePicker ID="rdHanThanhToan" runat="server" Width="180px" Culture="Vietnamese (Vietnam)">
                                    <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                        Skin="Windows7" ViewSelectorText="x" runat="server">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                        runat="server">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rdHanThanhToan"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Hình thức tạm ứng:
                            </td>
                            <td style="width: 10px"></td>
                            <td>
                                <telerik:RadComboBox ID="rdHinhThucTamUng" runat="server" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="rdHinhThucTamUng_SelectedIndexChanged">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Value="TM" Text="Tiền mặt" />
                                        <telerik:RadComboBoxItem runat="server" Value="CK" Text="Chuyển khoản" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>

                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="right">Tài khoản ngân hàng:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rdTaiKhoanNganHang" runat="server" Width="100%" Height="200px" EmptyMessage="Chọn tài khoản ngân hàng..."
                                    DataTextField="SoTaiKhoan" DataValueField="SoTaiKhoan" MarkFirstMatch="true" Filter="Contains"
                                    EnableLoadOnDemand="true" HighlightTemplatedItems="true" ShowMoreResultsBox="true"
                                    EnableVirtualScrolling="true" DropDownAutoWidth="Enabled" AutoPostBack="True" Enabled="false">
                                    <HeaderTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 100px;">Ngân hàng
                                                </td>
                                                <td style="width: 120px;">Số tài khoản
                                                </td>
                                                <td style="width: 150px;">Họ tên
                                                </td>
                                                <td style="width: 150px;">Đơn vị
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 100px;">
                                                    <%# DataBinder.Eval(Container.DataItem, "TenNganHang") %>
                                                </td>
                                                <td style="width: 120px;">
                                                    <%# DataBinder.Eval(Container.DataItem, "SoTaiKhoan") %>
                                                </td>
                                                <td style="width: 150px;">
                                                    <%# DataBinder.Eval(Container.DataItem, "TenTaiKhoan") %>
                                                </td>
                                                <td style="width: 150px;">
                                                    <%# DataBinder.Eval(Container.DataItem, "MADV") %>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Nội dung:
                            </td>
                            <td style="width: 10px">&nbsp;
                            </td>
                            <td align="left" colspan="5">
                                <asp:TextBox ID="txtNoiDung" runat="server" Height="25px" Width="100%" Skin="Windows7"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="20" align="center">
                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMaDV"
                                    Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Danh sách phiếu tạm ứng</legend>
                <telerik:RadGrid ID="RG" Width="970px" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" CellSpacing="0" GridLines="None" AllowFilteringByColumn="True"
                    AllowPaging="True" AllowSorting="false" EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand"
                    OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="50"
                    AllowAutomaticInserts="True" AllowAutomaticUpdates="True">
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                    <GroupingSettings CaseSensitive="False" />
                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
                    <MasterTableView>
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
                                HeaderText="SỬA" EditText="SỬA">
                                <ItemStyle />
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa không?" Text="Xóa" HeaderText="XÓA">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="CHI TIẾT" UniqueName="ChiTiet"
                                AllowFiltering="False" Groupable="False">
                                <ItemTemplate>
                                    <a onclick="openRadWindowShow('<%#Eval("PhieuTU") %>','<%#Eval("MaDV") %>','<%#Eval("Nam") %>','<%#Eval("Thang") %>')">
                                        <img id="Img1" runat="server" alt="" border="0" src="../images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("KTKiemTra")) %>' />
                                    </a>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                        CommandName="PRINT" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderText="PHIẾU TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="30px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="NgayLap_HienThi" DataField="NgayLap_HienThi"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TỈ GIÁ" UniqueName="TiGia" DataField="TiGia"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TỔNG TIỀN" UniqueName="TongTien" DataField="TongTien"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="LÝ DO" UniqueName="LyDo" DataField="LyDo" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="HÌNH THỨC TẠM ỨNG" UniqueName="HinhThucTamUng" DataField="HinhThucTamUng" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NGÂN HÀNG" UniqueName="TenNganhang" DataField="TenNganhang" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="SỐ TÀI KHOẢN" UniqueName="SoTaiKhoan" DataField="SoTaiKhoan" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TÊN TÀI KHOẢN" UniqueName="TenTaiKhoan" DataField="TenTaiKhoan" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="KTKiemTra" HeaderText="KTKT" UniqueName="KTKiemTra"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KTKiemTra")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
