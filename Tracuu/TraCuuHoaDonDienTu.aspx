<%@ page title="" language="C#" masterpagefile="~/Home.master" autoeventwireup="true" codefile="TraCuuHoaDonDienTu.aspx.cs" inherits="Tracuu.Tracuu_TraCuuHoaDonDienTu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <fieldset style="width: 970px; margin-left: 5px;">
                <legend>Điều kiện tìm kiếm</legend>

                <table>
                    <tr>
                        <td align="left">Từ ngày:
                        </td>
                        <td align="left">
                            <telerik:raddatepicker id="raddatepickerTuNgay" runat="server" width="180px">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                </telerik:raddatepicker>
                        </td>

                        <td align="left">Đơn vị:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="DropDownListDonVi" runat="server" Width="180px" DataTextField="TenDonVi"
                                DataValueField="IDMaDV"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </td>

                        <td align="left">Số phiếu:
                        </td>
                        <td align="left">
                            <telerik:radtextbox id="RadTextBoxSoPhieu" runat="server" width="180px"></telerik:radtextbox>
                        </td>

                    </tr>
                    <tr>
                        <td align="left">Đến ngày:
                        </td>

                        <td align="left">
                            <telerik:raddatepicker id="raddatepickerDenNgay" runat="server" width="180px">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="">
                                    </DateInput>
                                </telerik:raddatepicker>
                        </td>
                        <td align="left">Mã số thuế:
                        </td>

                        <td align="left">
                            <telerik:radtextbox id="RadTextBoxMaSoThue" runat="server" width="180px"></telerik:radtextbox>
                        </td>
                        <td align="left">Số hóa đơn
                        </td>

                        <td align="left">
                            <telerik:radtextbox id="RadTextBoxSoHoaDon" runat="server" width="180px"></telerik:radtextbox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">Tên File:
                        </td>

                        <td align="left">
                            <telerik:radtextbox id="RadTextBoxTenFile" runat="server" width="180px"></telerik:radtextbox>
                        </td>
                        <td align="left">Mã tra cứu:
                        </td>

                        <td align="left">
                            <telerik:radtextbox id="RadTextBoxMaTraCuuHoacTaiKhoan" runat="server" width="180px"></telerik:radtextbox>
                        </td>
                        <td align="center">
                            <asp:ImageButton ID="btnXem" runat="server" OnClick="btnXem_OnClick" ImageUrl="~/images/Nutchuanweb/btXem.png" />
                            &nbsp;   
                            <asp:ImageButton ID="btExcel" runat="server" ImageUrl="~/images/Nutchuanweb/excell.png"
                                OnClick="btExcel_OnClick" />

                        </td>
                    </tr>


                </table>

            </fieldset>
            <div style="width: 1000px">

                <telerik:radgrid id="RG" runat="server" allowpaging="True" allowfilteringbycolumn="False"
                    autogeneratecolumns="False" borderstyle="None" pagesize="20"
                    grouppanelposition="Top" showfooter="False" height="400px"
                    onneeddatasource="RG_OnNeedDataSource" OnExportCellFormatting="RG_OnExportCellFormatting">
                            <ClientSettings EnablePostBackOnRowClick="False">
                                      
                                        <Selecting AllowRowSelect="True" />
                                        <Scrolling AllowScroll="True" UseStaticHeaders="True"  />
                                        <Resizing AllowColumnResize="true" ResizeGridOnColumnResize="true" AllowResizeToFit="true" />
                                    </ClientSettings>
                            <MasterTableView>
                             
                              
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="STT" UniqueName="STT" DataField="STT" AllowFiltering="False"
                                        Groupable="False">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="40px" />
                                        <ItemTemplate>
                                            <%# Container.DataSetIndex  + 1%>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridHyperLinkColumn DataTextFormatString="Chi tiết" DataNavigateUrlFields="DuongDanTraCuu" 
                                                                 UniqueName="CHITIET"   HeaderText="Xem hóa đơn" 
                                                                 DataTextField="DuongDanTraCuu"  Target="_blank" >
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    </telerik:GridHyperLinkColumn>
                                    

                                    <telerik:GridBoundColumn DataField="MaDonVi" HeaderText="Bộ phận" UniqueName="MaDonVi"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="60px" />
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="TENFILE" HeaderText="Tên File" UniqueName="TENFILE"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="190px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="190px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SoHoaDon" HeaderText="Số hóa đơn" UniqueName="SoHoaDon"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MASOTHUE" HeaderText="MST" UniqueName="MASOTHUE"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DuongDanTraCuu" HeaderText="Đường link truy cập" UniqueName="DuongDanTraCuu"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="260px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="260px" />
                                    </telerik:GridBoundColumn>
                                    
                                   

                                    <telerik:GridBoundColumn DataField="MaTraHoacTaiKhoan" HeaderText="Mã tra cứu HĐĐT" UniqueName="MaTraHoacTaiKhoan"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="MaXacThucHoacMatKhau" HeaderText="Mã xác thực" UniqueName="MaXacThucHoacMatKhau"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="110px" />
                                    </telerik:GridBoundColumn>

                                    
                                    
                                    <telerik:GridBoundColumn DataField="SOTIEN" HeaderText="Số tiền" UniqueName="SOTIEN"
                                                             FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                             AllowFiltering="true"  DataFormatString="{0:#,#.##}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    

                                    <telerik:GridBoundColumn DataField="SoPhieu" HeaderText="Số phiếu" UniqueName="SoPhieu"
                                        FilterControlWidth="90px" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        AllowFiltering="true">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="120px" />
                                    </telerik:GridBoundColumn>
                                    
                                  
                                    <telerik:GridBoundColumn DataField="NGAYLAP" HeaderText="Ngày lập" UniqueName="NGAYLAP"
                                                             FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px"/>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px"/>
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridBoundColumn DataField="NgayKT" HeaderText="Ngày KT" UniqueName="NgayKT"
                                        FilterControlWidth="40px" AllowFiltering="false" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px"/>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="80px"/>
                                    </telerik:GridBoundColumn>
                                    
                                    <telerik:GridTemplateColumn DataField="KiemTra" HeaderText="Kế toán KT" UniqueName="KiemTra"
                                        AllowFiltering="false" ShowFilterIcon="false">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbhieuluc2" AutoPostBack="false" runat="server" Enabled="false"
                                                Checked='<%# clsConvertHelper.Tobool(Eval("KiemTra")) %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="75px"/>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="75px"/>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridHyperLinkColumn DataTextFormatString="Tải xuống" DataNavigateUrlFields="DuongDanLuuFile" 
                                                                 UniqueName="DUONGDANLUUFILE"   HeaderText="File hóa đơn" 
                                                                 DataTextField="DuongDanLuuFile"  Target="_blank" >
                                        <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="90px" />
                                    </telerik:GridHyperLinkColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:radgrid>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:content>
