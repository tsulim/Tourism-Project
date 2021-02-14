<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Tobloggo.SignUp" %>



<asp:Content ID="ScriptHeadContent" ContentPlaceHolderID="ScriptHeadContent" runat="server">
    <script src="https://www.google.com/recaptcha/api.js?render=6LfNt-sZAAAAAFNy9lUXnfG4dp-Hl_Z09yDJnBZO"></script>


    <%-- Client Side Password Complexity Checker --%>
    <script type="text/javascript">
        //Password onchange validation
        function validate() {
            var password = document.getElementById("tb_password").value;
            var cfmPassword = document.getElementById("tb_cfmPassword").value;

            var feedback = document.getElementById("lbl_pwdchecker")

            document.getElementById("btn_submit").disabled = true;

            if (password.length < 8) {
                feedback.innerHTML = "Password length must be at least 8 characters."
                feedback.style.color = "Red"
                return ("too_short")
            } else if (password.search(/^(?=.*[A-Z])/) == -1) {
                feedback.innerHTML = "Password requires at least 1 uppercase";
                feedback.style.color = "Red"
                return ("no_uppercase")
            } else if (password.search(/^(?=.*[a-z])/) == -1) {
                feedback.innerHTML = "Password requires at least 1 lowercase";
                feedback.style.color = "Red"
                return ("no_lowercase")
            } else if (password.search(/^(?=.*[$@$!%*?&])/) == -1) {
                feedback.innerHTML = "Password requires at least 1 special character";
                feedback.style.color = "Red"
                return ("no_number")
            } else if (password.search(/^(?=.*\d)/) == -1) {
                feedback.innerHTML = "Password requires at least 1 number";
                feedback.style.color = "Red"
                return ("no_special_character")
            } else {
                feedback.innerHTML = "Excellent!"
                feedback.style.color = "Blue"
            }

            if (password != cfmPassword) {
                document.getElementById("lbl_cfmchecker").innerHTML = "Password and Confirm Password must be the same value"
                document.getElementById("lbl_cfmchecker").style.color = "Red"
                return ("Password not same")
            }

            document.getElementById("lbl_cfmchecker").innerHTML = ""

            document.getElementById("signup_btn_submit").disabled = false;
        }
    </script>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div>
            <br />
            <asp:Label ID="Label7" runat="server" Font-Size="Larger" Text="Registration"></asp:Label>
            <br />
            <br />
            <table id="signupTable" class="auto-style4">
                <tr>
                    <td class="auto-style9">
                        <asp:Label ID="Label1" runat="server" Text="Account Name: " Width="272px" Height="22px"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="tb_accname" runat="server"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lbl_accnamechecker" runat="server" ForeColor="#CC3300"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style15">
                        <asp:Label ID="Label4" runat="server" Text="Email: "></asp:Label>
                    </td>
                    <td class="auto-style16">
                        <asp:TextBox ID="tb_email" runat="server" CssClass="auto-style8"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lbl_emailchecker" runat="server" ForeColor="#CC3300"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="Label5" runat="server" Text="Password: "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="tb_password" runat="server" TextMode="Password" onkeyup="javascript:validate()" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lbl_pwdchecker" runat="server" ForeColor="#CC3300" ClientIDMode="Static"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style11">
                        <asp:Label ID="Label8" runat="server" Text="Confirm Password: "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox ID="tb_cfmPassword" runat="server" TextMode="Password" onkeyup="javascript:validate()" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lbl_cfmchecker" runat="server" ForeColor="#CC3300" ClientIDMode="Static"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style9">Password must have at least:<br />
                        •
                    8 Digits<br />
                        • 1 Uppercase &amp; 1 Lowercase letter<br />
                        •
                    1 Special Character<br />
                        •
                    1 Number<br />
                </td>
            </tr>
            <tr>
                <td class="auto-style10">
                    <asp:Label ID="Label6" runat="server" Text="Contact Number: "></asp:Label>
                </td>
                <td class="auto-style12">
                    <asp:TextBox ID="tb_contactnum" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style1">
                    <asp:Label ID="lbl_contactchecker" runat="server" ForeColor="#CC3300"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <asp:Button ID="signup_btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" Enabled="False" ClientIDMode="Static"/>
    <br />
    <asp:Label ID="lbl_submitchecker" runat="server"></asp:Label>

        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />
    </div>
</asp:Content>


<asp:Content ID="ScriptAfterContent" ContentPlaceHolderID="ScriptAfterContent" runat="server">
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LfNt-sZAAAAAFNy9lUXnfG4dp-Hl_Z09yDJnBZO', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</asp:Content>