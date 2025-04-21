<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LapToTrinh_Update.ascx.cs"
    Inherits="Controls_LapToTrinh_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
       
        <tr>
            <td align="left">
                Loại tiền:
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlLoaiTien" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                    Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlLoaiTien"
                    Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
            <td align="left">
                Tỉ giá:
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                    Width="80px" Enabled="false">
                </telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="left">
                Nội dung:
            </td>
            <td align="left">
                <asp:TextBox ID="txtNoiDung" runat="server" Height="50px" Text='<%#Eval("VeViec") %>'
                    Width="300px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left" colspan="7">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="GEdit" />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
                <asp:HiddenField ID="hdPhieuTamUng" runat="server" Value='<%# Eval("SoToTrinh")%>' />
            </td>
        </tr>
    </table>  
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("TiGia"),Eval("LoaiTien")%>)' />
