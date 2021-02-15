<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="TourOverview.aspx.cs" Inherits="Tobloggo.TourOverview" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <h3 style="text-align:center;">Overview of Tour Package</h3>
    <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid" OnSelectedIndexChanged="gvTour_SelectedIndexChanged" HorizontalAlign="Center">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Name" ReadOnly="True" />
            <asp:ImageField DataImageUrlField="Image" HeaderText="Image" ControlStyle-CssClass="img" HeaderStyle-Width="10px" ></asp:ImageField>  
            <asp:BoundField DataField="Details" HeaderText="Details" ReadOnly="True" />
            <asp:BoundField DataField="DateTime" HeaderText="Date Time" ReadOnly="True" />
            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" />
            <asp:BoundField DataField="MinPeople" HeaderText="Minimum No. of People" ReadOnly="True" HeaderStyle-Width="10px" />
            <asp:BoundField DataField="MaxPeople" HeaderText="Maximum No. of People" ReadOnly="True" HeaderStyle-Width="10px" />
            <asp:BoundField DataField="Itinerary" HeaderText="Itinerary" ReadOnly="True" />
            <asp:CommandField ShowSelectButton="True" ButtonType="Button">
            <ControlStyle BorderColor="#796EFF" BorderStyle="Solid" BackColor="#796EFF" ForeColor="White" /> 
            </asp:CommandField>
        </Columns>
    </asp:GridView>
</asp:Content>
