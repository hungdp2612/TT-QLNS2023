<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rptBaoCao.aspx.cs" Inherits="Report_rptBaoCao" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.::Báo cáo::.</title>
    <%--<script type="text/javascript" language="javascript">
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
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <center>
        <table>
        <tr>
            <td>
                <asp:Label ID="lblloi" runat="server" Text=""></asp:Label>
            </td>
        </tr>
            <tr>
                <td align="left">
                    <CR:CrystalReportViewer ID="CrystalReportViewer1" BackColor="white" runat="server"
                        AutoDataBind="true" ToolPanelView="None" PageZoomFactor="100" OnUnload="CrystalReportViewer1_Unload" />
                </td>
                <td align="left">
                    <CR:CrystalReportViewer ID="CrystalReportViewer2" BackColor="white" runat="server"
                        AutoDataBind="true" ToolPanelView="None" PageZoomFactor="100" />
                </td>
            </tr>
        </table>
    </center>
    </form>
</body>
</html>
