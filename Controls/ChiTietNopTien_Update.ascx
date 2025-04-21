<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietNopTien_Update.ascx.cs"
    Inherits="Controls_ChiTietNopTien_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {


            rdThanhTien = $find("<%= rdThanhTienAn.ClientID %>");

            rnSoTienThanhToan = $find("<%= rnSoTienThanhToan.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnSoTienConLai.ClientID %>");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + (rdThanhTien.get_value() - rnSoTienThanhToan.get_value()));

        }
    </script>
</telerik:RadScriptBlock>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Số phiếu:
            </td>
            <td width="10">
            </td>
            <td align="left">
                <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="155px" Enabled="False"
                    Text='<%#Eval("SoPhieu") %>'></asp:TextBox>
            </td>
            <td width="10">
            </td>
            <td align="right">
                Lần thứ:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtLanThu" runat="server" Enabled="false" Width="155px" Text='<%#Eval("Lanthu") %>'></asp:TextBox>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right">
                Phiếu tạm ứng:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtPhieuTU" runat="server" Enabled="False" Width="155px" Text='<%#Eval("PhieuTU") %>'></asp:TextBox>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="right">
                Số tiền còn lại:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnSoTienConLai" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="160px" Enabled="False" Value="0">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right">
                Mã chi phí:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtMSCHiPhi" runat="server" Enabled="False" Width="155px" Text='<%#Eval("MSChiPhi") %>'></asp:TextBox>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="right">
                Số tiền thanh toán:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnSoTienThanhToan" runat="server" AutoPostBack="false"
                    Width="160px" Value="0" onkeyup="onkeyupEvent()" >
                </telerik:RadNumericTextBox>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right">
                Ghi chú:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left" colspan="5">
                <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="455px" Text='<%#Eval("GhiChu") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="7">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" AutoPostBack="True"
                    ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rdThanhTienAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
               <%-- <asp:TextBox ID="txtKhoa" runat="server" Height="25px" Visible="false" Text='<%#Eval("CTTT_ID") %>'></asp:TextBox>--%>
            </td>
        </tr>
        <%-- <tr>
            <td colspan="7">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
              
             
                <telerik:RadNumericTextBox ID="rdThanhTienAn" runat="server" Width="160px" Visible="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
            </td>
        </tr>--%>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("TienThanhToan")) %>' />
