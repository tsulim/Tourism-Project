<%@ Page Title="Tour" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ATour.aspx.cs" Inherits="Tobloggo.ATour" %> 
 
<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server"> 
    <div class="row"> 
        <div class="col-sm-12"> 
            <asp:Panel ID="PanelCust" runat="server"> 
                <div class="panel panel-primary"> 
                    <div class="panel-heading" style="text-align: center;"> 
                        <div style="text-align: center;"> 
                            <asp:Label ID="Lbl_title" runat="server" Font-Bold="True" Font-Size="36px"></asp:Label> 
                        </div> 
                    </div> 
                    <div class="panel-body"> 
                        <div class="row"> 
                            <div class="col-sm-12"></div> 
                            <asp:Image ID="Image1" runat="server" Style="display: block; margin-left: auto; margin-right: auto; height: 500px; width: 1000px;" /> 
                            <br /> 
                        </div> 
 
                        <div class="row"> 
                            <asp:Label ID="Lbl_details" runat="server"></asp:Label> 
                        </div> 
                        <div class="row"> 
                            <asp:Label ID="Lbl_DT" runat="server"></asp:Label> 
 
                        </div> 
                        <div class="row"> 
                            $<asp:Label ID="Lbl_price" runat="server"></asp:Label> 
                        </div> 
                        <div class="row"> 
                            <asp:Label ID="Lbl_iti" runat="server"></asp:Label> 
                        </div> 
                    </div> 
                </div> 
            </asp:Panel> 
            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" /> 
        </div> 
    </div> 
</asp:Content> 
