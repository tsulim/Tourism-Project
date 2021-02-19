<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="ListUsers.aspx.cs" Inherits="Tobloggo.Admin.ListUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container" style="margin-top: 10px;">
        <h1>User List</h1>
        <hr />
        <asp:ListView ID="ListView1" runat="server" DataSourceID="TobloggoUsers">
            <LayoutTemplate>
                <table runat="server" id="table1" border="1" style="width: 100%; padding: 5px;" >
                    <tr runat="server">
                        <td>Id</td>
                        <td>Google Id</td>
                        <td>Name</td>
                        <td>Email</td>
                        <td>Contact</td>
                        <td>Authorization</td>
                        <td>StripeId</td>
                        <td></td>
                    </tr>
                    <tr runat="server" id="itemPlaceholder" ></tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr runat="server">
                    <td runat="server">
                        <asp:Label ID="NameLabel" runat="server" Text='<%#Eval("Id") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("GoogleId") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label2" runat="server" Text='<%#Eval("Name") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("Email") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("Contact") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label5" runat="server" Text='<%#Eval("Authorization") %>' />
                    </td>
                    <td runat="server">
                        <asp:Label ID="Label6" runat="server" Text='<%#Eval("StripeId") %>' />
                    </td>
                    <td runat="server">
                        <asp:HyperLink ID="HyperLink1" href='<%#: GetRouteUrl("EditUserRoute", new {userId = Eval("Id")}) %>' runat="server">Edit</asp:HyperLink>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="TobloggoUsers" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\TobloggoDB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [Id], [GoogleId], [Name], [Email], [Contact], [Authorization], [StripeId] FROM [User]"></asp:SqlDataSource>
    </div>

</asp:Content>
