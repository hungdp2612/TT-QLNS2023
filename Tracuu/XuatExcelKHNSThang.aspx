<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="XuatExcelKHNSThang.aspx.cs" Inherits="TraCuu_XuatExcelKHNSThang" %>

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
                            Tháng:
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
                        <telerik:GridBoundColumn DataField="MaBP" FilterControlAltText="Filter MaBP column"
                            HeaderText="Mã bộ phận" ReadOnly="True" SortExpression="MaBP" UniqueName="MaBP"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            FilterControlWidth="30px">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TenDonVi" FilterControlAltText="Filter TenDonVi column"
                            HeaderText="Tên đơn vị" ReadOnly="True" SortExpression="TenDonVi" UniqueName="TenDonVi"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            FilterControlWidth="30px">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MSChiphi" FilterControlAltText="Filter MSChiphi column"
                            HeaderText="Mã ngân sách" ReadOnly="True" SortExpression="MSChiphi" UniqueName="MSChiphi"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            FilterControlWidth="30px">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Diengiai" FilterControlAltText="Filter Diengiai column"
                            HeaderText="Tên ngân sách" ReadOnly="True" SortExpression="Diengiai" UniqueName="Diengiai"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            FilterControlWidth="30px">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                            HeaderText="Ngân sách (VND)" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
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
                </MasterTableView>
            </telerik:RadGrid>
            
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
