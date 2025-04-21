<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChiTietChungTu_TraPhieu.aspx.cs"
    Inherits="ChiTietChungTu_TraPhieu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>.::Chi tiết chứng từ thanh toán::.</title>
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
        <center>
           
            <asp:Label ID="lbLoi" runat="server"></asp:Label>
        </center>
        <div style="float: left; margin-left: 20px">
            Số phiếu:
            <asp:TextBox ID="tbSoPhieu" runat="server" Enabled="false"></asp:TextBox><asp:HiddenField
                ID="hfPhieuTU" runat="server" />
            <asp:HiddenField ID="hfMaDV" runat="server" />
        </div>
        <center>
            <telerik:RadGrid ID="RG" runat="server" AutoGenerateColumns="False" GridLines="None"
                OnPageIndexChanged="RG_PageIndexChanged" OnPageSizeChanged="RG_PageSizeChanged" AllowPaging="True" PageSize="10">
                
                <MasterTableView>
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                    </ExpandCollapseColumn>
                    <Columns>                        
                        <telerik:GridTemplateColumn HeaderText="STT" UniqueName="SoTT" DataField="STT" AllowFiltering="False">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemTemplate>
                                <%# Container.DataSetIndex  + 1%>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="Số ID" UniqueName="CTTT_ID" DataField="CTTT_ID"
                            Display="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Thành tiền ban đầu" UniqueName="ThanhTienBD1"
                            DataField="ThanhTien" Display="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Thành tiền ban đầu" UniqueName="ThanhTienBD2"
                            DataField="ThanhTienBanDau" Display="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Hạn thanh toán KT" UniqueName="HanThanhToanKT"
                            DataField="HanThanhToanKT" Display="false">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Phiếu tạm ứng" UniqueName="PhieuTU" DataField="PhieuTU"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Mã chi phí" UniqueName="MSChiPhi" DataField="MSChiPhi"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tên và qui cách" UniqueName="TenvaQuiCach" DataField="TenvaQuiCach"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số hoá đơn" UniqueName="SoHoaDon" DataField="SoHoaDon"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                     
                        <telerik:GridBoundColumn HeaderText="ĐVT" UniqueName="DVT" DataField="DVT" FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Loại tiền" UniqueName="LoaiTien" DataField="LoaiTien"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Tỉ giá" UniqueName="TiGia" DataField="TiGia"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Số lượng" UniqueName="SoLuong" DataField="SoLuong"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Đơn giá" UniqueName="DonGia" DataField="DonGia"
                            FilterControlWidth="100px">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                        
                        <telerik:GridBoundColumn HeaderText="Thành tiền" UniqueName="TienThanhToan"
                            DataField="TienThanhToan" FilterControlWidth="70px" CurrentFilterFunction="Contains"
                            ShowFilterIcon="false" AutoPostBackOnFilter="true" DataFormatString="{0:###,###.##}">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </telerik:GridBoundColumn>
                       
                        <telerik:GridBoundColumn HeaderText="Ghi chú" UniqueName="GhiChu" DataField="GhiChu"
                            FilterControlWidth="70px" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                            AutoPostBackOnFilter="true">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
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
