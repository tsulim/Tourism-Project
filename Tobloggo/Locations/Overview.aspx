<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="Overview.aspx.cs" Inherits="Tobloggo.Locations.Overview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HyperLink NavigateUrl="/BPartner/Locations/Create" runat="server">Create</asp:HyperLink>
    <asp:GridView ID="gvLocation" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="Type" HeaderText="Type" />
            <asp:BoundField DataField="Images" HeaderText="Images" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="UserId" DataFormatString="{0:N}" HeaderText="User Id" />
            <asp:HyperLinkField DataNavigateUrlFields="Id" HeaderText="Action" NavigateUrl="/BPartner/Location/Edit/{locaId}" Text="Edit" />
        </Columns>
    </asp:GridView>
</asp:Content>
