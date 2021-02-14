<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Tobloggo.Login" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ScriptHeadContent" runat="server">
    <script src="https://www.google.com/recaptcha/api.js?render=6LfNt-sZAAAAAFNy9lUXnfG4dp-Hl_Z09yDJnBZO"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div>
            <br />
            <asp:Label ID="Label7" runat="server" Font-Size="Larger" Text="Login"></asp:Label>
            <br />
            <br />
            <table class="auto-style1">
                <tr>
                    <td>Email:</td>
                    <td>
                        <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td>
                        <asp:TextBox ID="tb_password" TextMode="Password" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Login" />

            <%--  --%>
            <div class="row form-group" style="margin-top: 40px;">
                <div class="col-md-12">
                    <asp:Button CssClass="btn btn-default" ID="GoogleBtn" runat="server" Text="Login with Google account" OnClick="GoogleBtnClick"></asp:Button>
                </div>
            </div>
            <div class="row form-group">
                <h3 class="col-md-12">User Info:
                </h3>
                <div class="col-md-12">
                    <asp:Literal ID="txtResponse" runat="server">External user info will populate here in json format.</asp:Literal>
                </div>
            </div>
            <%--  --%>

            <br />
            <asp:Label ID="lbl_errormsg" runat="server"></asp:Label>

            <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />

        </div>

        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Registration.aspx">Click here to Register</asp:HyperLink>
        <br />
        <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
    </div>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ScriptAfterContent" runat="server">


    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LfNt-sZAAAAAFNy9lUXnfG4dp-Hl_Z09yDJnBZO', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</asp:Content>
