<%@ Page Title="CHƯƠNG TRÌNH QUẢN LÝ NGÂN SÁCH" Language="C#" MasterPageFile="~/Home.master"
    AutoEventWireup="true" CodeFile="Trangchu.aspx.cs" Inherits="sites_Trangchu" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" class="EditFormHeader" cellpadding="0px" cellspacing="0px">
        <tr class="header">
            <td>
                <div class="header">
                    CHÀO MỪNG ĐẾN VỚI CHƯƠNG TRÌNH QUẢN LÝ NGÂN SÁCH</div>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr class="comboTable" align="center">
            <td>
                <fieldset class="fieldset" style="width: 900px;">
                    <legend>Thông tin hướng dẫn sử dụng</legend>
                    <br />
                    <span style="font-size: medium;">Hiển thị tốt nhất trên trình duyệt Mozilla FireFox,
                        độ phân giải màn hình tối thiểu 1024 x 768 px. </span>
                    <br />
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://www.mozilla.org/en-US/firefox/new/"
                        Target="_blank"><span style="font-size:medium;">Download Mozilla FireFox mới nhất tại đây</span></asp:HyperLink>
                    <br />
                    <br />
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Sites/Huongdanmanhinh.aspx"
                        Target="_self"><span style="font-size:medium;">Hướng dẫn điều chỉnh độ phân giải màn hình</span></asp:HyperLink>
                    <br />
                </fieldset>
            </td>
        </tr>
    </table>
</asp:Content>
