<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietThanhToanHopDong.aspx.cs"
    Inherits="ChiTietThanhToanHopDong" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết đề nghị thanh toán::.</title>
    <style type="text/css">
        .bgtieudebox
        {
            background-image: url("../image/bg_title.png");
            background-repeat: repeat-x;
            height: 40px;
            font-size: 14pt;
            color: White;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement && window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CheckWnd() {
            var wnd = GetRadWindow();
            if (wnd) {

            }
            else {
                window.location = "../Loi.aspx?Strloi=Truy cập không hợp lệ ...";
            }
        }
        CheckWnd();
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <script type="text/javascript" defer="defer" language="javascript">
        function onkeyupEvent() {



            rnTiGia = $find("<%= rnTiGia.ClientID %>");

            rdThanhTien = $find("<%= rdThanhTien.ClientID %>");

            rnTienHDConLaiAn = $find("<%= rnTienHDConLaiAn.ClientID %>");
            var InputSoTienHDConLai = $find("<%= rnSoTienHopDong.ClientID %>");
            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            cboSoHopDong = $find("<%= cboSoHopDong.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");

        
            if (document.getElementById("rdThanhTien").value >= 0) {

               
            

                InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());

                InputSoTienHDConLai.set_value(rnTienHDConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());
        
                //InputSoTienHDConLai.set_value(0);

              //  cboSoHopDong.clearSelection();       
                    
                
            }
            else {
//                if (document.getElementById("cboSoHopDong").value != "") {
                  
                   
                    // alert(rdThanhTien.value);

                    InputSoTienHDConLai.set_value(rnTienHDConLaiAn.get_value() + rdThanhTien.get_value() * rnTiGia.get_value());

                    InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value());
              //  }
//                else {

//                    alert("Nếu nhập < 0 thì phải có số hợp đồng");
//                    rdThanhTien.set_value(0);
//                }


            }






        }
        function onkeyupEvent2() {

            rnSoLuong = $find("<%= rnSoLuong.ClientID %>");
            rnDonGia = $find("<%= rnDonGia.ClientID %>");
            var rdSoTienThanhToan = $find("<%= rdThanhTien.ClientID %>");
            rdSoTienThanhToan.set_value(rnSoLuong.get_value() * rnDonGia.get_value());


            rnTiGia = $find("<%= rnTiGia.ClientID %>");

            rdThanhTien = $find("<%= rdThanhTien.ClientID %>");
            rnNganSachConLaiAn = $find("<%= rnNganSachConLaiAn.ClientID %>");

            var InputNganSachConLai = $find("<%= rnNganSachConLai.ClientID %>");
            // alert(rdThanhTien.get_value());

            InputNganSachConLai.set_value(rnNganSachConLaiAn.get_value() - rdThanhTien.get_value() * rnTiGia.get_value());


        }  
    </script>
    <div>
        <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
            Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
            VisibleTitlebar="False" Width="100%">
            <ContentTemplate>
                <center>
                    <asp:Label ID="lbLoi" runat="server"></asp:Label>
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                    </asp:UpdateProgress>
                </center>
            </ContentTemplate>
        </telerik:RadNotification>
        <fieldset>
            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập chi tiết phiếu
                đề nghị thanh toán</legend>
            <center>
                <table cellpadding="2" cellspacing="2">
                    <tr>
                        <td align="right">
                            Số phiếu:
                        </td>
                        <td width="10">
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtSoPhieu" runat="server" ReadOnly="True" Width="160px" Enabled="False"></asp:TextBox>
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
                            <asp:TextBox ID="txtLoaiTien" runat="server" Enabled="False" Width="155px"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right">
                            Tỉ giá:
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <telerik:RadNumericTextBox ID="rnTiGia" runat="server" Enabled="False" ReadOnly="True"
                                Width="160px">
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
                            <telerik:RadComboBox ID="cbMaChiPhi" runat="server" Width="165px" DataTextField="MSChiPhi"
                                AutoPostBack="True" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
                                EnableLoadOnDemand="true" Height='150px' DropDownWidth="350px" Enabled="true"
                                OnItemsRequested="cbMaChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged1">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <td width="150px">
                                                Mã CP
                                            </td>
                                            <td width="190px">
                                                Tên CP
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td width="150px">
                                                <%#Eval("MSChiPhi")%>
                                            </td>
                                            <td width="190px">
                                                <%#Eval("DienGiai")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <%--  <telerik:RadComboBox ID="cbMaChiPhi" runat="server" AutoPostBack="True" DataTextField="DienGiai"
                                DataValueField="MSChiPhi" DropDownWidth="400px" Height="170px" Width="165px"
                                OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged1" 
                                onitemsrequested="cbMaChiPhi_ItemsRequested">
                                <HeaderTemplate>
                                    <table width="400px">
                                        <tr>
                                            <td style="width: 100px">
                                                Mã chi phí
                                            </td>
                                            <td style="width: 300px">
                                                Diễn giải
                                            </td>
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table width="400px">
                                        <tr>
                                            <td style="width: 100px">
                                                <%# Eval("MSChiphi")%>
                                            </td>
                                            <td style="width: 300px">
                                                <%# Eval("DienGiai")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cbMaChiPhi"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                            <telerik:RadNumericTextBox ID="rnNganSachConLai" Enabled="false" runat="server" AutoPostBack="false"
                                Width="160px" Value="0">
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
                            <telerik:RadNumericTextBox ID="rdThanhTien" runat="server" AutoPostBack="false" Width="160px"
                                Value="0" onkeyup="onkeyupEvent()">
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
                            <asp:TextBox ID="txtQuiCach" runat="server" Enabled="true" Width="160px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuiCach"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
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
                            <telerik:RadNumericTextBox ID="rnSoLuong" runat="server" Width="160px" Enabled="true"
                                Value="0" onkeyup="onkeyupEvent2()">
                            </telerik:RadNumericTextBox>
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
                            <telerik:RadNumericTextBox ID="rnDonGia" runat="server" Width="160px" Enabled="true"
                                Value="0" onkeyup="onkeyupEvent2()">
                            </telerik:RadNumericTextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td align="right">
                            Đơn vị tính:
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtDVT" runat="server" Enabled="true" Width="160px"></asp:TextBox>
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
                            <telerik:RadNumericTextBox ID="rnVAT" runat="server" Width="160px" Enabled="true"
                                Value="0">
                            </telerik:RadNumericTextBox>
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
                            <asp:TextBox ID="txtSoHoaDon" runat="server" Enabled="true" Width="155px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Số hợp đồng:
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="cboSoHopDong" runat="server" Width="165px" DataTextField="Sohopdong"
                                AutoPostBack="True" DataValueField="Sohopdong" HighlightTemplatedItems="true"
                                EnableLoadOnDemand="true" Height='150px' DropDownWidth="350px" Enabled="true"
                                OnItemsRequested="cboSoHopDong_ItemsRequested" OnSelectedIndexChanged="cboSoHopDong_SelectedIndexChanged">
                                <HeaderTemplate>
                                    <table>
                                        <tr>
                                            <td width="150px">
                                                Số HD
                                            </td>
                                            <td width="190px">
                                                Mã CP
                                            </td>
                                            <td width="190px">
                                                Số tiền
                                            </td>
                                          
                                        </tr>
                                    </table>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td width="150px">
                                                <%#Eval("Sohopdong")%>
                                            </td>
                                            <td width="190px">
                                                <%#Eval("MSChiphi")%>
                                            </td>
                                            <td width="190px">
                                                <%#Eval("SotienHD")%>
                                            </td>
                                          
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right">
                            Số tiền HĐ còn:
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td align="left">
                            <telerik:RadNumericTextBox ID="rnSoTienHopDong" runat="server" Width="160px" Enabled="false"
                                Value="0">
                            </telerik:RadNumericTextBox>
                        </td>
                        <td>
                            &nbsp;
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
                            <asp:TextBox ID="txtGhiChu" runat="server" Width="98%" Height="25px"></asp:TextBox>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td align="center" colspan="15">
                            <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                ValidationGroup="gLuu" OnClick="btLuu_Click" />
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtMaDV" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                Visible="false"></asp:TextBox>
                            <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                Visible="false"></asp:TextBox>
                            <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                Visible="false"></asp:TextBox>
                            <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                Visible="false"></asp:TextBox>
                            <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" ReadOnly="True"
                                Width="160px" Enabled="false" Value="0" Display="false">
                            </telerik:RadNumericTextBox>

                             <telerik:RadNumericTextBox ID="rnTienHDConLaiAn" runat="server" ReadOnly="True"
                                Width="160px" Enabled="true" Value="0" Display="false">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr>
                </table>
            </center>
        </fieldset>
        <fieldset>
            <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                phiếu đề nghị thanh toán</legend>
            <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                AllowSorting="True" ShowStatusBar="True" EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand"
                OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" Skin="Windows7"
                PageSize="15">
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>
                <HeaderContextMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                </HeaderContextMenu>
                <GroupingSettings CaseSensitive="False" />
                <MasterTableView>
                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                            Groupable="False">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="ID" UniqueName="CTTT_ID" DataField="CTTT_ID"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" Visible="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tên - Qui cách" UniqueName="TenvaQuiCach" DataField="TenvaQuiCach"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số hóa đơn" UniqueName="SoHoaDon" DataField="SoHoaDon"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" Visible="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số phiếu" UniqueName="SoPhieu" DataField="SoPhieu"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" Visible="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="MSChiPhi" UniqueName="MSChiPhi" DataField="MSChiPhi"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" Visible="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số lượng" UniqueName="SoLuong" DataField="SoLuong"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Đơn giá" UniqueName="DonGia" DataField="DonGia"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Thành tiền" UniqueName="TienThanhToan" DataField="TienThanhToan"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="VAT" UniqueName="VAT" DataField="VAT" FilterControlWidth="70px"
                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                            DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tiền còn lại(VND)" UniqueName="TienConLai" DataField="TienConLai"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                            HeaderText="Sửa" EditText="Sửa">
                            <ItemStyle />
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                            ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                        <EditColumn UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </fieldset>
    </div>
    </form>
</body>
</html>
