<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="ViewReport.aspx.cs" Inherits="Tobloggo.ViewReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="ChooseReport" Visible="true" runat="server">
        <h3>Choose Report Type:</h3>
        <asp:Button ID="ViewBKSalesGV" runat="server" Text="Booking Sales" OnClick="ViewBKSalesGV_Click" />
        <asp:Button ID="ViewTourProfitGV" runat="server" Text="Tour Packages Profit" OnClick="ViewTourProfitGV_Click" />
        <br />
    </asp:Panel>

    <asp:Panel ID="PanelSharedView" Visible="false" runat="server">
        <asp:Button ID="btnExport" runat="server" Text="Export data to Excel" ToolTip="Exports all data displayed in the table. You may choose to filter the data before exporting to Excel." OnClick="btnExport_Click" />
        <h3>Viewing <span>
            <asp:Label ID="ReportTitle" runat="server"></asp:Label></span> Report</h3>
        <asp:Label ID="lblMsgResults" runat="server"></asp:Label>

    </asp:Panel>

    <asp:Panel ID="PanelViewBKSales" Visible="false" runat="server">
        <asp:GridView ID="gvBKSales" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid"
            OnPageIndexChanging="gvBKSales_PageIndexChanging" Width="1135px" Height="175px" AllowPaging="True"
            EmptyDataText="No records Found." PageSize="15">
            <Columns>
                <asp:BoundField DataField="bookid" HeaderText="Booking ID" ReadOnly="True" />
                <asp:BoundField DataField="createDate" HeaderText="Date of Booking" ReadOnly="True" />       
                <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />
                <asp:BoundField DataField="TourName" HeaderText="Tour" ReadOnly="True" />
                <asp:BoundField DataField="TourPrice" HeaderText="Base Price ($)" ReadOnly="True" />
                <asp:BoundField DataField="NumAttendees" HeaderText="No. of Attendees/Tickets" ReadOnly="True" />
                <asp:BoundField DataField="TotalAmt" HeaderText="Total Payable" ReadOnly="True" />
            </Columns>
            <HeaderStyle BackColor="#A86EFF" ForeColor="White" Height="40px" VerticalAlign="Middle" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="2" />
            <PagerStyle BackColor="White" />
            <RowStyle BackColor="White" />
        </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="PanelViewTourProfit" Visible="false" runat="server">
        <asp:GridView ID="gvTourProfit" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="myDatagrid"
            OnPageIndexChanging="gvTourProfit_PageIndexChanging" Width="1135px" Height="175px" AllowPaging="True"
            EmptyDataText="No records Found." PageSize="15">
            <Columns>
                <%--<asp:BoundField DataField="tourid" HeaderText="Tour ID" ReadOnly="True" />--%>
                <asp:BoundField DataField="title" HeaderText="Tour" ReadOnly="True" />
                <asp:BoundField DataField="bkconfirmed" HeaderText="Confirmed Bookings" ReadOnly="True" />
                <asp:BoundField DataField="bkrefunded" HeaderText="Refunded Bookings" ReadOnly="True" />
                <asp:BoundField DataField="availslots" HeaderText="Available Slots Left" ReadOnly="True" />
                <asp:BoundField DataField="price" HeaderText="Unit Price ($)" ReadOnly="True" />
                <asp:BoundField DataField="maxpeople" HeaderText="Max. No. of People Per Booking" ReadOnly="True" />
                <asp:BoundField DataField="peakprofit" HeaderText="Targeted Profit ($)" ReadOnly="True" />
                <asp:BoundField DataField="actualprofit" HeaderText="Actual Profit ($)" ReadOnly="True" />
<%--                <asp:BoundField DataField="refundloss" HeaderText="Loss from Refunds ($)" ReadOnly="True" />--%>
            </Columns>
            <HeaderStyle BackColor="#A86EFF" ForeColor="White" Height="40px" VerticalAlign="Middle" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="2" />
            <PagerStyle BackColor="White" />
            <RowStyle BackColor="White" />
        </asp:GridView>
    </asp:Panel>

    <style>
        body{
            background-color:#f0e6ff;
        }
    </style>
   
</asp:Content>
