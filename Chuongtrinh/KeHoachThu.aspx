<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachThu.aspx.cs" Inherits="Chuongtrinh_KeHoachThu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                <img alt="Loading..." src="../images/Nutchuanweb/ajax-loader-bar.gif" /></ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                </ContentTemplate>
            </telerik:RadNotification>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="MultiPage" ReorderTabsOnSelect="True"
                SelectedIndex="0">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Nhập chi tiết" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Đẩy từ excel">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <br />
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <center>
                        <table border="0">
                            <tr>
                                <td align="right">
                                    Nhóm Doanh Thu:
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cbBoPhan1" runat="server" HighlightTemplatedItems="true"
                                        Width="200px" DataTextField="Tendonvi" DataValueField="Madonvi" MaxHeight="150px"
                                        EnableLoadOnDemand="false" AutoPostBack="true" OnSelectedIndexChanged="cbBoPhan1_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cbBoPhan1"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                                <td align="right">
                                    Tháng/Năm:
                                </td>
                                <td>
                                    <telerik:RadMonthYearPicker ID="rThangNam" runat="server" Culture="vi-VN" Width="120px"
                                        OnSelectedDateChanged="rThangNam_SelectedDateChanged">
                                        <DateInput DisplayDateFormat="MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" AutoPostBack="false">
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    </telerik:RadMonthYearPicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorNam" runat="server" ControlToValidate="rThangNam"
                                        Display="Dynamic" ErrorMessage="Nam" SetFocusOnError="True" ValidationGroup="GInsert"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Kế hoạch thu:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="rnSoTien" runat="server" MinValue="0" Value="0" Width="120px">
                                        <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td align="right">
                                    Thực thu:
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox ID="rnThucThu" runat="server" MinValue="0" Value="0" Width="120px">
                                        <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    </telerik:RadNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Ghi chú:
                                </td>
                                <td  colspan="10">
                                    <asp:TextBox ID="tbDienGiai" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10" align="center">
                                    <asp:ImageButton ID="btnInsert" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnInsert_Click" />
                                </td>
                            </tr>
                        </table>
                    </center>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                        GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnEditCommand="RG_EditCommand" OnInsertCommand="RG_InsertCommand"
                        OnUpdateCommand="RG_UpdateCommand" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        AllowFilteringByColumn="True" AllowSorting="True" OnSortCommand="RG_SortCommand">
                        <%--  <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>--%>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView ShowFooter="true">
                            <%--       <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>--%>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Năm" UniqueName="Nam" DataField="Nam" FilterControlWidth="50px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Bộ phận" UniqueName="MABP" DataField="MABP"
                                    AllowFiltering="false" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="KH Thu" UniqueName="SoTien" DataField="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" Aggregate="Sum" FooterAggregateFormatString="{0:###,###.##}"
                                    FilterControlWidth="100px" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Thực thu" UniqueName="ThucThu" DataField="ThucThu"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" Aggregate="Sum" FooterAggregateFormatString="{0:###,###.##}"
                                    FilterControlWidth="100px" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="DienGiai" DataField="DienGiai"
                                    AllowFiltering="false" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                    HeaderText="Chỉnh sửa" EditText="Sửa">
                                    <ItemStyle />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <center>
                        <table>
                            <tr>
                                <td>
                                    Nhóm Doanh Thu:
                                </td>
                                <td colspan="10">
                                    <telerik:RadComboBox ID="cbBoPhan" runat="server" HighlightTemplatedItems="true"
                                        Width="260px" DataTextField="Tendonvi" DataValueField="Madonvi" MaxHeight="150px"
                                        EnableLoadOnDemand="false" AutoPostBack="true" OnSelectedIndexChanged="cbBoPhan_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMABP" runat="server" ControlToValidate="cbBoPhan"
                                        Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="NhapDuLieu"
                                        ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
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
                                        OnClick="btnNhapDuLieu_Click" ValidationGroup="NhapDuLieu" />
                                </td>
                            </tr>
                        </table>
                    </center>
                    <telerik:RadGrid ID="RG_EXCEL" Width="100%" runat="server" AutoGenerateColumns="False"
                        EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                        GridLines="None" AllowPaging="True" AllowFilteringByColumn="false" AllowSorting="True"
                        OnDeleteCommand="RG_EXCEL_DeleteCommand">
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Năm" UniqueName="Nam" DataField="Nam" FilterControlWidth="50px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Bộ phận" UniqueName="MABP" DataField="MABP"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="100px">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="KH Thu" UniqueName="SoTien" DataField="SoTien"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    Aggregate="Sum" FooterAggregateFormatString="{0:###,###.##}" FilterControlWidth="100px"
                                    FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn HeaderText="Thực thu" UniqueName="ThucThu" DataField="ThucThu"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    DataFormatString="{0:###,###.##}" Aggregate="Sum" FooterAggregateFormatString="{0:###,###.##}"
                                    FilterControlWidth="100px" FooterStyle-ForeColor="Blue" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                    FilterControlWidth="100px">
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
                        </MasterTableView>
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
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
