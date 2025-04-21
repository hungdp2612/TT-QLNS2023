<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Kehoachngansach_KTKiemTra.aspx.cs" Inherits="Kiemtra_Kehoachngansach_KTKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .test
        {
            color: Red;
            font-weight: bold;
        }
    </style>
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
                <table width="100%" cellpadding="0" cellspacing="0" id="topp">
                    <tr>
                        <td class="bgtieudebox">
                            <center>
                                KẾ TOÁN KIỂM TRA NGÂN SÁCH
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
                <table  cellpadding="1" cellspacing="0" style="margin-top:10px;">
                    <tr>
                        <td align="left">
                            Năm:
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="CboNam" runat="server" AllowCustomText="true" AutoPostBack="True"
                                DataTextField="Nam" DataValueField="Nam" Enabled="false" Filter="Contains" Height="200px"
                                MarkFirstMatch="true" Skin="Windows7" Width="100px" OnSelectedIndexChanged="CboNam_SelectedIndexChanged">
                                <ItemTemplate>
                                    <%#Eval("Nam") %>
                                    <asp:HiddenField ID="hfQui" runat="server" Value='<%#Eval("Qui") %>' />
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            Đơn vị:
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                DataValueField="MaDV" DataTextField="MaDV_DISPLAY" Enabled="True" Filter="Contains"
                                Height="100px" MarkFirstMatch="true" Skin="Windows7" Width="200px" OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            Qui:
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtQui" runat="server" Width="95px" Enabled="false"></asp:TextBox>
                            <%--  <asp:Label ID="lbQui" runat="server" Width="100px" Text=""></asp:Label>--%>
                        </td>
                        <td width="5px">
                        </td>
                        <td align="right">
                            Xác nhận:
                        </td>
                        <td width="5px">
                        </td>
                        <td>
                            <telerik:RadComboBox ID="RadCBoPD" runat="server" Height="100px" Skin="Windows7"
                                Width="200px">
                                <Items>
                                    <telerik:RadComboBoxItem Text="Chưa xác nhận" Value="False" />
                                    <telerik:RadComboBoxItem Text="Xác nhận" Value="True" />
                                </Items>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7" align="center" style="height:50px;">
                            <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                OnClick="btLuu_Click" ValidationGroup="btLuu" />
                            &nbsp;
                            <%-- <asp:ImageButton ID="btEmail" runat="server" ImageUrl="~/images/Nutchuanweb/email.png"
                                OnClick="btEmail_Click" ValidationGroup="btLuu" />
                            &nbsp;--%>
                            <br />
                        </td>
                    </tr>                   
                </table>
            </center>
            <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                cellspacing="0">
                <tr>
                    <td style="vertical-align: top; width: 50%;">
                        <table width="100%" style="table-layout: fixed;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="top">
                                    <telerik:RadGrid ID="RadGDKHCP" runat="server" Height="400px" Width="490px" AllowPaging="True"
                                        AllowFilteringByColumn="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                        AllowMultiRowEdit="True" OnPageIndexChanged="RadGDKHCP_PageIndexChanged" OnSelectedIndexChanged="RadGDKHCP_SelectedIndexChanged"
                                        OnItemCommand="RadGDKHCP_ItemCommand" Skin="Windows7" OnPageSizeChanged="RadGDKHCP_PageSizeChanged"
                                        CellSpacing="0" GridLines="None">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="MSCHIPHI"
                                            ShowFooter="true">
                                            <CommandItemSettings AddNewRecordText="Thêm mới" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                                                    <HeaderStyle Width="30px" HorizontalAlign="Center" />
                                                </telerik:GridClientSelectColumn>
                                                <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                                    HeaderText="Năm" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                                    Visible="false">
                                                    <HeaderStyle Width="40px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                                    HeaderText="Mã CP" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    FilterControlWidth="50px">
                                                    <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Chiphikehoach" FilterControlAltText="Filter Chiphikehoach column"
                                                    HeaderText="Chi phí KH" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="Chiphikehoach"
                                                    FooterStyle-Font-Bold="true" FooterStyle-ForeColor="Red" Aggregate="Sum" ItemStyle-Width="100px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    FilterControlWidth="120px" DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Red" />
                                                    <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" FilterControlAltText="Filter CHIPHI_DATHUCHIEN column"
                                                    HeaderText="Đã sử dụng" ReadOnly="True" SortExpression="CHIPHI_DATHUCHIEN" UniqueName="CHIPHI_DATHUCHIEN"
                                                    FooterStyle-Font-Bold="true" FooterStyle-ForeColor="Red" Aggregate="Sum" ItemStyle-Width="100px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    FilterControlWidth="100px" DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Red" />
                                                    <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                                    HeaderText="Tháng" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="false" FilterControlWidth="60px">
                                                    <HeaderStyle Width="40px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="40px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_CON" FilterControlAltText="Filter CHIPHI_CON column"
                                                    HeaderText="Chi phí còn" ReadOnly="True" SortExpression="CHIPHI_CON" UniqueName="CHIPHI_CON"
                                                    FooterStyle-Font-Bold="true" FooterStyle-ForeColor="Red" Aggregate="Sum" ItemStyle-Width="100px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    FilterControlWidth="100px" DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Red" />
                                                    <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
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
                                        <FooterStyle HorizontalAlign="Right" />
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                                        </HeaderContextMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <%--    BUOC 2--%>
                    <td style="vertical-align: top; width: 50%;">
                        <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                            cellspacing="0">
                            <tr>
                                <td style="top">
                                    <telerik:RadGrid ID="RadGDNganSach" runat="server" AllowPaging="True" Height="400px"
                                        Width="490px" AllowFilteringByColumn="True" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                        AllowMultiRowEdit="True" AllowAutomaticInserts="True" GridLines="None" Skin="Windows7"
                                        AutoGenerateColumns="False" OnCancelCommand="RadGDNganSach_CancelCommand" OnPageIndexChanged="RadGDNganSach_PageIndexChanged"
                                        OnPageSizeChanged="RadGDNganSach_PageSizeChanged" CellSpacing="0">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <MasterTableView
                                          >
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <CommandItemSettings AddNewRecordText="Thêm mới" />
                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Năm" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MS chi phí" UniqueName="MSChiphi" DataField="MSChiphi"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="Sotien" DataField="Sotien"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                                    FooterStyle-CssClass="test">
                                                    <FooterStyle CssClass="test" />
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Hieuluc" HeaderText="Xác nhận" UniqueName="Hieuluc"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc")) %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="NAM" FieldName="NAM" HeaderText="Nam" />
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Thang" HeaderText="Thang" />
                                                    </GroupByFields>
                                                </telerik:GridGroupByExpression>
                                            </GroupByExpressions>
                                            <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                                <EditColumn UniqueName="EditCommandColumn1">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </MasterTableView>
                                        <FooterStyle CssClass="test" />
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" runat="server" Visible="true" Width="0px" Height="0px">
                <asp:TextBox ID="txtAddress" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                <asp:TextBox ID="txtCC" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                <asp:TextBox ID="txtSub" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                <asp:TextBox ID="txtBody" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
