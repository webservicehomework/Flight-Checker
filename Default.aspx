﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="YYC_Web_App._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label2" runat="server" Text="Please enter your flight number"></asp:Label>
&nbsp;(eg. FN1, FN3)<br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" ToolTip="Flight number"></asp:TextBox>
        <br />
        <br />
    
    </div>
    <asp:Button ID="Button1" runat="server" style="height: 26px" Text="Get Data" />
&nbsp;&nbsp;&nbsp;
    <br />
    <br />
    <asp:Label ID="Label1" runat="server"></asp:Label>
    </form>
</body>
</html>
