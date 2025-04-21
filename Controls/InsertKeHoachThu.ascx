<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InsertKeHoachThu.ascx.cs"
    Inherits="uc_insert_KeHoachThu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="text-align: left; margin-left: 20px">
    <table border="0">
       
        <tr>
            <td>
                Nhóm Doanh Thu:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <telerik:RadComboBox ID="cbBoPhan" runat="server" HighlightTemplatedItems="true" Width="260px"
                    DataTextField="Tendonvi" DataValueField="Madonvi" MaxHeight="150px" EnableLoadOnDemand="true"
                    OnItemsRequested="cbBoPhan_ItemsRequested">
                </telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMABP" runat="server" ControlToValidate="cbBoPhan"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Doanh thu (Có VAT):
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rnSoTien" runat="server" MinValue="0" Value="0" Width="260px">
                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Diễn giải:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:TextBox ID="tbDienGiai" runat="server" Width="255px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btnInsert" runat="server" CommandName="PerformInsert" ImageUrl="~/images/Nutchuanweb/luu.png"
                    ValidationGroup="GInsert" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
            </td>
        </tr>
    </table>
</div>
