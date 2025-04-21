<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh_KeToan.aspx.cs" Inherits="Chuongtrinh_LapToTrinh_KeToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">

                function openRadWindowShow(SoToTrinh, madv, Nam, Thang) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd = manager.open("ChiTietToTrinh_KeToan.aspx?SoToTrinh=" + SoToTrinh + "&MaDV=" + madv + "&Nam=" + Nam + "&Thang=" + Thang, "RadWindowManager1");
                    oWnd.Center();
                }

                function OnClientClose() {
                    __doPostBack('fLoad', '');
                }
     
    
            </script>
            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage"
                AutoPostBack="True" OnTabClick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Lập tờ trinh" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Hiệu chỉnh">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
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
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                    </telerik:RadWindowManager>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Nhập thông tin tờ trình</legend>
                        <center>
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td align="right">
                                                    Năm:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="100px" AutoPostBack="true"
                                                        Skin="Windows7" Enabled="true" OnTextChanged="rnNam_TextChanged">
                                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td align="right">
                                                    Đơn vị:
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="IDMaCS" runat="server"
                                                        Skin="Windows7" Width="185px" Enabled="true" AutoPostBack="true" OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="right">
                                                    Người xem xét:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadComboBox ID="cbXemXet" runat="server" Width="185px" DataTextField="Hoten"
                                                        Skin="Windows7" DataValueField="MaNV" DropDownWidth="185px" HighlightTemplatedItems="true"
                                                        EnableLoadOnDemand="true" AutoPostBack="true">
                                                        <ItemTemplate>
                                                            <%#Eval("Hoten")%>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:TextBox ID="txtChucVuNguoiGui" runat="server" Width="180px" Enabled="false"
                                                        Skin="Windows7" Visible="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Tháng:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="100px" MaxValue="12"
                                                        Skin="Windows7" MinValue="1" Enabled="true" OnTextChanged="rnThang_TextChanged"
                                                        AutoPostBack="true">
                                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td align="right">
                                                    Người lập:
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtNguoiGui" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                                </td>
                                                <td align="right">
                                                    Người phê duyệt:
                                                </td>
                                                <td align="left">
                                                    <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="185px" DataTextField="MaTen"
                                                        Skin="Windows7" DataValueField="MAPD" DropDownWidth="185px" HighlightTemplatedItems="true"
                                                        EnableLoadOnDemand="true" AutoPostBack="true">
                                                        <ItemTemplate>
                                                            <%#Eval("MaTen")%>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    Về việc:
                                                </td>
                                                <td colspan="10">
                                                    <asp:TextBox ID="txtVeViec" runat="server" Height="20px" Width="99%" Skin="Windows7"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <tr>
                                            <td colspan="11" align="center">
                                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                            </td>
                                        </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtBoPhanNhan" runat="server" Width="180px" Enabled="false" Visible="false"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtChucVuNguoiNhan" runat="server" Width="180px" Enabled="false"
                                            Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px; margin-bottom: 5px;">
                        <legend>Danh sách tờ trình</legend>
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" EnableLinqExpressions="False" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                            GridLines="None" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            OnSortCommand="RG_SortCommand" OnCancelCommand="RG_CancelCommand" OnUpdateCommand="RG_UpdateCommand"
                            OnItemDataBound="RG_ItemDataBound" ShowFooter="true" OnSelectedIndexChanged="RG_SelectedIndexChanged"
                            CellSpacing="0">
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="True" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="False" />
                            <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoToTrinh">
                                <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                                        <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                        <ItemTemplate>
                                            <a style="cursor: pointer" onclick="openRadWindowShow('<%#Eval("SoToTrinh") %>','<%#Eval("MaDV") %>','<%#Eval("NAM") %>','<%#Eval("Thang") %>')">
                                                <img id="Img1" runat="server" alt="" visible='<%#!clsConvertHelper.Tobool( Eval("HieuLucPD")) %>'
                                                    border="0" height="16" src="../images/detail.png" /></a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                        FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="NguoiGoi" DataField="NguoiGoi"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="40px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÁ ĐV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MaNVXemXet" UniqueName="MaNVXemXet" DataField="MaNVXemXet"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="BoPhanNhan" UniqueName="BoPhanNhan" DataField="BoPhanNhan"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="VeViec" UniqueName="VeViec" DataField="VeViec"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Ngày gửi" UniqueName="NgayGoi" DataField="NgayGoi"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Người nhận" UniqueName="NguoiNhan" DataField="NguoiNhan"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Chức vụ NN" UniqueName="ChucVuNN" DataField="ChucVuNN"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Chức vụ NG" UniqueName="ChucVuNG" DataField="ChucVuNG"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                        FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="SoTien" DataField="SoTien"
                                        FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="TỔNG TIỀN (VND)" UniqueName="TongTien" DataField="TongTien"
                                        FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                        FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="VeViec" FilterControlAltText="Filter VeViec column"
                                        HeaderText="GHI CHÚ" ReadOnly="True" SortExpression="VeViec" UniqueName="VeViec"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle Width="130px" HorizontalAlign="Left" />
                                        <ItemStyle Width="130px" HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY PD" UniqueName="NgayNhan" DataField="NgayNhan"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="HL-XX" UniqueName="KiemTra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="HL-PD" UniqueName="KiemTra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLucPD")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="XÁC NHẬN" UniqueName="HieuLucPD" ShowFilterIcon="false"
                                        AllowFiltering="false" FilterControlWidth="60px">
                                        <HeaderStyle Width="120px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="120px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <telerik:RadComboBox ID="cbXacNhan" Width="100px" runat="server" AutoPostBack="true"
                                                Enabled='<%#!clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' OnSelectedIndexChanged="cbXacNhan_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="false" Text="Chưa xác nhận" />
                                                    <telerik:RadComboBoxItem Value="True" Text="Xác nhận" />
                                                </Items>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField ID="hfPheDuyet" runat="server" Value='<%# Eval("HieuLucPD") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Chọn tờ trình để hiệu chỉnh</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNamHieuChinhToTrinh" runat="server" Width="100px"
                                            Skin="Windows7" AutoPostBack="True" Enabled="true" OnTextChanged="rnNamHieuChinhToTrinh_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnNam"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Đơn vị:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlDonViHieuChinhToTrinh" DataTextField="TenDonVi" DataValueField="IDMaCS"
                                            Skin="Windows7" runat="server" Width="185px" Enabled="true" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlDonViHieuChinhToTrinh_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Tháng:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnThangHieuChinhToTrinh" runat="server" Width="100px"
                                            Skin="Windows7" MaxValue="12" MinValue="1" Enabled="true" AutoPostBack="true"
                                            OnTextChanged="rnThangHieuChinhToTrinh_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        Tờ trình:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlToTrinh" DataTextField="SoToTrinh" DataValueField="SoToTrinh"
                                            Skin="Windows7" runat="server" Width="185px" Enabled="true" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlToTrinh_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlToTrinh"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Số tiền:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnSoTien" runat="server" MinValue="0" Value="0" Width="100px"
                                            Skin="Windows7">
                                            <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                        </telerik:RadNumericTextBox>
                                    </td>
                                    <td align="right">
                                        MS chi phí:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbMaSoChiPhi" runat="server" Width="185px" DataTextField="MSCHIPHI"
                                            Skin="Windows7" DataValueField="MSCHIPHI" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                            Height='150px' DropDownWidth="350px" Enabled="true" OnItemDataBound="cbMaSoChiPhi_ItemDataBound"
                                            OnItemsRequested="cbMaSoChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaSoChiPhi_SelectedIndexChanged">
                                            <HeaderTemplate>
                                                <table>
                                                    <tr>
                                                        <td width="150px">
                                                            Mã CP
                                                        </td>
                                                        <td width="190px">
                                                            Tên CP
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td width="150px">
                                                            <%#Eval("MSChiPhi")%>
                                                        </td>
                                                        <td width="190px">
                                                            <%#Eval("DienGiai")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorMSCHIPHI" runat="server" ControlToValidate="cbMaSoChiPhi"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Ghi chú:
                                    </td>
                                    <td align="left" colspan="10">
                                        <telerik:RadTextBox ID="txtGhichuHieuChinh" runat="server" Height="25px" Width="100%"
                                            Skin="Windows7">
                                        </telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="11">
                                        <asp:ImageButton ID="tbXemTraCuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert2" OnClick="tbXemTraCuu_Click" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px; margin-bottom: 5px;">
                        <legend>Thông tin chi tiết tờ trình</legend>
                        <telerik:RadGrid ID="RGTraCuu" runat="server" Width="100%" AutoGenerateColumns="False"
                            Skin="Windows7" GridLines="None" OnDeleteCommand="RGTraCuu_DeleteCommand" OnPageIndexChanged="RGTraCuu_PageIndexChanged"
                            OnPageSizeChanged="RGTraCuu_PageSizeChanged">
                            <MasterTableView>
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="STT">
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="MSChiPhi" Display="False" HeaderText="MÃ NS"
                                        UniqueName="MSChiPhi">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MaNSDisplay" HeaderText="MÃ NS" UniqueName="MaNSDisplay">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="SoTien" HeaderText="SỐ TIỀN" UniqueName="SoTien">
                                        <ItemTemplate>
                                            <telerik:RadNumericTextBox ID="rnSoTienRGTraCuu" runat="server" Value='<%#fInt(Eval("SoTien")) %>'
                                                AutoPostBack="True" OnTextChanged="rnSoTienRGTraCuu_TextChanged">
                                                <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="GhiChu" HeaderText="GHI CHÚ" UniqueName="GhiChu">
                                        <ItemTemplate>
                                            <asp:TextBox ID="tbGhiChuTamTraCuu" Text='<%# Eval("GhiChu") %>' runat="server" Height="30px"
                                                Width="200px" AutoPostBack="True" OnTextChanged="tbGhiChuTamTraCuu_TextChanged"></asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa không?" Text="XÓA" HeaderText="XÓA">
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
