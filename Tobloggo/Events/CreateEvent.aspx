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
                        <asp:Label ID="Label1" runat="server" Text="Account Name: " Width="272px" Height="22px"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="editAccountName" runat="server" Text="(Account Name)" Width="272px" Height="22px"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Profile Image: "></asp:Label>
                    </td>

                    <td>
                        <asp:Label ID="Label3" runat="server" Text="(Profile Image)" Width="272px" Height="22px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Email: "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="editEmail" runat="server" Text="(Email)" Width="272px" Height="22px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Contact Number: "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="editContact" runat="server" Text="(Contact Number)" Width="272px" Height="22px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Authorization: "></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="editAuthorization" runat="server">
                            <asp:ListItem Selected="True" Value="0">User</asp:ListItem>
                            <asp:ListItem Value="1">Administrator</asp:ListItem>
                            <asp:ListItem Value="2">Event Manager</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="Stripe Id: "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="editStripeId" runat="server" Text="(StripeId)" Width="272px" Height="22px"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="edit_btn_submit" runat="server" OnClick="btn_submit_Click" Text="Confirm"/>
        <br />
        <asp:Label ID="lbl_submitchecker" runat="server"></asp:Label>

    </div>
</asp:Content>
