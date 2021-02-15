<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateEventTeam.aspx.cs" Inherits="Tobloggo.Events.CreateEventTeam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container" style="margin-top: 10px;">
        
        <div>
            <br />
            <asp:Label ID="editUserTitle" runat="server" Font-Size="Larger" Text="Create Event Team: "></asp:Label>
            <br />
            <br />
            <table id="editUserTable">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Team Name: " Width="272px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="teamName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Team Leader: " Width="272px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="teamLeaderId" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Contact Email: "></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="teamContact" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Start Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="date" id="teamStartDate" runat="server">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="End Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="date" id="teamEndDate" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="team_create_btn_submit" runat="server" OnClick="btn_submit_Click" Text="Confirm"/>

    </div>

</asp:Content>
