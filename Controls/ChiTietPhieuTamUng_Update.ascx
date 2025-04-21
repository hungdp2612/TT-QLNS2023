<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietPhieuTamUng_Update.ascx.cs"
    Inherits="Controls_ChiTietPhieuTamUng_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {
            rnTiGia = $find("<%= rnTiGia.ClientID %>");

            rdThanhTien = $find("<%= rdThanhTienAn.ClientID %>");

            UCrdSoTien = $find("<%= UCrdSoTien.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + (rdThanhTien.get_value() * rnTiGia.get_value() - UCrdSoTien.get_value() * rnTiGia.get_value()));
        }
            
    </script>
    
</telerik:RadScriptBlock>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Phiếu tạm ứng:
            </td>
            <td style="width: 10px">
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="UCtxtPhieuTU" runat="server" Text='<%#Eval("PhieuTU") %>' Width="150px"
                    Enabled="false"></asp:TextBox>
            </td>
            <td style="width: 10px">
                &nbsp;
            </td>
            <td align="right">
                Loại tiền:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="tbLoaiTien" runat="server" Enabled="False" Width="155px" Text='<%# Eval("LoaiTien") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Mã chi phí:
            </td>
            <td style="width: 10px">
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="UCtxtMSChiPhi" runat="server" Width="150px" Text='<%# Eval("MSChiPhi") %>'
                    Enabled="false"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="UCtxtMSChiPhi"
                    Display="Dynamic" ErrorMessage="Không lấy được mã chi phí." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
            <td style="width: 10px">
                &nbsp;
            </td>
            <td align="right">
                Tỉ giá:
            </td>
            <td align="left">
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                    Width="160px" Enabled="False">
                </telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ngân sách còn lại:
            </td>

            <td align="left">
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="155px" Enabled="False" Value="0">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
            </td>
            <td align="left">
                &nbsp;
            </td>
            <td align="right">
                Số tiền:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="UCrdSoTien" runat="server" Width="160px" Value="0"
                    MinValue="0" onkeyup="onkeyupEvent()">
                </telerik:RadNumericTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="UCrdSoTien"
                    Display="Dynamic" ErrorMessage="Nhập số tiền tạm ứng." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right">
                Nội dung:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left" colspan="5">
                <asp:TextBox ID="UCtxtLyDo" runat="server" Height="25px" Width="400px" Text='<%# Eval("LyDo") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
        <td>
         <asp:TextBox ID="txtNam" runat="server" Width="150px" Text='<%# Eval("Nam") %>' Visible="false"></asp:TextBox>
          <asp:TextBox ID="txtThang" runat="server" Width="150px" Text='<%# Eval("Thang") %>' Visible="false"></asp:TextBox>
        </td>
        </tr>
        <tr>
            <td colspan="7" align="center">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
                <asp:HiddenField ID="hdTamUng" runat="server" Value='<%# Eval("PhieuTU")%>' />
                <asp:HiddenField ID="hdDonVi" runat="server" Value='<%# Eval("MaDV")%>' />
                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rdThanhTienAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                    <asp:TextBox ID="txtMaBP" runat="server" Enabled="False" Width="155px" Visible="false"></asp:TextBox>
                     <asp:TextBox ID="txtIDMaCS" runat="server" Enabled="False"  Visible="false"></asp:TextBox>
                     <asp:TextBox ID="txtId_ChiTiet" runat="server" Text='<%#Eval("id_chitiet") %>' Width="150px"
                    Visible="false"></asp:TextBox>
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Tigia"),Eval("SoTien")) %>' />
