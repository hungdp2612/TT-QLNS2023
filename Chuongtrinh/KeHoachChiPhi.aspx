<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachChiPhi.aspx.cs" Inherits="Chuongtrinh_KeHoach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">

                function openRadWindowShow(khoa_chiphi, Nam) {
                    var manager = $find("<%= RadWindowManager1.ClientID %>");
                    var oWnd = manager.open("ChiTietKeHoachChiPhi.aspx?khoa_chiphi=" + khoa_chiphi + "&Nam=" + Nam, "RadWindowManager1");
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
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="">Chọn dữ liệu cần nhập</legend>
                <center>
                    <table border="0">
                        <tr>
                            <td align="right">
                                Năm:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnNam" runat="server" Width="70px" AutoPostBack="True"
                                    Skin="Windows7" OnTextChanged="rnNam_TextChanged">
                                    <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="rnNam"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Mã NS:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadComboBox ID="cbMaSoChiPhi" runat="server" Width="150px" DataTextField="MaNganSach"
                                    Skin="Windows7" DataValueField="MaNganSach" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                    OnItemsRequested="cbMaSoChiPhi_ItemsRequested" Height='150px' DropDownWidth="350px">
                                    <HeaderTemplate>
                                        <table>
                                            <tr>
                                                <td width="150px">
                                                    Mã NS
                                                </td>
                                                <td width="190px">
                                                    Tên NS
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table>
                                            <tr>
                                                <td width="150px">
                                                    <%#Eval("MaNganSach")%>
                                                </td>
                                                <td width="190px">
                                                    <%#Eval("DienGiai")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMSCHIPHI" runat="server" ControlToValidate="cbMaSoChiPhi"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Đơn vị:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="MaDonVi"
                                    Skin="Windows7" AutoPostBack="true" runat="server" Width="180px" Enabled="true"
                                    OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:TextBox ID="TxtMaDV" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                            <td width="5px">
                            </td>
                            <td align="right">
                                Chi phí duyệt:
                            </td>
                            <td width="5px">
                            </td>
                            <td align="left">
                                <telerik:RadNumericTextBox ID="rnChiPhiDuyet" runat="server" Value="0" Width="150px"
                                    Skin="Windows7">
                                </telerik:RadNumericTextBox>
                                <%--  <asp:CheckBox ID="chkhieuluc1" runat="server" Checked="true"></asp:CheckBox>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="11" align="center">
                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtMaBP" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                            </d>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend style="">Danh sách chi phí</legend>
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="false" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    AllowFilteringByColumn="false" AllowSorting="false" OnSortCommand="RG_SortCommand"
                    OnUpdateCommand="RG_UpdateCommand">
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                    <GroupingSettings CaseSensitive="False" />
                    <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                        <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                        <Selecting AllowRowSelect="true" />
                    </ClientSettings>
                    <MasterTableView ShowFooter="true">
                        <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemTemplate>
                                    <%# Container.DataSetIndex  + 1%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="CHI TIẾT" UniqueName="Chitiet" AllowFiltering="false">
                                <ItemTemplate>
                                    <a style="cursor: pointer" onclick="openRadWindowShow('<%# Eval("khoa_chiphi") %>','<%#Eval("Nam") %>')">
                                        <img alt="" border="0" height="16" src="../images/detail.png" /></a>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn HeaderText="khoa_chiphi" UniqueName="khoa_chiphi" DataField="khoa_chiphi"
                                FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="HT" DataField="HT" FilterControlWidth="50px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ DV" UniqueName="MADV" DataField="MADV" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                Display="false" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="70px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                Display="false" AllowFiltering="false">
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridNumericColumn DataField="Chiphiduocduyet" UniqueName="Chiphiduocduyet"
                                HeaderText="CHI PHÍ DUYỆT" FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px"
                                DataFormatString="{0:###,###.##}" HeaderStyle-Width="100px" Visible="true" AllowFiltering="false"
                                FooterStyle-HorizontalAlign="Right">
                                <ItemStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn DataField="Chiphikehoach" UniqueName="Chiphikehoach" HeaderText="CHI PHÍ KH"
                                FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" DataFormatString="{0:###,###.##}"
                                HeaderStyle-Width="100px" Visible="true" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                <ItemStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn DataField="CHIPHI_DV" UniqueName="CHIPHI_DV" HeaderText="CP ĐƠN VỊ"
                                FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" DataFormatString="{0:###,###.##}"
                                HeaderStyle-Width="100px" Visible="true" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                <ItemStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridNumericColumn>
                            <telerik:GridNumericColumn DataField="CHIPHI_UY" UniqueName="CHIPHI_UY" HeaderText="CP ỦY QUYỀN"
                                FooterStyle-ForeColor="Blue" Aggregate="Sum" ItemStyle-Width="100px" DataFormatString="{0:###,###.##}"
                                HeaderStyle-Width="100px" Visible="true" AllowFiltering="false" FooterStyle-HorizontalAlign="Right">
                                <ItemStyle Width="100px" />
                                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" />
                            </telerik:GridNumericColumn>
                            <telerik:GridTemplateColumn DataField="hieuluc" HeaderText="HL" UniqueName="hieuluc"
                                AllowFiltering="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("hieuluc")) %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="60px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                </telerik:RadGrid>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
