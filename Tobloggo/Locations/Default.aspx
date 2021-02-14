<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tobloggo.Locations._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-3">
        <div class="sidebar">
            <a href="#">Food</a>
            <a href="#">Entertainment</a>
            <a href="#">Cultural</a>
        </div>
    </div>
    <div class="col-9">

    </div>
    <asp:GridView ID="gvLocation" runat="server" AutoGenerateColumns="False" ClientIDMode="Static">
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
