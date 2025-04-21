<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HieuChinhThoiGianLapNS_Update.ascx.cs"
    Inherits="Controls_HieuChinhThoiGianLapNS_Update" %>
<style type="text/css">
    .Rong
    {
        width: 100px;
    }
</style>
<br />
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td>
                <asp:TextBox ID="txtMaDV" runat="server" Width="185px" Text='<%# Bind( "MaDV") %>'
                    Enabled="false" Visible="false"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtNam" runat="server" Width="185px" Text='<%# Bind( "Nam") %>'
                    Enabled="false" Visible="false"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="txtThang" runat="server" Width="185px" Text='<%# Bind("Thang") %>'
                    Enabled="false" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ngày hiệu chỉnh:
            </td>
            <td>
                <telerik:RadDatePicker ID="rdNgayHieuChinh" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                    Enabled="true" SelectedDate='<%# Bind("NgayHieuChinh") %>'>
                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                        ViewSelectorText="x" runat="server">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                        runat="server">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rdNgayHieuChinh"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Hiệu lực:
            </td>
            <td>
                <asp:CheckBox ID="ChkHieuLuc" runat="server" Checked='<%# DataBinder.Eval(Container, "DataItem.Hieuluc") %>' />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
            </td>
        </tr>
    </table>
</div>
<br />
