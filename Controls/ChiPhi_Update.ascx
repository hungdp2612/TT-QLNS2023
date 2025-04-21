<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiPhi_Update.ascx.cs"
    Inherits="Controls_ChiPhi_Update" %>
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Mã CP:
            </td>
            <td>
                <asp:TextBox ID="txtMaCP" runat="server" Width="100px" Enabled="false" Text='<%# Bind( "MSChiPhi") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMaCP"
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
                Mã Ngân sách:
            </td>
            <td>
                <asp:TextBox ID="txtMaNS" runat="server" Width="100px" Text='<%# Bind( "MaNganSach") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMaNS"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="Gedit"></asp:RequiredFieldValidator>
            </td>
            <td align="right">
                Diễn giải NS:
            </td>
            <td>
                <asp:TextBox ID="txtDienGiaiNS" runat="server" Width="300px" Text='<%# Bind( "DienGiai_NS") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDienGiaiNS"
                    Display="Dynamic" ErrorMessage="*" SetFocusOnError="True" ValidationGroup="Gedit"></asp:RequiredFieldValidator>
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
    <%--<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("MaNhomNS"))%>' />--%>
</div>
<br />
