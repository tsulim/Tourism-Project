<%@ Page Title="ViewTour" Language="C#" MasterPageFile="~/Site.Master" CodeBehind="ViewTour.aspx.cs" Inherits="Tobloggo.ViewTour" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-sm-8">
            <asp:Panel ID="PanelErrorResult" Visible="false" runat="server" CssClass="alert alert-dismissable alert-danger">
                <button type="button" class="close" data-dismiss="alert">
                    <span aria-hidden="true">&times;</span>
                </button>
                <asp:Label ID="Lbl_err" runat="server"></asp:Label>
            </asp:Panel>
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Search Tour Package</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <asp:Label ID="lbTitle" runat="server" Text="Title:"></asp:Label>
                        <asp:TextBox ID="tbTitle" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnGetTour" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnGetTour_Click" />
                </div>
            </div>
            <asp:Panel ID="PanelCust" Visible="false" runat="server">
                <div class="panel panel-info">
                    <div class="panel-heading">Results:</div>
                    <div class="panel-body">
                        <div class="row">
                            <label for="Lbl_Title" class="col-sm-2 col-form-label">Title :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_title" runat="server"></asp:Label>
                            </div>
                            <label for="Lbl_Image" class="col-sm-2 col-form-label">Image :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_image" runat="server"></asp:Label>
                            </div>
                            <label for="Lbl_Details" class="col-sm-2 col-form-label">Details :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_details" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <label for="Lbl_StartDT" class="col-sm-2 col-form-label">Start Date Time :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_startDT" runat="server"></asp:Label>
                            </div>
                            <label for="Lbl_EndDT" class="col-sm-2 col-form-label">End Date Time :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_endDT" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <label for="Lbl_Price" class="col-sm-2 col-form-label">Price :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_price" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <label for="Lbl_MinPpl" class="col-sm-2 col-form-label">Minimum number of people :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_minPpl" runat="server"></asp:Label>
                            </div>
                            <label for="Lbl_MaxPpl" class="col-sm-2 col-form-label">Maximum number of people :</label>
                            <div class="col-sm-4">
                                <asp:Label ID="Lbl_maxPpl" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <label for="Lbl_Iti" class="col-sm-2 col-form-label">Itinerary :</label>
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
            <asp:ImageField DataImageUrlField="Image" HeaderText="Image" ControlStyle-CssClass="img" ></asp:ImageField>  
            <asp:BoundField DataField="Details" HeaderText="Details" ReadOnly="True" />
            <asp:BoundField DataField="DateTime" HeaderText="Date Time" ReadOnly="True" />
            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" />
            <asp:BoundField DataField="MinPeople" HeaderText="Minimum Number of People" ReadOnly="True" />
            <asp:BoundField DataField="MaxPeople" HeaderText="Maximium Number of People" ReadOnly="True" />
            <asp:BoundField DataField="Itinerary" HeaderText="Itinerary" ReadOnly="True" />
        </Columns> 
    </asp:GridView>

</asp:Content>
