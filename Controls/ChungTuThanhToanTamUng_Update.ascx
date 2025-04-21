<%@ control language="C#" autoeventwireup="true" codefile="ChungTuThanhToanTamUng_Update.ascx.cs"
    inherits="Controls_ChungTuThanhToanTamUng_Update" %>
<%@ register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
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
                <asp:requiredfieldvalidator id="RequiredFieldValidator5" runat="server" controltovalidate="rdHanThanhToan"
                    display="Dynamic" errormessage="Chọn hạn thanh toán." validationgroup="GEdit">*</asp:requiredfieldvalidator>
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
                <asp:dropdownlist id="ddlHinhThucThanhToan" runat="server" width="150px" autopostback="True"
                    onselectedindexchanged="ddlHinhThucThanhToan_SelectedIndexChanged">
                    <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                    <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                </asp:dropdownlist>
                <asp:requiredfieldvalidator id="RequiredFieldValidator7" runat="server" controltovalidate="ddlHinhThucThanhToan"
                    display="Dynamic" errormessage="Chọn hình thức thanh toán." validationgroup="GEdit">*</asp:requiredfieldvalidator>
            </td>
            <td align="left">Loại tiền:
               
            </td>
            <td align="left">
                <asp:dropdownlist id="ddlLoaiTien" runat="server" datatextfield="LoaiTien" datavaluefield="LoaiTien"
                    width="55px" autopostback="True" onselectedindexchanged="ddlLoaiTien_SelectedIndexChanged">
                </asp:dropdownlist>
                <asp:requiredfieldvalidator id="RequiredFieldValidator6" runat="server" controltovalidate="ddlLoaiTien"
                    display="Dynamic" errormessage="Chọn loại tiền." validationgroup="GEdit">*</asp:requiredfieldvalidator>
                Tỉ giá:
                <telerik:radnumerictextbox id="rnTiGia" runat="server" culture="Vietnamese (Vietnam)"
                    width="65px" enabled="false">
                </telerik:radnumerictextbox>
                <asp:requiredfieldvalidator id="RequiredFieldValidator3" runat="server" controltovalidate="rnTiGia"
                    display="Dynamic" errormessage="Nhập tỉ giá." validationgroup="GEdit">*</asp:requiredfieldvalidator>
                <telerik:radnumerictextbox id="rnTiGiaCu" runat="server" culture="Vietnamese (Vietnam)"
                    width="80px" visible="false">
                </telerik:radnumerictextbox>

            </td>
        </tr>
        <tr>

            <td align="left">Ngân hàng:
            </td>
            <td align="left">
                <asp:textbox id="txtNganHang" runat="server" enabled="False" width="150px"></asp:textbox>

            </td>


            <td align="left">Tên tài khoản:
            </td>
            <td align="left">
                <asp:textbox id="txtTenTK" runat="server" enabled="False" width="150px"></asp:textbox>
            </td>

            <td align="left">Số tài khoản:
            </td>
            <td align="left">
                <asp:textbox id="txtSoTK" runat="server" enabled="False" width="150px"></asp:textbox>
            </td>
        </tr>
   
        <tr>
            <td align="left">Loại hóa đơn:
            </td>
            <td align="left">
                <asp:dropdownlist id="DropDownListLoaiHoaDon" runat="server" width="150px" autopostback="True"
                    skin="Windows7" onselectedindexchanged="DropDownListLoaiHoaDon_OnSelectedIndexChanged">
                    <asp:ListItem Value="THONGTHUONG">Thông thường</asp:ListItem>
                    <asp:ListItem Value="DIENTU">Điện tử</asp:ListItem>
                </asp:dropdownlist>

            </td>
            <td align="left">Nội dung:
            </td>
            <td align="left" colspan="4">
                <asp:textbox id="txtNoiDung" runat="server" height="25px" text='<%#Eval("NoiDung") %>'
                    width="475px"></asp:textbox>
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
            <td align="left" colspan="7">
                <asp:validationsummary id="ValidationSummary1" runat="server" validationgroup="GEdit" />
            </td>
        </tr>

        <tr>
            <td colspan="6" align="center">
                <asp:imagebutton id="btLuu" runat="server" imageurl="~/Images/Nutchuanweb/luu.png"
                    validationgroup="Gedit" commandname="Update" />
                &nbsp;<asp:imagebutton id="btnClose" runat="server" imageurl="~/Images/Nutchuanweb/dong.png"
                    commandname="Cancel" />
                <asp:hiddenfield id="hdSoPhieu" runat="server" value='<%# Eval("SoPhieu")%>' />
            </td>
        </tr>
    </table>
</div>
<asp:hiddenfield id="HiddenField1" runat="server" value='<%# fGet(Eval("Tigia"),Eval("LoaiTien"),Eval("HanThanhToan"),Eval("LaTienmat"),Eval("NganHang"),Eval("TenTaiKhoan"),Eval("SoTaiKhoan"),Eval("LoaiHoaDon")) %>' />
