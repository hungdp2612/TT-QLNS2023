<%@ Page Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="TinhHinhThucHienNganSach.aspx.cs"
    Inherits="BaoCao_TinhHinhThucHienNganSach" Title=".::Tình Hình Thực Hiện Ngân Sách::." %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
                                BÁO CÁO TÌNH HÌNH THỰC HIỆN NGÂN SÁCH
                            </center>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            Từ tháng:
                        </td>
                        <td style="width: 10px">
                        </td>
                        <td>
                            <telerik:RadMonthYearPicker ID="rnTuThang" runat="server" Culture="English (United States)">
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput DisplayDateFormat="MM/yyyy" LabelWidth="">
                                </DateInput>
                            </telerik:RadMonthYearPicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnTuThang"
                                ErrorMessage="Từ tháng" ValidationGroup="gLuu">*</asp:RequiredFieldValidator>
                        </td>
                        <td style="width: 10px">
                        </td>
                        <td>
                            Đến tháng:
                        </td>
                        <td style="width: 10px">
                        </td>
                        <td>
                            <telerik:RadMonthYearPicker ID="rnDenThang" runat="server" Culture="English (United States)">
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput DisplayDateFormat="MM/yyyy" LabelWidth="">
                                </DateInput>
                            </telerik:RadMonthYearPicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnDenThang"
                                ErrorMessage="Đến thàng" ValidationGroup="gLuu">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="gLuu" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="7">
                            <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                ValidationGroup="gLuu" OnClick="btXem_Click" />
                            &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                OnClick="btExcel_Click" ValidationGroup="gLuu" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="7">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                </table>
            </center>
            <%--<telerik:RadGrid ID="rg" runat="server" AutoGenerateColumns="False" CellSpacing="0" ShowFooter="true">                
         
                <MasterTableView>
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                      <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                       
                        <telerik:GridBoundColumn DataField="TenDonVi" FilterControlAltText="Filter TenDonVi column"
                            HeaderText="Tên đơn vị" UniqueName="MaBP">
                             <HeaderStyle Width="160px" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle Width="160px" HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NS" FilterControlAltText="Filter NS column"
                            HeaderText="Hế hoạch NS" UniqueName="NS" DataFormatString="{0:0,0}" Aggregate="Sum">
                             <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                          <telerik:GridBoundColumn DataField="NSBS" FilterControlAltText="Filter NSBS column"
                            HeaderText="NS bổ sung" UniqueName="NSBS" DataFormatString="{0:0,0}" Aggregate="Sum">
                             <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="SumNS" FilterControlAltText="Filter SumNS column"
                            HeaderText="Tổng NS sau khi bổ sung" UniqueName="SumNS" DataFormatString="{0:0,0}" Aggregate="Sum">
                             <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien" FilterControlAltText="Filter NSThucHien column"
                            HeaderText="Thực hiện NS" UniqueName="NSThucHien" DataFormatString="{0:0,0}" Aggregate="Sum">
                             <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ST_NS_CON" FilterControlAltText="Filter ST_NS_CON column"
                            HeaderText="Thừa (+), thiếu (-)" UniqueName="ST_NS_CON" DataFormatString="{0:0,0}" Aggregate="Sum">
                             <FooterStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                            <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle"  />
                        </telerik:GridBoundColumn>
                     
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <FilterMenu EnableImageSprites="False">
                    <WebServiceSettings>
                        <ODataSettings InitialContainerName="">
                        </ODataSettings>
                    </WebServiceSettings>
                </FilterMenu>
            </telerik:RadGrid>--%>
            <telerik:RadGrid ID="rg" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                GridLines="Both">
                <MasterTableView>
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="STT" FilterControlAltText="Filter STT column"
                            HeaderText="STT" UniqueName="STT">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TenDonVi" FilterControlAltText="Filter TenDonVi column"
                            HeaderText="Tên đơn vị" UniqueName="TenDonVi">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TongNSThang" FilterControlAltText="Filter TongNSThang column"
                            HeaderText="Kế hoạch" UniqueName="TongNSThang" DataFormatString="{0:0,0}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NSThucHien" FilterControlAltText="Filter NSThucHien column"
                            HeaderText="Thực hiện" UniqueName="NSThucHien" DataFormatString="{0:0,0}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="THUCCHI" FilterControlAltText="Filter THUCCHI column"
                            HeaderText="KH CHI" UniqueName="THUCCHI" DataFormatString="{0:0,0}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ThuaThieu" FilterControlAltText="Filter ThuaThieu column"
                            HeaderText="Thừa (+), thiếu (-)" UniqueName="ThuaThieu" DataFormatString="{0:0,0}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TH/KH" FilterControlAltText="Filter TH/KH column"
                            HeaderText="TH/KH" UniqueName="TH/KH">
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
