<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="XemKeHoachNganSachDaDuyet.aspx.cs" Inherits="Chuongtrinh_XemKeHoachNganSachDaDuyet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .test
        {
            color: Blue;
        }
    </style>
    <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
    </telerik:RadScriptBlock>
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
                                PHÊ DUYỆT NGÂN SÁCH
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
                <table cellpadding="1" cellspacing="0" style="margin-top: 10px; margin-bottom: 10px;">
                    <tr>
                        <td align="left">
                            Năm:
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="CboNam" runat="server" AllowCustomText="true" AutoPostBack="True"
                                DataTextField="Nam" DataValueField="Nam" Enabled="false" Filter="Contains" Height="200px"
                                MarkFirstMatch="true" Width="70px" OnSelectedIndexChanged="CboNam_SelectedIndexChanged">
                                <ItemTemplate>
                                    <%#Eval("Nam") %>
                                    <asp:HiddenField ID="hfQui" runat="server" Value='<%#Eval("Qui") %>' />
                                </ItemTemplate>
                            </telerik:RadComboBox>
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            Qui:
                        </td>
                        <td width="5px">
                        </td>
                        <td align="left">
                            <telerik:RadNumericTextBox ID="rnQui" runat="server" Width="70px" AutoPostBack="True"
                                MaxValue="4" MinValue="1" Enabled="true" OnTextChanged="rnQui_TextChanged">
                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                            </telerik:RadNumericTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnQui"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                ForeColor="Red"></asp:RequiredFieldValidator>
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
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td colspan="7" align="center">
                            <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                OnClick="btLuu_Click" ValidationGroup="btLuu" />
                            &nbsp;
                         
                            <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png" />&nbsp;</asp:HyperLink>
                            <br />
                        </td>
                    </tr>--%>
                    <tr>
                        <td align="center" colspan="9">
                            <asp:Label ID="lbEmail" runat="server"></asp:Label>
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
                                        AllowFilteringByColumn="false" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                        AllowMultiRowEdit="True" OnPageIndexChanged="RadGDKHCP_PageIndexChanged" OnSelectedIndexChanged="RadGDKHCP_SelectedIndexChanged"
                                        OnItemCommand="RadGDKHCP_ItemCommand" Skin="Windows7" OnPageSizeChanged="RadGDKHCP_PageSizeChanged"
                                        CellSpacing="0" GridLines="None" PageSize="15">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
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
                                                <telerik:GridTemplateColumn HeaderText="Mã CP" UniqueName="MSChiphi" DataField="MSChiphi"
                                                    AllowFiltering="False" Groupable="False">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOnGrid" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn DataField="Chiphikehoach" FilterControlAltText="Filter Chiphikehoach column"
                                                    HeaderText="Chi phí KH" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="Chiphikehoach"
                                                    FooterStyle-Font-Bold="true" FooterStyle-ForeColor="Red" Aggregate="Sum" ItemStyle-Width="100px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    FilterControlWidth="120px" DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle Font-Bold="True" ForeColor="Blue" />
                                                    <HeaderStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="120px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn DataField="Chiphikehoach" FilterControlAltText="Filter Chiphikehoach column"
                                                    HeaderText="Chi phí KH" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="Chiphikehoach"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="120px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle ForeColor="Blue" />
                                                    <HeaderStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" FilterControlAltText="Filter CHIPHI_DATHUCHIEN column"
                                                    HeaderText="Đã sử dụng" ReadOnly="True" SortExpression="CHIPHI_DATHUCHIEN" UniqueName="CHIPHI_DATHUCHIEN"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="90px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle ForeColor="Blue" />
                                                    <HeaderStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="90px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                                    HeaderText="đến tháng" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="false" FilterControlWidth="80px">
                                                    <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                    <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_CON" FilterControlAltText="Filter CHIPHI_CON column"
                                                    HeaderText="Chi phí KH còn" ReadOnly="True" SortExpression="CHIPHI_CON" UniqueName="CHIPHI_CON"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle ForeColor="Blue" />
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
                                        Width="490px" AllowFilteringByColumn="false" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                        AllowMultiRowEdit="True" AllowAutomaticInserts="True" GridLines="None" Skin="Windows7"
                                        AutoGenerateColumns="False" OnCancelCommand="RadGDNganSach_CancelCommand" OnPageIndexChanged="RadGDNganSach_PageIndexChanged"
                                        OnPageSizeChanged="RadGDNganSach_PageSizeChanged" CellSpacing="0" PageSize="15"
                                        OnItemCommand="RadGDNganSach_ItemCommand">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="none" ShowGroupFooter="true"
                                            TableLayout="Fixed">
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
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tháng" UniqueName="Thang" DataField="Thang"
                                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MBP" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="70px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Mã CP" UniqueName="MSChiphi" DataField="MSChiphi"
                                                    AllowFiltering="False" Groupable="False">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="Sotien" DataField="Sotien"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                                    FooterStyle-CssClass="test">
                                                    <FooterStyle CssClass="test" />
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <%-- <telerik:GridBoundColumn HeaderText="DIENGIAI" UniqueName="DIENGIAI" DataField="DIENGIAI"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                                </telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Ghichu" DataField="Ghichu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true">
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL" UniqueName="Hieuluc_PD"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <GroupByExpressions>
                                                <telerik:GridGroupByExpression>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="NAM" FieldName="NAM" HeaderText="Nam" />
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="NAM" HeaderText="NAM" />
                                                    </GroupByFields>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="Thang" FieldName="Thang" HeaderText="Thang" />
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="Thang" HeaderText="Thang" />
                                                    </GroupByFields>
                                                    <SelectFields>
                                                        <telerik:GridGroupByField FieldAlias="GroupMaCP" FieldName="GroupMaCP" HeaderText="Mã CP" />
                                                    </SelectFields>
                                                    <GroupByFields>
                                                        <telerik:GridGroupByField FieldName="GroupMaCP" HeaderText="Mã CP" />
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
