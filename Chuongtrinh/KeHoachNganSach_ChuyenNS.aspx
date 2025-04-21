<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="KeHoachNganSach_ChuyenNS.aspx.cs" Inherits="Chuongtrinh_KeHoachNganSach_ChuyenNS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">


        function OnClientClose() {
            __doPostBack('fLoad', '');
        }

    
    </script>
    <script type="text/javascript" defer="defer" language="javascript">


        function SelectAll(CheckBox) {
            var TargetBaseControl = document.getElementById('<%= this.RG_ThangTruoc.ClientID %>');
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
    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
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
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Chuyển kế hoạch ngân sách từ tháng này sang tháng khác</legend>
                <center>
                    <table border="0">
                        <tr>
                            <td align="right">
                                Đơn vị:
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlMaDV" DataTextField="TenDonVi" DataValueField="IDMaCS" runat="server"
                                    Skin="Windows7" Width="185px" Enabled="true" AutoPostBack="true" OnSelectedIndexChanged="ddlMaDV_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                Người XX:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cbXemXet" runat="server" Width="185px" DataTextField="Ten"
                                    Skin="Windows7" DataValueField="MaNV" DropDownWidth="185px" HighlightTemplatedItems="true"
                                    EnableLoadOnDemand="true" AutoPostBack="false">
                                </telerik:RadComboBox>
                            </td>
                            <td align="right">
                                Người PD:
                            </td>
                            <td>
                                <telerik:RadComboBox ID="cbNguoiPheDuyet" runat="server" Width="185px" DataTextField="MaTen"
                                    Skin="Windows7" DataValueField="MAPD" DropDownWidth="185px" HighlightTemplatedItems="true"
                                    EnableLoadOnDemand="true" AutoPostBack="true">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="false"
                                    Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Enabled="false" Visible="false"></asp:TextBox>
                                <telerik:RadNumericTextBox ID="rnNganSachConLaiAn" runat="server" ReadOnly="True"
                                    Width="160px" Enabled="false" Value="0" Display="false">
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <div style="float: left; width: 1000px">
                <div style="float: left; width: 470px; margin-left: 5px;">
                    <fieldset>
                        <legend style="font-size: 9pt; font-family: Tahoma; color: #982849; text-align: left">
                            1. Ngân sách tháng chuyển</legend>
                        <table width="100%">
                            <tr>
                                <td align="right">
                                    Tháng:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnThangCu" runat="server" Width="70px" AutoPostBack="True"
                                        Skin="Windows7" AllowOutOfRangeAutoCorrect="False" MaxValue="12" MinValue="1"
                                        OnTextChanged="rnThangCu_TextChanged">
                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="rnThangCu"
                                        Display="Dynamic" ErrorMessage="Nhập tháng ngân sách trước." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="right">
                                    Năm:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnNamCu" runat="server" Width="70px" AutoPostBack="True"
                                        Skin="Windows7" OnTextChanged="rnNamCu_TextChanged">
                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="rnNamCu"
                                        Display="Dynamic" ErrorMessage="Nhập năm ngân sách trước." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="RG_ThangTruoc" Height="370px" runat="server" AllowAutomaticDeletes="True"
                            Skin="Windows7" AllowAutomaticUpdates="True" AllowMultiRowEdit="True" ShowFooter="True"
                            CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" OnItemCommand="RG_ThangTruoc_ItemCommand"
                            OnPageIndexChanged="RG_ThangTruoc_PageIndexChanged" OnPageSizeChanged="RG_ThangTruoc_PageSizeChanged">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="false" CommandItemDisplay="None" ShowGroupFooter="true"
                                TableLayout="Fixed">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="30px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="NAM" FilterControlAltText="Filter NAM column"
                                        HeaderText="NĂM" ReadOnly="True" SortExpression="NAM" UniqueName="NAM" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                        Visible="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="THANG" FilterControlAltText="Filter THANG column"
                                        HeaderText="THÁNG" ReadOnly="True" SortExpression="THANG" UniqueName="THANG"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="60px" Visible="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                        HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="60px" Visible="true" AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="STCON" FilterControlAltText="Filter STCON column"
                                        HeaderText="NS CÒN" ReadOnly="True" SortExpression="STCON" UniqueName="STCON"
                                        ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:###,###}"
                                        AllowFiltering="false" Aggregate="Sum">
                                        <FooterStyle ForeColor="Blue" />
                                        <HeaderStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                        <ItemStyle Width="80px" HorizontalAlign="Right" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="STCHUYEN" HeaderText="ST CHUYỂN" UniqueName="STCHUYEN"
                                        AllowFiltering="false" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <telerik:RadNumericTextBox ID="rnSTChuyen" Width="80px" runat="server" Value='<%#fInt(Eval("STCHUYEN")) %>'
                                                Culture="Vietnamese (Vietnam)" AutoPostBack="false">
                                                <NumberFormat DecimalDigits="0" />
                                            </telerik:RadNumericTextBox>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn UniqueName="All" ReadOnly="True" AllowFiltering="False">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="chkSelectAll" runat="server" Text="" onclick="SelectAll(this);" />
                                        </HeaderTemplate>
                                        <HeaderStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle Width="40px" HorizontalAlign="Center" VerticalAlign="Middle" />
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
                            <FooterStyle HorizontalAlign="Right" VerticalAlign="Top" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
                <div style="float: left; margin-top: 150px;">
                    <asp:ImageButton ID="btLay" runat="server" ImageUrl="~/images/Nutchuanweb/lay.jpg"
                        ValidationGroup="gLay" OnClick="btLay_Click" />
                </div>
                <div style="float: left; width: 470px;">
                    <fieldset>
                        <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">2. Ngân sách tháng
                            được chuyển </legend>
                        <table width="100%">
                            <tr>
                                <td align="right">
                                    Tháng:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnThangMoi" runat="server" Width="70px" AutoPostBack="True"
                                        Skin="Windows7" Enabled="true" OnTextChanged="rnThangMoi_TextChanged">
                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="rnThangMoi"
                                        Display="Dynamic" ErrorMessage="Chưa lấy được ngân sách hiện tại." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="right">
                                    Năm:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnNamMoi" runat="server" Width="70px" AutoPostBack="True"
                                        Skin="Windows7" Enabled="true" OnTextChanged="rnNamMoi_TextChanged">
                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="rnNamMoi"
                                        Display="Dynamic" ErrorMessage="Chưa lấy được ngân sách hiện tại." ValidationGroup="gLay">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadGrid ID="RG" runat="server" Height="370px" AllowFilteringByColumn="True"
                            Skin="Windows7" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="True"
                            GridLines="None" AutoGenerateColumns="False" ShowFooter="True" OnDeleteCommand="RG_DeleteCommand"
                            OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                            OnUpdateCommand="RG_UpdateCommand" CellSpacing="0">
                            <GroupingSettings CaseSensitive="False" />
                            <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false">
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
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
                                    <telerik:GridBoundColumn HeaderText="ID_khoaCT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                        FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                        AutoPostBackOnFilter="true" Visible="false" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" Visible="false" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="maBP" DataField="maBP" FilterControlWidth="50px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="MÃ NV" UniqueName="MaNV" DataField="MaNV" FilterControlWidth="60px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        Visible="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MSCHIPHI" FilterControlAltText="Filter MSCHIPHI column"
                                        HeaderText="MÃ NS" ReadOnly="True" SortExpression="MSCHIPHI" UniqueName="MSCHIPHI"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        FilterControlWidth="50px" Visible="true" AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="NS CHUYỂN" DataField="Sotien" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}"
                                        Aggregate="Sum" FooterStyle-CssClass="test" AllowFiltering="false">
                                        <FooterStyle ForeColor="Blue" />
                                        <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                        ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FooterStyle CssClass="color" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
