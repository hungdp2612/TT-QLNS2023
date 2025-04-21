<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChiPhiKeHoachKhoanMuc.aspx.cs" Inherits="Chuongtrinh_ChiPhiKeHoachKhoanMuc" %>

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
                <legend>Nhập chi phí khoản mục</legend>
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
                                    OnTextChanged="rnNam_TextChanged" Skin="Windows7">
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
                                    Skin="Windows7" EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px"
                                    Enabled="true" OnItemsRequested="cbMaChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged">
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
                                                    <%# Eval("MSChiPhi")%>
                                                </td>
                                                <td style="width: 200px">
                                                    <%# Eval("DienGiai")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cbMaChiPhi"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Kế hoạch CP còn:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" ReadOnly="True" Width="165px"
                                    Enabled="False" Value="0" Skin="Windows7">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Khoản mục:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cboKhoaKhoanMuc" runat="server" Width="185px" DataTextField="Khoa_khoanmuc"
                                    AutoPostBack="True" DataValueField="Khoa_khoanmuc" HighlightTemplatedItems="true"
                                    Skin="Windows7" EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px"
                                    Enabled="true">
                                    <HeaderTemplate>
                                        <table width="300px">
                                            <tr>
                                                <td style="width: 100px">
                                                    Khoản mục
                                                </td>
                                                <td style="width: 200px">
                                                    Tên khoản mục
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table width="300px">
                                            <tr>
                                                <td style="width: 100px">
                                                    <%# Eval("Khoa_khoanmuc")%>
                                                </td>
                                                <td style="width: 200px">
                                                    <%# Eval("Tenkhoanmuc")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboKhoaKhoanMuc"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Thương hiệu:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbThuongHieu" runat="server" Width="185px" DataTextField="LoaiCP"
                                    Skin="Windows7" AutoPostBack="True" DataValueField="LoaiCP" HighlightTemplatedItems="true"
                                    EnableLoadOnDemand="true" Height='90px' DropDownWidth="240px" Enabled="true">
                                    <HeaderTemplate>
                                        <table width="220px">
                                            <tr>
                                                <td style="width: 80px">
                                                    Loại CP
                                                </td>
                                                <td style="width: 140px">
                                                    Thương hiệu
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table width="220px">
                                            <tr>
                                                <td style="width: 80px">
                                                    <%# Eval("LoaiCP")%>
                                                </td>
                                                <td style="width: 140px">
                                                    <%# Eval("Tenloaichiphi")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cbThuongHieu"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Số tiền KH:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnSoTienChiTiet" runat="server" Width="165px" Enabled="true"
                                    Value="0" onkeyup="onkeyupEvent()" Skin="Windows7">
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
                </center>
            </fieldset>
            <table>
                <tr>
                    <td>
                        <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" ReadOnly="True"
                            Width="160px" Enabled="false" Value="0" Display="false">
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </table>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Danh sách chi phí khoản mục</legend>
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    AllowFilteringByColumn="true" AllowSorting="false" OnSortCommand="RG_SortCommand"
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
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="XÓA">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn HeaderText="Khoa_ID" UniqueName="Khoa_ID" DataField="Khoa_ID"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="KHOẢN MỤC" UniqueName="Khoa_khoanmuc" DataField="Khoa_khoanmuc"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TÊN KHOẢN MỤC" UniqueName="Tenkhoanmuc" DataField="Tenkhoanmuc"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ CP" UniqueName="MaCP" DataField="MaCP" FilterControlWidth="80px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THƯƠNG HIỆU" UniqueName="LoaiCP" DataField="LoaiCP"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TỔNG TIỀN" UniqueName="SoTien" DataField="SoTien"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                        </Columns>
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="GroupKhoa" FieldName="GroupKhoa" HeaderText="Mã CP">
                                    </telerik:GridGroupByField>
                                    <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai" HeaderText="Diễn giải">
                                    </telerik:GridGroupByField>
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldAlias="GroupKhoa" FieldName="GroupKhoa"></telerik:GridGroupByField>
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
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
