<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapTamUng_KTKiemTra.aspx.cs" Inherits="Kiemtra_LapTamUng_KTKiemTra" %>

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
                                KẾ TOÁN KIỂM TRA PHIẾU TẠM ỨNG
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
                            <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True" Enabled="false"
                                OnTextChanged="rnNam_TextChanged">
                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                            </telerik:RadNumericTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Bộ phận:
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                DataValueField="MaDV" DataTextField="MaDV" Enabled="True" Filter="Contains" Height="100px"
                                MarkFirstMatch="true" Skin="Windows7" Width="205px" OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Tháng:
                        </td>
                        <td align="left">
                            <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="70px" AutoPostBack="True"
                                MaxValue="12" MinValue="1" Enabled="false" OnTextChanged="rnThang_TextChanged">
                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                            </telerik:RadNumericTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnThang"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Người kiểm tra:
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtKeToan" Width="200px" Enabled="false" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
             
            </center>
            <div style="float: left; width: 975px;">
                <fieldset style="width: 975px">
                    <legend>Ngân sách</legend>
                    <telerik:RadGrid ID="RGNganSach" Width="975px" Height="200px" runat="server" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" 
                        AllowPaging="True" ShowStatusBar="True" EnableLinqExpressions="False" 
                        Skin="Windows7" ShowFooter="True" onitemcommand="RGNganSach_ItemCommand" 
                        onpageindexchanged="RGNganSach_PageIndexChanged" 
                        onpagesizechanged="RGNganSach_PageSizeChanged">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="300"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <MasterTableView>
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn Visible="false" FilterControlAltText="Filter RowIndicator column">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn Visible="false" FilterControlAltText="Filter ExpandColumn column">
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
                                    HeaderText="Ngân sách (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                       <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TU" FilterControlAltText="Filter TU column" HeaderText="TU (VND)"
                                    ReadOnly="True" SortExpression="TU" UniqueName="TU" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                    AllowFiltering="false"  Aggregate="Sum">
                                          <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TU_CHUATT" FilterControlAltText="Filter TU_CHUATT column"
                                    HeaderText="TU_Chưa TT (VND)" ReadOnly="True" SortExpression="TU_CHUATT" UniqueName="TU_CHUATT"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false"  Aggregate="Sum">
                                          <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TTKHONGTAMUNG" FilterControlAltText="Filter TTKHONGTAMUNG column"
                                    HeaderText="TT_Không TU(VND)" ReadOnly="True" SortExpression="TTKHONGTAMUNG"
                                    UniqueName="TTKHONGTAMUNG" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"  Aggregate="Sum">
                                           <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TTTAMUNG" FilterControlAltText="Filter TTTAMUNG column"
                                    HeaderText="TT TU (VND)" ReadOnly="True" SortExpression="TTTAMUNG" UniqueName="TTTAMUNG"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false"  Aggregate="Sum">
                                          <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                   <telerik:GridBoundColumn DataField="TIENNOP" FilterControlAltText="Filter TIENNOP column"
                                    HeaderText="Tiền nộp (VND)" ReadOnly="True" SortExpression="TIENNOP" UniqueName="TIENNOP"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false"  Aggregate="Sum">
                                         <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="STCON" FilterControlAltText="Filter STCON column"
                                    HeaderText="Số Tiền còn (VND)" ReadOnly="True" SortExpression="STCON" UniqueName="STCON"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false"  Aggregate="Sum">
                                         <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
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
            <div style="float: left; width: 1000px;">
                <div style="float: left; width: 500px;">
                    <fieldset style="width: 500px">
                        <legend>Phiếu TU</legend>
                        <telerik:RadGrid ID="RDPhieuTU" runat="server" Height="300px" AllowPaging="True"
                            AllowFilteringByColumn="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                            AllowMultiRowEdit="True" OnPageIndexChanged="RDPhieuTU_PageIndexChanged" OnSelectedIndexChanged="RDPhieuTU_SelectedIndexChanged"
                            OnItemCommand="RDPhieuTU_ItemCommand" Skin="Windows7" OnItemDataBound="RDPhieuTU_ItemDataBound"
                            PageSize="6" OnPageSizeChanged="RDPhieuTU_PageSizeChanged" ShowFooter="True"
                            CellSpacing="0" GridLines="None">
                            <GroupingSettings CaseSensitive="False" />
                            <%-- <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>--%>
                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
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
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                             <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
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
                                    <telerik:GridTemplateColumn HeaderText="Xác nhận" UniqueName="KTKiemTra" ShowFilterIcon="false"
                                        AllowFiltering="false" FilterControlWidth="60px">
                                        <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <telerik:RadComboBox ID="cbKTKiemTra" Width="100px" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="cbKTKiemTra_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Value="false" Text="Chưa xác nhận" />
                                                    <telerik:RadComboBoxItem Value="True" Text="Xác nhận" />
                                                </Items>
                                            </telerik:RadComboBox>
                                            <asp:HiddenField ID="hfKiemTra" runat="server" Value='<%# Eval("KTKiemTra") %>' />
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
                <div style="float: left; width: 450px; margin-left:25px;">
                    <fieldset style="width: 450px">
                        <legend>Chi tiết phiếu TU</legend>
                        <telerik:RadGrid ID="RG" runat="server" Width="450px" Height="300px" AutoGenerateColumns="False"
                            CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                            AllowSorting="false" ShowStatusBar="True" EnableLinqExpressions="False" OnCancelCommand="RG_CancelCommand"
                            OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged" ShowFooter="true"
                            OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" Skin="Windows7"
                            PageSize="10">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="True" />
                            </ClientSettings>
                            <MasterTableView>
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
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </ExpandCollapseColumn>
                                <Columns>
                                    <%--            <telerik:GridBoundColumn HeaderText="Tạm ứng" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>--%>
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
                                    <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                        HeaderText="Số tiền" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                        FooterStyle-Font-Bold="true" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <FooterStyle Font-Bold="True" ForeColor="Red"  HorizontalAlign="Right"/>
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
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
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
