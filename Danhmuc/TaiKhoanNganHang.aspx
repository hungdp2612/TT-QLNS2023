<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/Home.master" CodeFile="TaiKhoanNganHang.aspx.cs" Inherits="Danhmuc_TaiKhoanNganHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
    <script type="text/javascript">
        function SelectAllrgNhapExcel(CheckBox) {
            var TargetBaseControl = document.getElementById('<%= this.rgNhapExcel.ClientID %>');
            var TargetChildControl = "chkChon";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0) {
                    if (Inputs[iCount].disabled == false) {
                        Inputs[iCount].checked = CheckBox.checked;
                    }
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                VisibleTitlebar="False" Width="998px">
                <ContentTemplate>
                    <center>
                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                SelectedIndex="0">
                <Tabs>
                    <telerik:RadTab Text="Danh sách tài khoản ngân hàng">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Nhập từ excel">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Nhập thông tin tài khoản</legend>
                        <center>
                            <table border="0">
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
                                    <td colspan="7" align="center">
                                        <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Danh sách tài khoản ngân hàng</legend>
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                            GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                            OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            AllowFilteringByColumn="True" AllowSorting="True" OnSortCommand="RG_SortCommand"
                            OnInsertCommand="RG_InsertCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="15">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                            <MasterTableView>
                                <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="XÓA">
                                    </telerik:GridButtonColumn>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="Sửa" HeaderText="SỬA"
                                        UniqueName="EditCommandColumn">
                                        <ItemStyle />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn HeaderText="Số TK" UniqueName="SoTaiKhoan" DataField="SoTaiKhoan"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tên ngân hàng" UniqueName="TenNganHang" DataField="TenNganHang"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Tên tài khoản" UniqueName="TenTaiKhoan" DataField="TenTaiKhoan"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Mã NV tài khoản" UniqueName="MANV" DataField="MANV"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Đơn vị" UniqueName="MADV" DataField="MADV"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Ghichu" DataField="Ghichu"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="HieuLuc" HeaderText="HL" UniqueName="HieuLuc"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLuc")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="ID" UniqueName="ID" DataField="ID" Display="false"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            </HeaderContextMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                <center>
                    <table>
                        <tr>
                            <td align="left">
                                <asp:FileUpload ID="fuDuongDan" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="(*)"
                                    ForeColor="red" ControlToValidate="fuDuongDan" ValidationGroup="GLoadExcel" Height="25px"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:ImageButton ID="btnLoadExcel" runat="server" OnClick="btnLoadExcel_Click" ImageUrl="~/images/Nutchuanweb/btLoadDuLieu.png"
                                    ValidationGroup="GLoadExcel" />
                            </td>
                            <td>
                                <asp:ImageButton ID="btnExportMau" runat="server" ImageUrl="~/images/Nutchuanweb/Mau.png"
                                    OnClick="btnExportMau_Click" />
                            </td>
                            <td>
                                <asp:ImageButton ID="btXoaTatCaExcel" runat="server" ImageUrl="~/images/Nutchuanweb/btXoaTatCa.png"
                                    OnClientClick="return fConfirm('Bạn có chắc muốn xóa dữ liệu này?')" OnClick="btXoaTatCaExcel_Click" />
                            </td>
                            <td>
                                <asp:ImageButton ID="btnNhapDuLieu" runat="server" ImageUrl="~/images/Nutchuanweb/NhapDuLieu.png"
                                    OnClick="btnNhapDuLieu_Click" ValidationGroup="GNhapExcel" />
                            </td>
                        </tr>
                    </table>
                    </center>
                    <telerik:RadGrid ID="rgNhapExcel" Width="100%" runat="server" AutoGenerateColumns="False"
                        EnableLinqExpressions="False" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                        GridLines="None" AllowPaging="True" AllowSorting="True" ShowGroupPanel="True"
                        CellSpacing="0" AllowFilteringByColumn="True" OnDeleteCommand="rgNhapExcel_DeleteCommand"
                        OnItemCommand="rgNhapExcel_ItemCommand" OnPageIndexChanged="rgNhapExcel_PageIndexChanged"
                        OnPageSizeChanged="rgNhapExcel_PageSizeChanged">
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            <WebServiceSettings>
                                <ODataSettings InitialContainerName="">
                                </ODataSettings>
                            </WebServiceSettings>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView>
                            <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="MADV" UniqueName="MADV" DataField="MADV"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MANV" UniqueName="MANV" DataField="MANV"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TENNGANHANG" UniqueName="TENNGANHANG" DataField="TENNGANHANG"
                                    FilterControlWidth="100px" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="SOTAIKHOAN" UniqueName="SOTAIKHOAN" DataField="SOTAIKHOAN"
                                    FilterControlWidth="100px" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="TENTAIKHOAN" UniqueName="TENTAIKHOAN" DataField="TENTAIKHOAN"
                                    FilterControlWidth="100px" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="GHICHU" UniqueName="GHICHU" DataField="GHICHU"
                                    FilterControlWidth="100px" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="Chon" HeaderText="Chọn" UniqueName="Chon"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="False">
                                    <HeaderTemplate>
                                        <input onclick="SelectAllrgNhapExcel(this);" type="checkbox">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkChon" runat="server" Checked='<%#clsConvertHelper.Tobool(Eval("Chon")) %>'
                                            Enabled='<%#(clsConvertHelper.Tobool(Eval("Chon"))== true)?true:false %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="TENMAYTINH" UniqueName="TENMAYTINH" DataField="TENMAYTINH"
                                    FilterControlWidth="100px" AllowFiltering="False" Display="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView><ClientSettings>
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <FilterMenu EnableImageSprites="False">
                            <WebServiceSettings>
                                <ODataSettings InitialContainerName="">
                                </ODataSettings>
                            </WebServiceSettings>
                        </FilterMenu>
                    </telerik:RadGrid>
               </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
       <Triggers>
            <asp:PostBackTrigger ControlID="btnLoadExcel" />
            <asp:PostBackTrigger ControlID="btnExportMau" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
