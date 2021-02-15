<%@ Page Title="CreateTour" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="EditTour.aspx.cs" Inherits="Tobloggo.EditTour" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <div>
        <h3 style="text-align:center;">Edit Tour Package</h3>
        <table class="auto-style6">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_title" runat="server" Text="Title :"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lbl_title1" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_img" runat="server" Text="Image :"></asp:Label>
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_details" runat="server" Text="Details :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tb_details" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_startD" runat="server" Text="Select Start Date Time and End Date Time:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="calendar" runat="server" ClientIDMode="Static" Width="715px" />
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_price" runat="server" Text="Price :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tb_price" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_minPpl" runat="server" Text="Minimum number of People : "></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlMinPpl" runat="server" Width="148px">
                        <asp:ListItem Selected="True" Value="0">- Select -</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style4">
                    <asp:Label ID="lbl_maxPpl" runat="server" Text="Maximum number of People :"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlMaxPpl" runat="server" Width="148px">
                        <asp:ListItem Selected="True" Value="0">- Select -</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="35">35</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="45">45</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                        <asp:ListItem Value="55">55</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lbl_iti" runat="server" Text="Itinerary :"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tb_iti" runat="server"></asp:TextBox>
                </td>
            </tr>

        </table>

        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" Height="33px" />&nbsp;&nbsp;
        <br />
        <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" />
        <br />
        <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label>
        <script>
            $(function () {
                $('input[id="calendar"]').daterangepicker({
                    timePicker: true,
                    locale: {
                        format: 'MM/DD/YY hh:mm A'
                    }
                });
            });
        </script>
    </div>
</asp:Content>

