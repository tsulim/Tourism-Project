<%@ Page Title="ViewTour" Language="C#" MasterPageFile="~/Site.Master" CodeBehind="ViewTour.aspx.cs" Inherits="Tobloggo.ViewTour" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <asp:Panel ID="PanelErrorResult" Visible="false" runat="server" CssClass="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">
                    <span aria-hidden="true">&times;</span>
                </button>
                <asp:Label ID="Lbl_err" runat="server"></asp:Label>
            </asp:Panel>
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h6 class="panel-title" style="text-align: center;">Search Tour Package</h6>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <asp:Label ID="lbTitle" runat="server" Text="Title:"></asp:Label>
                        <asp:TextBox ID="tbTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnGetTour" runat="server" Text="Search" OnClick="btnGetTour_Click" BackColor="#C3B1E1" ForeColor="White" BorderColor="#C3B1E1" />
                </div>
            </div>
            <asp:Panel ID="PanelCust" Visible="false" runat="server">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="text-decoration: underline; text-align: center;">Results</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <div style="text-align:center;">
                                    <asp:Label ID="Lbl_title" runat="server" Font-Bold="True" Font-Size="36px"></asp:Label>
                                </div>
                                <asp:Image ID="Image1" runat="server" Style="display: block; margin-left: 50px; margin-right: 50px; height: 500px; width: 1000px;" />
                                <br />
                            </div>
                        </div>
                        <div class="row;">
                            <asp:Label ID="Lbl_details" runat="server"></asp:Label>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_DT" runat="server"></asp:Label>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_price" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_iti" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>

    <asp:GridView ID="gvTour" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid" HorizontalAlign="Center">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Name" ReadOnly="True" />
            <asp:ImageField DataImageUrlField="Image" HeaderText="Image" ControlStyle-CssClass="img"></asp:ImageField>
            <asp:BoundField DataField="Details" HeaderText="Details" ReadOnly="True" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="DateTime" HeaderText="Date Time" ReadOnly="True" />
            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" />
            <asp:BoundField DataField="MinPeople" HeaderText="Minimum No. of People" ReadOnly="True" HeaderStyle-Width="10px" />
            <asp:BoundField DataField="MaxPeople" HeaderText="Maximum No. of People" ReadOnly="True" HeaderStyle-Width="10px" />
            <asp:BoundField DataField="Itinerary" HeaderText="Itinerary" ReadOnly="True" HeaderStyle-Width="30px" />
        </Columns>
    </asp:GridView>
</asp:Content>
