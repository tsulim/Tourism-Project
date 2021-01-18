<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="Tobloggo.CreateTour" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 6px;
        }
        .auto-style2 {
            width: 256px;
        }
        .auto-style3 {
            width: 6px;
            height: 33px;
        }
        .auto-style4 {
            width: 256px;
            height: 33px;
        }
        .auto-style5 {
            height: 33px;
        }
        .auto-style6 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbl_createTour" runat="server" Text="Create Tour Package"></asp:Label>
            <br />
            <br />
            <table class="auto-style6">
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_img" runat="server" Text="Images :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_img" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_title" runat="server" Text="Title :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_title" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_details" runat="server" Text="Details"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_details" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_startDT" runat="server" Text="Select Start Date Time :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_startDT" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_endDT" runat="server" Text="Select End Date Time :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_endDT" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_price" runat="server" Text="Price :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_price" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_minPpl" runat="server" Text="No. of Min People : "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_minPpl" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style4">
                        <asp:Label ID="lbl_maxPpl" runat="server" Text="No. of Max People :"></asp:Label>
                    </td>
                    <td class="auto-style5">
                        <asp:TextBox ID="tb_maxPpl" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lbl_iti" runat="server" Text="Itinerary :"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tb_iti" runat="server"></asp:TextBox>
                    </td>
                </tr>

            </table>

            <br />
            <asp:Button ID="btnCreate" runat="server" OnClick="btnAdd_Click" Text="Create" />
            <br />
            <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label>
            <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid">
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Name" ReadOnly="True" />
                <asp:BoundField DataField="Image" HeaderText="Image" ReadOnly="True" />
                <asp:BoundField DataField="Details" HeaderText="Details" ReadOnly="True" />
                <asp:BoundField DataField="StartDT" HeaderText="StartDT" ReadOnly="True" />
                <asp:BoundField DataField="EndDT" HeaderText="EndDT" ReadOnly="True" />
                <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" />
                <asp:BoundField DataField="MinPpl" HeaderText="MinPpl" ReadOnly="True" />
                <asp:BoundField DataField="MaxPpl" HeaderText="MaxPpl" ReadOnly="True" />
                <asp:BoundField DataField="Iti" HeaderText="Itinerary" ReadOnly="True" />
            </Columns>
        </asp:GridView>
        </div>
    </form>
</body>
</html>
