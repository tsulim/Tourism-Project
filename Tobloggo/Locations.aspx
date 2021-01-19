<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Locations.aspx.cs" Inherits="Tobloggo.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView ID="gvLocation" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="Type" HeaderText="Type" />
            <asp:BoundField DataField="Images" HeaderText="Images" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="UserId" DataFormatString="{0:N}" HeaderText="User Id" />
        </Columns>
    </asp:GridView>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptAfterContent" runat="server">
</asp:Content>
