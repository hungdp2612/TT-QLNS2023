<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanTamUng_Update.ascx.cs"
    Inherits="Controls_ChiTietThanhToanTamUng_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {

            rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            rnDonGia = $find("<%= rnDonGia.ClientID %>");
           
            rdThanhTien = $find("<%= rdThanhTienAn.ClientID %>");

            rnSoTienThanhToan = $find("<%= rnSoTienThanhToan.ClientID %>");

            var rnTienPhieuTU = $find("<%= rnTienPhieuTU.ClientID %>");
            rnTienPhieuTUAn = $find("<%= rnTienPhieuTUAn.ClientID %>");

            var rnTienThanhToanConLai = $find("<%= rdThanhTienAn.ClientID %>");


            var InputThanhToanConLai_ByMaChiPhi = $find("<%= rnTamUngConLaiCuaMaChiPhi.ClientID %>");
            rnTamUngConLai_ByMaChiPhiAn = $find("<%= rnTamUngConLai_ByMaChiPhiAn.ClientID %>");


            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLaiCuaPhieuTU = $find("<%= rnTienPhieuTU.ClientID %>");

            var InputNganSachConLai = $find("<%= rnSoTienConLai.ClientID %>");


            InputNganSachConLaiCuaPhieuTU.set_value(rnTienPhieuTUAn.get_value() + (rdThanhTien.get_value() - rnSoTienThanhToan.get_value()));

            InputThanhToanConLai_ByMaChiPhi.set_value(rnTamUngConLai_ByMaChiPhiAn.get_value() + (rdThanhTien.get_value() - rnSoTienThanhToan.get_value()));


            //            if (InputNganSachConLaiCuaPhieuTU.get_value() < 0) {

            //                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + rnTienThanhToanConLai.get_value() - rnSoTienThanhToan.get_value());
            //            }
            //            else {


            //                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value());
            //            }
            if (InputThanhToanConLai_ByMaChiPhi.get_value() < 0) {

                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() + rnTienThanhToanConLai.get_value() + rnTamUngConLai_ByMaChiPhiAn.get_value() - rnSoTienThanhToan.get_value());
            }
            else {


                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value());
            }

        }

        function onkeyUpEvent2() {

            rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            rnDonGia = $find("<%= rnDonGia.ClientID %>");
            var rdSoTienThanhToan = $find("<%= rnSoTienThanhToan.ClientID %>");
            rdSoTienThanhToan.set_value(rnSoLuong.get_value() * rnDonGia.get_value());

            rnTamUngConLai = $find("<%= rnTienPhieuTU.ClientID %>");

            rnTienPhieuTUAn = $find("<%= rnTienPhieuTUAn.ClientID %>");


            rdThanhTienAn = $find("<%= rdThanhTienAn.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");


            rnSoTienConLai = $find("<%= rnSoTienConLai.ClientID %>");



            rnTamUngConLai.set_value(rnTienPhieuTUAn.get_value() + rdThanhTienAn.get_value() - rdSoTienThanhToan.get_value());


            if (rnTamUngConLai.get_value() < 0) {


                rnSoTienConLai.set_value(rnNganSachConLaiAn.get_value() - rdSoTienThanhToan.get_value() + rdThanhTienAn.get_value());

            }
            else {
                rnSoTienConLai.set_value(rnNganSachConLaiAn.get_value());
            }

        }

    </script>
</telerik:RadScriptBlock>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Phiếu TU:
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
                Tổng TU còn lại:
            </td>
            <td width="10">
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTienPhieuTU" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="160px" Enabled="False" Value="0">
                </telerik:RadNumericTextBox>
            </td>
            <td width="10">
            </td>
            <td align="right">
                Số hóa đơn:
            </td>
            <td>
                <asp:TextBox ID="txtSoHoaDon" runat="server" Width="160px" Enabled="true" Text='<%#Eval("SoHoaDon") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Mã CP:
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
                Ngân sách còn lại:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnSoTienConLai" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="160px" Enabled="False" Value="0">
                </telerik:RadNumericTextBox>
            </td>
            <td width="10">
            </td>
            <td align="right">
                Tạm ứng còn lại:
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTamUngConLaiCuaMaChiPhi" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="165px" Enabled="False">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Tên - qui cách:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left">
                <asp:TextBox ID="txtQuiCach" runat="server" Enabled="true" Width="155px" Text='<%#Eval("TenvaQuiCach") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuiCach"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Gedit"
                    ForeColor="Red"></asp:RequiredFieldValidator>
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
                    Width="160px" Value="0" onkeyup="onkeyupEvent()">
                </telerik:RadNumericTextBox>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="right">
                VAT:
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnVAT" runat="server" Width="165px" Enabled="true"
                    Value="0">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Số lượng:
            </td>
            <td width="10">
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnSoLuong" runat="server" Width="160px" Enabled="true"
                    Value="0" onkeyup="onkeyUpEvent2()">
                </telerik:RadNumericTextBox>
            </td>
            <td width="10">
            </td>
            <td align="right">
                Đơn giá:
            </td>
            <td width="10">
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnDonGia" runat="server" Width="160px" Enabled="true"
                    Value="0" onkeyup="onkeyUpEvent2()">
                </telerik:RadNumericTextBox>
            </td>
            <td>
                &nbsp;
            </td>
            <td align="right">
                Đơn vị tính:
            </td>
            <td align="left">
                <asp:TextBox ID="txtDVT" runat="server" Enabled="true" Width="160px" Text='<%#Eval("DVT") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ghi chú:
            </td>
            <td>
                &nbsp;
            </td>
            <td align="left" colspan="10">
                <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="99%" Text='<%#Eval("GhiChu") %>'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="11">
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
                <telerik:RadNumericTextBox ID="rnTienPhieuTUAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rnTongNganSach" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rnNganSachThucHien" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rnTienThanhToanAn" runat="server" Width="160px" Display="false">
                </telerik:RadNumericTextBox>
                <asp:TextBox ID="txtKhoa" runat="server" Height="25px" Visible="false" Text='<%#Eval("CTTT_ID") %>'></asp:TextBox>
                <asp:TextBox ID="txtMaDV" runat="server" Enabled="False" Width="155px" Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtMaBP" runat="server" Enabled="False" Width="155px" Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtIDMaCS" runat="server" Enabled="False" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadNumericTextBox ID="rnTamUngConLai_ByMaChiPhiAn" runat="server" AutoPostBack="false"
                    ReadOnly="True" Width="160px" Enabled="false" Value="0" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="155px" Enabled="False"
                    Text='<%#Eval("SoPhieu") %>' Visible="false"></asp:TextBox>
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
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("TienThanhToan"),Eval("SoLuong"),Eval("DonGia"),Eval("VAT")) %>' />
