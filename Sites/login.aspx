<%@ Page Title="Chào mừng bạn đến với chương trình QUẢN LÝ NGÂN SÁCH" Language="C#"
    MasterPageFile="~/HomeLogin.master" AutoEventWireup="true" CodeFile="Login.aspx.cs"
    Inherits="Login" Debug="true" %>

<%@ Register Src="~/Controls/Login.ascx" TagName="Login" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:Login ID="Login1" runat="server" />
</asp:Content>
