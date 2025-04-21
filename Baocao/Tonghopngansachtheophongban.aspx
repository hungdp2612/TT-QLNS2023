<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Tonghopngansachtheophongban.aspx.cs" Inherits="Baocao_Tonghopngansachtheophongban" %>

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
                                BÁO CÁO TÌNH HÌNH THỰC HIỆN KẾ HOẠCH NGÂN SÁCH THEO PHONG BAN
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
                                        Đơn vị:
                                    </td>
                                    <td style="width: 10">
                                        &nbsp;
                                    </td>
                                    <td align="left" colspan="5">
                                        <asp:DropDownList ID="ddlDonVi" runat="server" Width="430px" DataTextField="TenDonVi"
                                            DataValueField="MaDonVi" Height="25px" OnSelectedIndexChanged="ddlDonVi_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlDonVi"
                                            Display="Dynamic" ErrorMessage="Chọn đơn vị." ValidationGroup="gIn">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="7">
                                        <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/Nutchuanweb/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>--%>
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="gIn" />
                                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="7">
                                        &nbsp;
                                        <asp:ImageButton ID="btIn" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                            OnClick="btIn_Click" ValidationGroup="gIn" />
                                        &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                            OnClick="btExcel_Click" ValidationGroup="gIn" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </center>
            <%--<telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" GridLines="Both"
                ShowGroupPanel="True" ShowFooter="True">
                <MasterTableView ShowGroupFooter="true">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <GroupByExpressions>
                        <telerik:GridGroupByExpression>
                            <SelectFields>
                                <telerik:GridGroupByField FieldAlias="DienGiaiNhomNS" FieldName="DienGiaiNhomNS"
                                    HeaderText="Nhóm ngân sách"></telerik:GridGroupByField>
                            </SelectFields>
                            <GroupByFields>
                                <telerik:GridGroupByField FieldName="DienGiaiNhomNS" SortOrder="Ascending" HeaderText="Nhóm ngân sách">
                                </telerik:GridGroupByField>
                            </GroupByFields>
                        </telerik:GridGroupByExpression>
                    </GroupByExpressions>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Ngân sách" UniqueName="DienGiai">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                            <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MSChiPhi" HeaderText="Mã CP" UniqueName="MSChiPhi">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NS" HeaderText="Số tiền NS" UniqueName="NS" DataFormatString="{0:0,0}"
                            FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSBS" HeaderText="Số tiền BS" UniqueName="NSBS"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SumNS" HeaderText="Tổng NSách" UniqueName="SumNS"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien" HeaderText="Ngân sách TH" UniqueName="NSThucHien"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ST_NS_CON" HeaderText="Thiếu thừa" UniqueName="ST_NS_CON"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                       
                    </Columns>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="True">
                </ClientSettings>
            </telerik:RadGrid>--%>
            <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" GridLines="Both"
                ShowGroupPanel="True" ShowFooter="True" OnExcelExportCellFormatting="RG_ExcelExportCellFormatting">
                <MasterTableView ShowGroupFooter="true">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <GroupByExpressions>
                        <telerik:GridGroupByExpression>
                            <SelectFields>
                                <telerik:GridGroupByField FieldAlias="DienGiaiNhomNS" FieldName="DienGiaiNhomNS"
                                    HeaderText="Nhóm ngân sách"></telerik:GridGroupByField>
                            </SelectFields>
                            <GroupByFields>
                                <telerik:GridGroupByField FieldName="DienGiaiNhomNS" SortOrder="Ascending" HeaderText="Nhóm ngân sách">
                                </telerik:GridGroupByField>
                            </GroupByFields>
                        </telerik:GridGroupByExpression>
                    </GroupByExpressions>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Ngân sách" UniqueName="DienGiai">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                            <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="200px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MSChiPhi" HeaderText="Mã chi phí" UniqueName="MSChiPhi">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienKH" HeaderText="Số tiền kế hoạch" UniqueName="SoTienKH"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS" HeaderText="Số tiền bổ sung" UniqueName="SoTienBS"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienChuyen" HeaderText="ST được chuyển" UniqueName="SoTienChuyen"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TienBiChuyen" HeaderText="ST chuyển" UniqueName="TienBiChuyen"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TongNSThang" HeaderText="Tổng ngân sách" UniqueName="TongNSThang"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien" HeaderText="Ngân sách thực hiện"
                            UniqueName="NSThucHien" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThua" HeaderText="Thiếu thừa" UniqueName="ThieuThua"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKH" HeaderText="TH/KH" UniqueName="THKH">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="True">
                </ClientSettings>
            </telerik:RadGrid>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
