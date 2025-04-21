<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChuyenPhuongThucThanhToan.aspx.cs" Inherits="Chuongtrinh_ChuyenPhuongThucThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="height: 10px;">
            </div>
            <center>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                            </asp:UpdateProgress>
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
            </center>
            <center>
                <table>
                    <tr>
                       
                        <td align="right">
                           Chuyển từ:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlPTTT" runat="server" ForeColor="Black" Width="200px" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlPTTT_SelectedIndexChanged">
                                <asp:ListItem Value="TMSNH">Tiền mặt sang ngân hàng</asp:ListItem>
                                <asp:ListItem Value="NHSTM">Ngân hàng sang tiền mặt</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlPTTT"
                                ValidationGroup="gl1" ForeColor="Red">(*)</asp:RequiredFieldValidator>
                                </td>
                         <td align="right">
                            Đơn vị:
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                DataValueField="MaDV" DataTextField="Ten" Enabled="True" Filter="Contains" Height="100px"
                                MarkFirstMatch="true" Skin="Windows7" Width="200px">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CboMaDV"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gl1"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                        </td>

                    </tr>
                    <tr>
                        <td align="right">
                            Từ ngày:
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdLapTuNgay" runat="server" Width="200px">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rdLapTuNgay"
                                ValidationGroup="gl1" ForeColor="Red">(*)</asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Đến ngày:
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdLapDenNgay" runat="server" Width="200px">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rdLapDenNgay"
                                ValidationGroup="gl1" ForeColor="Red">(*)</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Loại phiếu:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlLoaiPhieu" runat="server" ForeColor="Black" Width="200px">
                                <asp:ListItem Value="GTTTU">Giấy thanh toán tạm ứng</asp:ListItem>
                                <asp:ListItem Value="GTTKTU">Giấy thanh không tạm ứng</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlLoaiPhieu"
                                ValidationGroup="gl1" ForeColor="Red">(*)</asp:RequiredFieldValidator>
                        </td>
                       
                    </tr>
                    <tr>
                    <td></td>
                    <td></td>
                     
                    </tr>
                    <tr>
                    <td></td>
                    <td></td>
                     
                    </tr>
                    <tr>
                        <td align="center" colspan="5">
                            <asp:ImageButton ID="BtnTracuu" runat="server" ImageUrl="~/images/Nutchuanweb/tim.png"
                                ValidationGroup="gl1" OnClick="BtnTracuu_Click" />

                            <asp:ImageButton ID="BtnChuyen" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                ValidationGroup="gl1" Visible="false" onclick="BtnChuyen_Click" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <fieldset style="width: 980px">
                    <legend>Chuyển phương thức thanh toán</legend>                

                    <asp:GridView ID="RGChuyenPTTT" Width="99%" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                        CellPadding="3" Font-Bold="False" Font-Size="Smaller" PageSize="20" 
                        onselectedindexchanged="RGChuyenPTTT_SelectedIndexChanged">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <Columns>
                            <asp:TemplateField HeaderText="STT">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Số phiếu" InsertVisible="False">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_SoPhieu" runat="server" Text='<%# Eval("SoPhieu")%>' Width="100px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nội dung">
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Noidung" runat="server" Text='<%# Eval("NoiDung")%>' Width="190px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Hạn thanh to&#225;n">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_hanthanhtoan" runat="server" Text='<%# Eval("HanThanhToan")%>'
                                        Width="65px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Số tiền thanh to&#225;n">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Tien" runat="server" Text='<%# Eval("SoTien","{0:###,###,###}")%>'
                                        Width="70px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Loại tiền">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_LoaiTien" runat="server" Text='<%# Eval("LoaiTien")%>' Width="30px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Là tiền mặt">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lbl_TM" runat="server" Text='<%# Eval("LaTienmat")%>' Width="30px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                          
                            <asp:TemplateField HeaderText="Chuyển">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="check_Chuyen" runat="server" Width="25px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#912E49" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>

                </fieldset>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
