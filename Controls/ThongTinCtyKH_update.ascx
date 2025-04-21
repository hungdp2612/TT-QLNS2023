<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ThongTinCtyKH_update.ascx.cs"
    Inherits="Controls_ThongTinCtyKH_update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<fieldset>
    <legend style="color: #980039; font-weight: bold;">THÊM MỚI THÔNG TIN KHÁCH HÀNG</legend>
    <table>
        <tr>
            <td width="100">
            </td>
        </tr>
        <tr>
            <td>
                Mã Khách Hàng
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtMaCongtyKH" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.MaCongtyKH") %>'>
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadTxtMaCongtyKH"
                    Display="Dynamic" ErrorMessage="* MaCongtyKH" ForeColor="Red" ValidationGroup="gInsert"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Tên khách hàng
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtTenCty" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.TenCty") %>'>
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Địa chỉ
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtDiaChi" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.DiaChi") %>'>
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Điện thoại
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtTel" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.Tel") %>'>
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Fax
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtTeleFax" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.TeleFax") %>'>
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Email
            </td>
            <td class="style1">
                <telerik:RadTextBox ID="RadTxtEmail" runat="server" Width="300" Text='<%# DataBinder.Eval(Container, "DataItem.Email") %>'>
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Hiệu lực
            </td>
            <td>
                <asp:CheckBox ID="ChkHieuLuc" runat="server" Checked='<%#clsConvertHelper.Tobool( DataBinder.Eval(Container, "DataItem.hieuluc")) %>' />
            </td>
        </tr>
    </table>
    <p>
        <asp:ImageButton ID="btnInsert" runat="server" CommandName="Update" ImageUrl="~/images/Nutchuanweb/luu.png"
            ValidationGroup="gInsert" />
        &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Nutchuanweb/dong.png"
            CommandName="Cancel" />
    </p>
