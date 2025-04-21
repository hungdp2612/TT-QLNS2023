<%@ Page Title="" Language="C#" MasterPageFile="~/Home.master" AutoEventWireup="true" CodeFile="ThoiGianLapNganSach.aspx.cs" Inherits="Chuongtrinh_ThoiGianLapNganSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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

    <fieldset>
    <center>
<table>
<tr>
<td>
Mã ĐV:
</td>
 <td align="left">
                           <telerik:RadComboBox ID="cbMaDV" runat="server" Width="150px" DataTextField="MaDonVi"
                                DataValueField="MaDonVi" HighlightTemplatedItems="true" EnableLoadOnDemand="true"
                                DropDownWidth="350px" Enabled="true" 
                               onitemsrequested="cbMaDV_ItemsRequested"  >
                               <HeaderTemplate>
                               <table>
                               <tr>
                               <td width="150px">Mã DV</td>
                                <td width="190px">Tên DV</td>
                               </tr>
                               </table>
                               </HeaderTemplate>
                                <ItemTemplate>                                  
                                <table>
                                <tr>
                                <td width="150px">
                                                <%#Eval("MaDonVi")%>
                                </td>
                                  <td width="190px">
                                                <%#Eval("TenDonVi")%>
                                </td>
                                </tr>
                                </table>
                                
                                         
                                </ItemTemplate>
                            </telerik:RadComboBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidatorDONVI" runat="server"
                                ControlToValidate="cbMaDV" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True"
                                ValidationGroup="GInsert" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
</tr>

<tr>
<td>
Trước ngày:
</td>
<td>
   <telerik:RadNumericTextBox ID="rnSoNgay" runat="server" Width="70px" AutoPostBack="True"
                                        MaxValue="31" MinValue="1">
                                        <NumberFormat ZeroPattern="n" DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                    </telerik:RadNumericTextBox>
                                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server" ControlToValidate="rnThang"
                                        Display="Dynamic" ErrorMessage="Chọn tháng ngân sách." ValidationGroup="gInsert">*</asp:RequiredFieldValidator>--%>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidatorTHANG" runat="server"
                                ControlToValidate="rnSoNgay" Display="Dynamic" ErrorMessage="(*)" SetFocusOnError="True"
                                ValidationGroup="GInsert" ForeColor="Red"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
Ghi chú:
</td>
<td>
  <asp:TextBox ID="txtTen" runat="server" Width="180px" ></asp:TextBox>
</td>
</tr>
<tr>
<td colspan="11" align="center">
                            <asp:ImageButton ID="btnLuu" runat="server" ImageUrl="~/images/Nutchuanweb/luu.png"
                                ValidationGroup="GInsert" OnClick="btnLuu_Click" />
                            &nbsp;<asp:ImageButton ID="btnLamMoi" runat="server" 
                                ImageUrl="~/images/Nutchuanweb/lammoi.png" onclick="btnLamMoi_Click" />
                        </td>
</tr>
</table>
</center>


  <telerik:RadGrid ID="RG" Width="100%" runat="server" AutoGenerateColumns="False"
                EnableLinqExpressions="false" AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
                GridLines="None" AllowPaging="True" OnItemCommand="RG_ItemCommand"                
                AllowFilteringByColumn="True" AllowSorting="True" >
                  <FilterMenu EnableImageSprites="False">
                </FilterMenu>
                <HeaderContextMenu EnableTheming="True">
                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
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
                        <telerik:GridTemplateColumn HeaderText="Sửa" UniqueName="Edit" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/images/Nutchuanweb/edit.png"
                                    CommandName="SUA" /></ItemTemplate>
                        </telerik:GridTemplateColumn>
                        
                    
                        <telerik:GridBoundColumn HeaderText="Mã Đon vị" UniqueName="MaDV" DataField="MaDV"
                            FilterControlWidth="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>                       
                      
                       
                        <telerik:GridBoundColumn HeaderText="Trước ngày" UniqueName="SoNgay" DataField="SoNgay"
                            FilterControlWidth="70px"  CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="Ten" DataField="Ten"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        
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

</ContentTemplate>
</asp:UpdatePanel>

</asp:Content>

