<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Login.ascx.cs" Inherits="Controls_Login" %>
<center>
    <div class="loginDisplay">
        <fieldset class="fieldset">
            <%--<legend>Đăng Nhập</legend>--%>
            <table>
                <tr>
                    <td style="width: 40%;">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/login.png" Width="100%" />
                    </td>
                    <td style="width: 60%;">
                        <table style="width: 100%; text-align: left;">
                            <tr>
                                <td>
                                    Mã nhân viên
                                </td>
                                <td>
                                    <asp:TextBox ID="txtuser" runat="server" Width="160px" TabIndex="10"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtuser"
                                        ErrorMessage="Bạn chưa nhập vào tên">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Mật khẩu
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" Width="160px" TabIndex="11"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpassword"
                                        ErrorMessage="Bạn chưa nhập mật khẩu">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="left">
                                    <asp:CheckBox ID="cbGhiNho" runat="server" Text="Ghi nhớ ?" TabIndex="12" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnDangnhap" runat="server" OnClick="btnDangnhap_Click" Text="Đăng nhập"
                                        Width="100px" Height="30px" Font-Names="Times New Roman" TabIndex="13" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                                    <br />
                                    <asp:Label ID="lblLoi" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</center>
