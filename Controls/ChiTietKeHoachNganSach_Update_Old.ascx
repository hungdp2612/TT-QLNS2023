<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSach_Update_Old.ascx.cs"
    Inherits="Controls_ChiTietKeHoachNganSach_Update_Old" %>
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
            <td>
                <asp:TextBox ID="UCtxtMSChiPhi" runat="server" Width="185px" Text='<%# Bind( "MSChiphi") %>'
                    Enabled="false"></asp:TextBox>
            </td>
            <td align="right">
                Chi phí:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="UCrnChiPhi" runat="server" MinValue="0" Value="0"
                    Width="190px">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                ĐV nhận UQ:
            </td>
            <td>
                <telerik:RadComboBox ID="cboDVNhanUQ" runat="server" Skin="Windows7" Width="190px"
                    DataTextField="TENDONVI" DataValueField="MADONVI" Enabled="true">
                </telerik:RadComboBox>
                <%--<asp:TextBox ID="txtDVNhanUQ" runat="server" Width="185px" Text='<%# Bind( "MaDVNhanUQ") %>'
                    Enabled="false"></asp:TextBox>--%>
            </td>
            <td align="right">
                Tỉ lệ UQ(%):
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTiLeUQ" runat="server" MinValue="0" Value="0" Skin="Windows7"
                    MaxValue="100" Width="190px">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ghi chú:
            </td>
            <td colspan="10">
                <asp:TextBox ID="UCtxtGhiChu" runat="server" Width="99%" Text='<%# Bind( "Ghichu") %>'
                    Enabled="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtMaNV" runat="server" Width="185px" Text='<%# Bind("MaNV") %>'
                    Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtMaBP" runat="server" Width="185px" Text='<%# Bind("MaBP") %>'
                    Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtMaDV" runat="server" Width="185px" Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtGhiChuCapNhat" runat="server" Width="185px" Text='<%# Bind("Ghichu") %>'
                    Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtSoTienCapNhat" runat="server" Width="185px" Text='<%# Bind("Sotien") %>'
                    Visible="false"></asp:TextBox>
            </td>
            <td>
                <asp:TextBox ID="UCtxtKhoaKHNS" runat="server" Width="185px" Text='<%# Bind( "ID_Khoa") %>'
                    Enabled="false" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="11" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
                <%-- <asp:HiddenField ID="hdPhieuTamUng" runat="server" Value='<%# Eval("PhieuTU")%>' />--%>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Sotien"),Eval("TiLeUQ"),Eval("MaDVNhanUQ"))%>' />
<asp:TextBox ID="txtIDKhoaCT" runat="server" Width="185px" Text='<%# Bind( "ID_KhoaCT") %>'
    Visible="false"></asp:TextBox>
