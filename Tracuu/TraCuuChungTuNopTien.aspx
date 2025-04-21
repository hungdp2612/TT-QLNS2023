<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TraCuuChungTuNopTien.aspx.cs" Inherits="Tracuu_TraCuuChungTuNopTien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Chọn tháng năm cần xem của chứng từ nộp tiền</legend>
                <center>
                    <table>
                        <tr>
                            <td align="left">
                                Từ ngày:
                            </td>
                            <td align="left">
                                <telerik:RadDatePicker ID="rdTuNgay" runat="server" Width="180px">
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
                                <telerik:RadDatePicker ID="rdDenNgay" runat="server" Width="180px">
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
                                <asp:DropDownList ID="ddlDonVi" runat="server" Width="100%" DataTextField="TenDonVi"
                                    DataValueField="IDMaDV" OnSelectedIndexChanged="ddlDonVi_SelectedIndexChanged"
                                    AutoPostBack="true">
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
                            <td>
                                <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Danh sách chứng từ nộp tiền</legend>
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Số chứng từ nộp tiền" Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Diễn giải chi tiết chứng từ nộp tiền">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <div style="height: 20px;">
                </div>
                <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                    Height="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">
                        <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                            Width="100%" GridLines="None" AllowPaging="True" PageSize="50" AllowSorting="false"
                            AllowFilteringByColumn="True" ShowFooter="true" OnItemCommand="RG_ItemCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged">
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
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="Số phiếu" UniqueName="SoPhieu"
                                        FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NoiDung" HeaderText="Nội dung" UniqueName="NoiDung"
                                        FilterControlWidth="60px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="Loại tiền" UniqueName="LoaiTien"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tigia" HeaderText="Tỉ giá" UniqueName="Tigia"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTien" HeaderText="Tiền nộp" UniqueName="SoTien"
                                        FilterControlWidth="40px" DataFormatString="{0:###,###.##}" FooterStyle-HorizontalAlign="Right"
                                        Aggregate="Sum" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NgayLap" HeaderText="Ngày lập" UniqueName="NgayLap"
                                        FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NguoiLap" HeaderText="Người lập" UniqueName="NguoiLap"
                                        FilterControlWidth="40px" AllowFiltering="true" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NgayKT" HeaderText="Ngày KT" UniqueName="NgayKT"
                                        FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="Kế toán KT" UniqueName="KiemTra"
                                        AllowFiltering="false" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc2" AutoPostBack="false" runat="server" Enabled="false"
                                                Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
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
                    <telerik:RadPageView ID="RadPageView2" runat="server">
                        <telerik:RadGrid ID="RG2" runat="server" AutoGenerateColumns="False" ShowGroupPanel="false"
                            GridLines="None" CellSpacing="0" Width="100%" AllowPaging="True" PageSize="50"
                            AllowFilteringByColumn="true" EnableLinqExpressions="false" ShowFooter="true"
                            OnItemCommand="RG2_ItemCommand" OnPageIndexChanged="RG2_PageIndexChanged" OnPageSizeChanged="RG2_PageSizeChanged">
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
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="Số phiếu" UniqueName="SoPhieu"
                                        FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="Phiếu TU" UniqueName="PhieuTU"
                                        FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MaNS" HeaderText="Mã NS" UniqueName="MaNS" FilterControlWidth="120px"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="GhiChu" HeaderText="Ghi chú" UniqueName="GhiChu"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
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
                                    <telerik:GridBoundColumn DataField="NgayLap" HeaderText="Ngày lập" UniqueName="NgayLap"
                                        FilterControlWidth="40px" AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienThanhToan" HeaderText="Tiền nộp" UniqueName="TienThanhToan"
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
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
