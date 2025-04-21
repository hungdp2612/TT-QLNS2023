<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChungTuNopTien_Update.ascx.cs"
    Inherits="Controls_ChungTuNopTien_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
        <tr>
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
        </tr>
        <tr>
            <td align="right">
                Loại tiền:
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlLoaiTien" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                    Width="80px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlLoaiTien"
                    Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Tỉ giá:
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                    Width="80px" Enabled="false">
                </telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Nội dung:
            </td>
            <td align="left">
                <asp:TextBox ID="txtNoiDung" runat="server" Height="25px" Text='<%#Eval("NoiDung") %>'
                    Width="300px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="7">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="GEdit" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
                <asp:HiddenField ID="hdSoPhieuDeNghiThanhToan" runat="server" Value='<%# Eval("SoPhieu")%>' />
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Tigia"),Eval("LoaiTien"),Eval("HanThanhToan")) %>' />
