<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UPdateKeHoachThu.ascx.cs"
    Inherits="uc_update_KeHoachThu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="text-align: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2" border="0">
        <tr>
            <td>
                 Nhóm Doanh Thu:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
               <telerik:RadComboBox ID="cbBoPhan" runat="server" HighlightTemplatedItems="true" Width="260px"
                    DataTextField="HienThi" DataValueField="MaBoPhan" MaxHeight="150px" EnableLoadOnDemand="true"
                    OnItemsRequested="cbBoPhan_ItemsRequested" Enabled="false">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                KH thu:
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
                Thực thu:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rnThucThu" runat="server" MinValue="0" Value="0" Width="260px">
                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
               Ghi chú:
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
                <asp:ImageButton ID="btnEdit" runat="server" CommandName="Update" ImageUrl="~/images/Nutchuanweb/luu.png"
                    ValidationGroup="GEdit" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Thang"),Eval("Nam"),Eval("MABP"),Eval("SoTien"),Eval("ThucThu"),Eval("DienGiai"))%>' />
</div>
