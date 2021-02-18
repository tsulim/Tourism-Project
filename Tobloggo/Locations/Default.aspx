<%@ Page Title="Locations" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tobloggo.Locations._Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
    <script type="text/javascript">
        window.onload = function () {
            $('.test').on("click", function () {
                $('.active').removeClass("active");
                $(this).addClass("active");
            })
        }

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content">
        <div class="row">
            <div id="sidenav" class="sidenav">
                <a class='<% if (SelectedLoca == "all") { %>active <% } %> test' href="/Locations/all">All</a>
                <a class='<% if (SelectedLoca == "Food") { %>active <% } %>test' href="/Locations/Food">Food</a>
                <a class='<% if (SelectedLoca == "Entertainment") { %>active <% } %>test' href="/Locations/Entertainment">Entertainment</a>
                <a class=<% if (SelectedLoca == "Cultural") { %>active <% } %>'test' href="/Locations/Cultural">Cultural</a>
            </div>
            
            <asp:HiddenField runat="server" ID="hiden" Value="all" ClientIDMode="Static" />

            <div class="vertical-line"></div>
            <div class="col-sm-8 col-md-9 col-lg-10 feed-content justify-content-center align-items-center">
                <%  var allLocations = new Tobloggo.MyDBServiceReference.Service1Client().GetAllAvailLocations();
                    if (SelectedLoca != "all")
                    {
                        allLocations = new Tobloggo.MyDBServiceReference.Service1Client().GetAllTypeLocations(SelectedLoca);
                    }
                    if (allLocations == null || allLocations.Length == 0)
                    { %>
                    <h2>There's no Locations as of now</h2>
                <% } else {
                        for (var locaNum = 0; locaNum < allLocations.Length; locaNum++)
                        {
                            var imgList = allLocations[locaNum].Images.ToString().Split(',').ToList();%>
                            <div class="col-sm-12 col-md-6 col-lg-4 feed-card">
                                <a href="/Locations/Viewing/<%: allLocations[locaNum].Id %>">
                                    <div class="card">
                                        <div class="card-Img">
                                            <img src="/images/<%: imgList[0] %>" class="card-img-top">
                                        </div>
                                        <div class="card-body justify-content-center align-items-center">
                                            <h5 class="card-title"><%: allLocations[locaNum].Name %></h5>
                                        </div>
                                    </div>
                                </a>
                            </div>
                    <% }
                        }%>

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptAfterContent" runat="server">
</asp:Content>
