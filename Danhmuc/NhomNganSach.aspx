<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="NhomNganSach.aspx.cs" Inherits="Danhmuc_NhomNganSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Tạo nhóm ngân sách</legend>
                <center>
                    <table border="0">
                        <tr>
                            <td align="right">
                                Mã nhóm:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMaNhom" Width="100px" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorNAM" runat="server" ControlToValidate="txtMaNhom"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td align="right">
                                Diễn giải:
                            </td>
                            <td>
                                <asp:TextBox ID="txtDienGiai" Width="300px" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDienGiai"
                                    Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True" ValidationGroup="GInsert"
                                    ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7" align="center">
                                <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                    ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                            </td>
                        </tr>
                    </table>
                </center>
            </fieldset>
            <fieldset style="width: 970px; margin-left: 5px">
                <legend>Danh sách nhóm ngân sách ngân sách</legend>
                <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                    Skin="Windows7" EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                    GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand" OnDeleteCommand="RG_DeleteCommand"
                    OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged"
                    AllowFilteringByColumn="True" AllowSorting="True" OnSortCommand="RG_SortCommand"
                    OnInsertCommand="RG_InsertCommand" OnUpdateCommand="RG_UpdateCommand" PageSize="15">
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
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
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemTemplate>
                                    <%# Container.DataSetIndex  + 1%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="Delete"
                                ConfirmText="Bạn có chắc muốn xóa nhóm này?" Text="Xóa" HeaderText="XÓA">
                            </telerik:GridButtonColumn>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="Sửa" HeaderText="SỬA"
                                UniqueName="EditCommandColumn">
                                <ItemStyle />
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn HeaderText="MÃ NHÓM" UniqueName="MaNhomNS" DataField="MaNhomNS"
                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true" Visible="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="DIỄN GIẢI" UniqueName="DienGiai" DataField="DienGiai"
                                FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AutoPostBackOnFilter="true">
                                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            </telerik:GridBoundColumn>
                        </Columns>
                        <EditFormSettings EditFormType="WebUserControl" UserControlName="~/Controls/">
                            <EditColumn UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu EnableTheming="True">
                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                    </HeaderContextMenu>
                </telerik:RadGrid>
            </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
