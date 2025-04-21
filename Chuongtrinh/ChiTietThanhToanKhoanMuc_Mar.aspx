<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChiTietThanhToanKhoanMuc_Mar.aspx.cs" Inherits="Chuongtrinh_ChiTietThanhToanKhoanMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

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
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Chi tiết thanh toán khoản mục</legend>
                <center>
                    <table border="0">
                        <tr>
                            <td align="right">
                                Năm:
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    Skin="Windows7">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                            </td>
                            <td align="right">
                                Loại thanh toán:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLoaiThanhToan" runat="server" Width="185px" AutoPostBack="true"
                                    Skin="Windows7" OnSelectedIndexChanged="ddlLoaiThanhToan_SelectedIndexChanged">
                                    <asp:ListItem Value="GDNTT">Giấy đề nghị thanh toán</asp:ListItem>
                                    <asp:ListItem Value="GTTTU">Giấy thanh toán tam ứng</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Mã CP:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbMaChiPhi" runat="server" Width="185px" DataTextField="MSChiPhi"
                                    Skin="Windows7" AutoPostBack="True" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
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
                                                    <%# Eval("MSChiPhi")%>
                                                </td>
                                                <td style="width: 200px">
                                                    <%# Eval("DienGiai")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="cbMaChiPhi"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Khoản mục:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="rcKhoanMuc" runat="server" Width="185px" DataTextField="Khoa_khoanmuc"
                                    AutoPostBack="True" DataValueField="Khoa_khoanmuc" HighlightTemplatedItems="true"
                                    Skin="Windows7" EnableLoadOnDemand="false" Height='150px' DropDownWidth="500px"
                                    Enabled="true" OnSelectedIndexChanged="rcKhoanMuc_SelectedIndexChanged">
                                    <HeaderTemplate>
                                        <table width="500px">
                                            <tr>
                                                <td style="width: 100px">
                                                    Khoản mục
                                                </td>
                                                <td style="width: 200px">
                                                    Tên khoản mục
                                                </td>
                                                <td style="width: 100px">
                                                    Tiền KH
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table width="500px">
                                            <tr>
                                                <td style="width: 100px">
                                                    <%# Eval("Khoa_khoanmuc")%>
                                                </td>
                                                <td style="width: 200px">
                                                    <%# Eval("Tenkhoanmuc")%>
                                                </td>
                                                <td style="width: 100px">
                                                    <%# Eval("Sotien")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rcKhoanMuc"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                                <td align="right">
                                    Chi tiết KM:
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="cboChiTietKhoanMuc" runat="server" Width="185px" DataTextField="Khoa_Chitiet_KM"
                                        AutoPostBack="True" DataValueField="Khoa_Chitiet_KM" HighlightTemplatedItems="true"
                                        Skin="Windows7" Filter="StartsWith" EnableLoadOnDemand="true" Height='150px'
                                        DropDownWidth="500px" Enabled="true" EmptyMessage="Chọn CT KM" OnSelectedIndexChanged="cboKhoaKhoanMuc_SelectedIndexChanged"
                                        OnItemsRequested="cboChiTietKhoanMuc_ItemsRequested">
                                        <HeaderTemplate>
                                            <table width="500px">
                                                <tr>
                                                    <td style="width: 200px">
                                                        Khóa CT KM
                                                    </td>
                                                    <td style="width: 200px">
                                                        ND khoản mục
                                                    </td>
                                                    <td style="width: 100px">
                                                        Tiền KH
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table width="500px">
                                                <tr>
                                                    <td style="width: 200px">
                                                        <%# Eval("Khoa_Chitiet_KM")%>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <%# Eval("Noidung")%>
                                                    </td>
                                                    <td style="width: 100px">
                                                        <%# Eval("Sotienkehoach")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboChiTietKhoanMuc"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                </td>
                                <td align="right">
                                    Số phiếu:
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="cbSoPhieu" runat="server" Width="185px" DataTextField="SoPhieu"
                                        Skin="Windows7" AutoPostBack="True" DataValueField="SoPhieu" HighlightTemplatedItems="true"
                                        EnableLoadOnDemand="true" Height='120px' DropDownWidth="185px" Enabled="true"
                                        OnSelectedIndexChanged="cbSoPhieu_SelectedIndexChanged" OnItemsRequested="cbSoPhieu_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cbSoPhieu"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Tiền TT:
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cboCTTT_ID" runat="server" Width="185px" DataTextField="CTTT_ID"
                                    Skin="Windows7" AutoPostBack="True" DataValueField="CTTT_ID" HighlightTemplatedItems="true"
                                    EnableLoadOnDemand="true" Height='150px' DropDownWidth="420px" Enabled="true">
                                    <HeaderTemplate>
                                        <table width="420px">
                                            <tr>
                                                <td style="width: 250px">
                                                    Tên - Qui cách
                                                </td>
                                                <td style="width: 70px">
                                                    Mã CP
                                                </td>
                                                <td style="width: 100px">
                                                    Tiền thanh toán
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table width="420px">
                                            <tr>
                                                <td style="width: 250px">
                                                    <%# Eval("TenVaQuiCach")%>
                                                </td>
                                                <td style="width: 70px">
                                                    <%# Eval("MSChiPhi")%>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label ID="TTT" runat="server" Text='<%# Eval("TienThanhToan")%>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cboCTTT_ID"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Trừ VAT:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlVAT" runat="server" Width="185px" AutoPostBack="false" Skin="Windows7">
                                    <asp:ListItem Value="10">10%</asp:ListItem>
                                    <asp:ListItem Value="5">5%</asp:ListItem>
                                    <asp:ListItem Value="0">Không VAT</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Ghi chú:
                            </td>
                            <td>
                                <asp:TextBox ID="txtGhiChu" runat="server" Width="180px" Skin="Windows7"></asp:TextBox>
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
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Danh sách thanh toán khoản mục</legend>
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    AllowFilteringByColumn="false" AllowSorting="false" OnSortCommand="RG_SortCommand"
                    PageSize="100" ShowFooter="true" OnCancelCommand="RG_CancelCommand" OnUpdateCommand="RG_UpdateCommand">
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                        <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
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
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Sửa" EditText="Sửa">
                                <ItemStyle />
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="XÓA">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn HeaderText="Khoa_CT_TT_KM" UniqueName="Khoa_CT_TT_KM" DataField="Khoa_CT_TT_KM"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="CT KM" UniqueName="Khoa_Chitiet_KM" DataField="Khoa_Chitiet_KM"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="SỐ PHIẾU" UniqueName="SoPhieu" DataField="SoPhieu"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="NgayLap" DataField="NgayLap"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ CP" UniqueName="GroupMaCP" DataField="GroupMaCP"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="KHOẢN MỤC" UniqueName="KhoaCPKM" DataField="KhoaCPKM"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TÊN KM" UniqueName="Tenkhoanmuc" DataField="Tenkhoanmuc"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="CHI TIẾT KM" UniqueName="Noidung" DataField="Noidung"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="CHƯƠNG TRÌNH" UniqueName="TenCT" DataField="TenCT"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NHÂN VIÊN" UniqueName="HoTen" DataField="HoTen"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TIỀN TT" UniqueName="TienThanhToan" DataField="TienThanhToan"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="VAT" UniqueName="TruVAT" DataField="TruVAT"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="ĐÃ TRỪ VAT" UniqueName="TienThanhToanDaTruVAT"
                                DataField="TienThanhToanDaTruVAT" FilterControlWidth="70px" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                AllowFiltering="false" Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Ghichu" DataField="Ghichu"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                        </Columns>
                        <GroupByExpressions>
                            <telerik:GridGroupByExpression>
                                <SelectFields>
                                    <telerik:GridGroupByField FieldAlias="Nam" FieldName="Nam" HeaderText="Năm"></telerik:GridGroupByField>
                                    <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP" HeaderText="Mã CP">
                                    </telerik:GridGroupByField>
                                </SelectFields>
                                <GroupByFields>
                                    <telerik:GridGroupByField FieldAlias="Nam" FieldName="Nam"></telerik:GridGroupByField>
                                    <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP"></telerik:GridGroupByField>
                                </GroupByFields>
                            </telerik:GridGroupByExpression>
                        </GroupByExpressions>
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
