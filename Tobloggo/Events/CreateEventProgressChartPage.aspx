<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateEventProgressChartPage.aspx.cs" Inherits="Tobloggo.Events.CreateEventProgressChartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container" style="margin-top: 10px;">
        
        <div>
            <br />
            <h1 ID="editUserTitle" runat="server">Create Event Progress Chart:</h1>
            <asp:Label ID="Label1" runat="server"  Text="Create Event Progress Chart: ">Enter Expected Preparation Time of the Event</asp:Label>
            <br />
            <br />
            <table id="editUserTable">
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Start Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="datetime-local" id="preparationStartDate" runat="server">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="End Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="datetime-local" id="preparationEndDate" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="event_prog_btn_submit" runat="server" OnClick="btn_submit_Click" Text="Confirm"/>

    </div>

</asp:Content>
