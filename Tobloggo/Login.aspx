<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Tobloggo.Login" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ScriptHeadContent" runat="server">
    <script src="https://www.google.com/recaptcha/api.js?render=6LfNt-sZAAAAAFNy9lUXnfG4dp-Hl_Z09yDJnBZO"></script>

    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="748299484002-a0rjtlk5ovijs0pgdf2gfcs0429he8gs.apps.googleusercontent.com">
    
    <link href="/Content/Login.css" rel="stylesheet">

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
                    <asp:TextBox ID="tb_password" TextMode="Password" runat="server" ></asp:TextBox>
                </td>   
            </tr>
        </table>
        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Login" />


        <%--  --%>
        <br />
        <br />
        <asp:LinkButton ID="GoogleBtn2" runat="server" OnClick="Google_Click">
            <div class="google-btn">
              <div class="google-icon-wrapper">
                <img class="google-icon" src="https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"/>
              </div>
              <p class="btn-text"><b>Sign in with google</b></p>
            </div>
        </asp:LinkButton>
        <%--  --%>

            <br />
            <asp:Label ID="lbl_errormsg" runat="server"></asp:Label>

            <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />

        </div>

    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/SignUp.aspx">Click here to Register</asp:HyperLink>
    <br />
    <asp:Label ID="lbl_gScore" runat="server" ></asp:Label>


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
