<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_PCU_HCQT.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_PCU_HCQT" %>

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
            var oWnd = manager.open("ChiTietKeHoachNganSach_PCU_HCQT.aspx?ID_Khoa=" + ID_Khoa + "&MaDV=" + MaDV + "&Nam=" + Nam + "&Thang=" + Thang, "RadWindowManager1");
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
            <fieldset>
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
                                    OnTextChanged="rnNam_TextChanged">
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
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Enabled="false"></asp:TextBox>
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
                                    Enabled="false">
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
                                    MinValue="1">
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
                                <asp:TextBox ID="txtTenDV" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Người lập:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <asp:TextBox ID="TxtNguoiLap" runat="server" Width="180px" Enabled="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtMaDV"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
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
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="True" PageSize="12" ShowFooter="true" OnDeleteCommand="RG_DeleteCommand"
                    OnNeedDataSource="RG_NeedDataSource" OnPageIndexChanged="RG_PageIndexChanged"
                    OnPageSizeChanged="RG_PageSizeChanged">
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                        <Selecting AllowRowSelect="True" />
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
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemTemplate>
                                    <%# Container.DataSetIndex  + 1%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="Chi tiết" UniqueName="Chitiet" AllowFiltering="false">
                                <ItemTemplate>
                                    <a onclick="openRadWindowShow('<%#Eval("ID_Khoa") %>','<%#Eval("MaDV") %>','<%#Eval("Nam") %>','<%#Eval("Thang") %>')">
                                        <img runat="server" alt="" border="0" height="16" src="../images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("Hieuluc_XX")) %>' />
                                    </a>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Mã DV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Mã NV" UniqueName="MaNVNguoiLap" DataField="MaNVNguoiLap"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px"/>
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Năm" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"/>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"/>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Tổng tiền" UniqueName="TongTien" DataField="TongTien"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Ngày lập" UniqueName="Ngaylap" DataField="Ngaylap"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px"/>
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="Xem xét" UniqueName="Hieuluc_XX"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
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
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
