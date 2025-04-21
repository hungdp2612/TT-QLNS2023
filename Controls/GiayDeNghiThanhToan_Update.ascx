<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GiayDeNghiThanhToan_Update.ascx.cs"
    Inherits="Controls_GiayDeNghiThanhToan_Update" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<div style="float: left; margin-left: 20px">
    <table cellpadding="2" cellspacing="2">
       
          <tr>
            <td align="left">Hạn thanh toán:
            </td>
            <td align="left">
                <telerik:raddatepicker id="rdHanThanhToan" runat="server" width="150px" selecteddate='<%# Bind("HanThanhToan") %>'>
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                    </DateInput>
                </telerik:raddatepicker>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="rdHanThanhToan"
                    Display="Dynamic" ErrorMessage="Chọn hạn thanh toán." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
                <telerik:raddatepicker id="rdHanThanhToanCu" runat="server" width="200px" visible="False">
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                    </Calendar>
                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy">
                    </DateInput>
                </telerik:raddatepicker>
            </td>
            <td align="left">Hình thức thanh toán:
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlHinhThucThanhToan" runat="server" Width="150px" AutoPostBack="True"
                    OnSelectedIndexChanged="ddlHinhThucThanhToan_SelectedIndexChanged">
                    <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                    <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlHinhThucThanhToan"
                    Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
            </td>
            <td align="left">Loại tiền:
               
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlLoaiTien" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                    Width="55px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlLoaiTien"
                    Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
                Tỉ giá:
                <telerik:radnumerictextbox id="rnTiGia" runat="server" culture="Vietnamese (Vietnam)"
                    width="65px" enabled="false">
                </telerik:radnumerictextbox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                    Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GEdit">*</asp:RequiredFieldValidator>
                <telerik:radnumerictextbox id="rnTiGiaCu" runat="server" culture="Vietnamese (Vietnam)"
                    width="80px" visible="false">
                </telerik:radnumerictextbox>

            </td>
        </tr>
        <tr>

            <td align="left">Ngân hàng:
            </td>
            <td align="left">
                <asp:TextBox ID="txtNganHang" runat="server" Enabled="False" Width="150px"></asp:TextBox>

            </td>


            <td align="left">Tên tài khoản:
            </td>
            <td align="left">
                <asp:TextBox ID="txtTenTK" runat="server" Enabled="False" Width="150px"></asp:TextBox>
            </td>

            <td align="left">Số tài khoản:
            </td>
            <td align="left">
                <asp:TextBox ID="txtSoTK" runat="server" Enabled="False" Width="150px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="left">Loại hóa đơn:
            </td>
            <td align="left">
                <asp:DropDownList ID="DropDownListLoaiHoaDon" runat="server" Width="150px" AutoPostBack="True"
                    Skin="Windows7" OnSelectedIndexChanged="DropDownListLoaiHoaDon_OnSelectedIndexChanged">
                    <asp:ListItem Value="THONGTHUONG">Thông thường</asp:ListItem>
                    <asp:ListItem Value="DIENTU">Điện tử</asp:ListItem>
                </asp:DropDownList>

            </td>
            <td align="left">Nội dung:
            </td>
            <td align="left" colspan="4">
                <asp:TextBox ID="txtNoiDung" runat="server" Height="25px" Text='<%#Eval("NoiDung") %>'
                             Width="427px"></asp:TextBox>
            </td>




        </tr>
        
      <tr id="trLoaiHoaDonDienTu1" runat="server">
            <td align="left">Mã số thuế:	
            </td>
            <td align="left">
                <asp:textbox id="TextBoxMaSoThue" runat="server" text='<%#Eval("MaSoThue") %>'
                    width="150px"></asp:textbox>
            </td>
            <td align="left">Mã tra cứu/Tài khoản:	
            </td>
            <td align="left">
                <asp:textbox id="TextBoxMaTraCuuHoacTaiKhoan" runat="server" width="150px" text='<%#Eval("MaTraHoacTaiKhoan") %>'></asp:textbox>
            </td>

            <td align="left">Mã xác thực/Mật khẩu:	
            </td>
            <td align="left">
                <asp:textbox id="TextBoxSoHoaDonXacThuc" runat="server" width="150px" text='<%#Eval("MaXacThucHoacMatKhau") %>'></asp:textbox>
            </td>
        </tr>
      
        <tr id="trLoaiHoaDonDienTu2" runat="server">
            <td align="left">Số hóa đơn:	
            </td>
            <td align="left">
                <asp:textbox id="TextBoxSoHoaDon" runat="server" text='<%#Eval("SoHoaDon") %>'
                             width="150px"></asp:textbox>
            </td>
            <td align="left">Tên File:	
            </td>
            <td align="left">
                <asp:textbox id="TextBoxTenFile" runat="server" text='<%#Eval("TenFile") %>'
                    width="150px"></asp:textbox>
            </td>
            <td align="left">Đường link truy cập:	
            </td>
            <td align="left" >
                <asp:textbox id="TextBoxDuongDan" runat="server" width="150px" text='<%#Eval("DuongDanTraCuu") %>'></asp:textbox>
            </td>
           
        </tr>

        <tr id="trLoaiHoaDonDienTu3" runat="server">
           <td>
               <a href='<%#Eval("DuongDanLuuFile") %>' id="Download" target="_blank" runat="server">Lưu file hóa đơn</a>
           </td>
           <td>

               <telerik:radasyncupload runat="server" id="RadAsyncUploadFileHoaDonDienTu" hidefileinput="True"
                                       maxfileinputscount="1" allowedfileextensions="pdf,xml,zip" width="90px"
                                       onfileuploaded="RadAsyncUploadFileHoaDonDienTu_OnFileUploaded"
                                       skin="Windows7" height="20px">
                   <Localization Remove="Xóa" />
               </telerik:radasyncupload>
               <td></td>
           </td>
           <td>
               <telerik:radbutton id="RadButtonUpload" runat="server" text="Upload" width="92px">
                   <Icon PrimaryIconCssClass="rbUpload"></Icon>
               </telerik:radbutton>

               <telerik:radbutton id="RadButtonXoaHoaDonDienTu" runat="server" text="Xóa" width="92px" onclick="RadButtonXoaHoaDonDienTu_OnClick">
                   <Icon PrimaryIconCssClass="rbCancel"></Icon>
               </telerik:radbutton>


           </td>
           
       </tr>
        
        <tr>
            <td colspan="6">
                <asp:Label ID="LabelLoi" runat="server" ForeColor="Red" ></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="11" align="center">
                <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png"
                    ValidationGroup="Gedit" CommandName="Update" OnClick="btLuu_Click" />
                &nbsp;<asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/Images/Nutchuanweb/dong.png"
                    CommandName="Cancel" OnClick="btnClose_Click" />
                <asp:HiddenField ID="hdSoPhieuDeNghiThanhToan" runat="server" Value='<%# Eval("SoPhieu")%>' />
            </td>
        </tr>
    </table>
</div>
<asp:HiddenField ID="HiddenField1" runat="server" Value='<%# fGet(Eval("Tigia"),Eval("LoaiTien"),Eval("HanThanhToan"),Eval("LaTienmat"),Eval("NganHang"),Eval("TenTaiKhoan"),Eval("SoTaiKhoan"),Eval("LoaiHoaDon")) %>' />
