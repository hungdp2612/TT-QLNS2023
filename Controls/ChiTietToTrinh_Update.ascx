<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietToTrinh_Update.ascx.cs"
    Inherits="Controls_ChiTietToTrinh_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
            <td align="right">
                Số tờ trình:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="UCtxtSoToTrinh" runat="server" Width="185px" Text='<%# Bind( "SoToTrinh") %>'
                    Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <%-- <tr>
            <td align="right">
                Năm:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="txtNam" runat="server" Width="185px" Text='<%# Bind( "Nam") %>' Enabled="false"></asp:TextBox>             
               
            </td>
        </tr>     --%>
        <tr>
            <td align="right">
                MS chi phí:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="UCtxtMSChiPhi" runat="server" Width="185px" Text='<%# Bind( "MSChiPhi") %>'
                    Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Chi phí:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <telerik:RadNumericTextBox ID="UCrnChiPhi" runat="server" MinValue="0" Value="0"
                    Width="190px">
                    <%--<IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />--%>
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ghi chú:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="UCtxtGhiChu" runat="server" Width="185px" Text='<%# Bind( "GhiChu") %>'
                    Enabled="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
                <%-- <asp:HiddenField ID="hdPhieuTamUng" runat="server" Value='<%# Eval("PhieuTU")%>' />--%>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("SoTien"))%>' />
