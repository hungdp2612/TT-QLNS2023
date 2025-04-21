<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NganSach_Update.ascx.cs"
    Inherits="Controls_NganSach_Update" %>
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Mã NS:
            </td>
            <td>
                <asp:TextBox ID="txtMaNS" runat="server" Width="100px" Enabled="false" Text='<%# Bind( "MaNganSach") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMaNS"
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
            <td align="right">
                Mã nhóm:
            </td>
            <td colspan="10">
                <telerik:RadComboBox ID="cbMaNhom" runat="server" Width="470px" DataTextField="DienGiai"
                    DataValueField="MaNhomNS" HighlightTemplatedItems="false" EnableLoadOnDemand="true"
                    AutoPostBack="true">
                </telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cbMaNhom"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Gedit"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("MaNhomNS"))%>' />
</div>
<br />
