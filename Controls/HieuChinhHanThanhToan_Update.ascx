<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HieuChinhHanThanhToan_Update.ascx.cs"
    Inherits="Controls_HieuChinhHanThanhToan_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2" border="0" width="100%">
        <tr>
            <td align="right">
                Số phiếu:
            </td>
            <td>
                <asp:TextBox ID="txtSoPhieu" runat="server" Text='<%#Eval("SoPhieu") %>' Width="150px"
                    Enabled="false"></asp:TextBox>
            </td>
            <td align="right">
                Hạn thanh toán:
            </td>
            <td align="left">
                <telerik:RadDatePicker ID="rdHanThanhToan" runat="server" Width="200px" SelectedDate='<%# Bind("HanThanhToan") %>'>
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rdHanThanhToan"
                    Display="Dynamic" ErrorMessage="Chọn hạn thanh toán." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
             <td align="right">
                Ngày in:
            </td>
            <td align="left">
                <telerik:RadDatePicker ID="rdNgayIn" runat="server" Width="200px" SelectedDate='<%# Bind("NgayIn") %>'>
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdNgayIn"
                    Display="Dynamic" ErrorMessage="Chọn ngày in" ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Nội dung:
            </td>
            <td colspan="6">
                <asp:TextBox ID="txtNoiDung" runat="server" Text='<%#Eval("NoiDung") %>' Width="100%"
                    Enabled="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="10">
                <center>
                    <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                        ValidationGroup="Gedit" CommandName="Update" />
                    &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                        CommandName="Cancel" />
                </center>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("HanThanhToan")) %>' />
