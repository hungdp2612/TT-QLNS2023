<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="XemKeHoachKhoanMuc_Mar.aspx.cs" Inherits="Chuongtrinh_XemKeHoachKhoanMuc_Mar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">
                window.onload = function () {
                    window.setTimeout(function () { setCalendarTable(); }, 200);
                    window.setTimeout(function () { setCalendarTableDen(); }, 200);

                }
              
            </script>
            <div style="height: 10px;">
            </div>
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage"
                Skin="Windows7">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Xem kế hoạch chi phí" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem chi phí khoản mục">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem thanh toán khoản mục (Có chi tiết)">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem tổng thanh toán khoản mục">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Xem kế hoạch chi phí</legend>
                        <center>
                            <table>
                                <tr>
                                    <td align="left">
                                        Năm:
                                    </td>
                                    <td style="width: 10px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam3" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rnNam3"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert3"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Đơn vị
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:DropDownList ID="cboDonVi3" DataTextField="TenDonVi" DataValueField="IDMaDV"
                                            Skin="Windows7" runat="server" Width="200px" Enabled="true">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" />
                                        <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaBP3" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ImageButton ID="btXem3" runat="server" ImageUrl="~/Images/Nutchuanweb/btXem.png"
                                            ValidationGroup="GInsert3" OnClick="btXem3_Click" />
                                        &nbsp;<asp:ImageButton ID="btExcel3" runat="server" ImageUrl="~/Images/Nutchuanweb/excell.png"
                                            ValidationGroup="GInsert3" OnClick="btExcel3_Click" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Danh sách kế hoạch chi phí</legend>
                        <telerik:RadGrid ID="RG3" Width="100%" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" CellSpacing="0" GridLines="Both" AllowPaging="false" PageSize="50"
                            EnableLinqExpressions="False" ShowFooter="True" AllowSorting="false">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="300"></CollapseAnimation>
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                            <MasterTableView>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn" Groupable="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="MSChiPhi" FilterControlAltText="Filter MSChiPhi column"
                                        HeaderText="MÃ CP" ReadOnly="True" SortExpression="MSChiPhi" UniqueName="MSChiPhi"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DienGiai" FilterControlAltText="Filter DienGiai column"
                                        HeaderText="NỘI DUNG" ReadOnly="True" SortExpression="DienGiai" UniqueName="DienGiai"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Chiphiduocduyet" FilterControlAltText="Filter Chiphiduocduyet column"
                                        HeaderText="KẾ HOẠCH" ReadOnly="True" SortExpression="Chiphiduocduyet" UniqueName="Chiphiduocduyet"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienTH" FilterControlAltText="Filter TienTH column"
                                        HeaderText="TỔNG CP ĐÃ THỰC HIỆN" ReadOnly="True" SortExpression="TienTH" UniqueName="TienTH"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CPConLai" FilterControlAltText="Filter CPConLai column"
                                        HeaderText="CP CÒN LẠI" ReadOnly="True" SortExpression="CPConLai" UniqueName="CPConLai"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Xem chi phí khoản mục</legend>
                        <center>
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td align="left">
                                        Năm:
                                    </td>
                                    <td style="width: 10px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Đơn vị
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left" colspan="10">
                                        <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="IDMaDV" runat="server"
                                            Skin="Windows7" Width="200px" Enabled="true" OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ImageButton ID="btXem" runat="server" ImageUrl="~/Images/Nutchuanweb/btXem.png"
                                            OnClick="btXem_Click" ValidationGroup="GInsert" />
                                        &nbsp;<asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/Images/Nutchuanweb/excell.png"
                                            OnClick="btExcel_Click" ValidationGroup="GInsert" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Danh sách chi phí khoản mục</legend>
                        <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" CellSpacing="0" GridLines="None" AllowPaging="True" PageSize="50"
                            EnableLinqExpressions="False" ShowGroupFooter="true" ShowFooter="true" OnPageIndexChanged="RG_PageIndexChanged"
                            OnPageSizeChanged="RG_PageSizeChanged" AllowSorting="false">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="300"></CollapseAnimation>
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="false" />
                            </ClientSettings>
                            <MasterTableView ShowGroupFooter="true">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="TemplateColumn" Groupable="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Khoa_khoanmuc" FilterControlAltText="Filter Khoa_khoanmuc column"
                                        HeaderText="KHOẢN MỤC" ReadOnly="True" SortExpression="Khoa_khoanmuc" UniqueName="Khoa_khoanmuc"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tenkhoanmuc" FilterControlAltText="Filter Tenkhoanmuc column"
                                        HeaderText="NỘI DUNG" ReadOnly="True" SortExpression="Tenkhoanmuc" UniqueName="Tenkhoanmuc"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="30px">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SUMChiPhi" FilterControlAltText="Filter SUMChiPhi column"
                                        HeaderText="KẾ HOẠCH" ReadOnly="True" SortExpression="SUMChiPhi" UniqueName="SUMChiPhi"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                        <HeaderTemplate>
                                            <table id="Table1" cellspacing="1" cellpadding="1" border="1" width="200px">
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <b>Phân chia chi phí</b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%" align="right">
                                                        <b>THƯƠNG HIỆU</b>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <b>XTBH</b>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <b>CSKH</b>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <b>NCTT</b>
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table id="Table2" cellspacing="1" cellpadding="1" border="1" width="200px">
                                                <tr>
                                                    <td width="50%" align="right">
                                                        <%#Eval("ThuongHieu")%>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <%#Eval("XTBH")%>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <%#Eval("CSKH")%>
                                                    </td>
                                                    <td width="50%" align="right">
                                                        <%#Eval("NCTT")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="ThuongHieu" FilterControlAltText="Filter ThuongHieu column"
                                        HeaderText="THƯƠNG HIỆU" ReadOnly="True" SortExpression="ThuongHieu" UniqueName="ThuongHieu"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="XTBH" FilterControlAltText="Filter XTBH column"
                                        HeaderText="XTBH" ReadOnly="True" SortExpression="XTBH" UniqueName="XTBH" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CSKH" FilterControlAltText="Filter CSKH column"
                                        HeaderText="CSKH" ReadOnly="True" SortExpression="CSKH" UniqueName="CSKH" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NCTT" FilterControlAltText="Filter NCTT column"
                                        HeaderText="NCTT" ReadOnly="True" SortExpression="NCTT" UniqueName="NCTT" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoTienKH" FilterControlAltText="Filter SoTienKH column"
                                        HeaderText="KH THỰC HIỆN" ReadOnly="True" SortExpression="SoTienKH" UniqueName="SoTienKH"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TietKiem" FilterControlAltText="Filter TietKiem column"
                                        HeaderText="TIẾT KIỆM" ReadOnly="True" SortExpression="TietKiem" UniqueName="TietKiem"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ThucHienThucTe" FilterControlAltText="Filter ThucHienThucTe column"
                                        HeaderText="TH THỰC TẾ" ReadOnly="True" SortExpression="ThucHienThucTe" UniqueName="ThucHienThucTe"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NSConLai" FilterControlAltText="Filter NSConLai column"
                                        HeaderText="CP CÒN LẠI" ReadOnly="True" SortExpression="NSConLai" UniqueName="NSConLai"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TTKH" FilterControlAltText="Filter TTKH column"
                                        HeaderText="TH/KH" ReadOnly="True" SortExpression="TTKH" UniqueName="TTKH" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <GroupByExpressions>
                                    <telerik:GridGroupByExpression>
                                        <SelectFields>
                                            <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP" HeaderText="Mã NS">
                                            </telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai" HeaderText="Diễn giải">
                                            </telerik:GridGroupByField>
                                        </SelectFields>
                                        <GroupByFields>
                                            <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP"></telerik:GridGroupByField>
                                            <telerik:GridGroupByField FieldAlias="DienGiai" FieldName="DienGiai"></telerik:GridGroupByField>
                                        </GroupByFields>
                                    </telerik:GridGroupByExpression>
                                </GroupByExpressions>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Xem thanh toán khoản mục</legend>
                        <center>
                            <table border="0">
                                <tr>
                                    <td align="left">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam2" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnNam2"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ForeColor="Red" ValidationGroup="GInsert2"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Mã CP:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbMaChiPhi" runat="server" Width="185px" DataTextField="MSChiPhi"
                                            AutoPostBack="true" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
                                            Skin="Windows7" EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px"
                                            Enabled="true" OnItemsRequested="cbMaChiPhi_ItemsRequested" OnSelectedIndexChanged="cbMaChiPhi_SelectedIndexChanged">
                                            <HeaderTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Mã chi phí
                                                        </td>
                                                        <td style="width: 200px">
                                                            Diễn giải
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            <%# Eval("MSChiPhi")%>
                                                        </td>
                                                        <td style="width: 200px">
                                                            <%# Eval("DienGiai")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cbMaChiPhi"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert2"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Khoản mục:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbKhoanMuc" runat="server" Width="185px" DataTextField="Khoa_khoanmuc"
                                            AutoPostBack="True" DataValueField="Khoa_khoanmuc" HighlightTemplatedItems="true"
                                            Skin="Windows7" EmptyMessage="Chọn khoản mục" EnableLoadOnDemand="true" Height='150px'
                                            DropDownWidth="320px" Enabled="true">
                                            <HeaderTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Khoản mục
                                                        </td>
                                                        <td style="width: 200px">
                                                            Tên khoản mục
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            <%# Eval("Khoa_khoanmuc")%>
                                                        </td>
                                                        <td style="width: 200px">
                                                            <%# Eval("Tenkhoanmuc")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <td align="left">
                                            Chương trình:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="cboChuongTrinh" DataTextField="TenChuongTrinh" DataValueField="LoaiChuongTrinh"
                                                runat="server" Width="200px" Enabled="true" Visible="true" Skin="Windows7">
                                            </asp:DropDownList>
                                        </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="center" colspan="20">
                                        <asp:ImageButton ID="btnXemChungTu" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                            OnClick="btnXemChungTu_Click" ValidationGroup="GInsert2" />
                                        &nbsp;<asp:ImageButton ID="btnExcellChungTu" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                            OnClick="btnExcellChungTu_Click" ValidationGroup="GInsert2" />
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="center">
                                        <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/ajax-loader-bar.gif" alt="" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtMaBP2" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="cboDonVi2" DataTextField="TenDonVi" DataValueField="IDMaDV"
                                            runat="server" Width="200px" Enabled="true" Visible="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Danh sách thanh toán khoản mục</legend>
                        <telerik:RadGrid ID="rgChungTu" runat="server" AutoGenerateColumns="False" ShowGroupPanel="false"
                            Skin="Windows7" GridLines="None" CellSpacing="0" Width="100%" AllowPaging="false"
                            EnableLinqExpressions="false" ShowFooter="true" OnPageIndexChanged="rgChungTu_PageIndexChanged"
                            OnPageSizeChanged="rgChungTu_PageSizeChanged">
                            <MasterTableView>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="NGÀY TT" UniqueName="NgayLap" DataField="NgayLap"
                                        FilterControlWidth="70px" ShowFilterIcon="false" AutoPostBackOnFilter="false"
                                        DataFormatString="{0:dd/MM/yyyy}" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="SỐ PHIẾU" UniqueName="SoPhieu"
                                        FilterControlWidth="40px" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NHÂN VIÊN" UniqueName="HoTen" DataField="HoTen"
                                        FilterControlWidth="60px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TenKM" HeaderText="TÊN KM" UniqueName="TenKM"
                                        FilterControlWidth="40px">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Noidung" HeaderText="NỘI DUNG" UniqueName="Noidung"
                                        FilterControlWidth="40px">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tenchuongtrinh" HeaderText="CHƯƠNG TRÌNH" UniqueName="Tenchuongtrinh"
                                        FilterControlWidth="70px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Sotienkehoach" FilterControlAltText="Filter Sotienkehoach column"
                                        HeaderText="SỐ TIỀN KH" ReadOnly="True" SortExpression="Sotienkehoach" UniqueName="Sotienkehoach"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienThucHien" FilterControlAltText="Filter TienThucHien column"
                                        HeaderText="THỰC HIỆN" ReadOnly="True" SortExpression="TienThucHien" UniqueName="TienThucHien"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChenhLech" FilterControlAltText="Filter ChenhLech column"
                                        HeaderText="CHÊNH LỆCH(KH - TH)" ReadOnly="True" SortExpression="ChenhLech" UniqueName="ChenhLech"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="THKH" FilterControlAltText="Filter THKH column"
                                        HeaderText="TH/KH" ReadOnly="True" SortExpression="THKH" UniqueName="THKH" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Ghichu1" HeaderText="Ghi chú" UniqueName="Ghichu1"
                                        FilterControlWidth="40px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView4" runat="server">
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Xem tổng thanh toán khoản mục</legend>
                        <center>
                            <table border="0">
                                <tr>
                                    <td align="left">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam_TongKM" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnNam_TongKM"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ForeColor="Red" ValidationGroup="GInsert4"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Mã CP:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbMaCP_TongKM" runat="server" Width="185px" DataTextField="MSChiPhi"
                                            AutoPostBack="true" DataValueField="MSChiPhi" HighlightTemplatedItems="true"
                                            Skin="Windows7" EnableLoadOnDemand="true" Height='150px' DropDownWidth="320px"
                                            Enabled="true" OnItemsRequested="cbMaCP_TongKM_ItemsRequested" OnSelectedIndexChanged="cbMaCP_TongKM_SelectedIndexChanged">
                                            <HeaderTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Mã chi phí
                                                        </td>
                                                        <td style="width: 200px">
                                                            Diễn giải
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            <%# Eval("MSChiPhi")%>
                                                        </td>
                                                        <td style="width: 200px">
                                                            <%# Eval("DienGiai")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbMaCP_TongKM"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert4"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Khoản mục:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cbKhoanMuc_TongKM" runat="server" Width="185px" DataTextField="Khoa_khoanmuc"
                                            AutoPostBack="True" DataValueField="Khoa_khoanmuc" HighlightTemplatedItems="true"
                                            Skin="Windows7" EmptyMessage="Chọn khoản mục" EnableLoadOnDemand="true" Height='150px'
                                            DropDownWidth="320px" Enabled="true">
                                            <HeaderTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Khoản mục
                                                        </td>
                                                        <td style="width: 200px">
                                                            Tên khoản mục
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table width="300px">
                                                    <tr>
                                                        <td style="width: 100px">
                                                            <%# Eval("Khoa_khoanmuc")%>
                                                        </td>
                                                        <td style="width: 200px">
                                                            <%# Eval("Tenkhoanmuc")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <td align="left">
                                            Chương trình:
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="cbChuongTrinh_TongKM" DataTextField="TenChuongTrinh" DataValueField="LoaiChuongTrinh"
                                                runat="server" Width="200px" Enabled="true" Visible="true" Skin="Windows7">
                                            </asp:DropDownList>
                                        </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="center" colspan="20">
                                        <asp:ImageButton ID="btnXemTongKM" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                            ValidationGroup="GInsert4" OnClick="btnXemTongKM_Click" />
                                        &nbsp;<asp:ImageButton ID="btnExcellTongKM" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                            ValidationGroup="GInsert4" OnClick="btnExcellTongKM_Click" />
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td align="center">
                                        <asp:UpdateProgress ID="UpdateProgress4" runat="server">
                                            <ProgressTemplate>
                                                <img src="../images/ajax-loader-bar.gif" alt="" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="width: 970px; margin-left: 5px">
                        <legend>Danh sách thanh toán khoản mục</legend>
                        <telerik:RadGrid ID="RG_TongKM" runat="server" AutoGenerateColumns="False" ShowGroupPanel="false"
                            GridLines="None" CellSpacing="0" Width="100%" AllowPaging="false" EnableLinqExpressions="false"
                            ShowFooter="true" Skin="Windows7">
                            <MasterTableView>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="TenKM" HeaderText="TÊN KM" UniqueName="TenKM"
                                        FilterControlWidth="40px">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Noidung" HeaderText="NỘI DUNG" UniqueName="Noidung"
                                        FilterControlWidth="40px">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Tenchuongtrinh" HeaderText="CHƯƠNG TRÌNH" UniqueName="Tenchuongtrinh"
                                        FilterControlWidth="70px" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Sotienkehoach" FilterControlAltText="Filter Sotienkehoach column"
                                        HeaderText="SỐ TIỀN KH" ReadOnly="True" SortExpression="Sotienkehoach" UniqueName="Sotienkehoach"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TienThucHien" FilterControlAltText="Filter TienThucHien column"
                                        HeaderText="THỰC HIỆN" ReadOnly="True" SortExpression="TienThucHien" UniqueName="TienThucHien"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ChenhLech" FilterControlAltText="Filter ChenhLech column"
                                        HeaderText="CHÊNH LỆCH (KH - TH)" ReadOnly="True" SortExpression="ChenhLech"
                                        UniqueName="ChenhLech" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false"
                                        Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="THKH" FilterControlAltText="Filter THKH column"
                                        HeaderText="TH/KH" ReadOnly="True" SortExpression="THKH" UniqueName="THKH" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
            <asp:PostBackTrigger ControlID="btnExcellChungTu" />
            <asp:PostBackTrigger ControlID="btExcel3" />
            <asp:PostBackTrigger ControlID="btnExcellTongKM" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
