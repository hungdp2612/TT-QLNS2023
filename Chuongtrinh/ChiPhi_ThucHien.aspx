<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ChiPhi_ThucHien.aspx.cs" Inherits="Chuongtrinh_ChiPhi_ThucHien" %>

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
                                <img alt="Loading..." src="../images/ajax-loader-bar.gif" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>
            <center>
                <table>
                    <tr>
                        <td>
                            Năm/Tháng
                        </td>
                        <td width="5px">
                        </td>
                        <td>
                            <telerik:RadMonthYearPicker ID="rdThangNam" runat="server" Culture="vi-VN" Width="100px"
                                AutoPostBack="true" OnSelectedDateChanged="rdThangNam_SelectedDateChanged">
                                <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="MM/yyyy" LabelWidth="40%">
                                </DateInput>
                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                            </telerik:RadMonthYearPicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="(*)"
                                ValidationGroup="GInsert" ControlToValidate="rdThangNam" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                        <td width="5px">
                        </td>
                        <td>
                            Đơn vị
                        </td>
                        <td width="5px">
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cbDonVi" runat="server" DataTextField="TenDonVi" DataValueField="MaDonVi"
                                Enabled="true" AutoPostBack="true" EnableLoadOnDemand="true" HighlightTemplatedItems="true"
                                MaxHeight="150px" Width="180px" OnItemsRequested="cbDonVi_ItemsRequested" OnSelectedIndexChanged="cbDonVi_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="(*)" ValidationGroup="GInsert"
                                ForeColor="Red" Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="(*)" ValidationGroup="GNhapExcel"
                                ForeColor="Red" Display="Dynamic" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                        </td>
                    </tr>
                </table>
            </center>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                SelectedIndex="0">
                <Tabs>
                    <telerik:RadTab Text="Danh sách chi phí thực hiện">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Nhập từ excel">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <center>
                        <table border="0">
                            <tr>
                                <td>
                                    Mã chi phí:
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cbMaChiPhi" runat="server" DataTextField="HienThi" DataValueField="MSChiPhi"
                                        EnableLoadOnDemand="true" HighlightTemplatedItems="true" MaxHeight="150px" Width="260px"
                                        OnItemsRequested="cbMaChiPhi_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMSCHIPHI" runat="server" ControlToValidate="cbMaChiPhi"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Chi phí:
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="rnCHIPHI" runat="server" Value="0" Width="260px">
                                        <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="(*)"
                                        ValidationGroup="GInsert" ControlToValidate="rnCHIPHI" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <%--  <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Chi phí phải > 0"
                                        ForeColor="Red" ValueToCompare="0" ControlToValidate="rnCHIPHI" Display="Dynamic"
                                        Operator="GreaterThan" ValidationGroup="GInsert"></asp:CompareValidator>--%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="11" align="center">
                                    <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                </td>
                            </tr>
                        </table>
                    </center>
                    <telerik:RadGrid ID="RG" Width="1000px" runat="server" AutoGenerateColumns="False"
                        ShowFooter="True" EnableLinqExpressions="False" GridLines="None" OnItemCommand="RG_ItemCommand"
                        OnCancelCommand="RG_CancelCommand" OnDeleteCommand="RG_DeleteCommand" OnEditCommand="RG_EditCommand"
                        OnInsertCommand="RG_InsertCommand" OnUpdateCommand="RG_UpdateCommand" OnPageIndexChanged="RG_PageIndexChanged"
                        OnPageSizeChanged="RG_PageSizeChanged" AllowFilteringByColumn="True" OnSortCommand="RG_SortCommand"
                        CellSpacing="0">
                        <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <MasterTableView>
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="30px" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Năm" UniqueName="NAM" DataField="NAM" FilterControlWidth="50px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="THANG" DataField="THANG"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Đơn vị" UniqueName="MADV" DataField="MADV" FilterControlWidth="100px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Mã chi phí" UniqueName="MSCHIPHI" DataField="MSCHIPHI"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="70px">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Tên CP" UniqueName="DienGiai" DataField="DienGiai"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="70px" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                </telerik:GridBoundColumn>
                                <%--  <telerik:GridBoundColumn HeaderText="Chi phí" UniqueName="CHIPHI" DataField="CHIPHI"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false" FilterControlWidth="100px">
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>--%>
                                <telerik:GridBoundColumn HeaderText="Chi phí" UniqueName="CHIPHI" DataField="CHIPHI"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                    Aggregate="Sum" FooterStyle-ForeColor="Blue" FooterStyle-HorizontalAlign="Right">
                                    <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="kHOA" UniqueName="kHOA" DataField="kHOA" FilterControlWidth="100px"
                                    Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="Sửa" EditText="Sửa">
                                    <ItemStyle />
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <center>
                        <table>
                            <tr>
                                <td align="left">
                                    <asp:FileUpload ID="fuDuongDan" runat="server" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="(*)"
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
                                <telerik:GridBoundColumn HeaderText="Mã chi phí" UniqueName="MSCHIPHI" DataField="MSCHIPHI"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Diễn giải" UniqueName="DienGiai" DataField="DienGiai"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Chi phí" UniqueName="CHIPHI" DataField="CHIPHI"
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
                                <telerik:GridTemplateColumn DataField="GhiChu" HeaderText="Ghi chú" UniqueName="GhiChu"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtGhiChu" runat="server" Enabled="false" Text='<%#Eval("GhiChu").ToString()%>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridTemplateColumn>
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
