<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_ChiTiet.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_ChiTiet" %>

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
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {

            rnSoTienChiTiet = $find("<%= rnSoTienChiTiet.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");
            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rnSoTienChiTiet.get_value());
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
                    <telerik:RadTab runat="server" Text="Lập kế hoạch ngân sách chi tiết" Selected="True">
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
                    <%--    <fieldset>
                        <legend>Nhập kế hoạch ngân sách</legend>--%>
                    <center>
                        <div>
                            <fieldset>
                                <legend>Chọn mã NS để nhập chi tiết</legend>
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
                                            Mã CP:
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbMaChiPhi" runat="server" Width="185px" DataTextField="MSChiPhi"
                                                AutoPostBack="True" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px" Enabled="true"
                                                OnItemsRequested="cbMaChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged">
                                                <HeaderTemplate>
                                                    <table width="300px">
                                                        <tr>
                                                            <td style="width: 100px">
                                                                Mã chi phí
                                                            </td>
                                                            <td style="width: 200px">
                                                                Diễn giải
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table width="300px">
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <%# Eval("MSChiphi")%>
                                                            </td>
                                                            <td style="width: 200px">
                                                                <%# Eval("DienGiai")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbMaChiPhi"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="right">
                                            Số tiền duyệt còn lại:
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" ReadOnly="True" Width="165px"
                                                Enabled="False" Value="0">
                                            </telerik:RadNumericTextBox>
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
                                                MinValue="1" OnTextChanged="rnThang_TextChanged" AutoPostBack="true">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="right">
                                            Tên qui cách:
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTenQuiCach" runat="server" Width="180px" Enabled="true"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtTenQuiCach"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="right">
                                            Số tiền chi tiết:
                                        </td>
                                        <td width="5px">
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnSoTienChiTiet" runat="server" Width="165px" Enabled="true"
                                                Value="0" onkeyup="onkeyupEvent()">
                                            </telerik:RadNumericTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="11" align="center">
                                            <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                                ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                    </center>
                    <%--  </fieldset>--%>
                    <table>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtIDKhoaChiTiet" runat="server" Width="180px" Enabled="false" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Enabled="false" Visible="false"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMADV" runat="server" ControlToValidate="TxtMaDV"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" ReadOnly="True"
                                    Width="160px" Enabled="false" Value="0" Display="false">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                    <div style="width: 1000px;">
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                            GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            AllowFilteringByColumn="false" AllowSorting="false" OnSortCommand="RG_SortCommand"
                            PageSize="100" ShowFooter="true">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            </HeaderContextMenu>
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="false" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="False" />
                            <MasterTableView>
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
                                    <telerik:GridBoundColumn HeaderText="IDKhoa" UniqueName="IDKhoa" DataField="IDKhoa"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Mã DV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Năm" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MaCP" UniqueName="MaCP" DataField="MaCP" FilterControlWidth="80px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MaCP_CT" UniqueName="MaCP_CT" DataField="MaCP_CT"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="TenQuiCach" UniqueName="TenQuiCach" DataField="TenQuiCach"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tổng tiền" UniqueName="SoTien" DataField="SoTien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="Nam" FieldName="Nam" HeaderText="Năm"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang" HeaderText="Tháng">
                                            </telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai" HeaderText="Mã NS">
                                            </telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldAlias="Nam" FieldName="Nam"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
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
                                        <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="false">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnNam_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Quí:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui_Xem" runat="server" Width="70px" MaxValue="4"
                                            MinValue="1" AutoPostBack="false">
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
                    <div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui1" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                                GridLines="Both" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="false"
                                ShowFooter="True">
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
                                        <%-- <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <%-- <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui1" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang1" HeaderText="Tháng 1" UniqueName="Thang1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang2" HeaderText="Tháng 2" UniqueName="Thang2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang3" HeaderText="Tháng 3" UniqueName="Thang3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
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
                                GridLines="Both" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="false"
                                ShowFooter="True">
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
                                        <%--  <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <%--  <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui2" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang4" HeaderText="Tháng 4" UniqueName="Thang4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang5" HeaderText="Tháng 5" UniqueName="Thang5"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang6" HeaderText="Tháng 6" UniqueName="Thang6"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
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
                                GridLines="Both" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="false"
                                ShowFooter="True">
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
                                        <%-- <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <%--  <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui3" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang7" HeaderText="Tháng 7" UniqueName="Thang7"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang8" HeaderText="Tháng 8" UniqueName="Thang8"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang9" HeaderText="Tháng 9" UniqueName="Thang9"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
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
                                GridLines="Both" AllowFilteringByColumn="false" AllowPaging="false" AllowSorting="false"
                                ShowFooter="True">
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
                                        <%--    <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <%--   <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui4" HeaderText="Số tiền (VNĐ)" UniqueName="TongQui4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang10" HeaderText="Tháng 10" UniqueName="Thang10"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang11" HeaderText="Tháng 11" UniqueName="Thang11"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang12" HeaderText="Tháng 12" UniqueName="Thang12"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###.##}" FooterStyle-ForeColor="Blue"
                                            Aggregate="Sum" FooterStyle-HorizontalAlign="Right">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
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
