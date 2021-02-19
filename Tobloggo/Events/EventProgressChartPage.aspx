<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="EventProgressChartPage.aspx.cs" Inherits="Tobloggo.Events.EventProgressChartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >

    <asp:HiddenField ID="eventProgressChartPageHiddenValue" runat="server" ClientIDMode="Static"/>

    <div class="container" style="margin-top: 10px;">

        <asp:Label ID="eventTitle" runat="server" Text="" Font-Size="33pt" Font-Bold="True"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="@" Font-Size="33pt" Font-Bold="True" ></asp:Label>
        <asp:Label ID="eventLocation" runat="server" Text="" Font-Size="33pt" Font-Bold="True"></asp:Label>
        <br />
    
        <asp:Label ID="Label2" runat="server" Text="Status: " Font-Size="16pt" Font-Bold="True"></asp:Label>
        <asp:Label ID="eventStatus" runat="server" Text="" Font-Size="16pt" Font-Bold="True"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Event Manager: " Font-Size="16pt" Font-Bold="True"></asp:Label>
        <asp:Label ID="eventManager" runat="server" Text="" Font-Size="16pt" Font-Bold="True"></asp:Label>
        <asp:Label ID="eventManagerEmail" runat="server" Text="" Font-Size="16pt" Font-Bold="True"></asp:Label>
        <br />

        <div class="d-flex flex-row mt-2">
            <div class="d-flex flex-column align-items-center mx-3">
                <asp:Label ID="Label4" runat="server" Text="Total Progress" Font-Size="16pt"></asp:Label>
                <asp:Label ID="totalProgress" runat="server" Text="100%" Font-Size="50pt"></asp:Label>
            </div>
            <div class="d-flex flex-column align-items-center mx-3">
                <asp:Label ID="Label5" runat="server" Text="Days Remaining" Font-Size="16pt"></asp:Label>
                <asp:Label ID="daysRemaining" runat="server" Text="0" Font-Size="50pt"></asp:Label>
            </div>
        </div>

        <div class="d-flex flex-row w-100 justify-content-between">
            <div class="d-flex flex-column justify-content-end">
                <div class="d-flex flex-row justify-content-end">
                    <asp:Label ID="Label6" runat="server" Text="Preparation Start Date: " Font-Size="12pt"></asp:Label>
                    <asp:Label ID="preparationStartDate" runat="server" Text="13/01/2002" Font-Size="12pt"></asp:Label>
                </div>
                <div class="d-flex flex-row justify-content-end">
                    <asp:Label ID="Label7" runat="server" Text="Preparation End Date: " Font-Size="12pt"></asp:Label>
                    <asp:Label ID="preparationEndDate" runat="server" Text="13/01/2002" Font-Size="12pt"></asp:Label>
                </div>
            </div>
            <div class="d-flex flex-column justify-content-end">
                <div class="d-flex flex-row justify-content-end">
                    <asp:Label ID="Label8" runat="server" Text="Event Start Date: " Font-Size="12pt"></asp:Label>
                    <asp:Label ID="eventStartDate" runat="server" Text="13/01/2002" Font-Size="12pt"></asp:Label>
                </div>
                <div class="d-flex flex-row justify-content-end">
                    <asp:Label ID="Label10" runat="server" Text="Event End Date: " Font-Size="12pt"></asp:Label>
                    <asp:Label ID="eventEndDate" runat="server" Text="13/01/2002" Font-Size="12pt"></asp:Label>
                </div>
            </div>
            <div class="d-flex flex-column justify-content-end">
                <div class="d-flex flex-row justify-content-end align-items-center">
                    <asp:Label ID="Label9" runat="server" Text="Actual Work Done: " Font-Size="12pt"></asp:Label>
                    <div class="progress" style="width:40px; height: 15px;">
                      <div class="progress-bar" role="progressbar" aria-valuenow="50"
                      aria-valuemin="0" aria-valuemax="100" style="background-color:#4DFF6D; width:50%"></div>
                    </div>
                </div>
                <div class="d-flex flex-row justify-content-end align-items-center">
                    <asp:Label ID="Label12" runat="server" Text="Expected Work Done: " Font-Size="12pt"></asp:Label>
                    <div class="progress" style="width:40px; height: 15px;">
                      <div class="progress-bar" role="progressbar" aria-valuenow="50"
                      aria-valuemin="0" aria-valuemax="100" style="background-color:#FFD666; width:50%"></div>
                    </div>
                </div>
            </div>
            <div class="d-flex flex-column justify-content-end">
                <asp:HyperLink ID="progressLinkCreateTeam" runat="server">
                    <div class="d-flex flex-row justify-content-end align-items-center">
                        <i class="fa fa-plus mx-1" style="font-size: 18px"></i>
                        <asp:Label ID="Label15" runat="server" Text="Add New Team" Font-Size="18pt"></asp:Label>
                    </div>
                </asp:HyperLink>

                
                <asp:HyperLink ID="progressLinkEdit" runat="server">
                    <div class="d-flex flex-row justify-content-end align-items-center">
                        <i class="fa fa-edit mx-2" style="font-size:18px;"></i>
                        <asp:Label ID="Label17" runat="server" Text="Edit Event Details" Font-Size="18pt"></asp:Label>
                    </div>
                </asp:HyperLink>

            </div>
        </div>

        <hr class="my-1"/>

        <div class="d-flex flex-row justify-content-between">
            <asp:Label class="mx-2" ID="Label18" runat="server" Text="Team Name" Font-Size="12pt"></asp:Label>
            <asp:Label class="mx-2" ID="Label19" runat="server" Text="Work Progress (1 Unit ≈ 1 Day)" Font-Size="12pt"></asp:Label>

        </div>
        
        <hr class="my-1"/>
        
        <asp:Repeater ID="TeamRepeater" runat="server">
            <ItemTemplate>

                <div class="d-flex flex-column my-2">

                
                    <div class="d-flex flex-row align-items-center">
                        <asp:Label class="mr-2" ID="Label11" runat="server" Font-Size="18pt"><%# Eval("TeamName") %></asp:Label>
                        
                        <asp:HyperLink ID="editTeamButton" href='<%# GetRouteUrl("EventTeamPageRoute", new { teamId = Eval("Id") }) %>' runat="server">
                            <i class="fa fa-edit mx-2" style="font-size:18px;"></i>
                        </asp:HyperLink>
                        
                        
                        <asp:LinkButton runat="server"  href='<%# GetRouteUrl("EventTeamDeleteRoute", new { teamId = Eval("Id") }) %>'><i class="fa fa-trash mx-2" style="font-size:18px;"></i></asp:LinkButton>
                    </div>
                    

                    <div class="d-flex flex-row align-items-center">
                        <div class="d-flex justify-content-end col-sm-1" >
                            <asp:Label ID="Label13" runat="server" Font-Size="12pt">Actual:</asp:Label>
                        </div>
                        <div class="progress" style="height: 15px; flex-grow: 100;">
                            <div class="progress-bar" role="progressbar" aria-valuenow="50"
                            aria-valuemin="0" aria-valuemax="100" style="background-color:#4DFF6D; width:<%# Eval("ActualPercent") %>%"></div>
                        </div>
                        <asp:Label class="col-sm-1" ID="Label20" runat="server" Font-Size="12pt"><%# Eval("ActualPercent") %>%</asp:Label>
                    </div>

                    <div class="d-flex flex-row align-items-center">
                        <div class="d-flex justify-content-end col-sm-1" >
                            <asp:Label ID="Label14" runat="server" Font-Size="12pt">Expected:</asp:Label>
                        </div>
                        <div class="progress" style="height: 15px; flex-grow: 100;">
                            <div class="progress-bar" role="progressbar" aria-valuenow="50"
                            aria-valuemin="0" aria-valuemax="100" style='background-color:#FFD666; width:<%# Eval("ExpectedPercent") %>%'></div>
                        </div>
                        <asp:Label class="col-sm-1" ID="Label16" runat="server" Font-Size="12pt"><%# Eval("ExpectedPercent") %>%</asp:Label>
                    </div>

                </div>

            </ItemTemplate>
        </asp:Repeater>

        <hr />

        

    </div>


</asp:Content>
