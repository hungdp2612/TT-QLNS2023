<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LoginInfo.ascx.cs" Inherits="Controls_LoginInfo" %>
<asp:Panel ID="Panel1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td valign="middle" align="right">
                <font color="white"><strong>
                    <asp:Label ID="Label1" runat="server"></asp:Label></strong> &nbsp; |
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Thoát</asp:LinkButton>
                    |
                    <script language="javascript" type="text/javascript">
                        document.write(vndate());
                    </script>
                </font>
            </td>
        </tr>
    </table>
</asp:Panel>
