﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rptGiayNopTien.aspx.cs" Inherits="Reports_rptGiayNopTien" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Label ID="lblLoi" runat="server" Text="" CssClass="Error"></asp:Label>
    <asp:Panel ID="pnlReport" runat="server" ScrollBars="Horizontal" Width="100%">
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
            ShowAllPageIds="true" PrintMode="ActiveX" ToolPanelView="None" OnUnload="CrystalReportViewer1_Unload"
            HasCrystalLogo="False" HasDrilldownTabs="False" HasToggleGroupTreeButton="false">
        </CR:CrystalReportViewer>
    </asp:Panel>
    </form>
</body>
</html>
