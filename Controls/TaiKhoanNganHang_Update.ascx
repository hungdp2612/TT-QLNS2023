<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TaiKhoanNganHang_Update.ascx.cs" Inherits="Controls_TaiKhoanNganHang_Update" %>

<div style="margin-left: 20px">
    <table border="0" cellpadding="2" cellspacing="2">
        <tr>
            <td align="right" style="width: 100px">Số tài khoản:
            </td>
            <td align="left" colspan="3">
                <asp:TextBox ID="txtSotaikhoan" Width="100%" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSotaikhoan"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 100px">Đơn vị:
            </td>
            <td align="left">
                <telerik:RadComboBox ID="rdDonVi" runat="server" Width="100%" Height="200px" EmptyMessage="Chọn đơn vị..."
                    DataTextField="TenDonVi" DataValueField="MaDonVi" MarkFirstMatch="true" Filter="Contains"
                    EnableLoadOnDemand="true" HighlightTemplatedItems="true" ShowMoreResultsBox="true" OnSelectedIndexChanged="rdDonVi_SelectedIndexChanged"
                    EnableVirtualScrolling="true" DropDownAutoWidth="Enabled" AutoPostBack="True">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td style="width: 100px;">Mã đơn vị
                                </td>
                                <td style="width: 150px;">Tên gọi
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="width: 100px;">
                                    <%# DataBinder.Eval(Container.DataItem, "MaDonVi") %>
                                </td>
                                <td style="width: 120px;">
                                    <%# DataBinder.Eval(Container.DataItem, "TenDonVi") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td align="right" style="width: 100px">Tên tài khoản:
            </td>
            <td align="left">
                <telerik:RadComboBox ID="rdTenTaiKhoan" runat="server" Width="100%" Height="200px" EmptyMessage="Chọn tên tài khoản..."
                    DataTextField="MANV" DataValueField="MANV" MarkFirstMatch="true" Filter="Contains"
                    EnableLoadOnDemand="true" HighlightTemplatedItems="true" ShowMoreResultsBox="true"
                    EnableVirtualScrolling="true" DropDownAutoWidth="Enabled" AutoPostBack="True">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td style="width: 100px;">MANV
                                </td>
                                <td style="width: 150px;">Họ tên
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td style="width: 100px;">
                                    <%# DataBinder.Eval(Container.DataItem, "MANV") %>
                                </td>
                                <td style="width: 120px;">
                                    <%# DataBinder.Eval(Container.DataItem, "HOTEN") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 100px">Tên ngân hàng:
            </td>
            <td align="left" colspan="3">
                <asp:TextBox ID="txtTenNganHang" Width="100%" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTenNganHang"
                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 100px">Ghi chú:
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtGhichu" Width="100%" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("MADV"),Eval("MANV"),Eval("TenNganHang"),Eval("SoTaiKhoan"),Eval("Ghichu"))%>' />
</div>
<br />

