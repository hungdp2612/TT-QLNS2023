<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Tracuukehoachngansachqui.aspx.cs" Inherits="TraCuu_Tracuukehoachngansachqui" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <center>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                TRA CỨU KẾ HOẠCH NGÂN SÁCH
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
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
                    </tr>
                    <tr>
                        <td align="left">
                            Đơn vị
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left" colspan="5">
                            <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="IDMaDV" runat="server"
                                Width="420px" Enabled="true" OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
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
                        <td colspan="7" align="center">
                            <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                OnClick="btXem_Click" />
                            &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/Images/Nutchuanweb/excell.png"
                                OnClick="btExcel_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </center>
            <telerik:RadGrid ID="RG" Width="1000px" runat="server" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" AllowPaging="false" EnableLinqExpressions="False"
                Skin="Windows7" ShowFooter="True" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                AllowSorting="false">
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>
                <HeaderContextMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="300"></CollapseAnimation>
                </HeaderContextMenu>
                <GroupingSettings CaseSensitive="False" />
                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
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
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="MaNganSach" FilterControlAltText="Filter MaNganSach column"
                            HeaderText="Mã ngân sách" ReadOnly="True" SortExpression="MaNganSach" UniqueName="MaNganSach"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            FilterControlWidth="30px">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienKH" FilterControlAltText="Filter SoTienKH column"
                            HeaderText="Ngân sách (VND)" ReadOnly="True" SortExpression="SoTienKH" UniqueName="SoTienKH"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienBS" FilterControlAltText="Filter SoTienBS column"
                            HeaderText="NS bổ sung" ReadOnly="True" SortExpression="SoTienBS" UniqueName="SoTienBS"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SoTienChuyen" FilterControlAltText="Filter SoTienChuyen column"
                            HeaderText="NS được chuyển" ReadOnly="True" SortExpression="SoTienChuyen" UniqueName="SoTienChuyen"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TienBiChuyen" FilterControlAltText="Filter TienBiChuyen column"
                            HeaderText="NS chuyển" ReadOnly="True" SortExpression="TienBiChuyen" UniqueName="TienBiChuyen"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TongNSThang" FilterControlAltText="Filter TongNSThang column"
                            HeaderText="Tổng NS" ReadOnly="True" SortExpression="TongNSThang" UniqueName="TongNSThang"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien" FilterControlAltText="Filter NSThucHien column"
                            HeaderText="NS thực hiện" ReadOnly="True" SortExpression="NSThucHien" UniqueName="NSThucHien"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThieuThua" FilterControlAltText="Filter ThieuThua column"
                            HeaderText="NS còn (VND)" ReadOnly="True" SortExpression="ThieuThua" UniqueName="ThieuThua"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THKH" FilterControlAltText="Filter THKH column"
                            HeaderText="TH/KH" UniqueName="THKH">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
            <telerik:RadGrid ID="RGExCell" Width="1000px" runat="server" AutoGenerateColumns="False"
                ShowFooter="True" GridLines="Both">
                <MasterTableView>
                    <%-- <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>--%>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Mã ngân sách" UniqueName="TemplateColumn1">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("MaNganSach")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Kế hoạch ngân sách" UniqueName="SoTienKH"
                            Aggregate="Sum" FooterText="" DataField="SoTienKH">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("SoTienKH")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ngân sách bổ sung" UniqueName="SoTienBS"
                            Aggregate="Sum" FooterText="" DataField="SoTienBS">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("SoTienBS")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ngân sách được chuyển" UniqueName="TienBiChuyen"
                            Aggregate="Sum" FooterText="" DataField="TienBiChuyen">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("TienBiChuyen")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ngân sách chuyển" UniqueName="SoTienChuyen"
                            Aggregate="Sum" FooterText="" DataField="SoTienChuyen">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("SoTienChuyen")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Tổng KH NS" UniqueName="TongNSThang" Aggregate="Sum"
                            FooterText="" DataField="TongNSThang">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("TongNSThang")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Thực hiện ngân sách" UniqueName="NSThucHien"
                            Aggregate="Sum" FooterText="" DataField="NSThucHien">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("NSThucHien")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="Ngân sách còn lại" UniqueName="ThieuThua"
                            Aggregate="Sum" FooterText="" DataField="ThieuThua">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("ThieuThua")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn HeaderText="TH/KH" UniqueName="THKH" DataField="THKH">
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Eval("THKH")%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
