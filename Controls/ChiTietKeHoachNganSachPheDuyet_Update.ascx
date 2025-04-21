<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSachPheDuyet_Update.ascx.cs"
    Inherits="Controls_ChiTietKeHoachNganSachPheDuyet_Update" %>
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
                Mã NS:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="txtMSChiPhi" runat="server" Width="185px" Text='<%# Bind( "MSChiphi") %>'
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
                <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" MinValue="0" Value="0" Width="190px">
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
                <asp:TextBox ID="txtGhiChu" runat="server" Width="185px" Text='<%# Bind( "Ghichu") %>'
                    Enabled="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtPheDuyet" runat="server" Width="185px" Text='<%# Bind( "Hieuluc_PD") %>'
                    Enabled="true" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="11">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
                <%-- <asp:HiddenField ID="hdPhieuTamUng" runat="server" Value='<%# Eval("PhieuTU")%>' />--%>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Sotien"))%>' />
<asp:TextBox ID="txtIDKhoaCT" runat="server" Width="185px" Text='<%# Bind( "ID_KhoaCT") %>'
    Visible="false"></asp:TextBox>
