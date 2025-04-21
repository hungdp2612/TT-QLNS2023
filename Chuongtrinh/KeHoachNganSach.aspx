<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(ID_Khoa, Nam, Thang) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa + "&Nam=" + Nam + "&Thang=" + Thang, "RadWindowManager1");
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
                MultiPageID="MultiPage" OnTabClick="RadTabStrip1_TabClick">
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
                                        <img alt="Loading..." src="../images/ajax-loader-bar.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </center>
                        </ContentTemplate>
                    </telerik:RadNotification>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Nhập kế hoạch ngân sách</legend>
                        <div style="float: left; margin-left: 100px">
                            <center>
                                <div style="float: left">
                                    <fieldset style="height: 100px">
                                        <legend>1. Chọn năm tháng ngân sách</legend>
                                        <table border="0">
                                            <tr>
                                                <td align="right">Năm:
                                                </td>
                                                <td width="5px"></td>
                                                <td align="left">
                                                    <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                                        Skin="Windows7" OnTextChanged="rnNam_TextChanged">
                                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                                <td width="5px"></td>
                                                <td align="right">Mã DV:
                                                </td>
                                                <td width="5px"></td>
                                                <td align="left">
                                                    <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMADV" runat="server" ControlToValidate="TxtMaDV"
                                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">Tháng:
                                                </td>
                                                <td width="5px"></td>
                                                <td align="left">
                                                    <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" MaxValue="12"
                                                        Skin="Windows7" MinValue="1" OnTextChanged="rnThang_TextChanged" AutoPostBack="true">
                                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                                <td width="5px"></td>
                                                <td align="right">Tên BP:
                                                </td>
                                                <td width="5px"></td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTenDV" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="11" align="center">
                                                    <asp:ImageButton ID="btnLuu" CssClass="button" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div style="float: left">
                                    <fieldset style="height: 100px">
                                        <legend>2. Gửi email</legend>
                                        <table>
                                            <tr>
                                                <td align="left">Người xem xét:
                                                </td>
                                                <td style="width: 10px"></td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlEmailNguoiKiemTra" runat="server" Width="140px" DataValueField="MaNV" Visible="false"
                                                        Skin="Windows7" DataTextField="Hoten" AutoPostBack="True" OnSelectedIndexChanged="ddlEmailNguoiKiemTra_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <telerik:RadComboBox ID="rcEmailNguoiKiemTra" runat="server" Width="140px" DataTextField="Hoten" DataValueField="MaNV"
                                                        DropDownWidth="300px" EnableLoadOnDemand="true" OnItemsRequested="rcEmailNguoiKiemTra_ItemsRequested"
                                                        OnSelectedIndexChanged="rcEmailNguoiKiemTra_SelectedIndexChanged"
                                                        Height="250px" MarkFirstMatch="false" HighlightTemplatedItems="true" ItemRequestTimeout="500" AutoPostBack="true">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="11" align="center">
                                                    <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                                    <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div style="color: Blue; clear: both">
                                    <asp:Label ID="lbThoiGianLapNganSach" runat="server"></asp:Label>
                                </div>
                            </center>
                        </div>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend style="">Danh sách kế hoạch ngân sách</legend>
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                            GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            AllowFilteringByColumn="false" AllowSorting="false" OnSortCommand="RG_SortCommand"
                            PageSize="12" ShowFooter="true">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            </HeaderContextMenu>
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
                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                        <ItemTemplate>
                                            <a style="cursor: pointer" onclick="openRadWindowShow('<%#Eval("ID_Khoa") %>','<%#Eval("Nam") %>','<%#Eval("Thang") %>')">
                                                <img alt="" runat="server" border="0" height="16" src="../images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("Hieuluc_XX")) %>' /></a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Display="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ DV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="MaNVNguoiLap" DataField="MaNVNguoiLap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="TỔNG TIỀN" UniqueName="TongTien" DataField="TongTien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="Ngaylap" DataField="Ngaylap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
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
                                            <asp:CheckBox ID="cbhieulucPD" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
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
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <fieldset style="width: 970px; height: 50px; margin-left: 5px">
                        <legend>1. Chọn năm - quí cần xem</legend>
                        <center>
                            <table border="0">
                                <tr>
                                    <td align="right">Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="false"
                                            Skin="Windows7">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnNam_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">Quí:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui_Xem" runat="server" Width="70px" MaxValue="4"
                                            Skin="Windows7" MinValue="1" AutoPostBack="false">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnQui_Xem"
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
                    <div style="width: 990px; margin-left: 5px; margin-top: 5px;">
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
                                    <telerik:GridBoundColumn DataField="TongQui1" HeaderText="SỐ TIỀN (VNĐ)" UniqueName="TongQui1"
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
                                    <telerik:GridBoundColumn DataField="TongQui2" HeaderText="SỐ TIỀN (VNĐ)" UniqueName="TongQui2"
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
                                    <telerik:GridBoundColumn DataField="TongQui3" HeaderText="SỐ TIỀN (VNĐ)" UniqueName="TongQui3"
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
                                    <telerik:GridBoundColumn DataField="TongQui4" HeaderText="SỐ TIỀN (VNĐ)" UniqueName="TongQui4"
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
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
