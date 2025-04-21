<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TamUngChuaThanhToan.aspx.cs" Inherits="Tracuu_LapTamUng_XemXet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
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
            <center>
                <table width="100%" cellpadding="0" cellspacing="0" id="topp">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                TÌM KIẾM PHIẾU TẠM ỨNG
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
                <table>
                    <tr>
                        <td align="right">
                            Năm:
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
                        <td align="right">
                            Đơn vị:
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtMaDV" Width="70px" Enabled="false" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMaDV"
                                Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Tháng:
                        </td>
                        <td align="left">
                            <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" AutoPostBack="True"
                                MaxValue="12" MinValue="1" Enabled="true" OnTextChanged="rnThang_TextChanged">
                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                            </telerik:RadNumericTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnThang"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Tên đơn vị:
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtTenDonVi" Width="195px" Enabled="false" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <%--Chi phí:--%>
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="DienGiai"
                                DataValueField="MSChiPhi" DropDownWidth="400px" Height="170px" Width="200px"
                                OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged" Visible="false">
                                <HeaderTemplate>
                                    <table width="400px">
                                        <tr>
                                            <td style="width: 100px">
                                                Mã chi phí
                                            </td>
                                            <td style="width: 300px">
                                                Diễn giải
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="400px">
                                        <tr>
                                            <td style="width: 100px">
                                                <%# Eval("MSChiphi")%>
                                            </td>
                                            <td style="width: 300px">
                                                <%# Eval("DienGiai")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbMaChiPhi"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Phụ trách đơn vị:
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="false" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                DataTextField="Ten" Width="200px" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlNguoiThanhToan" runat="server" DataValueField="MaNV"
                                Visible="false" DataTextField="MaTen" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiThanhToan_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlNguoiThanhToan"
                                Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </center>
            <div style="float: left; width: 450px; height: 348px">
                <fieldset style="width: 450px">
                    <legend>Ngân sách</legend>
                    <telerik:RadGrid ID="RGNganSach" Width="450px" Height="350px" runat="server" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                        AllowSorting="True" ShowStatusBar="True" Skin="Windows7" PageSize="15" OnItemCommand="RGNganSach_ItemCommand"
                        OnPageIndexChanged="RGNganSach_PageIndexChanged" OnPageSizeChanged="RGNganSach_PageSizeChanged"
                        OnSelectedIndexChanged="RGNganSach_SelectedIndexChanged">
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="MSChiphi"
                            ShowGroupFooter="true" TableLayout="Fixed">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                    HeaderText="Năm" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                    HeaderText="Tháng" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="30px">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" FilterControlAltText="Filter MSChiphi column"
                                    HeaderText="Mã CP" ReadOnly="True" SortExpression="MSChiphi" UniqueName="MSChiphi"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="30px">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                    HeaderText="Số tiền (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FooterStyle-Font-Bold="true" FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
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
                    </telerik:RadGrid>
                </fieldset>
            </div>
            <div style="float: left; width: 500px; margin-left: 25px; height: 160px">
                <fieldset style="width: 500px">
                    <legend>Phiếu TU</legend>
                    <telerik:RadGrid ID="RDPhieuTU" runat="server" Width="500px" Height="158px" AllowPaging="true"
                        AllowFilteringByColumn="true" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                        AllowMultiRowEdit="True" OnPageIndexChanged="RDPhieuTU_PageIndexChanged" OnSelectedIndexChanged="RDPhieuTU_SelectedIndexChanged"
                        OnItemCommand="RDPhieuTU_ItemCommand" Skin="Windows7" OnItemDataBound="RDPhieuTU_ItemDataBound"
                        PageSize="10" OnPageSizeChanged="RDPhieuTU_PageSizeChanged">
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="PhieuTU">
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
                                <telerik:GridBoundColumn HeaderText="Phiếu Tạm ứng" UniqueName="PhieuTU" DataField="PhieuTU"
                                    FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <%--<telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                    HeaderText="Năm" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                    HeaderText="Tháng" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="30px">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn DataField="MaNV" FilterControlAltText="Filter MaNV column"
                                    HeaderText="MaNV" ReadOnly="True" SortExpression="MaNV" UniqueName="MaNV" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                    <HeaderStyle Width="40px" HorizontalAlign="Center" />
                                    <ItemStyle Width="40px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                    HeaderText="Số tiền (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="HanThanhToan" FilterControlAltText="Filter HanThanhToan column"
                                    HeaderText="Hạn thanh toán " ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="HanThanhToan"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                    <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
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
                <fieldset>
                    <legend>Chi tiết phiếu TU</legend>

                    <telerik:RadGrid ID="RG" runat="server" Width="500px" Height="158px" AllowPaging="True"
                        AllowFilteringByColumn="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                        AllowMultiRowEdit="True" OnPageIndexChanged="RG_PageIndexChanged"
                        OnItemCommand="RG_ItemCommand" Skin="Windows7" 
                        OnPageSizeChanged="RG_PageSizeChanged" CellSpacing="0" 
                        GridLines="None"  PageSize="10" >
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" >
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
                                    <HeaderStyle Width="20px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="20px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Mã CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tạm ứng" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum">
                                    <HeaderStyle Width="80px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="120px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="120px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
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
                   <%-- <telerik:RadGrid ID="RG" runat="server" Width="500px" Height="158px"  AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" 
                        AllowPaging="True" ShowStatusBar="True" OnCancelCommand="RG_CancelCommand" OnDeleteCommand="RG_DeleteCommand"
                        OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged"
                        OnPageSizeChanged="RG_PageSizeChanged" OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand"
                        Skin="Windows7" PageSize="2">
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true" 
                            AllowColumnsReorder="True" ReorderColumnsOnClient="True">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView ShowFooter="true">
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
                                    <HeaderStyle Width="20px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="20px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tạm ứng" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum">
                                    <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle Width="120px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle Width="120px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>--%>
                </fieldset>
            </div>
           
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
