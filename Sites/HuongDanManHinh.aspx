<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="HuongDanManHinh.aspx.cs" Inherits="Sites_HuongDanManHinh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" Width="1000px"
        MultiPageID="MultiPage" Skin="Windows7">
        <Tabs>
            <telerik:RadTab runat="server" Text="Windows XP" Selected="True" Width="500px">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Windows 7" Width="500px">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <div style="margin-top: 10px">
    </div>
    <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
        Height="100%">
        <telerik:RadPageView ID="RadPageView1" runat="server">
            <table class="EditFormHeader"  width="80%" border="0"
                style="border-collapse: collapse; margin-left: 100px;">
                <tbody>
                    <tr>
                        <td style="text-align: center; color: #982849; font-weight: bold; font-size: 16px">
                            <br />
                            HƯỚNG DẪN CẤU HÌNH ĐỘ PHÂN GIẢI MÀN HÌNH
                        </td>
                    </tr>
                    <tr>
                        <td class="header1" colspan="4">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Windows XP</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            - Chuột phải vào màn hình desktop chọn properties
                            <br />
                            - Một cửa sổ mới hiện ra, điều chỉnh các thông số như hình. Cuối cùng chọn Apply
                            để thay đổi có hiệu lực.<br />
                            - Ưu tiên chọn thông số màn hình cao nhất có thể để hiển thị hình ảnh tốt nhất.
                            <br />
                            <br />
                            <img id="img1" src="../images/1024x768.jpg" style="border-width: 0px;" alt="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="header1" colspan="4">
                            <br />
                        </td>
                    </tr>
                </tbody>
            </table>
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView2" runat="server">
            <table class="EditFormHeader"  width="80%" border="0"
                style="border-collapse: collapse; margin-left: 100px;">
                <tbody>
                    <tr>
                        <td style="text-align: center; color: #982849; font-weight: bold; font-size: 16px">
                            <br />
                            HƯỚNG DẪN CẤU HÌNH ĐỘ PHÂN GIẢI MÀN HÌNH
                        </td>
                    </tr>
                    <tr>
                        <td class="header1" colspan="4">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Windows 7</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            - Click nút Menu Start
                            <img id="img2" src="../images/logo-windows7.jpg" style="width: 5%; border-width: 0px;" />
                            <br />
                            <br />
                            - Chọn Control Panel --&gt; Click chọn nút Display
                            <img id="img3" src="../images/btnDisplay.jpg" style="width: 40%; border-width: 0px;" /><br>
                            <br />
                            - Click chọn menu Change display settings (bên trái màn hình)
                            <br />
                            <br />
                            - Điều chỉnh thanh trượt lên xuống tương ứng với độ phân giải màn hình mong muốn.
                            <br />
                            - Ưu tiên chọn thông số màn hình cao nhất có thể để hiển thị hình ảnh tốt nhất.
                            <br />
                            <img id="ctl00_ContentPlaceHolder1_Image4" src="../images/ChangeDisplay_Win7.jpg"
                                style="width: 100%; border-width: 0px;" /><br>
                            <br />
                        </td>
                    </tr>
                </tbody>
            </table>
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
