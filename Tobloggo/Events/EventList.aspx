<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="EventList.aspx.cs" Inherits="Tobloggo.Events.EventList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top: 10px;">
        <h1>Event List</h1>
        <p>There are {} total events</p>

        <div class="d-flex justify-content-end">
            <asp:HyperLink href="/Events/CreateEvent" ID="AddEventBtn" runat="server">+ Add New Event</asp:HyperLink>
        </div>

        <hr />

        <asp:ListView ID="ListView1" runat="server" DataSourceID="EventListView">
            <LayoutTemplate>
                <table runat="server" id="table1" border="1" style="width: 100%; padding: 5px;" >
                    <tr runat="server">
                        <th>Event Id</th>
                        <th>Event Name</th>
                        <th>Status</th>
                        <th>Preparation Date</th>
                        <th>Event Date</th>
                        <th>Event Page</th>
                        <th>Event Progress Chart</th>
                        <th></th>
                    </tr>
                    <tr runat="server" id="itemPlaceholder" ></tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr runat="server">
                    <td runat="server">
                        <asp:Label ID="NameLabel" runat="server" Text='<%#Eval("Id")%>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("Name") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("Status") %>' />
                    </td>
                    <td runat="server">
                        <% if (true)
                            { %>
                        <asp:Label ID="Label3" runat="server" Text='<%# String.Format("{0} - {1}", Eval("PStartDate"), Eval("PEndDate")) %>'/>
                        <% } %>
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label4" runat="server" Text='<%# String.Format("{0} - {1}", Eval("EStartDate"), Eval("EEndDate")) %>'/>
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label5" runat="server" Text="Hello" />
                    </td>
                    <td runat="server">
                        

                        <asp:HyperLink ID="HyperLink2" href='<%#: GetRouteUrl("EventProgressChartCreateRoute", new {eventId = Eval("Id")}) %>' 
                            visible = <%# Eval("ProgCreated").ToString()=="0" ? true : false %>
                            runat="server">Create</asp:HyperLink> 

                        <asp:HyperLink ID="HyperLink1" href='<%#: GetRouteUrl("EventProgressChartRoute", new {eventId = Eval("Id")}) %>' 
                            visible = <%# Eval("ProgCreated").ToString()=="1" ? true : false %>
                            runat="server">View</asp:HyperLink> 

                    </td>
                </tr>
            </ItemTemplate>

        </asp:ListView>




            <asp:SqlDataSource ID="EventListView" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\TobloggoDB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [Id], [Name], [Status], [Location], [EStartDate], [EEndDate], [ProgCreated], [PStartDate], [PEndDate] FROM [Event]"></asp:SqlDataSource>




    </div>

</asp:Content>
