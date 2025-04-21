<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="XemChungTuThanhToan_Mar.aspx.cs" Inherits="Chuongtrinh_XemChungTuThanhToan_Mar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                window.onload = function () {
                    window.setTimeout(function () { setCalendarTable(); }, 200);
                    window.setTimeout(function () { setCalendarTableDen(); }, 200);

                }
                function SetUpNavigation() {

                }
                function setCalendarTable() {

                    var picker = $find("<%= rdTuThangThanhToan.ClientID %>");
                    var calendar = picker.get_calendar();
                    var fastNavigation = calendar._getFastNavigation();

                    $clearHandlers(picker.get_popupButton());
                    $addHandler(picker.get_popupButton(), "click", function () {
                        var textbox = picker.get_textBox();
                        //adjust where to show the popup table 
                        var x, y;
                        var adjustElement = textbox;
                        if (textbox.style.display == "none")
                            adjustElement = picker.get_popupImage();

                        var pos = picker.getElementPosition(adjustElement);
                        x = pos.x;
                        y = pos.y + adjustElement.offsetHeight;

                        var e = {
                            clientX: x,
                            clientY: y - document.documentElement.scrollTop
                        };
                        //synchronize the input date if set with the picker one
                        var date = picker.get_selectedDate();
                        if (date) {
                            calendar.get_focusedDate()[0] = date.getFullYear();
                            calendar.get_focusedDate()[1] = date.getMonth() + 1;
                        }

                        $get(calendar._titleID).onclick(e);
                        return false;
                    });

                    fastNavigation.OnOK =
                    function () {
                        var date = new Date(fastNavigation.Year, fastNavigation.Month, 1);
                        picker.get_dateInput().set_selectedDate(date);
                        fastNavigation.Popup.Hide();
                    }


                    fastNavigation.OnToday =
                    function () {
                        var date = new Date();
                        picker.get_dateInput().set_selectedDate(date);
                        fastNavigation.Popup.Hide();
                    }

                }
                function setCalendarTableDen() {

                    var picker = $find("<%= rdDenThangThanhToan.ClientID %>");
                    var calendar = picker.get_calendar();
                    var fastNavigation = calendar._getFastNavigation();

                    $clearHandlers(picker.get_popupButton());
                    $addHandler(picker.get_popupButton(), "click", function () {
                        var textbox = picker.get_textBox();
                        //adjust where to show the popup table 
                        var x, y;
                        var adjustElement = textbox;
                        if (textbox.style.display == "none")
                            adjustElement = picker.get_popupImage();

                        var pos = picker.getElementPosition(adjustElement);
                        x = pos.x;
                        y = pos.y + adjustElement.offsetHeight;

                        var e = {
                            clientX: x,
                            clientY: y - document.documentElement.scrollTop
                        };
                        //synchronize the input date if set with the picker one
                        var date = picker.get_selectedDate();
                        if (date) {
                            calendar.get_focusedDate()[0] = date.getFullYear();
                            calendar.get_focusedDate()[1] = date.getMonth() + 1;
                        }

                        $get(calendar._titleID).onclick(e);
                        return false;
                    });

                    fastNavigation.OnOK =
                    function () {
                        var date = new Date(fastNavigation.Year, fastNavigation.Month, 1);
                        picker.get_dateInput().set_selectedDate(date);
                        fastNavigation.Popup.Hide();
                    }


                    fastNavigation.OnToday =
                    function () {
                        var date = new Date();
                        picker.get_dateInput().set_selectedDate(date);
                        fastNavigation.Popup.Hide();
                    }

                }   
            </script>
            <div style="height: 10px;">
            </div>
            <center>
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Xem ngân sách chi tiết thực hiện" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Tra cứu chi tiết chứng từ thanh toán">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                    Height="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <table cellpadding="2" cellspacing="2">
                            <tr>
                                <td align="left">
                                    Từ tháng:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadMonthYearPicker ID="rdTuThang" runat="server" Culture="English (United States)">
                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        <DateInput DateFormat="MMMM, yyyy" DisplayDateFormat="MM/yyyy" LabelWidth="">
                                        </DateInput>
                                    </telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdTuThang"
                                        Display="Dynamic" ErrorMessage="Nhập tháng." SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    Đến tháng:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadMonthYearPicker ID="rdDenThang" runat="server" Culture="English (United States)">
                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        <DateInput DateFormat="MMMM, yyyy" DisplayDateFormat="MM/yyyy" LabelWidth="">
                                        </DateInput>
                                    </telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdDenThang"
                                        Display="Dynamic" ErrorMessage="Nhập tháng." SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                </td>
                                <tr>
                                    <td align="left">
                                        Đơn vị
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="IDMaDV" runat="server"
                                            Width="460px" Enabled="true" OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                        </table>
                        <table>
                            <tr>
                                <td colspan="7" align="center">
                                    <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/Images/Nutchuanweb/btXem.png"
                                        OnClick="btXem_Click" ValidationGroup="GInsert" />
                                    &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/Images/Nutchuanweb/excell.png"
                                        OnClick="btExcel_Click" ValidationGroup="GInsert" />
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            CellSpacing="0" GridLines="Both"  AllowPaging="True" PageSize="50" EnableLinqExpressions="False"
                            ShowFooter="True" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            AllowSorting="false">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="300"></CollapseAnimation>
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                           <%-- <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            </ClientSettings>--%>
                            <MasterTableView>
                             <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn"  Groupable="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="MaCP_CT" FilterControlAltText="Filter MaCP_CT column"
                                        HeaderText="Mã ngân sách" ReadOnly="True" SortExpression="MaCP_CT" UniqueName="MaCP_CT"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TenQuiCach" FilterControlAltText="Filter TenQuiCach column"
                                        HeaderText="Diễn giải" ReadOnly="True" SortExpression="TenQuiCach" UniqueName="TenQuiCach"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienKHCT" FilterControlAltText="Filter TienKHCT column"
                                        HeaderText="Kế hoạch" ReadOnly="True" SortExpression="TienKHCT" UniqueName="TienKHCT"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienThucHienCT" FilterControlAltText="Filter TienThucHienCT column"
                                        HeaderText="Thực hiện" ReadOnly="True" SortExpression="TienThucHienCT" UniqueName="TienThucHienCT"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KHTH" FilterControlAltText="Filter KHTH column"
                                        HeaderText="KH - TH" ReadOnly="True" SortExpression="KHTH" UniqueName="KHTH"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                           
                                             <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai" HeaderText="Mã NS"></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                          
                                             <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <table>
                            <tr>
                                <td align="left">
                                    Lập từ ngày:
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbTuNgay" runat="server" />
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdLapTuNgay" runat="server" Width="180px">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    Đến ngày:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdLapDenNgay" runat="server" Width="180px">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Từ tháng thanh toán:
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbTuThang" runat="server" />
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdTuThangThanhToan" runat="server" Culture="Vietnamese (Vietnam)"
                                        Width="180px">
                                        <Calendar ID="Calendar2" runat="server">
                                            <ClientEvents OnLoad="SetUpNavigation" />
                                            <FastNavigationSettings TodayButtonCaption="current date" />
                                        </Calendar>
                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="MM/yyyy">
                                            <ClientEvents />
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    Đến tháng:
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdDenThangThanhToan" runat="server" Culture="Vietnamese (Vietnam)"
                                        Width="180px">
                                        <Calendar ID="Calendar1" runat="server">
                                            <ClientEvents OnLoad="SetUpNavigation" />
                                            <FastNavigationSettings TodayButtonCaption="current date" />
                                        </Calendar>
                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="MM/yyyy">
                                            <ClientEvents />
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Đơn vị:
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbDonVi" runat="server" Visible="false" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlDonVi" runat="server" Width="180px" DataTextField="TenDonVi"
                                        DataValueField="IDMaDV">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    Loại thanh toán:
                                </td>
                                <td style="width: 10px">
                                    <asp:CheckBox ID="cbLoaiThanhToan" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlLoaiThanhToan" runat="server" Width="180px">
                                        <asp:ListItem Value="GTTTU">Giấy thanh toán tam ứng</asp:ListItem>
                                        <asp:ListItem Value="GDNTT">Giấy đề nghị thanh toán</asp:ListItem>
                                    </asp:DropDownList>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    Người thanh toán:
                                </td>
                                <td>
                                    <asp:CheckBox ID="cbNguoiThanhToan" runat="server" />
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="tbNguoiThanhToan" runat="server" Width="175px"></asp:TextBox>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                        <ProgressTemplate>
                                            <img src="../images/ajax-loader-bar.gif" alt="" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:ImageButton ID="btnXemChungTu" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                        OnClick="btnXemChungTu_Click" />
                                    &nbsp;<asp:ImageButton ID="btnExcellChungTu" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                        OnClick="btnExcellChungTu_Click" />
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="rgChungTu" runat="server" AutoGenerateColumns="False" ShowGroupPanel="false"
                            GridLines="Both" CellSpacing="0" Width="100%" AllowPaging="True" PageSize="50"
                            EnableLinqExpressions="false" ShowFooter="true" OnPageIndexChanged="rgChungTu_PageIndexChanged"
                            OnPageSizeChanged="rgChungTu_PageSizeChanged">
                            <MasterTableView>
                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
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
                                    <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Mã ngân sách" UniqueName="DienGiai"
                                        FilterControlWidth="40px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TenvaQuiCach" HeaderText="Tên - Qui cách" UniqueName="TenvaQuiCach"
                                        FilterControlWidth="40px">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoHoaDon" HeaderText="Số HĐ" UniqueName="SoHoaDon"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="Loại tiền" UniqueName="LoaiTien"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tigia" HeaderText="Tỉ giá" UniqueName="Tigia"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoLuong" HeaderText="Số lượng" UniqueName="SoLuong"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DonGia" HeaderText="Đơn giá" UniqueName="DonGia"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NgayLap" HeaderText="Ngày lập" UniqueName="NgayLap"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HanThanhToan" HeaderText="Hạn TT" UniqueName="HanThanhToan"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienThanhToan" FilterControlAltText="Filter TienThanhToan column"
                                        HeaderText="Thực hiện" ReadOnly="True" SortExpression="TienThanhToan" UniqueName="TienThanhToan"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="SoPhieu" FieldName="SoPhieu"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="NoiDung" FieldName="NoiDung"></telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldName="SoPhieu"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldName="NoiDung"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </center>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
            <asp:PostBackTrigger ControlID="btnExcellChungTu" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
