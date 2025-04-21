<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapTamUng_XemXet.aspx.cs" Inherits="Chuongtrinh_LapTamUng_XemXet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
    <script type="text/javascript">

        function openRadWindowShow(ID_Khoa) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa, "RadWindowManager1");
            oWnd.Center();
        }

        function OnClientClose() {
            __doPostBack('fLoadChiTietTamUng', '');
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
            <center>
                <table width="100%" cellpadding="0" cellspacing="0" id="topp">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                XEM XÉT PHIẾU TẠM ỨNG
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
                            <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" 
                                AutoPostBack="True" ontextchanged="rnNam_TextChanged">
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
                            <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server"></asp:TextBox>
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
                                MaxValue="12" MinValue="1" Enabled="true" 
                                ontextchanged="rnThang_TextChanged">
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
                            <asp:TextBox ID="txtTenDonVi" Width="200px" Enabled="false" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Chi phí:
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="DienGiai"
                                DataValueField="MSChiPhi" DropDownWidth="400px" Height="170px" 
                                Width="180px" onselectedindexchanged="cbMaChiPhi_SelectedIndexChanged">
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
            <div style="float: left; width: 500px;">
                <fieldset style="width: 500px">
                    <legend>Ngân sách</legend>
                    <telerik:RadGrid ID="RGNganSach" Width="300px" runat="server" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                        AllowSorting="True" ShowStatusBar="True" EnableLinqExpressions="False" Skin="Windows7"
                        PageSize="15">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView>
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
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
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
                <fieldset style="width: 500px">
                    <legend>Phiếu TU</legend>
                    <telerik:RadGrid ID="RDPhieuTU" runat="server" AllowPaging="true" AllowFilteringByColumn="true"
                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                        OnPageIndexChanged="RDPhieuTU_PageIndexChanged" OnSelectedIndexChanged="RDPhieuTU_SelectedIndexChanged"
                        OnItemCommand="RDPhieuTU_ItemCommand" Skin="Windows7" OnItemDataBound="RDPhieuTU_ItemDataBound"
                        PageSize="15" OnPageSizeChanged="RDPhieuTU_PageSizeChanged">
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
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <%-- <telerik:GridBoundColumn DataField="ConLai" FilterControlAltText="Filter ConLai column"
                                                    HeaderText="Còn lại" ReadOnly="True" SortExpression="ConLai" UniqueName="ConLai"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>--%>
                              <%--  <telerik:GridTemplateColumn HeaderText="Xem xét" UniqueName="DVKiemTra" ShowFilterIcon="false"
                                    AllowFiltering="false" FilterControlWidth="60px">
                                    <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="cbXemXet1" Width="90px" runat="server" AutoPostBack="true"
                                            OnSelectedIndexChanged="cbXemXet1_SelectedIndexChanged">
                                            <Items>
                                                <telerik:RadComboBoxItem Value="false" Text="Chưa xem xét" />
                                                <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hfXemXet" runat="server" Value='<%# Eval("DVKiemTra") %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>--%>
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
                <fieldset style="width: 410px">
                    <legend>Chi tiết phiếu TU</legend>
                    <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                        GridLines="None" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                        ShowStatusBar="True" EnableLinqExpressions="False" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" Skin="Windows7"
                        PageSize="15">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
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
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                    <%--            <telerik:GridBoundColumn HeaderText="Tạm ứng" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>--%>

                                 <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                                        HeaderText="Chi phí còn" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                                        FooterStyle-Font-Bold="true" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                                        DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                                        <FooterStyle Font-Bold="True" ForeColor="Red" />
                                                        <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                        <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    </telerik:GridBoundColumn>


                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                            </Columns>
                            <%--  <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang" HeaderText="Tháng" />
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Thang" HeaderText="Thang" />
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>--%>
                        </MasterTableView>
                    </telerik:RadGrid>
                </fieldset>
            </div>
            <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                cellspacing="0">
                <tr>
                    <td style="vertical-align: top; width: 60%; overflow: scroll">
                        <table width="100%" style="table-layout: fixed;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="top">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="vertical-align: top; width: 50%; overflow: scroll">
                        <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td style="top">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
