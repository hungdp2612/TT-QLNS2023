<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="TamUngHetHan.aspx.cs" Inherits="TamUngHetHan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../js/Common.js" type="text/javascript"></script>
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
                                TẠM ỨNG HẾT HẠNG CHƯA THANH TOÁN
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <center>
                <table>
                    <tr>
                        <td align="right">
                            Phiếu TU:
                        </td>
                        <td align="left">
                            <telerik:RadComboBox ID="cbPhieuTU" runat="server" AutoPostBack="True" DataTextField="PhieuTU"
                                DataValueField="PhieuTU" DropDownWidth="165px" Height="170px" Width="165px" OnSelectedIndexChanged="cbPhieuTU_SelectedIndexChanged">
                                <ItemTemplate>
                                    <table width="165px">
                                        <tr>
                                            <td style="width: 100px">
                                                <%# Eval("PhieuTU")%>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cbPhieuTU"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="gLuu"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Tên đơn vị:
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtTenDonVi" Width="195px" Enabled="false" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Hạn thanh toán:
                        </td>
                        <td align="left">
                            <telerik:RadDatePicker ID="rdHanThanhToan" runat="server" Width="180px" Culture="Vietnamese (Vietnam)"
                                Enabled="false">
                                <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                    ViewSelectorText="x" runat="server">
                                </Calendar>
                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                <DateInput ID="DateInput4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy"
                                    runat="server">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdHanThanhToan"
                                Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="Group"
                                ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        <td align="right">
                            Phụ trách đơn vị:
                        </td>
                        <td align="left">
                            <asp:DropDownList Enabled="false" ID="ddlPhuTrachDonVi" runat="server" DataValueField="MaNV"
                                DataTextField="Ten" Width="200px" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Ghi chú:
                        </td>
                        <td colspan="9">
                            <asp:TextBox ID="txtGhiChu" runat="server" Height="25px" Width="99%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMaDV" Width="70px" Enabled="false" Visible="false" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMaDV"
                                Display="Dynamic" ErrorMessage="Chưa xác định được mã đơn vị." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtIDMaCS" runat="server" Width="180px" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="11" align="center">
                            <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                            <asp:HyperLink ID="hlEmail" runat="server"><img border='0' alt="" src="../images/Nutchuanweb/email.png" />&nbsp;</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="9">
                            <asp:Label ID="lbEmail" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <div>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="true" AllowPaging="True"
                        AllowSorting="false" EnableLinqExpressions="false" Skin="Windows7" PageSize="15"
                        AllowAutomaticInserts="True" AllowAutomaticUpdates="True" OnDeleteCommand="RG_DeleteCommand"
                        OnItemCommand="RG_ItemCommand" OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnUpdateCommand="RG_UpdateCommand">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="true">
                            <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <MasterTableView>
                            <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <%--  <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn"
                                HeaderText="Sửa" EditText="Sửa">
                                <ItemStyle />
                                  <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                            </telerik:GridEditCommandColumn>--%>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa không?" Text="Xóa">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                </telerik:GridButtonColumn>
                                <telerik:GridBoundColumn HeaderText="Phiếu TU" UniqueName="PhieuTU" DataField="PhieuTU"
                                    FilterControlWidth="120px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Hạn thanh toán" UniqueName="HanThanhToan" DataField="HanThanhToan"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ngày hiệu chỉnh" UniqueName="HieuChinhHanThanhToan"
                                    DataField="HieuChinhHanThanhToan" FilterControlWidth="70px" CurrentFilterFunction="Contains"
                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:dd/MM/yyyy}">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Lý do" UniqueName="GhiChu" DataField="GhiChu"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="HieuLuc" HeaderText="Hiệu lực" UniqueName="HieuLuc"
                                    AllowFiltering="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbhieuluc" runat="server" Enabled="false" Checked='<%# clsConvertHelper.Tobool(Eval("HieuLuc")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px" />
                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                </telerik:GridTemplateColumn>
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
                </div>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
