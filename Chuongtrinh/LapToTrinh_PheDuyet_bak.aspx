<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh_PheDuyet_bak.aspx.cs" Inherits="Chuongtrinh_LapToTrinh_PheDuyet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(SoToTrinh) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh_PheDuyet.aspx?SoToTrinh=" + SoToTrinh, "RadWindowManager1");
            oWnd.Center();
        }
        function openRadWindowShow2(SoToTrinh) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh_XemLai_PheDuyet.aspx?SoToTrinh=" + SoToTrinh, "RadWindowManager1");
            oWnd.Center();
        }

        function OnClientClose() {
            __doPostBack('fLoad', '');
        }

        function SelectAll(CheckBox) {
            var TargetBaseControl = document.getElementById('<%= this.RGToTrinh.ClientID %>');
            var TargetChildControl = "chkSelect";
            var Inputs = TargetBaseControl.getElementsByTagName("input");
            for (var iCount = 0; iCount < Inputs.length; ++iCount) {
                if (Inputs[iCount].type == 'checkbox' && Inputs[iCount].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[iCount].checked = CheckBox.checked;
            }
        }
     
    
    </script>
    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
    </telerik:RadWindowManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" AutoPostBack="true"
                MultiPageID="MultiPage">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Phê duyệt tờ trình" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Xem tờ trình đã phê duyệt">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <div style="margin-top: 10px">
            </div>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="false" AutoSize="false"
                        EnableShadow="true" ID="RadWindowManager2" runat="server" KeepInScreenBounds="True"
                        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
                        EnableViewState="False" InitialBehaviors="Maximize">
                        <Shortcuts>
                            <telerik:WindowShortcut CommandName="CloseAll" Shortcut="Esc" />
                        </Shortcuts>
                        <Windows>
                            <telerik:RadWindow ID="DialogWindow" Behaviors="Minimize, Close, Pin, Maximize" VisibleStatusbar="false"
                                ReloadOnShow="true" Modal="true" runat="server" DestroyOnClose="True" KeepInScreenBounds="true"
                                InitialBehaviors="Maximize">
                            </telerik:RadWindow>
                        </Windows>
                    </telerik:RadWindowManager>
                    <div>
                        <fieldset style="margin-left: 5px; width: 970px;">
                            <legend>Chọn đơn vị và click chọn tờ trình trên lưới để phê duyệt</legend>
                            <center>
                                <table style="margin: 10px 0 10px 0">
                                    <tr>
                                        <td align="right">
                                            Chọn đơn vị:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbDonVi" runat="server" Width="200px" DataTextField="TenDonVi"
                                                Skin="Windows7" DataValueField="MaDonVi" DropDownWidth="200px" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" AutoPostBack="true" Height='150px' OnSelectedIndexChanged="cbDonVi_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cbDonVi"
                                                Skin="Windows7" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="RadCBoPD" Skin="Windows7" runat="server" AutoPostBack="true"
                                                OnSelectedIndexChanged="RadCBoPD_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Chưa duyệt" Value="False" />
                                                    <telerik:RadComboBoxItem Text="Duyệt" Value="True" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png"  style=""/>&nbsp;</asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="10">
                                            <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="10">
                                            <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                    </div>
                    <div>
                        <fieldset style="margin-left: 5px; width: 970px;">
                            <legend>Tờ trình</legend>
                            <telerik:RadGrid ID="RGToTrinh" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True"
                                Skin="Windows7" AllowMultiRowEdit="True" ShowFooter="True" CellSpacing="0" GridLines="None"
                                OnItemCommand="RGToTrinh_ItemCommand" OnPageIndexChanged="RGToTrinh_PageIndexChanged"
                                OnPageSizeChanged="RGToTrinh_PageSizeChanged" OnSelectedIndexChanged="RGToTrinh_SelectedIndexChanged"
                                OnItemDataBound="RGToTrinh_ItemDataBound" AllowAutomaticInserts="True">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="true">
                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoToTrinh">
                                    <CommandItemSettings AddNewRecordText="Thêm mới" />
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderText="CHỌN"
                                            Visible="true">
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        </telerik:GridClientSelectColumn>
                                        <telerik:GridTemplateColumn HeaderText="EMAIL" AllowFiltering="false" Visible="false">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnEmail" runat="server" ImageUrl="~/images/Nutchuanweb/icon_email.png"
                                                    CommandName="Email" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                            <ItemTemplate>
                                                <a style="cursor: pointer" onclick="openRadWindowShow('<%#Eval("SoToTrinh") %>')">
                                                    <img id="Img1" runat="server" alt="" border="0" height="16" src="../images/detail.png" /></a>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                            FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ BP" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle Width="60px" HorizontalAlign="Left" />
                                            <ItemStyle Width="60px" HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                            HeaderText="NĂM" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px"
                                            Visible="true">
                                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="30px" Visible="true">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiGoi" FilterControlAltText="Filter NguoiGoi column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="NguoiGoi" UniqueName="NguoiGoi"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" Visible="false" FilterControlWidth="50px">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaNVXemXet" FilterControlAltText="Filter MaNVXemXet column"
                                            HeaderText="MaNVXemXet" ReadOnly="True" SortExpression="MaNVXemXet" UniqueName="MaNVXemXet"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" Visible="false" FilterControlWidth="50px">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiNhan" FilterControlAltText="Filter NguoiNhan column"
                                            HeaderText="NguoiNhan" ReadOnly="True" SortExpression="NguoiNhan" UniqueName="NguoiNhan"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" Visible="false" FilterControlWidth="50px">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongTien" FilterControlAltText="Filter TongTien column"
                                            HeaderText="NS DUYỆT" ReadOnly="True" SortExpression="TongTien" UniqueName="TongTien"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="VeViec" FilterControlAltText="Filter VeViec column"
                                            HeaderText="GHI CHÚ" ReadOnly="True" SortExpression="VeViec" UniqueName="VeViec"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" AllowFiltering="false">
                                            <HeaderStyle Width="200px" HorizontalAlign="Left" />
                                            <ItemStyle Width="200px" HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="HieuLucPD" HeaderText="HL-PD" UniqueName="HieuLucPD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="PheDuyet" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLucPD")) %>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="HL-PD" UniqueName="HieuLucPD" ShowFilterIcon="false"
                                            AllowFiltering="false" FilterControlWidth="60px" Visible="false">
                                            <HeaderStyle Width="120px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemStyle Width="120px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="cbPheDuyet" Width="100px" runat="server" AutoPostBack="true"
                                                    Enabled='<%#!clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' OnSelectedIndexChanged="cbPheDuyet_SelectedIndexChanged">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Value="false" Text="Chưa phê duyệt" />
                                                        <telerik:RadComboBoxItem Value="True" Text="Phê duyệt" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="hfPheDuyet" runat="server" Value='<%# Eval("HieuLucPD") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
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
                        </fieldset>
                    </div>
                    <div>
                        <telerik:RadGrid ID="RGChiTietToTrinh" runat="server" AutoGenerateColumns="False"
                            Skin="Windows7" CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False"
                            ShowFooter="True" Visible="false">
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                            <HeaderContextMenu EnableTheming="True">
                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                            </HeaderContextMenu>
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="True" />
                            </ClientSettings>
                            <MasterTableView>
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    <HeaderStyle Width="20px"></HeaderStyle>
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ BP" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                                        HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                                        Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="TỈ GIÁ" UniqueName="TiGia" DataField="TiGia"
                                        FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                                        FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Chọn năm - tháng cần xem</legend>
                            <center>
                                <table border="0">
                                    <tr>
                                        <td align="right">
                                            Chọn ĐV:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="ddlDonVi_XemLai" runat="server" Width="200px" DataTextField="TenDonVi"
                                                Skin="Windows7" DataValueField="MaDonVi" DropDownWidth="200px" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" AutoPostBack="true" Height='150px'>
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlDonVi_XemLai"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Năm:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNam_Xem" runat="server" Width="70px" AutoPostBack="false"
                                                Skin="Windows7">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnNam_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Tháng:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnThang_Xem" runat="server" Width="70px" MaxValue="12"
                                                Skin="Windows7" MinValue="1" AutoPostBack="false">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="rnThang_Xem"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GXem"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="btnXem" runat="server" ImageUrl="~/images/Nutchuanweb/btXem.png"
                                                ValidationGroup="GXem" OnClick="btnXem_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="10" align="center">
                                            <asp:Label runat="server" ID="lbXemLaiToTrinh"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </fieldset>
                    </div>
                    <div>
                        <fieldset style="width: 970px; margin-left: 5px">
                            <legend>Tờ trình</legend>
                            <telerik:RadGrid ID="RG_ToTrinh_XemLai" runat="server" Height="350px" AllowAutomaticDeletes="True"
                                Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True"
                                CellSpacing="0" AllowFilteringByColumn="true" GridLines="None" OnItemCommand="RG_ToTrinh_XemLai_ItemCommand"
                                OnSelectedIndexChanged="RG_ToTrinh_XemLai_SelectedIndexChanged">
                                <GroupingSettings CaseSensitive="False" />
                                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" DataKeyNames="SoToTrinh">
                                    <CommandItemSettings AddNewRecordText="Thêm mới" />
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                            <ItemTemplate>
                                                <%# Container.DataSetIndex  + 1%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                            <ItemTemplate>
                                                <a style="cursor: pointer" onclick="openRadWindowShow2('<%#Eval("SoToTrinh") %>')">
                                                    <img id="Img1" runat="server" alt="" border="0" height="16" src="../images/detail.png" /></a>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                            FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                            AutoPostBackOnFilter="true">
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MaDV" FilterControlAltText="Filter MaDV column"
                                            HeaderText="MÃ BP" ReadOnly="True" SortExpression="MaDV" UniqueName="MaDV" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <HeaderStyle Width="70px" HorizontalAlign="Left" />
                                            <ItemStyle Width="70px" HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                            HeaderText="NĂM" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                            ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="40px"
                                            Visible="true" AllowFiltering="false">
                                            <HeaderStyle Width="50px" HorizontalAlign="Center" />
                                            <ItemStyle Width="50px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Thang" FilterControlAltText="Filter Thang column"
                                            HeaderText="THÁNG" ReadOnly="True" SortExpression="Thang" UniqueName="Thang"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="30px" Visible="true" AllowFiltering="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="NguoiGoi" FilterControlAltText="Filter NguoiGoi column"
                                            HeaderText="MÃ NV" ReadOnly="True" SortExpression="NguoiGoi" UniqueName="NguoiGoi"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="50px" AllowFiltering="false">
                                            <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                            <ItemStyle Width="60px" HorizontalAlign="Center" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="TongTien" FilterControlAltText="Filter TongTien column"
                                            HeaderText="NS DUYỆT" ReadOnly="True" SortExpression="TongTien" UniqueName="TongTien"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            DataFormatString="{0:###,###.##}" AllowFiltering="false" Aggregate="Sum">
                                            <FooterStyle ForeColor="Blue" HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="VeViec" FilterControlAltText="Filter VeViec column"
                                            HeaderText="GHI CHÚ" ReadOnly="True" SortExpression="VeViec" UniqueName="VeViec"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            FilterControlWidth="40px" AllowFiltering="false">
                                            <HeaderStyle Width="200px" HorizontalAlign="Left" />
                                            <ItemStyle Width="200px" HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="HieuLucPD" HeaderText="HL-PD" UniqueName="HieuLucPD"
                                            AllowFiltering="False">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkPheDuyet" runat="server" Enabled="true" AutoPostBack="true"
                                                    Checked='<%# clsConvertHelper.Tobool(Eval("HieuLucPD")) %>' OnCheckedChanged="chkPheDuyet_CheckedChanged" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        </telerik:GridTemplateColumn>
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
                        </fieldset>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
