<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_SanXuat.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_SanXuat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        //        function openRadWindowShow(ID_Khoa, MaDV, Nam, Thang) {
        //            var manager = $find("<%= RadWindowManager1.ClientID %>");
        //            var oWnd = manager.open("ChiTietKeHoachNganSach_SanXuat.aspx?ID_Khoa=" + ID_Khoa, "&MaDV=" + MaDV, "&Nam=" + Nam, "&Thang=" + Thang, "RadWindowManager1");
        //            oWnd.Center();

        //        }
        function openRadWindowShow(ID_Khoa, MaDV, Nam, Thang) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietKeHoachNganSach_SanXuat.aspx?ID_Khoa=" + ID_Khoa + "&MaDV=" + MaDV + "&Nam=" + Nam + "&Thang=" + Thang, "RadWindowManager1");
            oWnd.Center();

        }

        function OnClientClose() {
            __doPostBack('FLoadKeHoachChiPhi', '');
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
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="MultiPage">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Kế hoạch ngân sách" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem kế hoạch ngân sách theo quí">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="margin-top: 10px">
            </div>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
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
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Nhập kế hoạch ngân sách</legend>
                        <center>
                            <table border="0">
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7" OnTextChanged="rnNam_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Mã DV:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorMADV" runat="server" ControlToValidate="TxtMaDV"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Ngày lập:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdNgay" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7" Enabled="false">
                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                ViewSelectorText="x" runat="server">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                                runat="server">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdNgay"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Tháng:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" MaxValue="12"
                                            Skin="Windows7" MinValue="1">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Tên DV:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenDV" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Người lập:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TxtNguoiLap" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtMaDV"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                            <div>
                                <asp:RadioButtonList ID="radioCapNhat" runat="server" RepeatColumns="2">
                                    <asp:ListItem Selected="True" Value="BangTay"> Nhận ủy quyền thủ công</asp:ListItem>
                                    <asp:ListItem Value="AuTo">Nhận ủy quyền tự động</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <table>
                                <tr>
                                    <td colspan="11" align="center">
                                        <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <div style="color: Blue; clear: both">
                                <asp:Label ID="lbThoiGianLapNganSach" runat="server"></asp:Label></div>
                        </center>
                    </fieldset>
                    <div style="width: 1000px;">
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Danh sách kế hoạch ngân sách</legend>
                            <telerik:RadGrid ID="RG" Width="100%" Height="370px" runat="server" AutoGenerateColumns="False"
                                Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                                GridLines="None" AllowPaging="True" PageSize="12" ShowFooter="true" OnDeleteCommand="RG_DeleteCommand"
                                OnNeedDataSource="RG_NeedDataSource" OnPageIndexChanged="RG_PageIndexChanged"
                                OnPageSizeChanged="RG_PageSizeChanged">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <HeaderContextMenu EnableTheming="True">
                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                </HeaderContextMenu>
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="false" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="false" />
                                </ClientSettings>
                                <GroupingSettings CaseSensitive="False" />
                                <MasterTableView>
                                    <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
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
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                            ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                            <ItemTemplate>
                                                <a onclick="openRadWindowShow('<%#Eval("ID_Khoa") %>','<%#Eval("MaDV") %>','<%#Eval("Nam") %>','<%#Eval("Thang") %>')">
                                                    <img runat="server" alt="" border="0" height="16" src="../images/detail.png" />
                                                </a>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                            FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" Visible="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ DV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="70px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="MaNVNguoiLap" DataField="MaNVNguoiLap"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="TỔNG TIỀN" UniqueName="TongTien" DataField="TongTien"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                            FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="Ngaylap" DataField="Ngaylap"
                                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbhieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
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
                        </fieldset>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <fieldset>
                        <legend>1. Chọn năm - quí cần xem</legend>
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
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnNam_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Quí:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui_Xem" runat="server" Width="70px" MaxValue="4"
                                            Skin="Windows7" MinValue="1" AutoPostBack="false">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rnQui_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                            ValidationGroup="GExcel" OnClick="btnXem_Click" />
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                            ValidationGroup="GExcel" OnClick="btExcel_Click" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui1" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                                Skin="Windows7" GridLines="None" AllowFilteringByColumn="false" AllowPaging="false"
                                AllowSorting="false" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="MÃ NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ỦY QUYỀN" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui1" HeaderText="SỐ TIỀN" UniqueName="TongQui1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang1" HeaderText="THÁNG 1" UniqueName="Thang1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang2" HeaderText="THÁNG 2" UniqueName="Thang2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang3" HeaderText="THÁNG 3" UniqueName="Thang3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui2" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                                Skin="Windows7" GridLines="None" AllowFilteringByColumn="false" AllowPaging="false"
                                AllowSorting="false" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="MÃ NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ỦY QUYỀN" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui2" HeaderText="SỐ TIỀN" UniqueName="TongQui2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang4" HeaderText="THÁNG 4" UniqueName="Thang4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang5" HeaderText="THÁNG 5" UniqueName="Thang5"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang6" HeaderText="THÁNG 6" UniqueName="Thang6"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui3" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                                Skin="Windows7" GridLines="None" AllowFilteringByColumn="false" AllowPaging="false"
                                AllowSorting="false" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="MÃ NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ỦY QUYỀN" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui3" HeaderText="SỐ TIỀN" UniqueName="TongQui3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang7" HeaderText="THÁNG 7" UniqueName="Thang7"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang8" HeaderText="THÁNG 8" UniqueName="Thang8"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang9" HeaderText="THÁNG 9" UniqueName="Thang9"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui4" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                                Skin="Windows7" GridLines="None" AllowFilteringByColumn="false" AllowPaging="false"
                                AllowSorting="false" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="MÃ NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ỦY QUYỀN" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui4" HeaderText="SỐ TIỀN" UniqueName="TongQui4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang10" HeaderText="THÁNG 10" UniqueName="Thang10"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang11" HeaderText="THÁNG 11" UniqueName="Thang11"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang12" HeaderText="THÁNG 12" UniqueName="Thang12"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
