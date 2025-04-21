<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="LapToTrinh.aspx.cs" Inherits="Chuongtrinh_LapToTrinh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function openRadWindowShow(SoToTrinh, Nam, Thang) {
            var manager = $find("<%= RadWindowManager1.ClientID %>");
            var oWnd = manager.open("ChiTietToTrinh.aspx?SoToTrinh=" + SoToTrinh + "&Nam=" + Nam + "&Thang=" + Thang, "RadWindowManager1");
            oWnd.Center();
        }

        function OnClientClose() {
            __doPostBack('fLoad', '');
        }
     
    
    </script>
    <telerik:RadWindowManager Style="z-index: 7001" ShowContentDuringLoad="False" AutoSize="false"
        EnableShadow="true" ID="RadWindowManager1" runat="server" KeepInScreenBounds="True"
        Width="1050px" Height="700px" VisibleStatusbar="false" DestroyOnClose="True"
        EnableViewState="False" InitialBehaviors="Maximize" OnClientClose="OnClientClose">
    </telerik:RadWindowManager>
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
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="text-transform: uppercase">LẬP TỜ TRÌNH</legend>
                <center>
                    <table>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td align="right">
                                            Năm:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="100px" AutoPostBack="false"
                                                Enabled="true" Skin="Windows7">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Người gửi:
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtNguoiGui" runat="server" Width="180px" Enabled="false" Skin="Windows7"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Tháng:
                                        </td>
                                        <td align="left">
                                            <telerik:RadNumericTextBox ID="rnThang" runat="server" Width="100px" MaxValue="12"
                                                Skin="Windows7" MinValue="1" Enabled="true">
                                                <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                            </telerik:RadNumericTextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                        <td align="right">
                                            Người xem xét:
                                        </td>
                                        <td align="left">
                                            <telerik:RadComboBox ID="cbXemXet" runat="server" Width="185px" DataTextField="Hoten"
                                                Skin="Windows7" DataValueField="MaNV" DropDownWidth="185px" HighlightTemplatedItems="true"
                                                EnableLoadOnDemand="true" AutoPostBack="true" OnSelectedIndexChanged="cbXemXet_SelectedIndexChanged">
                                                <ItemTemplate>
                                                    <%#Eval("Hoten")%>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="cbXemXet"
                                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                                ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="txtChucVuNguoiGui" runat="server" Width="180px" Enabled="false"
                                                Visible="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Về việc:
                                        </td>
                                        <td colspan="10">
                                            <asp:TextBox ID="txtVeViec" runat="server" Height="20px" Width="99%" Skin="Windows7"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <asp:TextBox ID="txtLoai" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtMaDV"
                                            Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                            ForeColor="Red"></asp:RequiredFieldValidator>
                                    </tr>
                                </table>
                                <tr>
                                    <td colspan="11" align="center">
                                        <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                            ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtChucVuNguoiXX" runat="server" Width="180px" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="text-transform: uppercase">DANH SÁCH TỜ TRÌNH</legend>
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    AllowFilteringByColumn="false" AllowSorting="false" OnSortCommand="RG_SortCommand"
                    PageSize="15" OnCancelCommand="RG_CancelCommand" OnUpdateCommand="RG_UpdateCommand">
                    <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                        <Selecting AllowRowSelect="false" />
                    </ClientSettings>
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
                                <ItemTemplate>
                                    <%# Container.DataSetIndex  + 1%>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="EMAIL" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEmail" runat="server" ImageUrl="~/images/Nutchuanweb/icon_email.png"
                                        Visible='<%#!clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' CommandName="Email" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                <ItemTemplate>
                                    <a style="cursor: pointer" onclick="openRadWindowShow('<%#Eval("SoToTrinh") %>','<%#Eval("NAM") %>','<%#Eval("Thang") %>')">
                                        <img id="Img1" runat="server" alt="" visible='<%#!clsConvertHelper.Tobool( Eval("KiemTra")) %>'
                                            border="0" height="16" src="../images/detail.png" /></a>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="IN" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnIn" runat="server" ImageUrl="~/images/Nutchuanweb/Print2.png"
                                        CommandName="PRINT" Visible='<%#clsConvertHelper.Tobool( Eval("HieuLucPD")) %>' /></ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="40px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="NguoiGoi" DataField="NguoiGoi"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="BoPhanNhan" UniqueName="BoPhanNhan" DataField="BoPhanNhan"
                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="VeViec" DataField="VeViec"
                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NGÀY GỬI" UniqueName="NgayGoi" DataField="NgayGoi"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MaNVXemXet" UniqueName="MaNVXemXet" DataField="MaNVXemXet"
                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Người nhận" UniqueName="NguoiNhan" DataField="NguoiNhan"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Chức vụ NN" UniqueName="ChucVuNN" DataField="ChucVuNN"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Chức vụ NG" UniqueName="ChucVuNG" DataField="ChucVuNG"
                                FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                                FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                                FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="SoTien" DataField="SoTien"
                                FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" Visible="false">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="TỔNG TIỀN (VND)" UniqueName="TongTien" DataField="TongTien"
                                FilterControlWidth="90px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Ngày phê duyệt" UniqueName="NgayNhan" DataField="NgayNhan"
                                FilterControlWidth="80px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}" Visible="false">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="HL-XX" UniqueName="KiemTra"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbhieuluc1" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="HL-PD" UniqueName="KiemTra"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbhieuluc2" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLucPD")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
