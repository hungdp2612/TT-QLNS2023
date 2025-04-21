<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="HieuChinhHanThanhToan.aspx.cs" Inherits="Chuongtrinh_HieuChinhHanThanhToan" %>

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
               
            </script>
            <div style="height: 10px;">
            </div>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="text-transform: uppercase">HIỆU CHỈNH GIẤY THANH TOÁN</legend>
                <center>
                    <table>
                        <tr>
                            <td align="left">
                                Từ ngày:
                            </td>
                            <td align="left">
                                <telerik:RadDatePicker ID="rdTuNgay" runat="server" Width="180px" Skin="Windows7">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                </telerik:RadDatePicker>
                            </td>
                            <td align="left">
                                Đến ngày:
                            </td>
                            <td align="left">
                                <telerik:RadDatePicker ID="rdDenNgay" runat="server" Width="180px" Skin="Windows7">
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
                                Loại TT:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLoaiThanhToan" runat="server" Width="180px" Skin="Windows7">
                                    <asp:ListItem Value="GTTTU">Giấy thanh toán tam ứng</asp:ListItem>
                                    <asp:ListItem Value="GDNTT">Giấy đề nghị thanh toán</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Đơn vị:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDonVi" runat="server" Width="180px" DataTextField="TenDonVi"
                                    Skin="Windows7" DataValueField="IDMaDV" OnSelectedIndexChanged="dlDonVi_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="7">
                                <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                    OnClick="btnXem_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="10" align="center">
                                <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="text-transform: uppercase">DANH SÁCH GIẤY THANH TOÁN</legend>
                <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                    Skin="Windows7" Width="100%" GridLines="None" AllowPaging="True" OnPageSizeChanged="RG_PageSizeChanged"
                    PageSize="50" AllowSorting="false" AllowFilteringByColumn="True" ShowFooter="true"
                    OnPageIndexChanged="RG_PageIndexChanged" OnItemCommand="RG_ItemCommand" OnCancelCommand="RG_CancelCommand"
                    OnUpdateCommand="RG_UpdateCommand">
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
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="SỬA" EditText="SỬA">
                                <ItemStyle />
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                AllowFiltering="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NgayLap" HeaderText="NGÀY LẬP" UniqueName="NgayLap"
                                FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NgayIn" HeaderText="NGÀY IN" UniqueName="NgayIn"
                                FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HanThanhToan" HeaderText="HẠN TT" UniqueName="HanThanhToan"
                                FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NoiDung" HeaderText="NỘI DUNG" UniqueName="NoiDung"
                                FilterControlWidth="60px" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                FilterControlWidth="40px" AllowFiltering="false" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SoTien" HeaderText="SỐ TIỀN" UniqueName="SoTien"
                                FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                FilterControlWidth="40px" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NguoiLap" HeaderText="MÃ NV" UniqueName="NguoiLap"
                                FilterControlWidth="40px" AllowFiltering="true" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
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
                        <EditFormSettings EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
