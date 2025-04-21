<%@ Page Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="TongHopNganSach.aspx.cs"
    Inherits="BaoCao_TongHopNganSach" Title=".::Báo cáo tổng hợp ngân sách::." %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <style type="text/css">
                .rgFooter td
                {
                    text-align: right;
                }
                .rgGroupHeader td
                {
                    text-align: left;
                }
            </style>
            <script type="text/javascript">
                window.onload = function () {
                    window.setTimeout(function () { setCalendarTable(); }, 200);
                    window.setTimeout(function () { setCalendarTableDen(); }, 200);

                }
                function SetUpNavigation() {

                }
                function setCalendarTable() {

                    var picker = $find("<%= rdTuThang.ClientID %>");
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

                    var picker = $find("<%= rdDenThang.ClientID %>");
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
            <center>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                BÁO CÁO KẾ HOẠCH NGÂN SÁCH
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table>
                                <tr>
                                    <td align="left">
                                        Từ tháng:
                                    </td>
                                    <td style="width: 10">
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdTuThang" runat="server" Culture="Vietnamese (Vietnam)"
                                            Width="175px">
                                            <Calendar ID="Calendar2" runat="server">
                                                <ClientEvents OnLoad="SetUpNavigation" />
                                                <FastNavigationSettings TodayButtonCaption="current date" />
                                            </Calendar>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            <DateInput ID="DateInput1" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="MM/yyyy">
                                                <ClientEvents />
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdTuThang"
                                            Display="Dynamic" ErrorMessage="Chọn từ tháng." ValidationGroup="gIn">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 10">
                                    </td>
                                    <td align="left">
                                        Đến tháng:
                                    </td>
                                    <td style="width: 10">
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdDenThang" runat="server" Culture="Vietnamese (Vietnam)"
                                            Width="175px">
                                            <Calendar ID="Calendar1" runat="server">
                                                <ClientEvents OnLoad="SetUpNavigation" />
                                                <FastNavigationSettings TodayButtonCaption="current date" />
                                            </Calendar>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            <DateInput ID="DateInput2" runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="MM/yyyy">
                                                <ClientEvents />
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdDenThang"
                                            Display="Dynamic" ErrorMessage="Chọn đến tháng." ValidationGroup="gIn">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Ngày trình:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdNgayTrinh" runat="server" Culture="Vietnamese (Vietnam)"
                                            Width="175px">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        Ngày nhận:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdNgayNhan" runat="server" Culture="Vietnamese (Vietnam)"
                                            Width="175px">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Người trình:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlNguoiTrinh" runat="server" Width="175px" DataValueField="HoTen"
                                            DataTextField="HoTen" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiTrinh_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        Người nhận:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlNguoiNhan" runat="server" Width="175px" DataValueField="HoTen"
                                            DataTextField="HoTen" AutoPostBack="True" OnSelectedIndexChanged="ddlNguoiNhan_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Bộ phận:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbBoPhan" runat="server" Enabled="False" Width="170px"></asp:TextBox>
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        &nbsp;Bộ phận:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbBoPhanNhan" runat="server" Enabled="False" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Chức vụ:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbChucVu" runat="server" Enabled="False" Width="170px"></asp:TextBox>
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        Chức vụ
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbChucVuNhan" runat="server" Enabled="False" Width="170px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="7">
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/Nutchuanweb/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="gIn" />
                                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </center>
            <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="false" AutoSize="false"
                EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                Width="1000px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                EnableViewState="False">
                <Shortcuts>
                    <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                </Shortcuts>
                <Windows>
                    <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize, Reload"
                        VisibleStatusbar="false" ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True"
                        KeepInScreenBounds="True" InitialBehaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="MultiPage" ReorderTabsOnSelect="True"
                SelectedIndex="0">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Bảng in" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xuất excel">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0">
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <center>
                        <table>
                            <tr>
                                <td align="center">
                                    <asp:ImageButton ID="btIn" runat="server" ImageUrl="~/images/Nutchuanweb/in.png"
                                        OnClick="btIn_Click" ValidationGroup="gIn" />
                                </td>
                            </tr>
                        </table>
                    </center>
                    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <center>
                        <table>
                            <tr>
                                <td align="center">
                                    <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                        OnClick="btXem_Click" ValidationGroup="gIn" />
                                    &nbsp;
                                    <asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                        OnClick="btExcel_Click" ValidationGroup="gIn" />
                                </td>
                            </tr>
                        </table>
                        <div style="overflow: scroll; width: 1000px; height: 500px">
                            <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                                GridLines="Both" ShowGroupFooter="true">
                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                </HeaderContextMenu>
                                <MasterTableView ShowGroupFooter="true">
                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn Groupable="False" HeaderText="STT" ReadOnly="True" UniqueName="STT"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MSChiPhi" FilterControlAltText="Filter MSChiPhi column"
                                            HeaderText="Mã chi phí" UniqueName="MSChiPhi">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" FilterControlAltText="Filter DienGiai column"
                                            HeaderText="Diễn giải" UniqueName="DienGiai">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Cong" FilterControlAltText="Filter Cong column"
                                            HeaderText="Cộng" UniqueName="Cong" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Det1" FilterControlAltText="Filter Det1 column"
                                            HeaderText="Dệt 1" UniqueName="Det1" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Det2_PXMay" FilterControlAltText="Filter Det2_PXMay column"
                                            HeaderText="Dệt 2 + May" UniqueName="Det2_PXMay" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Nhuom" FilterControlAltText="Filter Nhuom column"
                                            HeaderText="Nhuộm" UniqueName="Nhuom" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CungUng" FilterControlAltText="Filter CungUng column"
                                            HeaderText="C.Ứng" UniqueName="CungUng" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RD" FilterControlAltText="Filter RD column" HeaderText="RD"
                                            UniqueName="RD" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Marketting" FilterControlAltText="Filter Marketting column"
                                            HeaderText="T.Thị" UniqueName="Marketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="KDND" FilterControlAltText="Filter KDND column"
                                            HeaderText="NĐ" UniqueName="KDND" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="XK" FilterControlAltText="Filter XK column" HeaderText="Xuất khẩu"
                                            UniqueName="XK" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TCKT" FilterControlAltText="Filter TCKT column"
                                            HeaderText="TCKT" UniqueName="TCKT" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="HCQT" FilterControlAltText="Filter HCQT column"
                                            HeaderText="HCQT" UniqueName="HCQT" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NhanSu" FilterControlAltText="Filter NhanSu column"
                                            HeaderText="Nhân sự" UniqueName="NhanSu" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TinHoc" FilterControlAltText="Filter TinHoc column"
                                            HeaderText="Tin học" UniqueName="TinHoc" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="QLCL" FilterControlAltText="Filter QLCL column"
                                            HeaderText="QLCL" UniqueName="QLCL" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>


                                         <telerik:GridBoundColumn DataField="BTGD" FilterControlAltText="Filter BTGD column"
                                            HeaderText="BTGD" UniqueName="BTGD" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                                            Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <GroupByExpressions>
                                        <telerik:GridGroupByExpression>
                                            <SelectFields>
                                                <telerik:GridGroupByField FieldAlias="ThuChi" FieldName="ThuChi" HeaderText="Thu chi" />
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldName="ThuChi" HeaderText="Thu chi" />
                                            </GroupByFields>
                                        </telerik:GridGroupByExpression>
                                        <telerik:GridGroupByExpression>
                                            <SelectFields>
                                                <telerik:GridGroupByField FieldAlias="DienGiaiNhomNS" FieldName="DienGiaiNhomNS"
                                                    HeaderText="Nhóm ngân sách" />
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldName="DienGiaiNhomNS" HeaderText="Nhóm ngân sách" />
                                            </GroupByFields>
                                        </telerik:GridGroupByExpression>
                                    </GroupByExpressions>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                            </telerik:RadGrid>
                        </div>
                    </center>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
        <Triggers>
        <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
