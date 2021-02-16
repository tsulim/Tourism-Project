<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Successful.aspx.cs" Inherits="Tobloggo.Successful" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptHeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-create-content">
        <div class="form-container">
            <div class="form-row row">
                <div class="row justify-content-center align-content-center">
                    <h3>Payment Successful!</h3>
                    <asp:HyperLink NavigateUrl="/" runat="server" CssClass="btn btn-primary">Back to Home</asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptAfterContent" runat="server">
</asp:Content>
