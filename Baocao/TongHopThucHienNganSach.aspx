<%@ Page Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="TongHopThucHienNganSach.aspx.cs"
    Inherits="BaoCao_TongHopThucHienNganSach" Title=".::Báo cáo tổng hợp thực hiện ngân sách::." %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .RadGrid_Default
        {
            border: 0;
        }
        .RadGrid_Default .rgGroupPanel td
        {
            background-color: #FFFFFF;
            text-align: left;
        }
        .RadGrid_Default .rgGroupPanel
        {
            border: 0;
            text-align: left;
        }
        .rgGroupHeader td p
        {
            text-align: left;
            float: left;
        }
        .rgFooter
        {
            text-align: right;
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
                        BÁO CÁO TÌNH HÌNH THỰC HIỆN KẾ HOẠCH NGÂN SÁCH TOÀN CÔNG TY
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
        <div style="overflow: scroll; width: 990px; height: 400px; float: left">
            <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" GridLines="Both"
                OnGroupsChanging="RG_GroupsChanging" Width="6000px" ShowFooter="true">
                <MasterTableView ShowFooter="true" ShowGroupFooter="true">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <GroupByExpressions>
                        <telerik:GridGroupByExpression>
                            <SelectFields>
                                <telerik:GridGroupByField FieldAlias="NhomNganSachDienGiai" FieldName="NhomNganSachDienGiai"
                                    HeaderText="Nhóm ngân sách"></telerik:GridGroupByField>
                            </SelectFields>
                            <GroupByFields>
                                <telerik:GridGroupByField FieldName="NhomNganSachDienGiai" SortOrder="Ascending"
                                    HeaderText="Nhóm ngân sách"></telerik:GridGroupByField>
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
                        <telerik:GridBoundColumn DataField="NganSachDienGiai" HeaderText="Ngân sách" UniqueName="NganSachDienGiai">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="250px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="250px" />
                            <FooterStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="250px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MSChiPhi" HeaderText="Mã chi phí" UniqueName="MSChiPhi">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_Tong" HeaderText="Tổng cộng KH NS" UniqueName="SoTien_Tong"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_Tong" HeaderText="Tổng cộng BS NS" UniqueName="SoTienBS_Tong"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TongNSThang_Tong" HeaderText="Tổng NS" UniqueName="TongNSThang_Tong"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_Tong" HeaderText="Tổng NS TH" UniqueName="NSThucHien_Tong"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaTong" HeaderText="Thiếu thừa" UniqueName="ThieuThuaTong"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHTong" HeaderText="TH/KH" UniqueName="THKHTong">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_Det1" HeaderText="KH NS Dệt 1" UniqueName="SoTien_Det1"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_Det1" HeaderText="BS Dệt 1" UniqueName="SoTienBS_Det1"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--  <telerik:GridBoundColumn DataField="SoTienChuyen_Det1" HeaderText="NS được chuyển Dệt 1" UniqueName="SoTienChuyen_Det1"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_Det1" HeaderText="NS bị chuyển Dệt 1" UniqueName="TienBiChuyen_Det1"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_Det1" HeaderText="Tổng NS dệt 1"
                            UniqueName="TongNSThang_Det1" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_Det1" HeaderText="NS TH dệt 1" UniqueName="NSThucHien_Det1"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaDet1" HeaderText="Thiếu thừa dệt 1"
                            UniqueName="ThieuThuaDet1" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHDet1" HeaderText="TH/KH dệt 1" UniqueName="THKHDet1">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_Det2" HeaderText="KH NS Dệt 2" UniqueName="SoTien_Det2"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_Det2" HeaderText="BS Dệt 2" UniqueName="SoTienBS_Det2"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--  <telerik:GridBoundColumn DataField="SoTienChuyen_Det2" HeaderText="NS được chuyển Dệt 2" UniqueName="SoTienChuyen_Det2"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_Det2" HeaderText="NS bị chuyển Dệt 2" UniqueName="TienBiChuyen_Det2"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_Det2" HeaderText="Tổng NS dệt 2"
                            UniqueName="TongNSThang_Det2" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_Det2" HeaderText="NS TH dệt 2" UniqueName="NSThucHien_Det2"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaDet2" HeaderText="Thiếu thừa dệt 2"
                            UniqueName="ThieuThuaDet2" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHDet2" HeaderText="TH/KH dệt 2" UniqueName="THKHDet2">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_PXM" HeaderText="KH NS PXM" UniqueName="SoTien_PXM"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_PXM" HeaderText="BS PXM" UniqueName="SoTienBS_PXM"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TongNSThang_PXM" HeaderText="Tổng NS PXM" UniqueName="TongNSThang_PXM"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_PXM" HeaderText="NS TH PXM" UniqueName="NSThucHien_PXM"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaPXM" HeaderText="Thiếu thừa PXM" UniqueName="ThieuThuaPXM"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHPXM" HeaderText="TH/KH PXM" UniqueName="THKHPXM">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_Nhuom" HeaderText="KH NS nhuộm" UniqueName="SoTien_Nhuom"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_Nhuom" HeaderText="BS nhuộm" UniqueName="SoTienBS_Nhuom"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_Nhuom" HeaderText="NS được chuyển nhuộm" UniqueName="SoTienChuyen_Nhuom"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_Nhuom" HeaderText="NS bị chuyển nhuộm" UniqueName="TienBiChuyen_Nhuom"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_Nhuom" HeaderText="Tổng NS nhuộm"
                            UniqueName="TongNSThang_Nhuom" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_Nhuom" HeaderText="NS TH nhuộm" UniqueName="NSThucHien_Nhuom"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaNhuom" HeaderText="Thiếu thừa nhuộm"
                            UniqueName="ThieuThuaNhuom" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHNhuom" HeaderText="TH/KH nhuộm" UniqueName="THKHNhuom">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_CungUng" HeaderText="KH NS cung ứng" UniqueName="SoTien_CungUng"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_CungUng" HeaderText="BS cung ứng" UniqueName="SoTienBS_CungUng"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_CungUng" HeaderText="NS được chuyển cung ứng" UniqueName="SoTienChuyen_CungUng"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>

                         <telerik:GridBoundColumn DataField="TienBiChuyen_CungUng" HeaderText="NS bị chuyển cung ứng" UniqueName="TienBiChuyen_CungUng"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_CungUng" HeaderText="Tổng NS cung ứng"
                            UniqueName="TongNSThang_CungUng" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_CungUng" HeaderText="NS TH cung ứng"
                            UniqueName="NSThucHien_CungUng" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaCungUng" HeaderText="Thiếu thừa cung ứng"
                            UniqueName="ThieuThuaNhuom" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHCungUng" HeaderText="TH/KH cung ứng" UniqueName="THKHCungUng">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_RD" HeaderText="KH NS RD" UniqueName="SoTien_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_RD" HeaderText="BS RD" UniqueName="SoTienBS_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--    <telerik:GridBoundColumn DataField="SoTienChuyen_RD" HeaderText="NS được chuyển RD" UniqueName="SoTienChuyen_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_RD" HeaderText="NS bị chuyển RD" UniqueName="TienBiChuyen_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_RD" HeaderText="Tổng NS RD" UniqueName="TongNSThang_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_RD" HeaderText="NS TH RD" UniqueName="NSThucHien_RD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaRD" HeaderText="Thiếu thừa RD" UniqueName="ThieuThuaRD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHRD" HeaderText="TH/KH RD" UniqueName="THKHRD">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_Marketting" HeaderText="KH NS Marketting"
                            UniqueName="SoTien_Marketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_Marketting" HeaderText="BS Marketting"
                            UniqueName="SoTienBS_Marketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn DataField="SoTienChuyen_Marketting" HeaderText="NS được chuyển Marketting" UniqueName="SoTienChuyen_Marketting"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_Marketting" HeaderText="NS bị chuyển Marketting" UniqueName="TienBiChuyen_Marketting"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_Marketting" HeaderText="Tổng NS Marketting"
                            UniqueName="TongNSThang_Marketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_Marketting" HeaderText="NS TH Marketting"
                            UniqueName="NSThucHien_Marketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaMarketting" HeaderText="Thiếu thừa Marketting"
                            UniqueName="ThieuThuaMarketting" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHMarketting" HeaderText="TH/KH Marketting"
                            UniqueName="THKHMarketting">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_KDND" HeaderText="KH NS KDND" UniqueName="SoTien_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_KDND" HeaderText="BS KDND" UniqueName="SoTienBS_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn DataField="SoTienChuyen_KDND" HeaderText="NS được chuyển KDND" UniqueName="SoTienChuyen_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>

                         <telerik:GridBoundColumn DataField="TienBiChuyen_KDND" HeaderText="NS bị chuyển KDND" UniqueName="TienBiChuyen_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_KDND" HeaderText="Tổng NS KDND" UniqueName="TongNSThang_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_KDND" HeaderText="NS TH KDND" UniqueName="NSThucHien_KDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaKDND" HeaderText="Thiếu thừa KDND" UniqueName="ThieuThuaKDND"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHKDND" HeaderText="TH/KH KDND" UniqueName="THKHKDND">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_XK" HeaderText="KH NS XK" UniqueName="SoTien_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_XK" HeaderText="BS XK" UniqueName="SoTienBS_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_XK" HeaderText="NS được chuyển XK" UniqueName="SoTienChuyen_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_XK" HeaderText="NS bị chuyển XK" UniqueName="TienBiChuyen_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_XK" HeaderText="Tổng NS XK" UniqueName="TongNSThang_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_XK" HeaderText="NS TH XK" UniqueName="NSThucHien_XK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaXK" HeaderText="Thiếu thừa XK" UniqueName="ThieuThuaXK"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHXK" HeaderText="TH/KH XK" UniqueName="THKHXK">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_TCKT" HeaderText="KH NS TCKT" UniqueName="SoTien_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_TCKT" HeaderText="BS TCKT" UniqueName="SoTienBS_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--   <telerik:GridBoundColumn DataField="SoTienChuyen_TCKT" HeaderText="NS được chuyển TCKT" UniqueName="SoTienChuyen_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_TCKT" HeaderText="NS bị chuyển TCKT" UniqueName="TienBiChuyen_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_TCKT" HeaderText="Tổng NS TCKT" UniqueName="TongNSThang_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_TCKT" HeaderText="NS TH TCKT" UniqueName="NSThucHien_TCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaTCKT" HeaderText="Thiếu thừa TCKT" UniqueName="ThieuThuaTCKT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHTCKT" HeaderText="TH/KH TCKT" UniqueName="THKHTCKT">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_HCQT" HeaderText="KH NS HCQT" UniqueName="SoTien_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_HCQT" HeaderText="BS HCQT" UniqueName="SoTienBS_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_HCQT" HeaderText="NS được chuyển HCQT" UniqueName="SoTienChuyen_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>

                         <telerik:GridBoundColumn DataField="TienBiChuyen_HCQT" HeaderText="NS bị chuyển HCQT" UniqueName="TienBiChuyen_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_HCQT" HeaderText="Tổng NS HCQT" UniqueName="TongNSThang_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_HCQT" HeaderText="NS TH HCQT" UniqueName="NSThucHien_HCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaHCQT" HeaderText="Thiếu thừa HCQT" UniqueName="ThieuThuaHCQT"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHHCQT" HeaderText="TH/KH HCQT" UniqueName="THKHHCQT">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_NhanSu" HeaderText="KH NS nhân sự" UniqueName="SoTien_NhanSu"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_NhanSu" HeaderText="BS nhân sự" UniqueName="SoTienBS_NhanSu"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_NhanSu" HeaderText="NS được chuyển nhân sự" UniqueName="SoTienChuyen_NhanSu"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_NhanSu" HeaderText="NS bị chuyển nhân sự" UniqueName="TienBiChuyen_NhanSu"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_NhanSu" HeaderText="Tổng NS nhân sự"
                            UniqueName="TongNSThang_NhanSu" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_NhanSu" HeaderText="NS TH nhân sự"
                            UniqueName="NSThucHien_NhanSu" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaNhanSu" HeaderText="Thiếu thừa nhân sự"
                            UniqueName="ThieuThuaNhanSu" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHNhanSu" HeaderText="TH/KH nhân sự" UniqueName="THKHNhanSu">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_TinHoc" HeaderText="KH NS tin học" UniqueName="SoTien_TinHoc"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_TinHoc" HeaderText="BS tin học" UniqueName="SoTienBS_TinHoc"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_TinHoc" HeaderText="NS được chuyển tin học" UniqueName="SoTienChuyen_TinHoc"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_TinHoc" HeaderText="NS bị chuyển tin học" UniqueName="TienBiChuyen_TinHoc"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_TinHoc" HeaderText="Tổng NS tin học"
                            UniqueName="TongNSThang_TinHoc" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_TinHoc" HeaderText="NS TH tin học"
                            UniqueName="NSThucHien_TinHoc" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaTinHoc" HeaderText="Thiếu thừa tin học"
                            UniqueName="ThieuThuaTinHoc" DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}"
                            Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHTinHoc" HeaderText="TH/KH tin học" UniqueName="THKHTinHoc">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_QLCL" HeaderText="KH NS QLCL" UniqueName="SoTien_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_QLCL" HeaderText="BS QLCL" UniqueName="SoTienBS_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%--  <telerik:GridBoundColumn DataField="SoTienChuyen_QLCL" HeaderText="NS được chuyển QLCL" UniqueName="SoTienChuyen_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_QLCL" HeaderText="NS bị chuyển QLCL" UniqueName="TienBiChuyen_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_QLCL" HeaderText="Tổng NS QLCL" UniqueName="TongNSThang_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_QLCL" HeaderText="NS TH QLCL" UniqueName="NSThucHien_QLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaQLCL" HeaderText="Thiếu thừa QLCL" UniqueName="ThieuThuaQLCL"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHQLCL" HeaderText="TH/KH QLCL" UniqueName="THKHQLCL">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTien_BTGD" HeaderText="KH NS BTGD" UniqueName="SoTien_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS_BTGD" HeaderText="BS BTGD" UniqueName="SoTienBS_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <%-- <telerik:GridBoundColumn DataField="SoTienChuyen_BTGD" HeaderText="NS được chuyển BTGD" UniqueName="SoTienChuyen_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                         <telerik:GridBoundColumn DataField="TienBiChuyen_BTGD" HeaderText="NS bị chuyển BTGD" UniqueName="TienBiChuyen_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn DataField="TongNSThang_BTGD" HeaderText="Tổng NS BTGD" UniqueName="TongNSThang_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien_BTGD" HeaderText="NS TH BTGD" UniqueName="NSThucHien_BTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThuaBTGD" HeaderText="Thiếu thừa BTGD" UniqueName="ThieuThuaBTGD"
                            DataFormatString="{0:0,0}" FooterAggregateFormatString="{0:0,0}" Aggregate="Sum">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKHBTGD" HeaderText="TH/KH BTGD" UniqueName="THKHBTGD">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="True">
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </center>
</asp:Content>
