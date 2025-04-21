<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="tracuuphieutamung.aspx.cs" Inherits="Tracuu_tracuuphieutamung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <%--   <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
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
            </telerik:RadNotification>--%>
            <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="false" AutoSize="false"
                EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
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
                    </tr>
                </table>
                <asp:TextBox ID="txtMaBP" Visible="false" Enabled="true" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtIDMaCS" Visible="false" Enabled="false" runat="server"></asp:TextBox>
            </center>
            <div>
                <fieldset style="">
                    <legend>Kế hoạch ngân sách</legend>
                    <telerik:RadGrid ID="RGNganSach" runat="server" Height="300px" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="false" AllowSorting="false"
                        ShowStatusBar="True" Skin="Windows7" OnItemCommand="RGNganSach_ItemCommand" OnPageIndexChanged="RGNganSach_PageIndexChanged"
                        OnPageSizeChanged="RGNganSach_PageSizeChanged" OnSelectedIndexChanged="RGNganSach_SelectedIndexChanged"
                        ShowFooter="true">
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
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderText="Chọn">
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                </telerik:GridClientSelectColumn>
                                <telerik:GridBoundColumn DataField="MSChiphi" FilterControlAltText="Filter MSChiphi column"
                                    HeaderText="Mã NS" ReadOnly="True" SortExpression="MSChiphi" UniqueName="MSChiphi"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="30px">
                                    <HeaderStyle Width="60px" HorizontalAlign="Left" />
                                    <ItemStyle Width="70px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" FilterControlAltText="Filter DienGiai column"
                                    HeaderText="Tên NS" ReadOnly="True" SortExpression="DienGiai" UniqueName="DienGiai"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="30px">
                                    <HeaderStyle Width="60px" HorizontalAlign="Left" />
                                    <ItemStyle Width="120px" HorizontalAlign="Left" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTienKH" FilterControlAltText="Filter SoTienKH column"
                                    HeaderText="Ngân sách (VND)" ReadOnly="True" SortExpression="SoTienKH" UniqueName="SoTienKH"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTienBS" FilterControlAltText="Filter SoTienBS column"
                                    HeaderText="NS bổ sung" ReadOnly="True" SortExpression="SoTienBS" UniqueName="SoTienBS"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTienChuyen" FilterControlAltText="Filter SoTienChuyen column"
                                    HeaderText="NS được chuyển" ReadOnly="True" SortExpression="SoTienChuyen" UniqueName="SoTienChuyen"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TienBiChuyen" FilterControlAltText="Filter TienBiChuyen column"
                                    HeaderText="NS chuyển" ReadOnly="True" SortExpression="TienBiChuyen" UniqueName="TienBiChuyen"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SumNS" FilterControlAltText="Filter SumNS column"
                                    HeaderText="Tổng NS" ReadOnly="True" SortExpression="SumNS" UniqueName="SumNS"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TienThucHien" FilterControlAltText="Filter TienThucHien column"
                                    HeaderText="NS thực hiện" ReadOnly="True" SortExpression="TienThucHien" UniqueName="TienThucHien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="STCON" FilterControlAltText="Filter STCON column"
                                    HeaderText="NS còn" ReadOnly="True" SortExpression="STCON" UniqueName="STCON"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
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
            <div>
                <fieldset>
                    <legend>Phiếu TU</legend>
                    <div style="float: left; width: 500px">
                        <telerik:RadGrid ID="RDPhieuTU" runat="server" Height="300px" AllowFilteringByColumn="true"
                            AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                            OnPageIndexChanged="RDPhieuTU_PageIndexChanged" OnSelectedIndexChanged="RDPhieuTU_SelectedIndexChanged"
                            OnItemCommand="RDPhieuTU_ItemCommand" Skin="Windows7" OnItemDataBound="RDPhieuTU_ItemDataBound"
                            OnPageSizeChanged="RDPhieuTU_PageSizeChanged" ShowFooter="True" CellSpacing="0"
                            GridLines="None">
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
                                    <telerik:GridTemplateColumn HeaderText="In" AllowFiltering="false">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                CommandName="PRINT" /></ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                        FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MaNV" FilterControlAltText="Filter MaNV column"
                                        HeaderText="MaNV" ReadOnly="True" SortExpression="MaNV" UniqueName="MaNV" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                        <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                        <ItemStyle Width="50px" HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                        HeaderText="Số tiền" ReadOnly="True" SortExpression="SoTien" UniqueName="SoTien"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NgayLapPhieu" FilterControlAltText="Filter NgayLapPhieu column"
                                        HeaderText="Ngày lập " ReadOnly="True" SortExpression="NgayLapPhieu" UniqueName="NgayLapPhieu"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HanThanhToan" FilterControlAltText="Filter HanThanhToan column"
                                        HeaderText="Hạn TT " ReadOnly="True" SortExpression="HanThanhToan" UniqueName="HanThanhToan"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <%--   <telerik:GridTemplateColumn DataField="DVKiemTra" HeaderText="Đơn vị KT" UniqueName="DVKiemTra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbHieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("DVKiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridTemplateColumn>--%>
                                    <telerik:GridTemplateColumn DataField="KTKiemTra" HeaderText="KT" UniqueName="KTKiemTra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbHieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KTKiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
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
                    </div>
                    <div style="float: left; width: 480px">
                        <telerik:RadGrid ID="RG" runat="server" Height="300px" AllowAutomaticDeletes="True"
                            AllowFilteringByColumn="true" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                            OnPageIndexChanged="RG_PageIndexChanged" OnItemCommand="RG_ItemCommand" Skin="Windows7"
                            ShowFooter="True" OnPageSizeChanged="RG_PageSizeChanged" CellSpacing="0" GridLines="None">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
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
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="Mã CP" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="60px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <HeaderStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tạm ứng" UniqueName="Sotien" DataField="Sotien"
                                        FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                        AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle Width="80px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Lydo" DataField="Lydo"
                                        FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false">
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
                    </div>
                </fieldset>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
