<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietToTrinh.aspx.cs" Inherits="ChiTietToTrinh" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết tờ trình</title>
    <script type="text/javascript">
        function stopRKey(evt) {
            var evt = (evt) ? evt : ((event) ? event : null);
            var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
            if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
        }

        document.onkeypress = stopRKey;

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement && window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CheckWnd() {
            var wnd = GetRadWindow();
            if (wnd) {

            }
            else {
                window.location = "../TruyCapTraiPhep.aspx";
            }
        }
        CheckWnd();
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                    Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                    VisibleTitlebar="False" Width="100%">
                    <ContentTemplate>
                        <center>
                            <asp:Label ID="lbLoi" runat="server"></asp:Label>                           
                        </center>
                    </ContentTemplate>
                </telerik:RadNotification>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập thông tin
                        chi tiết tờ trình</legend>
                    <center>
                        <table>
                            <tr>
                                <td align="right">
                                    Tờ trình:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadTextBox ID="txtKHCP_ID" runat="server" Width="160px" Enabled="false" Skin="Windows7">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 10px">
                                </td>
                                 <td align="right">
                                    Số tiền:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" MinValue="0" Value="0" Width="160px" Skin="Windows7">
                                        <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                    </telerik:RadNumericTextBox>
                                </td>
                                <td style="width: 10px">
                                </td>                             
                            </tr>
                            <tr>
                                <td align="right">
                                    Mã NS:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadComboBox ID="cbMaSoChiPhi" runat="server" Width="160px" DataTextField="MSCHIPHI"
                                        DataValueField="MSCHIPHI" HighlightTemplatedItems="true" EnableLoadOnDemand="true" Skin="Windows7"
                                        Height='150px' DropDownWidth="350px" Enabled="true" 
                                        onitemsrequested="cbMaSoChiPhi_ItemsRequested">
                                        <HeaderTemplate>
                                            <table>
                                                <tr>
                                                    <td width="150px">
                                                        Mã CP
                                                    </td>
                                                    <td width="190px">
                                                        Tên CP
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td width="150px">
                                                        <%#Eval("MSChiPhi")%>
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
                                <td style="width: 10px">
                                </td>
                                 <td align="right">
                                    Ghi chú:
                                </td>
                                <td style="width: 10px">
                                </td>
                                <td align="left">
                                    <telerik:RadTextBox ID="txtGhichu" runat="server" Skin="Windows7">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 10px">
                                </td>
                              
                            </tr>
                            <tr>
                               
                               
                            </tr>
                            <tr>
                                <td colspan="11" align="center">
                                    <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />                                  
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtMaDV" runat="server" Visible="false"></asp:TextBox>
                                      <asp:TextBox ID="txtMaBP" runat="server" Visible="false"></asp:TextBox>
                                      <asp:TextBox ID="txtIDMaCS" runat="server" Visible="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNam" runat="server" Visible="false"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtThang" runat="server" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </center>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                        tờ trình</legend>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False" Skin="Windows7"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="false" AllowPaging="True"
                        AllowSorting="false" ShowStatusBar="True" EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="10">
                        
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </HeaderContextMenu>
                        <GroupingSettings CaseSensitive="False" />
                        <MasterTableView CommandItemDisplay="None">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="TỜ TRÌNH" UniqueName="SoToTrinh" DataField="SoToTrinh"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn HeaderText="MÃ ĐV" UniqueName="MaDV" DataField="MaDV" FilterControlWidth="40px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiphi" DataField="MSChiphi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn HeaderText="NĂM" UniqueName="NAM" DataField="NAM" FilterControlWidth="40px"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="THÁNG" UniqueName="Thang" DataField="Thang"
                                FilterControlWidth="30px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="SỐ TIỀN" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="Ghichu" DataField="Ghichu"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                               
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="SỬA" HeaderText="SỬA"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="XÓA" HeaderText="XÓA">
                                </telerik:GridButtonColumn>
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
    </div>
    <%-- <asp:SqlDataSource ID="sql_ChiTiet_ChiPhiKeHoach" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectQLNS %>"
        SelectCommand="spLoad_ChiTiet_ChiPhiKeHoach" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
    </form>
</body>
</html>
