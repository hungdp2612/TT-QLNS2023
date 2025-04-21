<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChungTuThanhToan_KTKiemTra.aspx.cs" Inherits="Chuongtrinh_ChungTuThanhToan_KTKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript">

                function SelectAllGTTTU(CheckBox) {
                    var TargetBaseControl = document.getElementById('<%= this.RGTTTU.ClientID %>');
                    var TargetChildControl = "chkSelect";
                    var Inputs = TargetBaseControl.getElementsByTagName("input");
                    for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                        if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                            Inputs[iCount].checked = CheckBox.checked;
                    }
                }


                function SelectAll(CheckBox) {
                    var TargetBaseControl = document.getElementById('<%= this.RGTTKTU.ClientID %>');
                    var TargetChildControl = "chkSelect";
                    var Inputs = TargetBaseControl.getElementsByTagName("input");
                    for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                        if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                            Inputs[iCount].checked = CheckBox.checked;
                    }
                }

                function fConfirm(str) {
                    if (confirm(str)) {
                        return true;
                    }
                    else {
                        return false;
                    };
                };

                function openRadWindowShow(sophieu) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd = manager.open("ChiTietChungTu_TraPhieu.aspx?sophieu=" + sophieu, "RadWindowManager1");
                    oWnd.Center();
                }

                function OnClientClose() {
                    __doPostBack('fLoad', '');
                }



                function openRadWindowShowKiemTra(sophieu) {
                    var manager = $find("<%= RadWindowManager2.ClientID %>");
                    var oWnd = manager.open("ChiTietChungTu_KiemTra.aspx?sophieu=" + sophieu, "RadWindowManager2");
                    oWnd.Center();
                }
                function OnClientClose2() {
                    __doPostBack('FLoadThanhToanKhongTamUng', '');
                }
            

            </script>
            <div style="height: 10px;">
            </div>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage"
                AutoPostBack="True" OnTabClick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Kế toán kiểm tra thanh toán tạm ứng" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Kế toán kiểm tra phiếu đề nghị thanh toán">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Kế toán kiểm tra chứng từ nộp tiền">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="height: 10px;">
            </div>
            <center>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="998px">
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
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                    </telerik:RadWindowManager>
                    <telerik:RadTabStrip ID="RadTabStripGTTTU" runat="server" SelectedIndex="0" MultiPageID="RadMultiPageGTTTU"
                        OnTabClick="RadTabStripGTTTU_TabClick">
                        <Tabs>
                            <telerik:RadTab runat="server" Text="Kiểm tra" Selected="True">
                            </telerik:RadTab>
                            <telerik:RadTab runat="server" Text="Trả phiếu">
                            </telerik:RadTab>
                        </Tabs>
                    </telerik:RadTabStrip>
                    <center>
                        <telerik:RadMultiPage ID="RadMultiPageGTTTU" runat="server" Width="100%" SelectedIndex="0"
                            Height="100%">
                            <telerik:RadPageView ID="RadPageView4" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                                Skin="Windows7" DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True"
                                                Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px" OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                                                Skin="Windows7" DataTextField="HoTen" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiThanhToan_SelectedIndexChanged">
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
                                            <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                                Skin="Windows7" DataTextField="Ten" Width="220px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Loại thanh toán:
                                        </td>
                                        <td width="10px">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlLoaiThanhToan1" runat="server" Width="180px" AutoPostBack="true"
                                                Skin="Windows7" OnSelectedIndexChanged="ddlLoaiThanhToan1_SelectedIndexChanged">
                                                <asp:ListItem Value="TM">Tiền mặt</asp:ListItem>
                                                <asp:ListItem Value="NH">Ngân hàng</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="10">
                                            <asp:ImageButton ID="btnKTGTTTU" runat="server" ImageUrl="~/images/kiemtra.png" ValidationGroup="GInsert"
                                                OnClick="btnKTGTTTU_Click" />
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
                                <fieldset>
                                    <legend>Kiểm tra phiếu thanh toán tạm ứng</legend>
                                    <telerik:RadGrid ID="RGTTTU" runat="server" AllowFilteringByColumn="True" AllowAutomaticDeletes="True"
                                        Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" PageSize="6"
                                        ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RGTTTU_ItemCommand"
                                        OnPageIndexChanged="RGTTTU_PageIndexChanged" OnPageSizeChanged="RGTTTU_PageSizeChanged"
                                        OnSelectedIndexChanged="RGTTTU_SelectedIndexChanged">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
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
                                                <telerik:GridTemplateColumn UniqueName="All" ReadOnly="True" AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" Text="" onclick="SelectAllGTTTU(this);" />
                                                    </HeaderTemplate>
                                                    <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ngày lập" UniqueName="NgayLap" DataField="NgayLap"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Hạn TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenTaiKhoan" FilterControlAltText="Filter TenTaiKhoan column"
                                                    HeaderText="Tên TK" UniqueName="TenTaiKhoan">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenNganHang" FilterControlAltText="Filter TenNganHang column"
                                                    HeaderText="Ngân hàng" UniqueName="TenNganHang">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="SoTaiKhoan" FilterControlAltText="Filter SoTaiKhoan column"
                                                    HeaderText="Số TK" UniqueName="SoTaiKhoan">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Tổng tiền" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" Width="150px" />
                                                    <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <%#Eval("NoiDung") %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="Chi tiết" UniqueName="ChiTiet"
                                                    AllowFiltering="False" Groupable="False">
                                                    <ItemTemplate>
                                                        <a onclick="openRadWindowShowKiemTra('<%#Eval("SoPhieu") %>')">
                                                            <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("BPTCKTKiemtra")) %>' />
                                                        </a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
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
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="RadPageView5" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="RC_TraPhieuGTTTU" runat="server" AllowCustomText="true"
                                                Skin="Windows7" AutoPostBack="True" DataValueField="IDMaDV" DataTextField="TenDonVi"
                                                Enabled="True" Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px"
                                                OnSelectedIndexChanged="RC_TraPhieuGTTTU_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="RC_TraPhieuGTTTU"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                                            <asp:DropDownList Enabled="true" ID="ddlNguoiThanhToan_TraPhieuGTTTU" runat="server"
                                                Skin="Windows7" DataValueField="MaNV" DataTextField="HoTen" Width="180px" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlNguoiThanhToan_TraPhieuGTTTU_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlNguoiThanhToan_TraPhieuGTTTU"
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
                                            <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi_TraPhieuGTTTU" runat="server"
                                                Skin="Windows7" DataValueField="MaNV" DataTextField="Ten" Width="220px" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Loại thanh toán:
                                        </td>
                                        <td width="10px">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlLoaiThanhToan_TraPhieuGTTTU" runat="server" Width="180px"
                                                Skin="Windows7" AutoPostBack="true" OnSelectedIndexChanged="ddlLoaiThanhToan_TraPhieuGTTTU_SelectedIndexChanged">
                                                <asp:ListItem Value="TM">Tiền mặt</asp:ListItem>
                                                <asp:ListItem Value="NH">Ngân hàng</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:TextBox ID="txtMaDVTraPhieuGTTTU" Width="80px" Enabled="false" runat="server"
                                                Visible="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCSGTTTU" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtMaBPGTTTU" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <fieldset>
                                    <legend>Trả phiếu đề nghị thanh toán</legend>
                                    <telerik:RadGrid ID="RGTraPhieuGTTTU" runat="server" AllowFilteringByColumn="True"
                                        Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                        PageSize="6" ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RGTraPhieuGTTTU_ItemCommand"
                                        OnPageIndexChanged="RGTraPhieuGTTTU_PageIndexChanged" OnPageSizeChanged="RGTraPhieuGTTTU_PageSizeChanged">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="false" />
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
                                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ngày lập" UniqueName="NgayLap" DataField="NgayLap"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Hạn TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenTaiKhoan" FilterControlAltText="Filter TenTaiKhoan column"
                                                    HeaderText="Tên TK" UniqueName="TenTaiKhoan">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenNganHang" FilterControlAltText="Filter TenNganHang column"
                                                    HeaderText="Ngân hàng" UniqueName="TenNganHang">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="SoTaiKhoan" FilterControlAltText="Filter SoTaiKhoan column"
                                                    HeaderText="Số TK" UniqueName="SoTaiKhoan">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Tổng tiền" ReadOnly="True" SortExpression="SoTien" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" Width="50px" />
                                                    <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <%#Eval("NoiDung") %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="Chi tiết" UniqueName="ChiTiet"
                                                    AllowFiltering="False" Groupable="False">
                                                    <ItemTemplate>
                                                        <a onclick="openRadWindowShow('<%#Eval("SoPhieu") %>')">
                                                            <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" />
                                                        </a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Trả phiếu" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnTraPhieu" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                                            CommandName="TraPhieu" CommandArgument='<%# Eval("SoPhieu")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
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
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </center>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose2">
                    </telerik:RadWindowManager>
                    <center>
                        <telerik:RadTabStrip ID="RadTabStripXLCK" runat="server" SelectedIndex="0" MultiPageID="RadMultiPageXLCK"
                            OnTabClick="RadTabStripXLCK_TabClick">
                            <Tabs>
                                <telerik:RadTab runat="server" Text="Kiểm tra" Selected="True">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Trả phiếu">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                        <telerik:RadMultiPage ID="RadMultiPageXLCK" runat="server" Width="100%" SelectedIndex="0"
                            Height="100%">
                            <br />
                            <telerik:RadPageView ID="RadPageViewKeToanKiemTra" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="CboMaDV2" runat="server" AllowCustomText="true" AutoPostBack="True"
                                                Skin="Windows7" DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True"
                                                Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px" OnSelectedIndexChanged="CboMaDV2_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="CboMaDV2"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                                                Skin="Windows7" DataTextField="HoTen" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiThanhToan2_SelectedIndexChanged">
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
                                            <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi2" runat="server" DataValueField="MaNV"
                                                Skin="Windows7" DataTextField="Ten" Width="220px" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Loại thanh toán:
                                        </td>
                                        <td width="10px">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlLoaiThanhToan2" runat="server" Width="180px" AutoPostBack="true"
                                                Skin="Windows7" OnSelectedIndexChanged="ddlLoaiThanhToan2_SelectedIndexChanged">
                                                <asp:ListItem Value="TM">Tiền mặt</asp:ListItem>
                                                <asp:ListItem Value="NH">Ngân hàng</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="10">
                                            <asp:ImageButton ID="btnKiemTra" runat="server" ImageUrl="~/images/kiemtra.png" ValidationGroup="GInsert"
                                                OnClick="btnKiemTra_Click" />
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
                                <fieldset>
                                    <legend>Kiểm tra phiếu đề nghị thanh toán</legend>
                                    <telerik:RadGrid ID="RGTTKTU" runat="server" AllowFilteringByColumn="True" AllowAutomaticDeletes="True"
                                        Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" PageSize="6"
                                        ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RGTTKTU_ItemCommand"
                                        OnItemDataBound="RGTTKTU_ItemDataBound" OnPageIndexChanged="RGTTKTU_PageIndexChanged"
                                        OnPageSizeChanged="RGTTKTU_PageSizeChanged" OnSelectedIndexChanged="RGTTKTU_SelectedIndexChanged">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="false" />
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
                                                <telerik:GridTemplateColumn UniqueName="All" ReadOnly="True" AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" Text="" onclick="SelectAll(this);" />
                                                    </HeaderTemplate>
                                                    <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ngày lập" UniqueName="NgayLap" DataField="NgayLap"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Hạn TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenTaiKhoan" FilterControlAltText="Filter TenTaiKhoan column"
                                                    HeaderText="Tên TK" UniqueName="TenTaiKhoan">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenNganHang" FilterControlAltText="Filter TenNganHang column"
                                                    HeaderText="Ngân hàng" UniqueName="TenNganHang">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="SoTaiKhoan" FilterControlAltText="Filter SoTaiKhoan column"
                                                    HeaderText="Số TK" UniqueName="SoTaiKhoan">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Tổng tiền" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" Width="150px" />
                                                    <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <%#Eval("NoiDung") %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="Chi tiết" UniqueName="ChiTiet"
                                                    AllowFiltering="False" Groupable="False">
                                                    <ItemTemplate>
                                                        <a onclick="openRadWindowShowKiemTra('<%#Eval("SoPhieu") %>')">
                                                            <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("BPTCKTKiemtra")) %>' />
                                                        </a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
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
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="RadPageViewTraPhieu" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="RC_TraPhieuDNTT" runat="server" AllowCustomText="true" AutoPostBack="True"
                                                Skin="Windows7" DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True"
                                                Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px" OnSelectedIndexChanged="RC_TraPhieuDNTT_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="RC_TraPhieuDNTT"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                                            <asp:DropDownList Enabled="true" ID="ddlNguoiThanhToan_TraPhieuGDNTT" runat="server"
                                                Skin="Windows7" DataValueField="MaNV" DataTextField="HoTen" Width="180px" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlNguoiThanhToan_TraPhieuGDNTT_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlNguoiThanhToan_TraPhieuGDNTT"
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
                                            <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi_TraPhieuGDNTT" runat="server"
                                                Skin="Windows7" DataValueField="MaNV" DataTextField="Ten" Width="220px" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Loại thanh toán:
                                        </td>
                                        <td width="10px">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlLoaiThanhToan_TraPhieuGDNTT" runat="server" Width="180px"
                                                Skin="Windows7" AutoPostBack="true" OnSelectedIndexChanged="ddlLoaiThanhToan_TraPhieuGDNTT_SelectedIndexChanged">
                                                <asp:ListItem Value="TM">Tiền mặt</asp:ListItem>
                                                <asp:ListItem Value="NH">Ngân hàng</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:TextBox ID="txtMaDVTraPhieuNDTT" Width="80px" Enabled="false" runat="server"
                                                Visible="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCSDNTT" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtMaBPDNTT" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <fieldset>
                                    <legend>Trả phiếu đề nghị thanh toán</legend>
                                    <telerik:RadGrid ID="RGTraPhieuDNTT" runat="server" AllowFilteringByColumn="True"
                                        Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                        PageSize="6" ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RGTraPhieuDNTT_ItemCommand"
                                        OnPageIndexChanged="RGTraPhieuDNTT_PageIndexChanged" OnPageSizeChanged="RGTraPhieuDNTT_PageSizeChanged">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="false" />
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
                                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Ngày lập" UniqueName="NgayLap" DataField="NgayLap"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Hạn TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenTaiKhoan" FilterControlAltText="Filter TenTaiKhoan column"
                                                    HeaderText="Tên TK" UniqueName="TenTaiKhoan">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="TenNganHang" FilterControlAltText="Filter TenNganHang column"
                                                    HeaderText="Ngân hàng" UniqueName="TenNganHang">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowFiltering="False" DataField="SoTaiKhoan" FilterControlAltText="Filter SoTaiKhoan column"
                                                    HeaderText="Số TK" UniqueName="SoTaiKhoan">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                    HeaderText="Tổng tiền" ReadOnly="True" SortExpression="SoTien" UniqueName="SoTien"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" Width="50px" />
                                                    <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Nội dung" UniqueName="NoiDung" DataField="NoiDung"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <%#Eval("NoiDung") %>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="Chi tiết" UniqueName="ChiTiet"
                                                    AllowFiltering="False" Groupable="False">
                                                    <ItemTemplate>
                                                        <a onclick="openRadWindowShow('<%#Eval("SoPhieu") %>')">
                                                            <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" />
                                                        </a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Trả phiếu" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnTraPhieu" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                                            CommandName="TraPhieu" CommandArgument='<%# Eval("SoPhieu")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
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
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </center>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <center>
                        <telerik:RadTabStrip ID="RadTabStrip2" runat="server" SelectedIndex="0" MultiPageID="RadMultiPageNopTien">
                            <Tabs>
                                <telerik:RadTab runat="server" Text="Kiểm tra" Selected="True">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Trả phiếu">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                        <telerik:RadMultiPage ID="RadMultiPageNopTien" runat="server" Width="100%" SelectedIndex="0"
                            Height="100%">
                            <br />
                            <telerik:RadPageView ID="RadPageView6" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="CboMaDV3" runat="server" AllowCustomText="true" AutoPostBack="True"
                                                Skin="Windows7" DataValueField="IDMaDV" DataTextField="TenDonVi" Enabled="True"
                                                Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px" OnSelectedIndexChanged="CboMaDV3_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="CboMaDV3"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Người nộp tiền:
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList Enabled="true" ID="ddlNguoiNopTien" runat="server" DataValueField="MaNV"
                                                Skin="Windows7" DataTextField="HoTen" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiNopTien_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="ddlNguoiNopTien"
                                                Display="Dynamic" ErrorMessage="Chọn." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
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
                                            <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi3" runat="server" DataValueField="MaNV"
                                                Skin="Windows7" DataTextField="Ten" Width="220px" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Ngày kiểm tra:
                                        </td>
                                        <td width="10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadDatePicker ID="rdNgayXemXet3" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                                Skin="Windows7" Enabled="false">
                                                <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                    ViewSelectorText="x" runat="server">
                                                </Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput2" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                                    runat="server">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="rdNgayXemXet3"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:TextBox ID="txtMaDV3" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtMaDV2"
                                                Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCS3" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtMaBP3" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div style="float: left; width: 1000px;">
                                    <div style="float: left; width: 500px;">
                                        <fieldset style="width: 500px">
                                            <legend>Chứng từ nộp tiền</legend>
                                            <telerik:RadGrid ID="RGPNT" runat="server" Height="300px" AllowFilteringByColumn="True"
                                                Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                                PageSize="6" ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RGPNT_ItemCommand"
                                                OnItemDataBound="RGPNT_ItemDataBound" OnPageIndexChanged="RGPNT_PageIndexChanged"
                                                OnPageSizeChanged="RGPNT_PageSizeChanged" OnSelectedIndexChanged="RGPNT_SelectedIndexChanged">
                                                <GroupingSettings CaseSensitive="False" />
                                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
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
                                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                            HeaderText="Tổng tiền" ReadOnly="True" SortExpression="SoTien" UniqueName="SoTien"
                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                            <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                            <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Xác nhận" UniqueName="KiemTra" ShowFilterIcon="false"
                                                            AllowFiltering="false" FilterControlWidth="60px">
                                                            <HeaderStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <ItemStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            <ItemTemplate>
                                                                <telerik:RadComboBox ID="cbKiemTraPNT" Width="100px" runat="server" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="cbKiemTraPNT_SelectedIndexChanged">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Value="false" Text="Chưa xác nhận" />
                                                                        <telerik:RadComboBoxItem Value="True" Text="Xác nhận" />
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <asp:HiddenField ID="hfKiemTraPNT" runat="server" Value='<%# Eval("KiemTra") %>' />
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
                                            <legend>Chi tiết chứng từ nộp tiền</legend>
                                            <telerik:RadGrid ID="RGCTPNT" runat="server" Width="450px" Height="300px" AutoGenerateColumns="False"
                                                Skin="Windows7" CellSpacing="0" GridLines="None" AllowFilteringByColumn="True"
                                                ShowStatusBar="True" EnableLinqExpressions="False" ShowFooter="True" OnItemCommand="RGCTPNT_ItemCommand"
                                                OnPageIndexChanged="RGCTPNT_PageIndexChanged" OnPageSizeChanged="RGCTPNT_PageSizeChanged">
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
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemTemplate>
                                                                <%# Container.DataSetIndex  + 1%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Mã CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Tên CP" UniqueName="DienGiai" DataField="DienGiai"
                                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AllowFiltering="false" AutoPostBackOnFilter="true">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TienThanhToan" FilterControlAltText="Filter TienThanhToan column"
                                                            HeaderText="Số tiền" ReadOnly="True" SortExpression="TienThanhToan" UniqueName="TienThanhToan"
                                                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" FilterControlWidth="100px" DataFormatString="{0:###,###.##}"
                                                            AllowFiltering="false">
                                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                            <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                            <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
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
                            <telerik:RadPageView ID="RadPageView7" runat="server">
                                <table>
                                    <tr>
                                        <td align="right">
                                            Đơn vị:
                                        </td>
                                        <td style="width: 10px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="ddlDonViNopTien_TraPhieu" runat="server" AllowCustomText="true"
                                                Skin="Windows7" AutoPostBack="True" DataValueField="IDMaDV" DataTextField="TenDonVi"
                                                Enabled="True" Filter="Contains" Height="200px" MarkFirstMatch="true" Width="220px"
                                                OnSelectedIndexChanged="ddlDonViNopTien_TraPhieu_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlDonViNopTien_TraPhieu"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            Người nộp tiền:
                                        </td>
                                        <td style="width: 10px">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList Enabled="true" ID="ddlNguoiNopTien_TraPhieu" runat="server" DataValueField="MaNV"
                                                Skin="Windows7" DataTextField="HoTen" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiNopTien_TraPhieu_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="ddlNguoiNopTien_TraPhieu"
                                                Display="Dynamic" ErrorMessage="Chọn." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:TextBox ID="txtMaDV4" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCS4" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                            <asp:TextBox ID="txtMaBP4" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div style="float: left; width: 1000px;">
                                    <div style="float: left; width: 500px;">
                                        <fieldset style="width: 500px">
                                            <legend>Chứng từ nộp tiền</legend>
                                            <telerik:RadGrid ID="RG_NopTien_TraPhieu" runat="server" Height="300px" AllowFilteringByColumn="True"
                                                Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                                                PageSize="6" ShowFooter="True" CellSpacing="0" GridLines="None" OnItemCommand="RG_NopTien_TraPhieu_ItemCommand"
                                                OnSelectedIndexChanged="RG_NopTien_TraPhieu_SelectedIndexChanged">
                                                <GroupingSettings CaseSensitive="False" />
                                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
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
                                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                                            Groupable="False">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemTemplate>
                                                                <%# Container.DataSetIndex  + 1%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AllowFiltering="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                                            HeaderText="Tổng tiền" ReadOnly="True" SortExpression="SoTien" UniqueName="SoTien"
                                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                            <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                            <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Trả phiếu" AllowFiltering="false">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="btnTraPhieuNopTien" runat="server" ImageUrl="~/images/Nutchuanweb/FileUpload.gif"
                                                                    CommandName="TraPhieu" CommandArgument='<%# Eval("SoPhieu")%>' OnClientClick="return fConfirm('Bạn có muốn trả phiếu này cho đơn vị ?');" />
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
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
                                            <legend>Chi tiết chứng từ nộp tiền</legend>
                                            <telerik:RadGrid ID="RGChiTietNopTien_TraPhieu" runat="server" Width="450px" Height="300px"
                                                Skin="Windows7" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                                AllowFilteringByColumn="True" ShowStatusBar="True" EnableLinqExpressions="False"
                                                ShowFooter="True">
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
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                                            <ItemTemplate>
                                                                <%# Container.DataSetIndex  + 1%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Mã CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Tên CP" UniqueName="DienGiai" DataField="DienGiai"
                                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AllowFiltering="false" AutoPostBackOnFilter="true">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TienThanhToan" FilterControlAltText="Filter TienThanhToan column"
                                                            HeaderText="Số tiền" ReadOnly="True" SortExpression="TienThanhToan" UniqueName="TienThanhToan"
                                                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" FilterControlWidth="100px" DataFormatString="{0:###,###.##}"
                                                            AllowFiltering="false">
                                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                                            FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                            AutoPostBackOnFilter="true" AllowFiltering="false">
                                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
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
                    </center>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
