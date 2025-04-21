<%@ Page Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true"
    CodeFile="PhanQuyen.aspx.cs" Inherits="admin_PhanQuyen" Title="" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" SelectedIndex="0" MultiPageID="MultiPage"
                AutoPostBack="True" OnTabClick="RadTabStrip1_TabClick" Skin="Windows7">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Phân quyền" Selected="True">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Danh mục site">
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Danh mục quyền">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <center>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <img style="margin-top: 10px;" alt="Loading..." 
                            src="../images/ajax-loader-bar.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </center>
            <telerik:RadMultiPage ID="MultiPage" runat="server" Width="100%" SelectedIndex="0"
                Height="100%">
                <telerik:RadPageView ID="RadPageView1" runat="server">
                    <center>
                        <fieldset style="width: 90%">
                            <legend>Danh mục SITE</legend>
                            <table border="0" cellpadding="2" cellspacing="2" style="width: 96%; text-align: left">
                                <tr>
                                    <td align="left" width="120px">
                                        Danh mục site:
                                    </td>
                                    <td align="left">
                                        <telerik:RadComboBox ID="RadIDSITE" runat="server" Height="200px" Width="200px" HighlightTemplatedItems="true"
                                            DataTextField="IDSITE" DropDownWidth="400px" DataValueField="IDSITE" 
                                            Skin="Windows7">
                                            <HeaderTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" width="350px">
                                                    <tr>
                                                        <td style="width: 100px" align="left">
                                                            IDSITE
                                                        </td>
                                                        <td style="width: 250px" align="right">
                                                            TÊN SITE
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" width="350px">
                                                    <tr>
                                                        <td style="width: 100px" align="left">
                                                            <%# Eval("IDSITE")%>
                                                        </td>
                                                        <td style="width: 250px" align="right">
                                                            <%# Eval("TENSITE")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="height: 12px">
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset style="width: 90%">
                            <legend>Danh mục Nhân Viên</legend>
                            <table border="0" cellpadding="2" cellspacing="2" style="width: 96%; text-align: left">
                                <tr>
                                    <td align="left" width="120px">
                                        Mã nhân viên:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbMANV" runat="server" Width="185px" AutoPostBack="True" OnTextChanged="tbMANV_TextChanged"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbMANV"
                                            Display="Dynamic" ErrorMessage="Nhập mã nhân viên." SetFocusOnError="True" ValidationGroup="Gpq"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbTenNV"
                                            Display="Dynamic" ErrorMessage="Mã nhân viên không tồn tại." ValidationGroup="Gpq"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" width="120px">
                                        Tên nhân viên:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="tbTenNV" runat="server" Enabled="false" Width="185px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="height: 12px">
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset style="width: 90%">
                            <legend>Quyền</legend>
                            <table border="0" cellpadding="2" cellspacing="2" style="width: 96%; text-align: left">
                                <tr>
                                    <td align="left" width="120px">
                                        Danh mục quyền:
                                    </td>
                                    <td align="left">
                                        <asp:RadioButtonList ID="rdDMQuyen" runat="server" DataTextField="Quyen"
                                            DataValueField="IDQuyen" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        </asp:RadioButtonList>           
                                        <asp:CheckBox runat="server" ID="CheckBoxKhongCheckIP" Text="Không kiểm tra IP"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" width="120px">
                                        <asp:Label ID="lbLoi" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="height: 12px">
                                        <asp:ImageButton ID="btLuu" runat="server" ImageUrl="~/Images/Nutchuanweb/luu.png" OnClick="btLuu_Click"
                                            ValidationGroup="Gpq" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset style="width: 90%">
                            <div style="margin-left: 20px; text-align: left;">
                            </div>
                        </fieldset>
                        <br />
                        <fieldset style="width: 90%">
                            <legend>Phân quyền</legend>
                            <telerik:RadGrid ID="RGPHANQUYEN" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                                AllowAutomaticUpdates="True" 
                                AutoGenerateColumns="False" BorderStyle="None"
                                GridLines="None" OnCancelCommand="RGDMSITE_CancelCommand" OnDeleteCommand="RGPHANQUYEN_DeleteCommand"
                                PageSize="20" Width="100%" Skin="Windows7">
                                <PagerStyle Mode="NextPrevAndNumeric" />
                                <MasterTableView AutoGenerateColumns="False" HorizontalAlign="NotSet" Width="100%">
                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                                        Visible="True">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                                        Visible="True">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="IDSITE" HeaderText="IDSITE" UniqueName="IDSITE">
                                            <ItemTemplate>
                                                <%# Eval("IDSITE")%><asp:HiddenField ID="hdIDSITE" runat="server" Value='<%# Eval("IDSITE")%>' />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="Quyen" HeaderText="Quyền" UniqueName="Quyen">
                                            <ItemTemplate>
                                                <asp:RadioButtonList ID="rbQuyen" runat="server" DataTextField="Quyen" DataValueField="IDQuyen"
                                                    RepeatDirection="Horizontal" RepeatLayout="Flow" OnSelectedIndexChanged="rbQuyen_SelectedIndexChanged"
                                                    AutoPostBack="True">
                                                </asp:RadioButtonList>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                                            ConfirmText="Bạn có muốn xóa thông tin này không?" ConfirmTitle="Delete" HeaderText="Xóa"
                                            Text="Xóa" UniqueName="column">
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                            </telerik:RadGrid>
                        </fieldset>
                    </center>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView2" runat="server">
                    <telerik:RadGrid ID="RGDMSITE" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                        AllowAutomaticUpdates="True" AllowPaging="True" 
                        AutoGenerateColumns="False" BorderStyle="None"
                        GridLines="None" OnCancelCommand="RGDMSITE_CancelCommand" OnDeleteCommand="RGDMSITE_DeleteCommand"
                        OnInsertCommand="RGDMSITE_InsertCommand" OnItemCommand="RGDMSITE_ItemCommand"
                        OnPageIndexChanged="RGDMSITE_PageIndexChanged" OnPageSizeChanged="RGDMSITE_PageSizeChanged"
                        OnUpdateCommand="RGDMSITE_UpdateCommand" PageSize="20" Width="100%" 
                        Skin="Windows7">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" />
                        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" HorizontalAlign="NotSet"
                            Width="100%">
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="IDSITE" HeaderText="ID site" UniqueName="IDSITE">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%# Eval("IDSITE")%><asp:HiddenField ID="hfIDSITE" runat="server" Value='<%# Eval("IDSITE")%>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="TENSITE" HeaderText="Tên site" UniqueName="TENSITE">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%# Eval("TENSITE")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="HIEULUC" HeaderText="Hiệu lực" UniqueName="HIEULUC">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:CheckBox Enabled="false" ID="cbHIEULUC" runat="server" Checked='<%# fBool(DataBinder.Eval(Container, "DataItem.HieuLuc").ToString()) %>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="Sửa" HeaderText="Chỉnh sửa"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle />
                                        <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                 
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                                    ConfirmText="Bạn có muốn xóa thông tin này không?" ConfirmTitle="Delete" HeaderText="Xóa"
                                    Text="Xóa" UniqueName="column">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl" UserControlName="~/controls/Insert_Update/">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView ID="RadPageView3" runat="server">
                    <telerik:RadGrid ID="RGDMQuyen" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                        AllowAutomaticUpdates="True" AllowPaging="True" PageSize="20"
                        Width="100%" OnItemCommand="RGDMQuyen_ItemCommand" OnCancelCommand="RGDMQuyen_CancelCommand"
                        OnDeleteCommand="RGDMQuyen_DeleteCommand" OnInsertCommand="RGDMQuyen_InsertCommand"
                        OnUpdateCommand="RGDMQuyen_UpdateCommand" Skin="Windows7">
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                        <HeaderContextMenu EnableTheming="True">
                            <CollapseAnimation Duration="200" Type="OutQuint" />
                        </HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" />
                        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" HorizontalAlign="NotSet"
                            Width="100%">
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <CommandItemSettings AddNewRecordText="Thêm mới" RefreshText="" />
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn DataField="IDQuyen" HeaderText="ID quyền" UniqueName="IDQuyen">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%# Eval("IDQuyen")%><asp:HiddenField ID="hfIDQuyen" runat="server" Value='<%# Eval("IDQuyen")%>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="Quyen" HeaderText="Tên quyền" UniqueName="Quyen">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <%# Eval("Quyen")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton" EditText="Sửa" HeaderText="Chỉnh sửa"
                                    UniqueName="EditCommandColumn">
                                    <ItemStyle />
                                    <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                            
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                                    ConfirmText="Bạn có muốn xóa thông tin này không?" ConfirmTitle="Delete" HeaderText="Xóa"
                                    Text="Xóa" UniqueName="column">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings EditFormType="WebUserControl" UserControlName="~/controls/Insert_Update/">
                                <EditColumn UniqueName="EditCommandColumn1">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
