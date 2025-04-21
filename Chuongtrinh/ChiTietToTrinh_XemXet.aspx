<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietToTrinh_XemXet.aspx.cs"
    Inherits="ChiTietToTrinh_XemXet" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết tờ trình::.</title>
    <style type="text/css">
        .bgtieudebox
        {
            background-image: url("../image/bg_title.png");
            background-repeat: repeat-x;
            height: 40px;
            font-size: 14pt;
            color: White;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
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
                window.location = "../Loi.aspx?Strloi=Truy cập không hợp lệ ...";
            }
        }
        CheckWnd();
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <div style="float: left; margin-left: 20px">
            <asp:TextBox ID="tbSoPhieu" runat="server" Visible="false"></asp:TextBox><asp:HiddenField
                ID="hfPhieuTU" runat="server" />
        </div>
        <center>
            <telerik:RadGrid ID="RGChiTietToTrinh" runat="server" AutoGenerateColumns="False" Width="100%"
                CellSpacing="0" GridLines="None" ShowStatusBar="True" EnableLinqExpressions="False" Skin="Windows7"
                ShowFooter="True">
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>
                <GroupingSettings CaseSensitive="False" />
                <ClientSettings EnableRowHoverStyle="false" EnablePostBackOnRowClick="false">
                    <Scrolling AllowScroll="True" SaveScrollPosition="True" UseStaticHeaders="True" />
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
                <MasterTableView>
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False"
                            Groupable="False">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px"/>
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="MÃ NS" UniqueName="MSChiPhi" DataField="MSChiPhi"
                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px"/>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px"/>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="TÊN NS" UniqueName="DienGiai" DataField="DienGiai"
                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px"/>
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="140px"/>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Sotien" FilterControlAltText="Filter Sotien column"
                            HeaderText="SỐ TIỀN" ReadOnly="True" SortExpression="Sotien" UniqueName="Sotien"
                            Aggregate="Sum" ItemStyle-Width="100px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true" FilterControlWidth="100px" DataFormatString="{0:###,###.##}"
                            AllowFiltering="false">
                            <FooterStyle ForeColor="Blue" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px"/>
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Middle" Width="120px"/>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="LOẠI TIỀN" UniqueName="LoaiTien" DataField="LoaiTien"
                            FilterControlWidth="40px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px"/>
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px"/>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="GHI CHÚ" UniqueName="GhiChu" DataField="GhiChu"
                             CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="300px" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="300px"/>
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </center>
    </div>
    </form>
</body>
</html>
