<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuyDinhThoiGianLapNS_Update.ascx.cs"
    Inherits="Controls_QuyDinhThoiGianLapNS_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<br />
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td class="Rong" align="left">
                Năm:
            </td>
            <td>
                <asp:TextBox ID="txtNam" runat="server" Width="70px" Text='<%# Bind( "Nam") %>' Enabled="false"></asp:TextBox>
            </td>
            <td align="left">
                Tháng:
            </td>
            <td>
                <asp:TextBox ID="txtThang" runat="server" Width="70px" Text='<%# Bind("Thang") %>'
                    Enabled="false"></asp:TextBox>
            </td>
            <td class="Rong" align="left">
                Ngày lập NS:
            </td>
            <td>
                <telerik:RadDatePicker ID="rdNgayLap" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                    Enabled="true" SelectedDate='<%# Bind("Ngaylapngansach") %>'>
                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                        ViewSelectorText="x" runat="server">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                        runat="server">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rdNgayLap"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Gedit"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>
                Hiệu lực
            </td>
            <td>
                <asp:CheckBox ID="ChkHieuLuc" runat="server" Checked='<%# DataBinder.Eval(Container, "DataItem.Hieuluc") %>' />
            </td>
        </tr>
        <tr>
            <td colspan="10" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
            </td>
        </tr>
    </table>
</div>
