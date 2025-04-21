<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChungTuThanhToan.aspx.cs" Inherits="Chuongtrinh.Chuongtrinh_ChungTuThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript">

                function openRadWindowShow(sophieu, MaDV) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd;

                    oWnd = manager.open("ChiTietThanhToanTamUng.aspx?sophieu=" + sophieu + "&MaDV=" + MaDV, "RadWindowManager1");

                    oWnd.Center();
                } /*Tâm thêm mới window.validationFailed = function ( sender, args) 03/10/2019*/
               
                window.validationFailed = function ( sender, args) {
                    
                    var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
                    if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                        if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                            alert("File phải là định dạng zip, pdf,xml");
                        }
                       else {
                            alert("File phải dưới 10MB");
                        }
                    }
                    else {
                        alert("not correct extension!");
                    }
                    var $row = $(args.get_row());
                }
              
                function OnClientClose() {
                    __doPostBack('fLoad', '');
                }
                function OpenDisplayTigia() {
                    var manager2 = $find("<%= rnTiGia.ClientID %>");
                    manager2.Enable = true
                }

             
                function openRadWindowShow2(sophieu, MaDV, LoaiTien, TiGia) {
                    var manager2 = $find("<%= RadWindowManager2.ClientID %>");
                    var oWnd2;

                    oWnd2 = manager2.open("ChiTietThanhToanKhongTamUng.aspx?sophieu=" + sophieu + "&LoaiTien=" + LoaiTien + "&TiGia=" + TiGia, "RadWindowManager2");

                    oWnd2.Center();
                }
                function OnClientClose2() {
                    __doPostBack('fLoad', '');
                }
                function openRadWindowShow3(sophieu, LoaiTien, TiGia) {
                    var manager3 = $find("<%= RadWindowManager4.ClientID %>");
                    var oWnd3 = manager3.open("ChiTietChungTuNopTien.aspx?sophieu=" + sophieu + "&LoaiTien=" + LoaiTien + "&TiGia=" + TiGia, "RadWindowManager4");
                    oWnd2.Center();
                }
                function OnClientClose3() {
                    __doPostBack('fLoad', '');
                }

            </script>
            
            <br />
            <telerik:radtabstrip id="RadTabStrip1" runat="server" selectedindex="0" multipageid="MultiPage"
                autopostback="True" ontabclick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Thanh toán tạm ứng" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Giấy đề nghị thanh toán">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Chứng từ nộp tiền">
                    </telerik:RadTab>
                </Tabs>
            </telerik:radtabstrip>
            <div style="height: 20px;">
            </div>
            <telerik:radwindowmanager style="z-index: 7001" showcontentduringload="false" autosize="false"
                enableshadow="true" id="RadWindowManager3" runat="server" keepinscreenbounds="True"
                width="1050px" height="700px" visiblestatusbar="false" destroyonclose="True"
                enableviewstate="False" initialbehaviors="Maximize">
                <Shortcuts>
                    <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                </Shortcuts>
                <Windows>
                    <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize" VisibleStatusbar="false"
                        ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True" KeepInScreenBounds="true"
                        InitialBehaviors="Maximize">
                    </telerik:RadWindow>
                </Windows>
            </telerik:radwindowmanager>
            <telerik:radmultipage id="MultiPage" runat="server" width="100%" selectedindex="0"
                height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                    </telerik:RadWindowManager>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Nhập thông tin thanh toán tạm ứng</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Tên đơn vị:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenDonVi" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Người được thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="false" ID="ddlNguoiThanhToan" runat="server" DataValueField="MaNV"
                                            DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlNguoiThanhToan"
                                            Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Hình thức thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlHinhThucThanhToan" runat="server" Width="180px" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddlHinhThucThanhToan_SelectedIndexChanged" Skin="Windows7">
                                            <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                                            <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlHinhThucThanhToan"
                                            Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Phụ trách đơn vị:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                            DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right">
                                        Phương thức thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlPhuongThucThanhToan" runat="server" Width="180px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <asp:ListItem Value="TTML">Thanh toán một lần</asp:ListItem>
                                            <asp:ListItem Value="TTTP">Thanh toán từng phần</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlPhuongThucThanhToan"
                                            Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Ngân hàng:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtNganHang" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Loại tiền:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlLoaiTien" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                                            Skin="Windows7" Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlLoaiTien"
                                            Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Hạn thanh toán:
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdHanThanhToan" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7">
                                            <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                ViewSelectorText="x" runat="server">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                                runat="server">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rdHanThanhToan"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Tên tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenTaiKhoan" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Tỉ giá:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7" Width="70px" Enabled="true">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnTiGia"
                                            Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="GInsert">*</asp:RequiredFieldValidator>
                                         <a id="Links" target="_blank" href="https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1" style="color: blue" > Bảng Tỉ Giá </a>
                                    </td>
                                    
                                       
                                     

                                    <td align="right">
                                       Loại hóa đơn:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="DropDownListLoaiHoaDon" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="DropDownListLoaiHoaDon_OnSelectedIndexChanged"
                                                          Skin="Windows7">
                                            <asp:ListItem Value="THONGTHUONG">Thông thường</asp:ListItem>
                                            <asp:ListItem Value="DIENTU">Điện tử</asp:ListItem>
                                        </asp:DropDownList>
                                        
                                    </td>
                                    <td align="right">
                                        Số tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtSoTaiKhoan" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                           
                                <tr id="trLoaiHoaDon" runat="server" Visible="False">
                                    <td align="right">
                                        Mã số thuế:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxMaSoThue" Width="175px" runat="server" Skin="Windows7"></asp:TextBox>
                                       
                                    </td>
                                    <td align="right">
                                      Mã tra cứu/Tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxMaTraCuuHoacTaiKhoan" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                        
                                    </td>
                                      
                                      <td align="right">
                                         Mã xác thực/Mật khẩu:
                                      </td>
                                      <td align="left">
                                          <asp:TextBox ID="TextBoxMaXacThucHoacMatKhau" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                      </td>
                                   
                                </tr>
                                
                                <tr id="trDuongDanLoaiHoaDon" runat="server" Visible="False">
                                    <td align="right">
                                        Số hóa đơn:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxSoHoaDon" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Tên File:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxTenFile" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                      Đường link truy cập:	
                                    </td>
                                    <td align="left" >
                                        <asp:TextBox ID="TextBoxDuongDanHoaDonDienTu" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                       
                                    </td>
                                    
                                </tr>
                                
                                <tr id="trDuongDanFileLuuHoaDon" runat="server" Visible="False">
                                    <td>
                                        <a href="#" id="Download" target="_blank" runat="server">Lưu file hóa đơn</a>
                                    </td>
                                    <td>
                                   <%--  --Tâm them mới OnClientValidationFailed="validationFailed", asp:Panel ID="InvalidFiles" 03/10/2019--%>
                                        <telerik:RadAsyncUpload runat="server" ID="RadAsyncUploadFileHoaDonDienTu" HideFileInput="True"
                                                                MaxFileInputsCount="1" AllowedFileExtensions="pdf,xml,zip" Width="190px"
                                                                OnFileUploaded="RadAsyncUploadFileHoaDonDienTu_OnFileUploaded" 
                                                                OnClientValidationFailed="validationFailed"
                                                                MaxfileSize ="10500288"
                                                                Skin="Windows7" Height="20px" >
                                            <Localization Remove="Xóa" />
                                            <%--OnClientFileUploading ="fileUploading"--%>
                                        </telerik:RadAsyncUpload>
                                        
                                         
                                         <%--  --Tâm them mới OnClientValidationFailed="validationFailed", asp:Panel ID="InvalidFiles" 03/10/2019--%>
                                        <td></td>
                                    </td> 
                                        <td colspan="2" >
                                        <telerik:RadButton ID="RadButtonUpload" runat="server" Text="Upload" Width="92px">
                                            <Icon PrimaryIconCssClass="rbUpload"></Icon>
                                        </telerik:RadButton>
                                        
                                        <telerik:RadButton ID="RadButtonXoaHoaDonDienTu" runat="server" Text="Xóa" Width="92px"  OnClick="RadButtonXoaHoaDonDienTu_OnClick">
                                            <Icon PrimaryIconCssClass="rbCancel"></Icon>
                                        </telerik:RadButton>
                                        
                                     
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="right">
                                        Ghi chú:
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:TextBox ID="txtNoiDung" runat="server" Height="25px" Width="99%" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtMaDV" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtMaDV"
                                            Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="2" cellspacing="2" border="0">
                                <tr>
                                    <td align="center">
                                        <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbLoiTU" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Danh sách thanh toán tạm ứng</legend>
                        <telerik:RadGrid ID="rgChungTuThanhToan" runat="server" Width="970px" AutoGenerateColumns="False"
                            EnableLinqExpressions="False" GridLines="None" AllowFilteringByColumn="True"
                            Skin="Windows7" AllowPaging="True" AllowSorting="false" PageSize="50" OnDeleteCommand="rgChungTuThanhToan_DeleteCommand"
                            OnPageIndexChanged="rgChungTuThanhToan_PageIndexChanged" OnPageSizeChanged="rgChungTuThanhToan_PageSizeChanged"
                            OnItemCommand="rgChungTuThanhToan_ItemCommand" OnCancelCommand="rgChungTuThanhToan_CancelCommand"
                            OnUpdateCommand="rgChungTuThanhToan_UpdateCommand">
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="false" />
                            </ClientSettings>
                            <MasterTableView>
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="SỬA" EditText="SỬA">
                                        <ItemStyle />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa không?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="CHI TIẾT" UniqueName="ChiTiet"
                                        AllowFiltering="False" Groupable="False">
                                        <ItemTemplate>
                                            <a onclick="openRadWindowShow('<%#Eval("SoPhieu") %>','<%#Eval("MaDV") %>')">
                                                <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("BPTCKTKiemtra")) %>' />
                                            </a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                    
                                  

                                    <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                CommandName="PRINT" /></ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                        FilterControlWidth="70px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhieuTU" HeaderText="PHIẾU TU" UniqueName="PhieuTU"
                                        FilterControlWidth="70px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MADV" DataField="MADV" FilterControlWidth="50px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN TT" UniqueName="SoTien" DataField="SoTien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                        AllowFiltering="false">
                                        <ItemTemplate>
                                            <%# String.Format("{0:0,0}", Eval("Tigia"))%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="LaTienmat" HeaderText="HTTT" UniqueName="LaTienmat"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhuongThucTT" HeaderText="PTTT" UniqueName="PhuongThucTT"
                                        FilterControlWidth="40px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NganHang" HeaderText="NGÂN HÀNG" UniqueName="NganHang"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TenTaiKhoan" HeaderText="TÊN TK" UniqueName="TenTaiKhoan"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTaiKhoan" HeaderText="SỐ TK" UniqueName="SoTaiKhoan"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="NgayLap" DataField="NgayLap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" DataField="NoiDung" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="BPTCKTKiemtra" HeaderText="KIỂM TRA" UniqueName="BPTCKTKiemtra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("BPTCKTKiemtra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose2">
                    </telerik:RadWindowManager>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Nhập thông tin giấy đề nghị thanh toán</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Tên đơn vị:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenDonVi2" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Người được thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="false" ID="ddlNguoiDuocThanhToan2" runat="server" DataValueField="MaNV"
                                            DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlNguoiDuocThanhToan2"
                                            Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Hình thức thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlHinhThucThanhToan2" runat="server" Width="180px" AutoPostBack="True"
                                            Skin="Windows7" OnSelectedIndexChanged="ddlHinhThucThanhToan2_SelectedIndexChanged">
                                            <asp:ListItem Value="TM">Thanh toán tiền mặt</asp:ListItem>
                                            <asp:ListItem Value="NH">Thanh toán qua ngân hàng</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlHinhThucThanhToan2"
                                            Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Phụ trách đơn vị:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi2" runat="server" DataValueField="MaNV"
                                            Skin="Windows7" DataTextField="Ten" Width="180px" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="right">
                                        Phương thức thanh toán:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlPhuongThucThanhToan2" runat="server" Width="180px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <asp:ListItem Value="TTML">Thanh toán một lần</asp:ListItem>
                                            <asp:ListItem Value="TTTP">Thanh toán từng phần</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="ddlPhuongThucThanhToan2"
                                            Display="Dynamic" ErrorMessage="Chọn hình thức thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Ngân hàng:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtNganHang2" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Loại tiền:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlLoaiTien2" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                                            Skin="Windows7" Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien2_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="ddlLoaiTien"
                                            Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Hạn thanh toán:
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdHanThanhToan2" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7">
                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                ViewSelectorText="x" runat="server">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput1" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                                runat="server">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="rdHanThanhToan2"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Tên tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenTaiKhoan2" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Tỉ giá:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnTiGia2" runat="server" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7" Width="70px" Enabled="true">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="rnTiGia2"
                                            Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                         <a id="Links2" target="_blank" href="https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1" style="color: blue" > Bảng Tỉ Giá </a>
                                    </td>
                                    <td align="right">
                                        Loại hóa đơn:
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="DropDownListDNTTLoaiHoaDon" runat="server" Width="180px" AutoPostBack="True" OnSelectedIndexChanged="DropDownListDNTTLoaiHoaDon_OnSelectedIndexChanged"
                                                          Skin="Windows7">
                                            <asp:ListItem Value="THONGTHUONG">Thông thường</asp:ListItem>
                                            <asp:ListItem Value="DIENTU">Điện tử</asp:ListItem>
                                        </asp:DropDownList>
                                        
                                    </td>
                                    <td align="right">
                                        Số tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtSoTaiKhoan2" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                               
                                
                                <tr id="trDNTTLoaiHoaDon" runat="server" Visible="False">
                                    <td align="right">
                                        Mã số thuế:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxDNTTMaSoThue" Width="175px" runat="server" Skin="Windows7"></asp:TextBox>
                                       
                                    </td>
                                    <td align="right">
                                      Mã tra cứu/Tài khoản:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxDNTTMaTraCuuHoacTaiKhoan" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                        
                                    </td>
                                      
                                      <td align="right">
                                         Mã xác thực/Mật khẩu:
                                      </td>
                                      <td align="left">
                                          <asp:TextBox ID="TextBoxDNTTMaXacThucHoacMatKhau" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                      </td>
                                   
                                </tr>
                                
                                <tr id="trDNTTDuongDanLoaiHoaDon" runat="server" Visible="False">
                                    <td align="right">
                                        Số hóa đơn:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxDNTTSoHoaDon" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        Tên File:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="TextBoxDNTTTenFile" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                      Đường link truy cập:	
                                    </td>
                                    <td align="left" >
                                        <asp:TextBox ID="TextBoxDNTTDuongLinkTruyCap" Width="175px"  runat="server" Skin="Windows7"></asp:TextBox>
                                       
                                    </td>
                                    
                                </tr>
                                
                                <tr id="trDNTTDuongDanFileLuuHoaDon" runat="server" Visible="False">
                                    <td>
                                        <a href="#" id="DNTTDownload" target="_blank" runat="server">Lưu file hóa đơn</a>
                                    </td>
                                    <td>
                                     <%--tâm thêm mới 03/10/2019  OnClientValidationFailed="validationFailed"
                                                                MaxfileSize ="10500288"--%>
                                        <telerik:RadAsyncUpload runat="server" ID="RadAsyncUploadDNTTFileHoaDonDienTu" HideFileInput="True"
                                                                MaxFileInputsCount="1" AllowedFileExtensions="pdf,xml,zip" Width="190px"
                                                                OnFileUploaded="RadAsyncUploadDNTTFileHoaDonDienTu_OnFileUploaded"
                                                                OnClientValidationFailed="validationFailed"
                                                                MaxfileSize ="10500288" 
                                                                Skin="Windows7" Height="20px">
                                            <Localization Remove="Xóa" />
                                        </telerik:RadAsyncUpload>
                                        <td></td>
                                    </td> 
                                        <td colspan="2" >
                                        <telerik:RadButton ID="RadButtonDNTTUpload" runat="server" Text="Upload" Width="92px">
                                            <Icon PrimaryIconCssClass="rbUpload"></Icon>
                                        </telerik:RadButton>
                                        
                                        <telerik:RadButton ID="RadButtonDNTTXoaFile" runat="server" Text="Xóa" Width="92px"  OnClick="RadButtonDNTTXoaFile_OnClick">
                                            <Icon PrimaryIconCssClass="rbCancel"></Icon>
                                        </telerik:RadButton>
                                        
                                     
                                    </td>
                                </tr>
                                

                                <tr>
                                    <td align="right">
                                        Ghi chú:
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:TextBox ID="txtNoiDung2" runat="server" Height="25px" Width="99%" Skin="Windows7"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtMaDV2" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtMaDV2"
                                            Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="2" cellspacing="2" border="0">
                                <tr>
                                    <td align="center" style="color: Blue">
                                        Lưu ý:Hạn thanh toán là tháng trừ ngân sách
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:ImageButton ID="btnLuu2" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu2_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbLoiDN" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Danh sách giấy đề nghị thanh toán</legend>
                        <telerik:RadGrid ID="RGKhongTamUng" runat="server" Width="970px" AutoGenerateColumns="False"
                            Skin="Windows7" EnableLinqExpressions="False" GridLines="None" AllowFilteringByColumn="True"
                            AllowPaging="True" AllowSorting="false" PageSize="50" OnDeleteCommand="RGKhongTamUng_DeleteCommand"
                            OnPageIndexChanged="RGKhongTamUng_PageIndexChanged" OnPageSizeChanged="RGKhongTamUng_PageSizeChanged"
                            OnItemCommand="RGKhongTamUng_ItemCommand" OnCancelCommand="RGKhongTamUng_CancelCommand"
                            OnUpdateCommand="RGKhongTamUng_UpdateCommand">
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="false" />
                            </ClientSettings>
                            <MasterTableView>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="SỬA" EditText="SỬA">
                                        <ItemStyle />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa không?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="CHI TIẾT" UniqueName="ChiTiet"
                                        AllowFiltering="False" Groupable="False">
                                        <ItemTemplate>
                                            <a onclick="openRadWindowShow2('<%#Eval("SoPhieu") %>','<%#Eval("MaDV") %>','<%#Eval("LoaiTien") %>','<%#Eval("Tigia") %>')">
                                                <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("BPTCKTKiemtra")) %>' />
                                            </a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                CommandName="PRINT" /></ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                        FilterControlWidth="70px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MADV" DataField="MADV" FilterControlWidth="50px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN TT" UniqueName="SoTien" DataField="SoTien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                        AllowFiltering="false">
                                        <ItemTemplate>
                                            <%# String.Format("{0:0,0}", Eval("Tigia"))%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="LaTienmat" HeaderText="HTTT" UniqueName="LaTienmat"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PhuongThucTT" HeaderText="PTTT" UniqueName="PhuongThucTT"
                                        FilterControlWidth="40px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NganHang" HeaderText="NGÂN HÀNG" UniqueName="NganHang"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TenTaiKhoan" HeaderText="TÊN TK" UniqueName="TenTaiKhoan"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTaiKhoan" HeaderText="SỐ TK" UniqueName="SoTaiKhoan"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100PX" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="NgayLap" DataField="NgayLap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" DataField="NoiDung" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="BPTCKTKiemtra" HeaderText="KIỂM TRA" UniqueName="BPTCKTKiemtra"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("BPTCKTKiemtra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager4" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose3">
                    </telerik:RadWindowManager>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Nhập thông tin giấy nộp tiền</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="right">
                                        Tên đơn vị:
                                    </td>
                                    <td style="width: 10px">
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtTenDV3" Width="175px" Enabled="false" runat="server" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="right">
                                        Người nộp tiền:
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="false" ID="ddlNguoiNopTien" runat="server" DataValueField="MaNV"
                                            DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="ddlNguoiNopTien"
                                            Display="Dynamic" ErrorMessage="Chọn người được thanh toán." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Phụ trách đơn vị:
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList Enabled="true" ID="ddlPhuTrachDonVi3" runat="server" DataValueField="MaNV"
                                            DataTextField="Ten" Width="180px" AutoPostBack="True" Skin="Windows7">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="right">
                                        Hạn thanh toán:
                                    </td>
                                    <td width="10px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadDatePicker ID="rdHanThanhToan3" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7">
                                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                                ViewSelectorText="x" runat="server">
                                            </Calendar>
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput2" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                                runat="server">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="rdHanThanhToan3"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Loại tiền:
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlLoaiTien3" runat="server" DataTextField="LoaiTien" DataValueField="LoaiTien"
                                            Skin="Windows7" Width="70px" AutoPostBack="True" OnSelectedIndexChanged="ddlLoaiTien3_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="ddlLoaiTien3"
                                            Display="Dynamic" ErrorMessage="Chọn loại tiền." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="right">
                                        Tỉ giá:
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnTiGia3" runat="server" Culture="Vietnamese (Vietnam)"
                                            Skin="Windows7" Width="70px" Enabled="true">
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="rnTiGia3"
                                            Display="Dynamic" ErrorMessage="Nhập tỉ giá." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                         <a id="Links3" target="_blank" href="https://portal.vietcombank.com.vn/Usercontrols/TVPortal.TyGia/pXML.aspx?b=1" style="color: blue" > Bảng Tỉ Giá </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Ghi chú:
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:TextBox ID="txtGhiChu" runat="server" Width="96%" Height="25px" Skin="Windows7"></asp:TextBox>
                                    </td>
                                    <td style="width: 10px">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="txtMaDV3" Width="80px" Enabled="false" runat="server" Visible="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtMaDV2"
                                            Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS3" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP3" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="2" cellspacing="2" border="0">
                                <tr>
                                    <td align="center">
                                        <asp:ImageButton ID="btnLuu3" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu3_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <asp:Label ID="lbLoiNT" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px;">
                        <legend>Danh sách chứng từ nộp tiền</legend>
                        <telerik:RadGrid ID="RGGiayNopTien" runat="server" AutoGenerateColumns="False" EnableLinqExpressions="False"
                            GridLines="None" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="false"
                            Skin="Windows7" PageSize="50" OnDeleteCommand="RGGiayNopTien_DeleteCommand" OnItemCommand="RGGiayNopTien_ItemCommand"
                            OnPageIndexChanged="RGGiayNopTien_PageIndexChanged" OnPageSizeChanged="RGGiayNopTien_PageSizeChanged"
                            OnUpdateCommand="RGGiayNopTien_UpdateCommand" OnCancelCommand="RGGiayNopTien_CancelCommand">
                            <ClientSettings EnableRowHoverStyle="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="false" />
                            </ClientSettings>
                            <MasterTableView>
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="SỬA" EditText="SỬA">
                                        <ItemStyle />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa không?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn DataField="ChiTiet" HeaderText="CHI TIẾT" UniqueName="ChiTiet"
                                        AllowFiltering="False" Groupable="False">
                                        <ItemTemplate>
                                            <a onclick="openRadWindowShow3('<%#Eval("SoPhieu") %>','<%#Eval("LoaiTien") %>','<%#Eval("Tigia") %>')">
                                                <img id="Img1" runat="server" alt="" border="0" src="~/images/detail.png" visible='<%#!clsConvertHelper.Tobool( Eval("KiemTra")) %>' />
                                            </a>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                                CommandName="PRINT" /></ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                        FilterControlWidth="70px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="50px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="NguoiLap" DataField="NguoiLap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Visible="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LoaiTien" HeaderText="LOẠI TIỀN" UniqueName="LoaiTien"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Tigia" HeaderText="TỈ GIÁ" UniqueName="Tigia"
                                        AllowFiltering="false">
                                        <ItemTemplate>
                                            <%# String.Format("{0:0,0}", Eval("Tigia"))%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="SoTien" DataField="SoTien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY LẬP" UniqueName="NgayLap" DataField="NgayLap"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="HẠN TT" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" DataField="NoiDung" UniqueName="NoiDung"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderStyle-Width="100px" DataField="KiemTra" HeaderText="KIỂM TRA"
                                        UniqueName="KiemTra" AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
            </telerik:radmultipage>
            <asp:Panel runat="server" ID="panel1">
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
