<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="AddInvoice.aspx.cs" Inherits="Tobloggo.AddInvoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
    <h3>Add New Invoice</h3>
    <table style="width:100%;">
        <tr>
            <td colspan="2">Note: In order to ensure up-to-date invoices, only recent booking IDs up to the last 3 months can be used for creating an invoice.
                <br />Should there be a need to create an invoice for an old booking record, you may directly create it in the email server. <br />
                Invoice Type will be set based on Booking Status at time of Invoice Creation. (E.g Booking Status : Refunded → Invoice Type: RA)
            </td>
        </tr>
        <tr>
            <td class="auto-style1" style="width: 134px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1" style="width: 134px">Booking ID:</td>
            <td>
                <!--<asp:TextBox ID="tbBookId" runat="server"></asp:TextBox>-->
                <asp:DropDownList ID="DropDownList1" runat="server" Width="100px"></asp:DropDownList>
            </td>
        </tr>

        <tr>
            <td class="auto-style1" style="width: 134px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1" style="width: 134px">&nbsp;</td>
            <td>
                <asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="Add" Width="77px" />
                <asp:Button ID="btnBack" runat="server" OnClick="BtnBack_Click" Text="Back" />
            </td>
        </tr>
        <tr>
            <td class="auto-style1" style="width: 134px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style1" style="width: 134px">&nbsp;</td>
            <td>
                <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    </div>

    <style>
        body{
            background-color:#f0e6ff;
        }
    </style>
</asp:Content>
