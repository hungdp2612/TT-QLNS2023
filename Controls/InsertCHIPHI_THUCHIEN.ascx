<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InsertCHIPHI_THUCHIEN.ascx.cs"
    Inherits="uc_insert_CHIPHI_THUCHIEN" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="text-align: left; margin-left: 20px">
    <table border="0">       
        <tr>
            <td>
                Mã chi phí:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <telerik:RadComboBox ID="cbMaChiPhi" runat="server" DataTextField="HienThi" DataValueField="MSChiPhi"
                    EnableLoadOnDemand="true" HighlightTemplatedItems="true" MaxHeight="150px" Width="260px"
                    OnItemsRequested="cbMaChiPhi_ItemsRequested">
                </telerik:RadComboBox>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="(*)" ValidationGroup="GInsert"
                    ForeColor="Red" Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td>
                Chi phí:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rnCHIPHI" runat="server" MinValue="0" Value="0" Width="260px">
                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                </telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="(*)"
                    ValidationGroup="GInsert" ControlToValidate="rnCHIPHI" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Chi phí phải > 0"
                    ForeColor="Red" ValueToCompare="0" ControlToValidate="rnCHIPHI" Display="Dynamic"
                    Operator="GreaterThan" ValidationGroup="GInsert"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:ImageButton ID="btnInsert" runat="server" CommandName="PerformInsert" ImageUrl="~/images/Nutchuanweb/luu.png"
                    ValidationGroup="GInsert" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
                <asp:HiddenField ID="hfNam_DonVi" runat="server" />
            </td>
        </tr>
    </table>
</div>
