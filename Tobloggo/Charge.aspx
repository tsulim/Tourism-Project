<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Charge.aspx.cs" Inherits="Tobloggo.Charge" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptHeadContent" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-create-content">
        <div class="form-container">
            <h2><%: Title %></h2>
            <div class="form-row row">
                <div class="row justify-content-center align-content-center">
                    <div class="col-12">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <asp:TextBox ID="email" runat="server" CssClass="form-control" placeholder="Enter email" ClientIDMode="Static"></asp:TextBox>
                            <asp:Label ID="lbl_email" runat="server" ClientIDMode="Static"></asp:Label>
                        </div>
                        <div class="form-group">
                            <label for="cardNo">Card Information</label>
                            <asp:TextBox ID="cardNo" runat="server" CssClass="form-control" placeholder="1234 1234 1234 1234" ClientIDMode="Static"></asp:TextBox>
                            <asp:Label ID="lbl_cardNo" runat="server" ClientIDMode="Static"></asp:Label>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <asp:TextBox ID="expDate" runat="server" CssClass="form-control" placeholder="MM / YY" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-group">
                                    <asp:TextBox ID="cvc" runat="server" CssClass="form-control" placeholder="CVC" ClientIDMode="Static"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="name">Name on card</label>
                            <asp:TextBox ID="name" runat="server" CssClass="form-control" placeholder="Enter name on card.." ClientIDMode="Static"></asp:TextBox>
                            <asp:Label ID="lbl_name" runat="server" ClientIDMode="Static"></asp:Label>
                        </div>
                        <asp:LinkButton ID="cancelBtn" runat="server" OnClick="cancelBtn_Click" CssClass="btn btn-outline-danger" ClientIDMode="Static">Cancel</asp:LinkButton>
                        <asp:LinkButton ID="payBtn" runat="server" OnClick="payBtn_Click" CssClass="btn btn-success" ClientIDMode="Static">Pay</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptAfterContent" runat="server">
</asp:Content>
