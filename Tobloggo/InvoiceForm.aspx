<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="InvoiceForm.aspx.cs" Inherits="Tobloggo.InvoiceForm" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="PanelMsgResult" Visible="false" runat="server" CssClass="alert alert-dismissable alert-info">
        <button type="button" class="close" data-dismiss="alert">
            <span aria-hidden="true">&times;</span>
        </button>
        <asp:Label ID="Lbl_Msg" runat="server"></asp:Label>
    </asp:Panel>
    <div style="margin-right: auto; margin-left: auto;">
        <h3>Invoice Management Table</h3>
        <asp:Button ID="btnExport" runat="server" Text="Export data to Excel" OnClick="btnExport_Click" ToolTip="Exports invoice data only displayed in the table. You may choose to filter the data before exporting to Excel." />
        <div id="FormGridViewTools" style="text-align: left;">
            <asp:Label ID="lblFilterMsg" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <asp:Label ID="lblSortMsg" runat="server" ForeColor="Red"></asp:Label>
            <br />
            Sort By: 
            <asp:DropDownList ID="ddlSort" runat="server" Height="25px" Width="137px" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                <asp:ListItem Value="dateDesc">Last Updated (Latest to Oldest) - Default</asp:ListItem>
                <asp:ListItem Value="dateAsc">Last Updated (Oldest to Latest) </asp:ListItem>
                <asp:ListItem Value="idDesc">Booking ID (Highest to Lowest) </asp:ListItem>
                <asp:ListItem Value="idAsc">Booking ID (Lowest to Highest) </asp:ListItem>
            </asp:DropDownList>
            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            Filter Results By:
            <asp:DropDownList ID="ddlFilter" runat="server" Height="25px" Width="132px" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                <asp:ListItem Value="">None - Default</asp:ListItem>
                <asp:ListItem Value="BC">BC Invoice Only </asp:ListItem>
                <asp:ListItem Value="RA">RA Invoice Only </asp:ListItem>
                <asp:ListItem Value="Pending">Pending Only </asp:ListItem>
                <asp:ListItem Value="Sent">Sent Only </asp:ListItem>
            </asp:DropDownList>
            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            Search:
            <asp:TextBox ID="searchBar" runat="server" placeholder="Search by Booking ID, Tour, Customer..." Width="361px"></asp:TextBox>
            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-lg" OnClick="btnSearch_Click"><i class="glyphicon glyphicon-search"></i></asp:LinkButton>

            <br />
            <asp:Label ID="lblMsgResults" runat="server"></asp:Label>

        </div>
        <br />
        <asp:GridView ID="gvInvoice" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid" Style="margin: inherit;"
            OnRowCommand="gvInvoice_RowCommand" OnPageIndexChanging="gvInvoice_PageIndexChanging" Width="1135px" Height="175px" AllowPaging="True"
            EmptyDataText="No Invoice(s) Found.">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="bookingid" HeaderText="Booking ID" ReadOnly="True" />
                <asp:BoundField DataField="tourname" HeaderText="Tour Package" ReadOnly="True" />
                <asp:BoundField DataField="custname" HeaderText="Customer Name" ReadOnly="True" />
                <asp:BoundField DataField="type" HeaderText="Type" ReadOnly="True" />
                <asp:BoundField DataField="createdate" HeaderText="Last Updated" ReadOnly="True" />
                <asp:BoundField DataField="status" HeaderText="Status" ReadOnly="True" />
                <asp:ButtonField ButtonType="Link" CommandName="Update" Text="Update" HeaderText="Actions" />
                <asp:ButtonField ButtonType="Link" CommandName="Send" Text="Send" />

                <%--<asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <button type="button" class="btn btn-default btn-sm">
                            <span class="glyphicon glyphicon-pencil"></span>
                        </button>
                        <button type="button" class="btn btn-default btn-sm">
                            <span class="glyphicon glyphicon-send"></span>
                        </button>      
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
            <HeaderStyle BackColor="#A86EFF" ForeColor="White" Height="40px" VerticalAlign="Middle" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="2" />
            <PagerStyle BackColor="White" />
            <RowStyle BackColor="White" />
        </asp:GridView>
        <br />
        <div style="text-align: right;">
            <asp:Button ID="btnAddInvoice" runat="server" Text="Add New Invoice" Width="150px" OnClick="btnAddInvoice_Click" BackColor="#BB66CC" BorderStyle="None" Font-Bold="True" ForeColor="White" Height="40px" />
        </div>

    </div>
    <style>
        body{
            background-color:#f0e6ff;
        }
    </style>
</asp:Content>
