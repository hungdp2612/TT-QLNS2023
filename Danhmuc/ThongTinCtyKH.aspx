<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="ThongTinCtyKH.aspx.cs" Inherits="Danhmuc_ThongTinCtyKH" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 90px;
        }
        .style2
        {
            width: 61px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table width="100%" cellpadding="0" cellspacing="0" id="topp">
            <tr>
                <td class="bgtieudebox">
                    <center>
                        DANH MỤC THÔNG TIN CÔNG TY KHÁCH HÀNG
                    </center>
                </td>
            </tr>
        </table>
        <fieldset>
            <legend style="color: #980039; font-weight: bold;">CẬP NHẬT THÔNG TIN CÔNG TY KHÁCH
                HÀNG </legend>
            <center>
                <table>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="RDThongTinCtyKH" runat="server" DataSourceID="SqlDTS_RDThongTinCtyKH"
                                    OnDeleteCommand="RDThongTinCtyKH_DeleteCommand" OnInsertCommand="RDThongTinCtyKH_InsertCommand"
                                    OnItemCommand="RDThongTinCtyKH_ItemCommand" OnPageIndexChanged="RDThongTinCtyKH_PageIndexChanged"
                                    OnPageSizeChanged="RDThongTinCtyKH_PageSizeChanged" OnUpdateCommand="RDThongTinCtyKH_UpdateCommand">
                                    <GroupingSettings CaseSensitive="False" />
                                    <MasterTableView AutoGenerateColumns="false" DataSourceID="SqlDTS_RDThongTinCtyKH"
                                        CommandItemDisplay="Top">
                                        <CommandItemSettings AddNewRecordText="Thêm mới" />
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                            <HeaderStyle Width="20px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="MaCongtyKH" FilterControlAltText="Filter MaCongtyKH column"
                                                HeaderText="Mã Công ty" ReadOnly="True" SortExpression="MaCongtyKH" UniqueName="MaCongtyKH"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TenCty" FilterControlAltText="Filter TenCty column"
                                                HeaderText="Tên Công ty" ReadOnly="True" SortExpression="TenCty" UniqueName="TenCty"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="DiaChi" FilterControlAltText="Filter DiaChi column"
                                                HeaderText="Địa chỉ" ReadOnly="True" SortExpression="DiaChi" UniqueName="DiaChi"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Tel" FilterControlAltText="Filter Tel column"
                                                HeaderText="Tel" ReadOnly="True" SortExpression="Tel" UniqueName="Tel" CurrentFilterFunction="Contains"
                                                ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="TeleFax" FilterControlAltText="Filter TeleFax column"
                                                HeaderText="TeleFax" ReadOnly="True" SortExpression="TeleFax" UniqueName="TeleFax"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="Email" FilterControlAltText="Filter Email column"
                                                HeaderText="Email" ReadOnly="True" SortExpression="Email" UniqueName="TeleFax"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="hieuluc" FilterControlAltText="Filter hieuluc column"
                                                HeaderText="Hiệu lực" ReadOnly="True" SortExpression="hieuluc" UniqueName="hieuluc"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" HeaderText="Sửa" ButtonType="ImageButton"
                                                UpdateImageUrl="../Images/Edit.gif" ItemStyle-HorizontalAlign="Center">
                                                <HeaderStyle Width="10%" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ConfirmText="Bạn thật sự muốn xóa ?" ConfirmDialogType="RadWindow"
                                                ItemStyle-Width="3%" ConfirmTitle="Xóa" ButtonType="ImageButton" CommandName="Delete"
                                                Text="Delete" UniqueName="DeleteColumn" HeaderText="Xóa">
                                                <HeaderStyle Width="3%" />
                                                <ItemStyle Width="3%"></ItemStyle>
                                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
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
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                    </HeaderContextMenu>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblLoi" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
    </div>
    <asp:SqlDataSource ID="SqlDTS_RDThongTinCtyKH" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectDB_QLNS2013%>"
        SelectCommand="sp_ThongTinCtyKH_Load" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</asp:Content>
