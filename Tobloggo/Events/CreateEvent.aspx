<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateEvent.aspx.cs" Inherits="Tobloggo.Events.CreateEvent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container" style="margin-top: 10px;">
        
        <div>
            <br />
            <asp:Label ID="editUserTitle" runat="server" Font-Size="Larger" Text="Create Event: "></asp:Label>
            <br />
            <br />
            <table id="editUserTable">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Event Name: " Width="272px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="eventName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Location: "></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="eventLocation" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Description: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="eventDescription" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Start Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="datetime-local" id="eventStartDate" runat="server">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="End Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="datetime-local" id="eventEndDate" runat="server">
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="event_create_btn_submit" runat="server" OnClick="btn_submit_Click" Text="Confirm"/>

    </div>
</asp:Content>
