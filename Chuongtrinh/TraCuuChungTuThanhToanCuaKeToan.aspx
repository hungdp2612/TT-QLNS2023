<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TraCuuChungTuThanhToanCuaKeToan.aspx.cs" Inherits="Chuongtrinh_TraCuuChungTuThanhToanCuaKeToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
          
            <div style="height: 10px;">
            </div>
            <center>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
            </center>
            <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
            </telerik:RadWindowManager>
            <center>
                <table>
                    <tr>
                        <td align="right">
                            Tên đơn vị:
                        </td>
                        <td style="width: 10px">
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtTenDonVi" Width="175px" Enabled="false" runat="server"></asp:TextBox>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="right">
                            Phụ trách đơn vị:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="false" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                DataTextField="Ten" Width="180px" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                       
                    </tr>
                    <tr>
                     <td align="right">
                           Từ ngày:
                        </td>
                        <td width="10px">
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdTuNgay" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                Enabled="false">
                                <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                    runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdTuNgay"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        
                         <td style="width: 10px">
                            &nbsp;
                        </td>
                        

                        <td align="right">
                           Đến ngày:
                        </td>
                        <td width="10px">
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdDenNgay" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                Enabled="false">
                                <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                    runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rdDenNgay"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                     <td align="right">
                           Loại phiếu:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlLoaiPhieu" runat="server" DataValueField="MaNV"
                                DataTextField="HoTen" Width="180px" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlLoaiPhieu"
                                Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>

                        <td align="right">
                           Phương thức thanh toán:
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="true" ID="ddlPhuongThucThanhToan" runat="server" DataValueField="MaNV"
                                DataTextField="HoTen" Width="180px" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlPhuongThucThanhToan"
                                Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                            &nbsp;
                        </td>
                    
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="left">
                            <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtMaDV"
                                Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <fieldset style="width: 980px">
                    <legend>Chuyển phương thức thanh toán</legend>
                    <telerik:RadGrid ID="RGTTTU" runat="server" Height="300px" AllowPaging="True" AllowFilteringByColumn="True"
                        AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowMultiRowEdit="True"
                        Skin="Windows7" PageSize="6" ShowFooter="True" CellSpacing="0" GridLines="None">
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Selecting AllowRowSelect="True" />
                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                        </ClientSettings>
                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoPhieu">
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
                                <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                                    FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SoTien" FilterControlAltText="Filter SoTien column"
                                    HeaderText="Số tiền (VND)" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                    <FooterStyle Font-Bold="True" ForeColor="Red" HorizontalAlign="Right" />
                                    <HeaderStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="Xem xét" UniqueName="KiemTra" ShowFilterIcon="false"
                                    AllowFiltering="false" FilterControlWidth="60px">
                                    <HeaderStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle Width="70px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="cbKiemTra" Width="100px" runat="server" AutoPostBack="true">
                                            <Items>
                                                <telerik:RadComboBoxItem Value="false" Text="Chưa xem xét" />
                                                <telerik:RadComboBoxItem Value="True" Text="Xem xét" />
                                            </Items>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hfKiemTra" runat="server" Value='<%# Eval("KiemTra") %>' />
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
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
