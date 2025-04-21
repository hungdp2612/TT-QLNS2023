<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="CapNhatNghiepVuTienMatNganHang.aspx.cs" Inherits="Chuongtrinh_CapNhatNghiepVuTienMatNganHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="bgtieudebox">
                    <center>
                        CẬP NHẬT CÁC NGHIỆP VỤ CHI TIỀN MẶT, NGÂN HÀNG
                    </center>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table>
                        <tr>
                            <td align="left">
                                Tháng:
                            </td>
                            <td style="width: 10">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnThang" runat="server" Culture="Vietnamese (Vietnam)"
                                    MaxLength="2" MaxValue="12" MinValue="1" Width="50px">
                                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnThang"
                                    Display="Dynamic" ErrorMessage="Nhập tháng." SetFocusOnError="True" ValidationGroup="gLuuTam">*</asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 10">
                            </td>
                            <td align="left">
                                Năm:
                            </td>
                            <td style="width: 10">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Culture="Vietnamese (Vietnam)"
                                    MaxLength="4" MaxValue="3000" MinValue="0" Width="60px">
                                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnNam"
                                    Display="Dynamic" ErrorMessage="Nhập năm." SetFocusOnError="True" ValidationGroup="gLuuTam">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="7">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="gLuuTam"
                                    DisplayMode="SingleParagraph" />
                                <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="7">
                                <asp:ImageButton ID="tbXem" runat="server" ImageUrl="~/Images/Nutchuanweb/btXem.png"
                                    ValidationGroup="gLuuTam" OnClick="tbXem_Click" />
                                &nbsp;<asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                                    OnClick="btLuu_Click" ValidationGroup="gLuuTam" />
                            </td>
                        </tr>
                    </table>
                    <telerik:RadGrid ID="RG" runat="server" Width="100%" AutoGenerateColumns="False"
                        GridLines="None">
                        <MasterTableView  ShowFooter="true" >
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="STT">
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="MaNS" HeaderText="Mã ngân sách" UniqueName="MaNS">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Diễn giải" UniqueName="DienGiai">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="ChiPhi" HeaderText="Chi phí" UniqueName="ChiPhi"
                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" FooterAggregateFormatString="{0:0,0} đ">
                                    <ItemTemplate>
                                        <%# String.Format("{0:0,0}", Eval("ChiPhi"))%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="chitiet">
                                    <ItemTemplate>
                                        <a href="#" onclick="openRadWindow('<%# Eval("MaNS") %>'); return false;" />
                                        <img title="Chi tiết" alt="" border="0" src="../Images/Nutchuanweb/detail.png" />
                                        </a>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </center>
</asp:Content>
