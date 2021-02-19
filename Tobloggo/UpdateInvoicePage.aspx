<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="UpdateInvoicePage.aspx.cs" Inherits="Tobloggo.UpdateInvoicePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 style="text-align: center"><strong>Update Invoice</strong></h3>
    <table class="table">
        <tr>
            <td class="modal-sm" style="width: 206px"><strong>Booking ID:</strong></td>
            <td style="width: 19px" class="modal-lg">
                <asp:Label ID="lbBookId" runat="server"></asp:Label>
            </td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td class="modal-sm" style="width: 19px">&nbsp;</td>
        </tr>
        <tr>
            
            <td class="modal-sm" style="width: 206px"><strong>Tour Package:</strong></td>
            <td style="width: 19px">
                <asp:Label ID="lbTourName" runat="server"></asp:Label>
            </td>
            <td class="modal-sm" style="width: 19px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
   
        </tr>
        <tr>
            <td class="modal-sm" style="width: 206px"><strong>Customer Name:</strong></td>
            <td style="width: 122px" class="modal-lg">
                <asp:Label ID="lbCustName" runat="server"></asp:Label>
            </td>
            <td class="modal-sm" style="width: 19px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
        </tr>
        <tr>
            <td class="modal-sm" style="width: 206px"><strong>Invoice Type:</strong></td>
            <td style="width: 19px" class="modal-lg">
                <asp:DropDownList ID="ddlInvType" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="0">--Select--</asp:ListItem>
                    <asp:ListItem Value="BC">Booking Confirmation (BC)</asp:ListItem>
                    <asp:ListItem Value="RA">Refund Approval (RA)</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td class="modal-sm" style="width: 19px">&nbsp;</td>
        </tr>
        <tr>
            <td class="modal-sm" style="width: 206px">&nbsp;</td>
            <td style="width: 19px" class="modal-lg">&nbsp;</td>
            <td class="modal-sm" style="width: 206px">&nbsp;</td>
            <td style="width: 19px" class="modal-lg">&nbsp;</td>
        </tr>
        <tr>
            <td class="modal-sm" style="width: 206px">&nbsp;</td>
            <td class="modal-sm" style="width: 19px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px"><asp:Label ID="lbResult" runat="server"></asp:Label></td>
            <td style="width: 140px" class="modal-lg">
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="BtnUpdate_Click" style="height: 26px"  />&nbsp;&nbsp;
                <asp:Button ID="btnBack" runat="server" OnClick="BtnBack_Click" Text="Back" />
            </td>
        </tr>
        
    </table>
</asp:Content>
