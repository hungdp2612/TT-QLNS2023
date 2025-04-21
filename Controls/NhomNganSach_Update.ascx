<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NhomNganSach_Update.ascx.cs"
    Inherits="Controls_NhomNganSach_Update" %>
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Mã nhóm:
            </td>
            <td>
                <asp:TextBox ID="txtMaNhom" runat="server" Width="100px" Enabled="false" Text='<%# Bind( "MaNhomNS") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMaNhom"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="Gedit"></asp:RequiredFieldValidator>
            </td>
            <td align="right">
                Diễn giải:
            </td>
            <td>
                <asp:TextBox ID="txtDienGiai" runat="server" Width="300px" Text='<%# Bind( "DienGiai") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDienGiai"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="Gedit"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="10" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
            </td>
        </tr>
    </table>
</div>
<br />
