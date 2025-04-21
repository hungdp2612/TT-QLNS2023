<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UpdateCHIPHI_THUCHIEN.ascx.cs"
    Inherits="Controls_UpdateCHIPHI_THUCHIEN" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Mã CP:
            </td>
            <td align="left">
                <asp:TextBox ID="txtMaCP" runat="server" Enabled="False" Width="145px" Text='<%# Bind( "MSCHIPHI") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Chi phí:
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" Value="0" Width="150px">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtKhoa" runat="server" Visible="false" Width="145px" Text='<%# Bind( "kHOA") %>'></asp:TextBox>
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
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("CHIPHI")) %>' />
