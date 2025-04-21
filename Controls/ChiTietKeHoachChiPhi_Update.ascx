<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachChiPhi_Update.ascx.cs"
    Inherits="Controls_ChiTietKeHoachChiPhi_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {



            rdThanhTienAn = $find("<%= rdThanhTienAn.ClientID %>");

            UCrnChiPhi = $find("<%= UCrnChiPhi.ClientID %>");

            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputChiPhiConLai = $find("<%= rnChiPhiConLai.ClientID %>");

            InputChiPhiConLai.set_value(rnNganSachConLaiAn.get_value() + (rdThanhTienAn.get_value() - UCrnChiPhi.get_value()));
        }
            
    </script>
</telerik:RadScriptBlock>
<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right">
                Khóa chi phí:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="UCtxtKhoaCP" runat="server" Width="150px" Text='<%# Bind( "Khoa_chiphi") %>'
                    Enabled="false"></asp:TextBox>
            </td>
            <td align="right">
                Chi phí:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <telerik:RadNumericTextBox ID="UCrnChiPhi" runat="server" Value="0" Width="150px"
                    onkeyup="onkeyupEvent()">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Tháng:
            </td>
            <td style="width: 20px">
            </td>
            <td>
                <asp:TextBox ID="UCtxtThang" runat="server" Width="150px" Text='<%# Bind( "Thang") %>'
                    Enabled="false"></asp:TextBox>
            </td>
            <td align="right">
                Tỉ lệ ĐV:
            </td>
            <td style="width: 20px">
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnTiLeDV" runat="server" MinValue="0" Value="0" MaxValue="100"
                    Width="150px">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Chi phí duyệt còn lại:
            </td>
            <td width="5px">
            </td>
            <td align="left">
                <telerik:RadNumericTextBox ID="rnChiPhiConLai" runat="server" Value="0" Width="150px"
                    Enabled="false">
                </telerik:RadNumericTextBox>
            </td>
            <td align="right">
                ĐV nhận ủy quyền:
            </td>
            <td width="5px">
            </td>
            <td align="left">
                <%--<asp:DropDownList ID="ddlDonVi" runat="server" Width="150px" DataTextField="TenDonVi"
                    DataValueField="MaDonVi" Height="25px">
                </asp:DropDownList>--%>
                <telerik:RadComboBox ID="ddlDonVi" DropDownWidth="200px" runat="server" Skin="Windows7"
                    Width="150px" AutoPostBack="true" MarkFirstMatch="true" Filter="Contains" AllowCustomText="true"
                    DataValueField="MaDonVi" DataTextField="TenDonVi">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                Ghi chú:
            </td>
            <td width="5px">
            </td>
            <td align="left" colspan="10">
                <asp:TextBox ID="txtGhiChu" runat="server" Height="20px" Width="98%" Text='<%# Bind( "GHICHU") %>'
                    Skin="Windows7"></asp:TextBox>
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
        <tr>
            <td>
                <asp:TextBox ID="txtMaNV" runat="server" Width="185px" Text='<%# Bind("ManvCN") %>'
                    Visible="false"></asp:TextBox>
                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
                <telerik:RadNumericTextBox ID="rdThanhTienAn" runat="server" Width="160px" Display="false">
                    <NumberFormat ZeroPattern="n"></NumberFormat>
                </telerik:RadNumericTextBox>
            </td>
        </tr>
    </table>
</div>
<asp:TextBox ID="UCtxtIDKhoa" runat="server" Width="185px" Text='<%# Bind( "IDkhoa_chitietKH") %>'
    Visible="false"></asp:TextBox>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Chiphi"),Eval("TileDvi"),Eval("MaDVduocUQ"))%>' />
