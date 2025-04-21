<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="Kehoachngansach_Pduyet_PTGDSX.aspx.cs" Inherits="Chuongtrinh_Kehoachngansach_Pduyet_PTGDSX" %>

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
        <script type="text/javascript">
            function sendMail() {
                var Addressmail = document.getElementById('<%=txtAddress.ClientID%>').value
                var cc = document.getElementById('<%=txtCC.ClientID%>').value
                var Sub = document.getElementById('<%=txtSub.ClientID%>').value
                var body = document.getElementById('<%=txtBody.ClientID%>').value
                var mailto_link = 'mailto:' + Addressmail + '?cc=' + cc + '&subject=' + Sub + '&body=' + body;
                win = window.open(mailto_link, 'tempWindow');
                if (win && win.open && !win.closed) win.close();
            }
        </script>
    </telerik:RadScriptBlock>
    <script type="text/javascript">

        function openRadWindowShow(ID_Khoa) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietKeHoachNganSach.aspx?ID_Khoa=" + ID_Khoa, "RadWindowManager1");
            oWnd.Center();
        }

        function OnClientClose() {
            __doPostBack('fLoad', '');
        }

    
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" AutoPostBack="true"
                MultiPageID="MultiPage" OnTabClick="RadTabStrip1_TabClick">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Phê duyệt ngân sách" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem lại ngân sách ">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Hiệu chỉnh ngân sách ">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="margin-top: 10px">
            </div>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
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
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
                        <Shortcuts>
                            <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                        </Shortcuts>
                        <Windows>
                            <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize, Reload"
                                VisibleStatusbar="false" ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True"
                                KeepInScreenBounds="True" InitialBehaviors="Maximize">
                            </telerik:RadWindow>
                        </Windows>
                    </telerik:RadWindowManager>
                    <fieldset style="margin-left: 5px; width: 970px;">
                        <legend>Phê duyệt kế hoạch ngân sách </legend>
                        <center>
                            <table cellpadding="1" cellspacing="0" style="margin-top: 10px; margin-bottom: 10px;">
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="CboNam" runat="server" AllowCustomText="true" AutoPostBack="True"
                                            Skin="Windows7" DataTextField="Nam" DataValueField="Nam" Enabled="false" Filter="Contains"
                                            Height="200px" MarkFirstMatch="true" Width="70px" OnSelectedIndexChanged="CboNam_SelectedIndexChanged">
                                            <ItemTemplate>
                                                <%#Eval("Nam") %>
                                                <asp:HiddenField ID="hfQui" runat="server" Value='<%#Eval("Qui") %>' />
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Đơn vị:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="CboMaDV" runat="server" AllowCustomText="true" AutoPostBack="True"
                                            Skin="Windows7" DataValueField="MaDV" DataTextField="MaDV_DISPLAY" Enabled="True"
                                            Filter="Contains" Height="100px" MarkFirstMatch="true" Width="200px" OnSelectedIndexChanged="CboMaDV_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="CboMaDV"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="btLuu"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Qui:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7" MaxValue="4" MinValue="1" Enabled="false" OnTextChanged="rnQui_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnQui"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td align="right">
                                        Phê duyệt:
                                    </td>
                                    <td width="5px">
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="RadCBoPD" runat="server" Width="200px" Skin="Windows7">
                                            <Items>
                                                <%--  <telerik:RadComboBoxItem Text="Chưa duyệt" Value="False" />--%>
                                                <telerik:RadComboBoxItem Text="Duyệt" Value="True" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7" align="center">
                                        <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            OnClick="btLuu_Click" ValidationGroup="btLuu" />
                                        <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png" />&nbsp;</asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="9">
                                        <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <table width="100%" style="border-collapse: collapse; table-layout: fixed;" cellpadding="0"
                        cellspacing="0" border="0">
                        <tr>
                            <td style="vertical-align: top; width: 45%;">
                                <fieldset>
                                    <legend style="">Chi phí thực hiện </legend>
                                    <telerik:RadGrid ID="RadGDKHCP" runat="server" Height="400px" Width="98%" AllowAutomaticDeletes="True"
                                        Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" OnPageIndexChanged="RadGDKHCP_PageIndexChanged"
                                        OnSelectedIndexChanged="RadGDKHCP_SelectedIndexChanged" OnItemCommand="RadGDKHCP_ItemCommand"
                                        OnPageSizeChanged="RadGDKHCP_PageSizeChanged" CellSpacing="0" GridLines="None"
                                        PageSize="15">
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
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                                    AllowFiltering="False" Groupable="False">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOnGrid" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn DataField="Chiphikehoach" FilterControlAltText="Filter Chiphikehoach column"
                                                    HeaderText="CHI PHÍ KH" ReadOnly="True" SortExpression="Chiphikehoach" UniqueName="Chiphikehoach"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="120px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false">
                                                    <FooterStyle ForeColor="Blue" />
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" FilterControlAltText="Filter CHIPHI_DATHUCHIEN column"
                                                    HeaderText="ĐÃ SỬ DỤNG" ReadOnly="True" SortExpression="CHIPHI_DATHUCHIEN" UniqueName="CHIPHI_DATHUCHIEN"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="90px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false" Visible="true">
                                                    <FooterStyle ForeColor="Blue" />
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                                    HeaderText="THÁNG" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="false" FilterControlWidth="80px" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="CHIPHI_CON" FilterControlAltText="Filter CHIPHI_CON column"
                                                    HeaderText="CHI PHÍ CÒN" ReadOnly="True" SortExpression="CHIPHI_CON" UniqueName="CHIPHI_CON"
                                                    FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="100px"
                                                    DataFormatString="{0:###,###}" AllowFiltering="false" Visible="true">
                                                    <FooterStyle ForeColor="Blue" />
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
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
                                </fieldset>
                            </td>
                            <td style="vertical-align: top; width: 55%;">
                                <fieldset>
                                    <legend>Kế hoạch ngân sách </legend>
                                    <telerik:RadGrid ID="RadGDNganSach" runat="server" Height="400px" AllowAutomaticDeletes="True"
                                        AllowAutomaticUpdates="True" AllowMultiRowEdit="True" AllowAutomaticInserts="True"
                                        Skin="Windows7" AllowFilteringByColumn="true" GridLines="None" AutoGenerateColumns="False"
                                        OnCancelCommand="RadGDNganSach_CancelCommand" OnPageIndexChanged="RadGDNganSach_PageIndexChanged"
                                        OnPageSizeChanged="RadGDNganSach_PageSizeChanged" CellSpacing="0" OnItemCommand="RadGDNganSach_ItemCommand"
                                        ShowFooter="true">
                                        <GroupingSettings CaseSensitive="False" />
                                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                            <Selecting AllowRowSelect="True" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView ShowGroupFooter="true">
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
                                                <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="40px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    AllowFiltering="true">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                                    FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="true">
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                                    AllowFiltering="False" Groupable="False">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                                        </asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                                    AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                                    <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                                    AllowFiltering="False">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Ghichu" DataField="Ghichu"
                                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                                </telerik:GridBoundColumn>
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
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" runat="server" Visible="true" Width="0px" Height="0px">
                        <asp:TextBox ID="txtAddress" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                        <asp:TextBox ID="txtCC" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                        <asp:TextBox ID="txtSub" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                        <asp:TextBox ID="txtBody" runat="server" Visible="true" Width="0px" Height="0px"></asp:TextBox>
                    </asp:Panel>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <fieldset style="margin-left: 5px; width: 970px;">
                        <legend>Xem lại kế hoạch ngân sách </legend>
                        <center>
                            <table style="margin-top: 10px;">
                                <tr>
                                    <td align="left">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="True"
                                            Skin="Windows7" Enabled="true" OnTextChanged="rnNam_Xem_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel_xem"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Qui:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui_Xem" runat="server" Width="70px" MaxValue="4"
                                            Skin="Windows7" MinValue="1" AutoPostBack="true" OnTextChanged="rnQui_Xem_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rnQui_Xem"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel_xem"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="left">
                                        Đơn vị:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="CboMaDV_XemNS" runat="server" AllowCustomText="true" AutoPostBack="True"
                                            DataValueField="MaDV" DataTextField="MaDV_DISPLAY" Enabled="True" Filter="Contains"
                                            Height="100px" MarkFirstMatch="true" Width="200px" OnSelectedIndexChanged="CboMaDV_XemNS_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="CboMaDV_XemNS"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GExcel_xem"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="10" align="center">
                                        <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                            ValidationGroup="GExcel_xem" OnClick="btnXem_Click" />
                                        <asp:ImageButton ID="btnExcelXem" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                            ValidationGroup="GExcel_xem" OnClick="btnExcelXem_Click" />
                                        <asp:ImageButton ID="btnNSUyQuyenCacDV" runat="server" ImageUrl="~/images/Nutchuanweb/PrintUyQuyen.png"
                                            ValidationGroup="GExcel_xem" OnClick="btnNSUyQuyenCacDV_Click" />
                                        <asp:ImageButton ID="btnNSUyQuyen" runat="server" ImageUrl="~/images/Nutchuanweb/PrintUyQuyen.png"
                                            OnClick="btnNSUyQuyen_Click" />
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="margin-left: 5px; width: 970px;">
                        <legend>Danh sách kế hoạch ngân sách </legend>
                        <telerik:RadGrid ID="RG_XemNS" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                            Skin="Windows7" AllowMultiRowEdit="True" AllowAutomaticInserts="True" GridLines="None"
                            AutoGenerateColumns="False" ShowFooter="true">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="false">
                                <Selecting AllowRowSelect="false" />
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
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                        AllowFiltering="False" Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                        FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="170px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                        FooterStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Ghichu" DataField="Ghichu"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkXemXet2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FooterStyle CssClass="test" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                    <div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui1" runat="server" Width="970px" AutoGenerateColumns="False"
                                EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                                AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui1" HeaderText="Số tiền quí 1 (VNĐ)" UniqueName="TongQui1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang1" HeaderText="Tháng 1" UniqueName="Thang1"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang2" HeaderText="Tháng 2" UniqueName="Thang2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang3" HeaderText="Tháng 3" UniqueName="Thang3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui2" runat="server" Width="970px" AutoGenerateColumns="False"
                                EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                                AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui2" HeaderText="Số tiền quí 2 (VNĐ)" UniqueName="TongQui2"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang4" HeaderText="Tháng 4" UniqueName="Thang4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang5" HeaderText="Tháng 5" UniqueName="Thang5"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang6" HeaderText="Tháng 6" UniqueName="Thang6"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui3" runat="server" Width="970px" AutoGenerateColumns="False"
                                EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                                AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui3" HeaderText="Số tiền quí 3 (VNĐ)" UniqueName="TongQui3"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang7" HeaderText="Tháng 7" UniqueName="Thang7"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang8" HeaderText="Tháng 8" UniqueName="Thang8"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang9" HeaderText="Tháng 9" UniqueName="Thang9"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                        <div>
                            <telerik:RadGrid ID="ExcelQui4" runat="server" Width="970px" AutoGenerateColumns="False"
                                EnableLinqExpressions="False" GridLines="Both" AllowFilteringByColumn="false"
                                AllowPaging="True" AllowSorting="false" PageSize="40" ShowFooter="True">
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" FrozenColumnsCount="7" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                            Groupable="False">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="MaBP" HeaderText="Mã BP" UniqueName="MaBP" FilterControlWidth="50px"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TenBP" HeaderText="Tên BP" UniqueName="TenBP"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MSChiphi" HeaderText="Mã NS" UniqueName="MSChiphi"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="DienGiai" HeaderText="Tên NS" UniqueName="DienGiai"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDVUQ" HeaderText="ĐV ủy quyền" UniqueName="MaDVUQ"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Chiphikehoach" HeaderText="Chi phí KH" UniqueName="Chiphikehoach"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CHIPHI_DATHUCHIEN" HeaderText="Chi phí TH" UniqueName="CHIPHI_DATHUCHIEN"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongQui4" HeaderText="Số tiền quí 4 (VNĐ)" UniqueName="TongQui4"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang10" HeaderText="Tháng 10" UniqueName="Thang10"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang11" HeaderText="Tháng 11" UniqueName="Thang11"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang12" HeaderText="Tháng 12" UniqueName="Thang12"
                                            FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            AllowFiltering="false" DataFormatString="{0:###,###,###}" Aggregate="Sum">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="Phê duyệt" UniqueName="Hieuluc_PD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbketThuc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                        </div>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <fieldset style="margin-left: 5px; width: 970px;">
                        <legend>Hiệu chỉnh kế hoạch ngân sách </legend>
                        <center>
                            <table cellpadding="1" cellspacing="0" style="margin-top: 10px; margin-bottom: 10px;">
                                <tr>
                                    <td align="right">
                                        Năm:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="cboNam_HieuChinh" runat="server" AllowCustomText="true"
                                            Skin="Windows7" AutoPostBack="True" DataTextField="Nam" DataValueField="Nam"
                                            Enabled="false" Filter="Contains" Height="200px" MarkFirstMatch="true" Width="70px">
                                            <ItemTemplate>
                                                <%#Eval("Nam") %>
                                                <asp:HiddenField ID="hfQui_HieuChinh" runat="server" Value='<%#Eval("Qui") %>' />
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboNam_HieuChinh"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GHieuChinh"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Đơn vị:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="CboMaDV_HieuChinh" runat="server" AllowCustomText="true"
                                            Skin="Windows7" AutoPostBack="True" DataValueField="MaDV" DataTextField="MaDV_DISPLAY"
                                            Enabled="True" Filter="Contains" Height="100px" MarkFirstMatch="true" Width="200px"
                                            OnSelectedIndexChanged="CboMaDV_HieuChinh_SelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="CboMaDV_HieuChinh"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GHieuChinh"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Qui:
                                    </td>
                                    <td align="left">
                                        <telerik:RadNumericTextBox ID="rnQui_HieuChinh" runat="server" Width="70px" MaxValue="4"
                                            Skin="Windows7" MinValue="1" AutoPostBack="true" Enabled="false" OnTextChanged="rnQui_HieuChinh_TextChanged">
                                            <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                        </telerik:RadNumericTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rnQui_HieuChinh"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GHieuChinh"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </td>
                                    <td align="right">
                                        Phê duyệt:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="RC_HieuChinh" runat="server" Width="200px">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Bỏ duyệt" Value="False" />
                                                <telerik:RadComboBoxItem Text="Duyệt" Value="True" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="10" align="center">
                                        <asp:ImageButton ID="btnBoDuyet" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            OnClick="btnBoDuyet_Click" ValidationGroup="GHieuChinh" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="10" align="center" style="color: Blue">
                                        <asp:Label ID="lbThongBao" Text="Phải bỏ duyệt mới hiệu chỉnh được ngân sách" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </fieldset>
                    <fieldset style="margin-left: 5px; width: 970px;">
                        <legend>Danh sách kế hoạch ngân sách </legend>
                        <telerik:RadGrid ID="RG_HieuChinh" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                            Skin="Windows7" AllowMultiRowEdit="True" AllowAutomaticInserts="True" GridLines="None"
                            AutoGenerateColumns="False" AllowFilteringByColumn="false" ShowFooter="true"
                            OnDeleteCommand="RG_HieuChinh_DeleteCommand" OnItemCommand="RG_HieuChinh_ItemCommand"
                            OnUpdateCommand="RG_HieuChinh_UpdateCommand" OnCancelCommand="RG_HieuChinh_CancelCommand">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="false">
                                <Selecting AllowRowSelect="false" />
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
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                        HeaderText="SỬA" EditText="SỬA">
                                        <ItemStyle />
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridBoundColumn HeaderText="ID_khoaCT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaBP" DataField="MaBP" FilterControlWidth="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="ĐV-UQ" UniqueName="MaDVUQ" DataField="MaDVUQ"
                                        FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                        AllowFiltering="False" Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblOnGrid1" runat="server" Text='<%#(Eval("MSChiphi")) %>' ToolTip='<%#Eval("DienGiai")%>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="DienGiai" HeaderText="TÊN NS" UniqueName="DienGiai"
                                        FilterControlWidth="50px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="130px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="130px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Aggregate="Sum"
                                        FooterStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Ghichu" DataField="Ghichu"
                                        FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="Hieuluc_XX" HeaderText="HL-XX" UniqueName="Hieuluc_XX"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkXemXet3" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_XX")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="Hieuluc_PD" HeaderText="HL-PD" UniqueName="Hieuluc_PD"
                                        AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbHieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("Hieuluc_PD")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FooterStyle CssClass="test" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
        <%--  <Triggers>
           <asp:PostBackTrigger ControlID="btExcel" />         
        </Triggers>--%>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExcelXem" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
