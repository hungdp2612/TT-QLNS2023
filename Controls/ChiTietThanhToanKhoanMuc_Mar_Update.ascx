<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanKhoanMuc_Mar_Update.ascx.cs"
    Inherits="Controls_ChiTietThanhToanKhoanMuc_Mar_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<center>
    <div>
        <table border="0">
            <tr>
                <td align="right">
                    Trừ VAT:
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlVAT" runat="server" Width="185px" AutoPostBack="true">
                        <asp:ListItem Value="0">Không VAT</asp:ListItem>
                        <asp:ListItem Value="10.00">10%</asp:ListItem>
                        <asp:ListItem Value="5.00">5%</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td align="right">
                    Ghi chú:
                </td>
                <td>
                    <asp:TextBox ID="txtGhiChu" runat="server" Width="180px" Text='<%#Eval("GhiChu") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtKhoa_CT_TT_KM" runat="server" Width="180px" Visible="false" Text='<%#Eval("Khoa_CT_TT_KM") %>'></asp:TextBox>
                </td>
                <td>
                    <telerik:RadNumericTextBox ID="rnTienThanhToan" runat="server" Width="185px" Enabled="true" Visible="false">
                    </telerik:RadNumericTextBox>
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
</center>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("TruVAT"),Eval("TienThanhToan")) %>' />
