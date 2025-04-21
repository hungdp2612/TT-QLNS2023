<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PhanQuyen.ascx.cs" Inherits="Controls_PhanQuyen" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">
        function handleClickEvent(sender, args) {
            argsargs = args || window.event;
            if (args.keyCode == 13) {
                args.cancelBubble = true;
                args.returnValue = false;
                if (args.preventDefault) args.preventDefault();
                if (args.stopPropagation) args.stopPropagation();
            }
        }

        function StopEnter(combo, e) {
            if (e.keyCode == 13) {

                window.setTimeout(function () { combo.ShowDropDown(); }, 200);
            }
        }

        function disableEnterKey(e) {
            var key;
            if (window.event)
                key = window.event.keyCode; //IE
            else
                key = e.which; //firefox     

            return (key != 13);
        }

        function stopRKey(evt) {

            var evt = (evt) ? evt : ((event) ? event : null);

            var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);

            if ((evt.keyCode == 13) && (node.type == "text"))
                return false;
        }

        document.onkeypress = stopRKey;
        // Trap Backspace(8) and Enter(13) - 
        // Except bksp on text/textareas, enter on textarea/submit

        if (typeof window.event != 'undefined') // IE
            document.onkeydown = function () // IE
            {
                var t = event.srcElement.type;
                var kc = event.keyCode;
                return ((kc != 8 && kc != 13) || (t == 'text' && kc != 13) ||
             (t == 'textarea') || (t == 'submit' && kc == 13))
            }
        else
            document.onkeypress = function (e)  // FireFox/Others 
            {
                var t = e.target.type;
                var kc = e.keyCode;
                if ((kc != 8 && kc != 13) || (t == 'text' && kc != 13) ||
        (t == 'textarea') || (t == 'submit' && kc == 13))
                    return true
                else {
                    //alert('Sorry Backspace/Enter is not allowed here'); // Demo code
                    return false
                }
            }


        function ChangeToUpperCase(sender, args) {
            var inputElement = sender.get_inputDomElement();
            inputElement.style.textTransform = "uppercase";
        }
    </script>
</telerik:RadScriptBlock>
<div class="header">
    PHÂN QUYỀN SỬ DỤNG CHƯƠNG TRÌNH BIỂU MẪU THUẾ
</div>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="" Transparency="30">
    <div class="loading">
        <asp:Image ID="Image1" runat="server" ImageUrl="~/Ajax/Img/loading4.gif" AlternateText="loading" />
    </div>
</telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%"
    LoadingPanelID="RadAjaxLoadingPanel1">
    <table class="EditFormHeader" style="border-collapse: collapse" border="0px" width="100%"
        cellpadding="2px" cellspacing="2px">
        <tr>
            <td style="width: 15%;">
            </td>
            <td>
                <asp:Label ID="lbloi" runat="server" Text="" CssClass="Error" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Chọn mã nhân viên
            </td>
            <td>
                <telerik:RadComboBox ID="RadcboMaNV" AllowCustomText="True" runat="server" TabIndex="11"
                    EnableLoadOnDemand="true" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                    Width="400px" Skin="Windows7" Height="200px" DataTextField="TV" DataValueField="MaNV"
                    Filter="Contains" AutoPostBack="True" ExpandDelay="500" HighlightTemplatedItems="True"
                    OnClientKeyPressing="ChangeToUpperCase" OnItemsRequested="RadcboMaNV_ItemsRequested">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                ID Site
            </td>
            <td>
                <telerik:RadComboBox ID="RadCboIDSite" AllowCustomText="True" runat="server" TabIndex="12"
                    DropDownWidth="510px" DataSourceID="SqlDTS_RadCboIDSite" EnableLoadOnDemand="true"
                    ShowMoreResultsBox="true" EnableVirtualScrolling="true" Width="400px" Skin="Windows7"
                    Height="200px" DataTextField="DIENGIAI" DataValueField="SITES" Filter="Contains"
                    AutoPostBack="True" ExpandDelay="500" HighlightTemplatedItems="True" OnClientKeyPressing="ChangeToUpperCase">
                    <HeaderTemplate>
                        <table style="width: 500px" cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 200px;">
                                    SITES
                                </td>
                                <td style="width: 300px;">
                                    DIỄN GIẢI
                                </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table style="width: 500px" cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 200px;">
                                    <%# DataBinder.Eval(Container.DataItem, "SITES") %>
                                </td>
                                <td style="width: 300px;">
                                    <%# DataBinder.Eval(Container.DataItem, "DIENGIAI") %>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                Phân quyền
            </td>
            <td>
                <telerik:RadComboBox ID="RadcboPhanQuyen" runat="server" Skin="Windows7" Width="400px">
                    <Items>
                        <telerik:RadComboBoxItem Text="NoAccess" Value="NoAccess" />
                        <telerik:RadComboBoxItem Text="OnlyRead" Value="OnlyRead" />
                        <telerik:RadComboBoxItem Text="AccessAll" Value="AccessAll" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:ImageButton ID="imgbtnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                    OnClick="imgbtnLuu_Click" />
            </td>
        </tr>
    </table>
    <table style="table-layout: fixed;" width="100%">
        <tr>
            <td>
                <telerik:RadGrid ID="RadGridPhanQuyen" AllowSorting="True" DataSourceID="SqlDTS_RadGridPhanQuyen"
                    ClientSettings-Selecting-AllowRowSelect="true" runat="server" GridLines="None"
                    Height="400px" Width="100%" AutoGenerateColumns="False" Skin="Windows7" CellSpacing="0"
                    OnDeleteCommand="RadGridPhanQuyen_DeleteCommand">
                    <ExportSettings FileName="">
                    </ExportSettings>
                    <HeaderContextMenu Skin="Windows7" EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                    <PagerStyle NextPageText="Next" PrevPageText="Prev" Mode="NextPrevAndNumeric" />
                    <ClientSettings>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="True">
                        </Scrolling>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView Width="100%" CommandItemDisplay="None">
                        <CommandItemSettings ShowExportToWordButton="false" ShowExportToExcelButton="false"
                            ShowExportToCsvButton="false" ShowExportToPdfButton="false" AddNewRecordText=""
                            ShowRefreshButton="false" />
                        <NoRecordsTemplate>
                            <div style="text-align: center; color: Blue">
                                Không có dữ liệu tương ứng</div>
                        </NoRecordsTemplate>
                        <Columns>
                            <telerik:GridBoundColumn UniqueName="STT" HeaderText="STT" ReadOnly="true" DataField="STT"
                                ItemStyle-Width="2%">
                                <HeaderStyle Width="2%" />
                                <ItemStyle Width="2%"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="SITES" HeaderText="SITES" ReadOnly="true" DataField="SITES"
                                ItemStyle-Width="7%">
                                <HeaderStyle Width="7%" />
                                <ItemStyle Width="7%"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="DIENGIAI" HeaderText="DIENGIAI" ReadOnly="true"
                                DataField="DIENGIAI" ItemStyle-Width="10%">
                                <HeaderStyle Width="10%" />
                                <ItemStyle Width="10%"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="MANV" HeaderText="MANV" ReadOnly="true" DataField="MANV"
                                ItemStyle-Width="5%">
                                <HeaderStyle Width="5%" />
                                <ItemStyle Width="5%"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn UniqueName="QUYEN" HeaderText="QUYEN" ReadOnly="true" DataField="QUYEN"
                                ItemStyle-Width="5%">
                                <HeaderStyle Width="5%" />
                                <ItemStyle Width="5%"></ItemStyle>
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ConfirmText="Bạn thật sự muốn xóa ?" ConfirmDialogType="RadWindow"
                                HeaderText="Xóa" ItemStyle-Width="3%" ConfirmTitle="Delete" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <HeaderStyle Width="3%" HorizontalAlign="Center" />
                                <ItemStyle Width="3%"></ItemStyle>
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn UniqueName="ID" HeaderText="ID" ReadOnly="true" Visible="false"
                                DataField="ID" ItemStyle-Width="5%">
                                <HeaderStyle Width="5%" />
                                <ItemStyle Width="5%"></ItemStyle>
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings UserControlName="~/Controls/" EditFormType="WebUserControl">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDTS_RadCboIDSite" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectDB_GiaThanhSPM %>"
        SelectCommand="SELECT * FROM DMSITES_GIATHANH_SPM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDTS_RadGridPhanQuyen" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectDB_GiaThanhSPM %>"
        SelectCommand="SP_LOADDANHMUCPHANQUYENSITE_GIATHANH_SPM" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadcboMaNV" DefaultValue="%" Name="MANV" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="RadCboIDSite" DefaultValue="%" Name="SITE" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</telerik:RadAjaxPanel>
