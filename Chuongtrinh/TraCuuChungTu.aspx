<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TraCuuChungTu.aspx.cs" Inherits="Chuongtrinh_TraCuuChungTu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
            <%-- <center>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="1000px">
                    <ContentTemplate>
                        <center>
                         
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
            </center>--%>
            <center>
                <telerik:RadTabStrip ID="RadTabStrip2" runat="server" SelectedIndex="0" MultiPageID="MultiPage2">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Tra cứu chứng từ thanh toán" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Tra cứu phiếu tạm ứng">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <div style="height: 20px;">
                </div>
                <telerik:RadMultiPage ID="MultiPage2" runat="server" Width="100%" SelectedIndex="0"
                    Height="100%">
                    <telerik:RadPageView ID="RadPageView3" runat="server">
                        <table>
                            <tr>
                                <td align="left">
                                    Từ ngày lập:
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbTuNgay" runat="server" />
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdLapTuNgay" runat="server" Width="180px" Skin="Windows7">
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
                                    <telerik:RadDatePicker ID="rdLapDenNgay" runat="server" Width="180px" Skin="Windows7">
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
                                    Từ tháng ngân sách:
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbTuThang" runat="server" Visible="true" Skin="Windows7" Checked="true" />
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="rdTuThangThanhToan" runat="server" Width="180px" Visible="true"
                                        Skin="Windows7">
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
                                        Skin="Windows7" Width="180px" Visible="true">
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
                                    <asp:CheckBox ID="cbDonVi" runat="server" Skin="Windows7" Checked="false"  Enabled="true"/>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlDonVi" runat="server" Width="180px" DataTextField="TenDonVi"
                                        Skin="Windows7" DataValueField="IDMaDV" OnSelectedIndexChanged="ddlDonVi_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                                <td align="left">
                                    Loại thanh toán:
                                </td>
                                <td style="width: 10px">
                                    <asp:CheckBox ID="cbLoaiThanhToan" runat="server" Skin="Windows7" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlLoaiThanhToan" runat="server" Width="180px" Skin="Windows7">
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
                                    <asp:CheckBox ID="cbNguoiThanhToan" runat="server" Skin="Windows7" />
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="tbNguoiThanhToan" runat="server" Width="175px" Skin="Windows7"></asp:TextBox>
                                </td>
                                <td style="width: 10px">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                        <ProgressTemplate>
                                            <img src="../images/ajax-loader-bar.gif" alt="" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                            <Tabs>
                                <telerik:RadTab runat="server" Text="Số chứng từ" Selected="True">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Diễn giải chi tiết chứng từ">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                        <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                            Height="100%">
                            <telerik:RadPageView ID="RadPageView1" runat="server">
                                <table>
                                    <tr>
                                        <td align="center" colspan="7">
                                            <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                                OnClick="btXem_Click" />
                                            &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                                OnClick="btExcel_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div style="width: 1000px">
                                    <telerik:RadGrid ID="RGTraCuuCTTT" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                                        Skin="Windows7" Width="100%" GridLines="None" AllowPaging="True" OnPageIndexChanged="RGTraCuuCTTT_PageIndexChanged"
                                        OnPageSizeChanged="RGTraCuuCTTT_PageSizeChanged" PageSize="50" AllowSorting="false"
                                        AllowFilteringByColumn="True" ShowFooter="true" OnItemCommand="RGTraCuuCTTT_ItemCommand1">
                                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                        </ClientSettings>
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
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                                    <ItemTemplate>
                                                        <%# Container.DataSetIndex  + 1%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                                    FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="NoiDung" HeaderText="NỘI DUNG" UniqueName="NoiDung"
                                                    FilterControlWidth="60px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MaDV" HeaderText="ĐƠN VỊ" UniqueName="MaDV" FilterControlWidth="60px"
                                                    AllowFiltering="false" Visible="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="LaTienMat" HeaderText="HTTT" UniqueName="LaTienMat"
                                                    FilterControlWidth="60px" AllowFiltering="false" Visible="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="TienThanhToan" HeaderText="TIỀN TT" UniqueName="TienThanhToan"
                                                    FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                                    Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="NgayLap" HeaderText="NGÀY LẬP" UniqueName="NgayLap"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="HanThanhToan" HeaderText="THÁNG NS" UniqueName="HanThanhToan"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="NguoiLap" HeaderText="NGƯỜI LẬP" UniqueName="NguoiLap"
                                                    FilterControlWidth="40px" AllowFiltering="true" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="HanThanhToanKT" HeaderText="NGÀY KT" UniqueName="HanThanhToanKT"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="BPTCKTKiemtra" HeaderText="KT KT" UniqueName="BPTCKTKiemtra"
                                                    AllowFiltering="false" ShowFilterIcon="false">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbhieuluc2" AutoPostBack="false" runat="server" Enabled="false"
                                                            Checked='<%# clsConvertHelper.Tobool(Eval("BPTCKTKiemtra")) %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="RadPageView2" runat="server">
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
                                <div>
                                    <telerik:RadGrid ID="rgChungTu" runat="server" AutoGenerateColumns="False" ShowGroupPanel="false"
                                        Skin="Windows7" GridLines="None" CellSpacing="0" Width="100%" AllowPaging="True"
                                        PageSize="50" AllowFilteringByColumn="true" EnableLinqExpressions="false" ShowFooter="true"
                                        OnPageIndexChanged="rgChungTu_PageIndexChanged" OnPageSizeChanged="rgChungTu_PageSizeChanged"
                                        OnItemCommand="rgChungTu_ItemCommand">
                                        <MasterTableView ShowGroupFooter="false">
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
                                                <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                                    FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="MÃ NS" UniqueName="DienGiai"
                                                    FilterControlWidth="120px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="TenvaQuiCach" HeaderText="TÊN - QUI CÁCH" UniqueName="TenvaQuiCach"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="GhiChu" HeaderText="GHI CHÚ" UniqueName="GhiChu"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoHoaDon" HeaderText="SỐ HĐ" UniqueName="SoHoaDon"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                                    FilterControlWidth="40px" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SoLuong" HeaderText="SỐ LƯỢNG" UniqueName="SoLuong"
                                                    FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:###,###.##}">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="DonGia" HeaderText="ĐƠN GIÁ" UniqueName="DonGia"
                                                    FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:###,###.##}">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="NgayLap" HeaderText="NGÀY LẬP" UniqueName="NgayLap"
                                                    FilterControlWidth="40px" AllowFiltering="false" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="HanThanhToan" HeaderText="Hạn TT" UniqueName="HanThanhToan"
                                                    FilterControlWidth="40px" AllowFiltering="false" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="TienThanhToan" HeaderText="TIỀN TT" UniqueName="TienThanhToan"
                                                    FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                                    Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
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
                                </div>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="RadPageView4" runat="server">
                        <table>
                            <tr>
                                <td align="left">
                                    Từ ngày:
                                </td>
                                <td align="left">
                                    <telerik:RadDatePicker ID="PTU_rdTuNgay" runat="server" Width="180px" Skin="Windows7">
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
                                    <telerik:RadDatePicker ID="PTU_rdDenNgay" runat="server" Width="180px" Skin="Windows7">
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
                                    Đơn vị:
                                </td>
                                <td align="left" colspan="6">
                                    <asp:DropDownList ID="PTU_ddlDonVi" runat="server" Width="100%" DataTextField="TenDonVi"
                                        Skin="Windows7" DataValueField="IDMaDV" OnSelectedIndexChanged="PTU_ddlDonVi_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="7">
                                    <asp:ImageButton ID="PTU_btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                        OnClick="PTU_btnXem_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtMaBP2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                            Skin="Windows7" Width="100%" GridLines="None" AllowPaging="True" OnPageSizeChanged="RG_PageSizeChanged"
                            PageSize="50" AllowSorting="false" AllowFilteringByColumn="True" ShowFooter="true"
                            OnPageIndexChanged="RG_PageIndexChanged" OnItemCommand="RG_ItemCommand">
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            </ClientSettings>
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
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="PHIẾU TU" UniqueName="PhieuTU"
                                        FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NgayLapPhieu" HeaderText="NGÀY LẬP" UniqueName="NgayLapPhieu"
                                        FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LyDo" HeaderText="NỘI DUNG" UniqueName="LyDo"
                                        FilterControlWidth="60px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTien" HeaderText="TIỀN TU" UniqueName="SoTien"
                                        FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TongTT" HeaderText="TIỀN TT" UniqueName="TongTT"
                                        FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TongNop" HeaderText="TIỀN NỘP" UniqueName="TongNop"
                                        FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienCL" HeaderText="TIỀN CL" UniqueName="TienCL"
                                        FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MaNV" HeaderText="MÃ NV" UniqueName="MaNV" FilterControlWidth="40px"
                                        AllowFiltering="true" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="KTKiemTra" HeaderText="KT KT" UniqueName="KTKiemTra"
                                        AllowFiltering="false" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc2" AutoPostBack="false" runat="server" Enabled="false"
                                                Checked='<%# clsConvertHelper.Tobool(Eval("KTKiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
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
