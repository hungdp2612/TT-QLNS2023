<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietKeHoachNganSach2.aspx.cs"
    Inherits="ChiTietKeHoachNganSach2" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chi tiết kế hoạch ngân sách</title>
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
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Nhập thông tin
                        chi tiết kế hoạch ngân sách</legend>
                    <center>
                        <table>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td align="right">
                                                Khóa NS:
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="left">
                                                <telerik:RadTextBox ID="txtKHCP_ID" runat="server" Width="150px" Enabled="false">
                                                </telerik:RadTextBox>
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="right">
                                                MS chi phí:
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="left">
                                                <telerik:RadComboBox ID="cbMaSoChiPhi" runat="server" Width="150px" DataTextField="MSCHIPHI"
                                                    DataValueField="MSCHIPHI" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                                    Height='150px' DropDownWidth="350px" Enabled="true" OnItemsRequested="cbMaSoChiPhi_ItemsRequested"
                                                    OnSelectedIndexChanged="cbMaSoChiPhi_SelectedIndexChanged" AutoPostBack="true">
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
                                            <td width="5px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Số tiền được lập:
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="left">
                                                <telerik:RadNumericTextBox ID="rnSoTienDuocLap" runat="server" Value="0" Width="150px"
                                                    Enabled="false">
                                                </telerik:RadNumericTextBox>
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="right">
                                                Chi phí:
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="left">
                                                <telerik:RadNumericTextBox ID="rnChiPhi" runat="server" MinValue="0" Value="0" Width="150px">
                                                    <IncrementSettings InterceptArrowKeys="False" InterceptMouseWheel="False" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                            <td width="5px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Ghi chú:
                                            </td>
                                            <td width="5px">
                                            </td>
                                            <td align="left" colspan="5">
                                                <telerik:RadTextBox ID="txtGhichu" runat="server" Width="100%">
                                                </telerik:RadTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="11" align="center">
                                    <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                        ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                                 
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtMaDV" runat="server" Visible="false">
                                    </telerik:RadTextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMaBP" runat="server" ReadOnly="True" Width="160px" Enabled="False"
                                        Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtIDMaCS" runat="server" ReadOnly="True" Width="160px" Enabled="false"
                                        Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtNam" runat="server" ReadOnly="True" Enabled="true" Visible="false"></asp:TextBox>
                                    <asp:TextBox ID="txtThang" runat="server" ReadOnly="True" Enabled="true" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </center>
                </fieldset>
                <fieldset>
                    <legend style="font-size: 9pt; font-family: Tahoma; color: #982849;">Thông tin chi tiết
                        chi phí kế hoạch</legend>
                    <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                        CellSpacing="0" GridLines="None" AllowFilteringByColumn="True" AllowPaging="True"
                        AllowSorting="True" ShowStatusBar="True" EnableLinqExpressions="false" OnCancelCommand="RG_CancelCommand"
                        OnDeleteCommand="RG_DeleteCommand" OnGroupsChanging="RG_GroupsChanging" OnItemCommand="RG_ItemCommand"
                        OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                        OnSortCommand="RG_SortCommand" OnUpdateCommand="RG_UpdateCommand">
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
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px"/>
                                    <ItemTemplate>
                                        <%# Container.DataSetIndex  + 1%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="Khóa CT" UniqueName="ID_khoaCT" DataField="ID_khoaCT"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="ID_Khoa" UniqueName="ID_Khoa" DataField="ID_Khoa"
                                    FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Bộ phận" UniqueName="MaBP" DataField="MaBP"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                </telerik:GridBoundColumn>
                                   <telerik:GridBoundColumn HeaderText="DV UQ" UniqueName="MaDVUQ" DataField="MaDVUQ" FilterControlWidth="50px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                                    </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MaNV" UniqueName="MaNV" DataField="MaNV" FilterControlWidth="50px"
                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="MSChiphi" UniqueName="MSChiphi" DataField="MSChiphi"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" >
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Số tiền" UniqueName="Sotien" DataField="Sotien"
                                    FilterControlWidth="50px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="90px"/>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Ghichu" DataField="Ghichu"
                                    FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                    AutoPostBackOnFilter="true" AllowFiltering="false">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="120px"/>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"  Width="120px"/>
                                </telerik:GridBoundColumn>
                                <%--   <telerik:GridTemplateColumn HeaderText="Sửa" UniqueName="Edit" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/images/Nutchuanweb/edit.png"
                                    CommandName="SUA" /></ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="Sửa" HeaderText="Sửa"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle />
                                    <ItemStyle HorizontalAlign="Center"  Width="40px"/>
                                    <HeaderStyle HorizontalAlign="Center" Width="40px"/>
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                    ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="Xóa">
                                     <ItemStyle HorizontalAlign="Center"  Width="40px"/>
                                    <HeaderStyle HorizontalAlign="Center" Width="40px"/>
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
                <div style="clear: both">
                    <telerik:RadNotification ID="RadNotification1" runat="server" AutoCloseDelay="0"
                        Height="40px" Position="BottomCenter" ShowCloseButton="False" VisibleOnPageLoad="True"
                        VisibleTitlebar="False" Width="100%">
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
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div style="clear: both">
        </div>
    </div>
    <%-- <asp:SqlDataSource ID="sql_ChiTiet_ChiPhiKeHoach" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectQLNS %>"
        SelectCommand="spLoad_ChiTiet_ChiPhiKeHoach" SelectCommandType="StoredProcedure"></asp:SqlDataSource>--%>
    </form>
</body>
</html>
