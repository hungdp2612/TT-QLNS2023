<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanKhongTamUng_Mar_Update.ascx.cs"
    Inherits="Controls_ChiTietThanhToanKhongTamUng_Mar_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {

            rnTiGia = $find("<%= rnTiGia.ClientID %>");
            rdThanhTien = $find("<%= rdThanhTien.ClientID %>");
            rdThanhTienAn = $find("<%= rdThanhTienAn.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + (rdThanhTienAn.get_value() * rnTiGia.get_value() - rdThanhTien.get_value() * rnTiGia.get_value()));

            var txtMaCP_CT = $find("<%= txtMaCP_CT.ClientID %>");
            if (txtMaCP_CT.get_textBoxValue() != "") {


                rnTienChiTietConLaiAn = $find("<%= rnTienChiTietConLaiAn.ClientID %>");
                var InputTienChiTietConLai = $find("<%= rnTienChiTietConLai.ClientID %>");
                InputTienChiTietConLai.set_value(rnTienChiTietConLaiAn.get_value() + (rdThanhTienAn.get_value() * rnTiGia.get_value() - rdThanhTien.get_value() * rnTiGia.get_value()));

            }


            var rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            var rnDonGia = $find("<%= rnDonGia.ClientID %>");
            rnSoLuong.set_value(0);
            rnDonGia.set_value(0);
        }
        function onkeyupEvent2() {

            rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            rnDonGia = $find("<%= rnDonGia.ClientID %>");
            var rdSoTienThanhToan = $find("<%= rdThanhTien.ClientID %>");
            rdSoTienThanhToan.set_value(rnSoLuong.get_value() * rnDonGia.get_value());


            rnTiGia = $find("<%= rnTiGia.ClientID %>");

            rdThanhTien = $find("<%= rdThanhTien.ClientID %>");
            rdThanhTienAn = $find("<%= rdThanhTienAn.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + (rdThanhTienAn.get_value() * rnTiGia.get_value() - rdThanhTien.get_value() * rnTiGia.get_value()));


            var txtMaCP_CT = $find("<%= txtMaCP_CT.ClientID %>");
            if (txtMaCP_CT.get_textBoxValue() != "") {


                rnTienChiTietConLaiAn = $find("<%= rnTienChiTietConLaiAn.ClientID %>");
                var InputTienChiTietConLai = $find("<%= rnTienChiTietConLai.ClientID %>");
                InputTienChiTietConLai.set_value(rnTienChiTietConLaiAn.get_value() + (rdThanhTienAn.get_value() * rnTiGia.get_value() - rdThanhTien.get_value() * rnTiGia.get_value()));
            }
        }  
    </script>
</telerik:RadScriptBlock>
<table cellpadding="2" cellspacing="2">
    <tr>
        <td align="right">
            Số phiếu:
        </td>
        <td width="10">
        </td>
        <td align="left">
            <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                Text='<%#Eval("SoPhieu") %>'></asp:TextBox>
        </td>
        <td width="10">
        </td>
        <td align="right">
            Loại tiền:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <asp:TextBox ID="tbLoaiTien" runat="server" Enabled="False" Width="160px" Text='<%# Eval("LoaiTien") %>'></asp:TextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            Ngân sách còn lại:
        </td>
        <td align="left">
            &nbsp;
        </td>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnNganSachConLai" runat="server" AutoPostBack="false"
                ReadOnly="True" Width="165px" Enabled="False" Value="0">
                <NumberFormat ZeroPattern="n"></NumberFormat>
            </telerik:RadNumericTextBox>
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
            <asp:TextBox ID="txtMSCHiPhi" runat="server" Enabled="False" Width="160px" Text='<%#Eval("MSChiPhi") %>'></asp:TextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            Mã CP CT:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <%--  <asp:TextBox ID="txtMaCP_CT" runat="server" Enabled="False" Width="160px" Text='<%#Eval("MaCP_CT") %>'></asp:TextBox>--%>
            <telerik:RadTextBox ID="txtMaCP_CT" runat="server" Width="165px" Enabled="false"
                Text='<%# Eval("MaCP_CT") %>'>
            </telerik:RadTextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            NS CT còn lại:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnTienChiTietConLai" Enabled="false" runat="server"
                AutoPostBack="false" Width="165px" Value="0">
            </telerik:RadNumericTextBox>
        </td>
    </tr>
    <tr>
        <td align="right">
            Tên và qui cách:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <asp:TextBox ID="txtQuiCach" runat="server" Enabled="true" Width="160px" Text='<%#Eval("TenvaQuiCach") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuiCach"
                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Gedit"
                ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            Số lượng:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnSoLuong" runat="server" Width="165px" Enabled="true"
                Value="0" onkeyup="onkeyupEvent2()">
            </telerik:RadNumericTextBox>
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
            <telerik:RadNumericTextBox ID="rdThanhTien" runat="server" AutoPostBack="false" Width="165px"
                Value="0" onkeyup="onkeyupEvent()">
            </telerik:RadNumericTextBox>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td align="right">
            Đơn vị tính:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <asp:TextBox ID="txtDVT" runat="server" Enabled="true" Width="160px" Text='<%# Eval("DVT") %>'></asp:TextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            Đơn giá:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnDonGia" runat="server" Width="165px" Enabled="true"
                Value="0" onkeyup="onkeyupEvent2()">
            </telerik:RadNumericTextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            VAT:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnVAT" runat="server" Width="165px" Enabled="true"
                Value="0">
            </telerik:RadNumericTextBox>
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
            <asp:TextBox ID="txtGhiChu" runat="server" Width="98%" Text='<%#Eval("GhiChu") %>'
                Height="25px"></asp:TextBox>
        </td>
        <td>
            &nbsp;
        </td>
        <td align="right">
            Số hóa đơn:
        </td>
        <td>
            &nbsp;
        </td>
        <td align="left">
            <asp:TextBox ID="txtSoHoaDon" runat="server" Enabled="true" Width="160px" Text='<%# Eval("SoHoaDon") %>'></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td align="left">
            <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                Width="165px" Enabled="False" Display="false">
            </telerik:RadNumericTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>
            <telerik:RadNumericTextBox ID="rnTienChiTietConLaiAn" runat="server" ReadOnly="True"
                Width="160px" Enabled="false" Value="0" Display="false">
            </telerik:RadNumericTextBox>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="15">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                ValidationGroup="Gedit" CommandName="Update" />
            &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                CommandName="Cancel" />
            <asp:TextBox ID="txtKhoa" runat="server" Height="25px" Visible="false" Text='<%#Eval("CTTT_ID") %>'></asp:TextBox>
            <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" Width="160px" Display="false">
                <NumberFormat ZeroPattern="n"></NumberFormat>
            </telerik:RadNumericTextBox>
            <telerik:RadNumericTextBox ID="rdThanhTienAn" runat="server" Width="160px" Display="false">
                <NumberFormat ZeroPattern="n"></NumberFormat>
            </telerik:RadNumericTextBox>
            <asp:TextBox ID="txtMaBP" runat="server" Enabled="False" Width="155px" Visible="false"></asp:TextBox>
            <asp:TextBox ID="txtIDMaCS" runat="server" Enabled="False" Visible="false"></asp:TextBox>
        </td>
    </tr>
</table>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Tigia"),Eval("TienThanhToan"),Eval("SoLuong"),Eval("DonGia"),Eval("VAT")) %>' />
