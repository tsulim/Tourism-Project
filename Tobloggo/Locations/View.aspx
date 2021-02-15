<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View.aspx.cs" Inherits="Tobloggo.Locations.View" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ScriptHeadContent" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script>
        function showDropdown() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function (event) {
            if (!event.target.matches('.dropbtn')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                var i;
                for (i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content">
        <div class="form-container">
            
            <div class="post-row row d-flex">
                <div class="col-sm-12 col-md-4" style="padding-left: 0px; padding-right: 0px;">
                    <% var imgList = SelectedLocation.Images.ToString().Split(',').ToList();
                        var imgListLen = imgList.Count(); %>

                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <% if (imgListLen > 1) {
                                   for (var imgCount = 1; imgCount < imgListLen; imgCount++) {%>
                            <li data-target="#carouselExampleIndicators" data-slide-to="<%: imgCount %>"></li>
                            <%     }
                               } %>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="d-block w-100" src="/images/<%: imgList[0] %>" alt="First slide">
                            </div>
                            <% for (var imgNo = 1; imgNo < imgListLen; imgNo++) { %>
                            <div class="carousel-item">
                                <img class="d-block w-100" src="/images/<%: imgList[imgNo] %>">
                            </div>
                            <% } %>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                </div>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div class="col-11 post-col" style="margin-top: 10px">
                            <h3><%: SelectedLocation.Name %></h3>
                        </div>
                        <div class="col-1 post-col">
                            <div class="dropdown">
                                <!-- three dots -->
                                <ul class="dropbtn icons btn-right showLeft" onclick="showDropdown()">
                                    <li></li>
                                    <li></li>
                                    <li></li>
                                </ul>
                                <!-- menu -->
                                <div id="myDropdown" class="dropdown-content">
                                    <a href="#home">Report</a>
                                    <a href="#" target="_blank">Share to Facebook</a>
                                    <a href="#">Copy Link</a>
                                    <%--<a href="#contact">Contact</a>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-1 post-col"><b>Type:</b></div>
                        <div class="col-11 post-col"><%: SelectedLocation.Type %></div>
                    </div>
                    <div class="row">
                        <div class="col-2"><b>Address:</b></div>
                        <div class="col-12 post-col"><%: SelectedLocation.Address %></div>
                    </div>
                    <div class="row">
                        <div class="col-12 post-col">
                            <b>Description:</b>
                        </div>
                        <div class="col-12 post-col">
                            <div class="alert alert-secondary">
                                <%= SelectedLocation.Details %>
                            </div>
                        </div>
                        <% if (TicketList.Count != 0)
                            {%>
                        <div class="col-12" style="text-align:right; padding-bottom: 10px;">
                            <button type="button" style="text-align:right; padding-bottom: 10px;" class="btn btn-outline-primary" clientidmode="Static"><i class="fa fa-calendar-check"></i> Book</button>
                        </div>
                        <% } %>
                    </div>

                </div>
            </div>

        </div>
    </div>
    
    <hr />

    <div class="page-content">
        <div class="review-container">
            <div class="row post-col">
                <h5>Reviews </h5>
                <button type="button" id="reviewBtn" class="btn btn-secondary" clientidmode="Static">Write Review</button>
            </div>
            <div class="row">
                <div class="col-12 feed-content">

                    <div class="col-sm-12 col-md-6 col-lg-4 feed-card">
                        <div class="card">
                            <%--<div class="card-Img">
                                <img src="/images/.." class="card-img-top">
                            </div>--%>
                            <div class="card-body justify-content-center align-items-center">
                                <h5 class="card-title">Hi</h5>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-6 col-lg-4 feed-card">
                        <div class="card">
                            <%--<div class="card-Img">
                                <img src="/images/.." class="card-img-top">
                            </div>--%>
                            <div class="card-body justify-content-center align-items-center">
                                <h5 class="card-title">Hi</h5>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-6 col-lg-4 feed-card">
                        <div class="card">
                            <div class="card-Img">
                                <img src="/images/.." class="card-img-top">
                            </div>
                            <div class="card-body justify-content-center align-items-center">
                                <h5 class="card-title">Hi</h5>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-6 col-lg-4 feed-card">
                        <div class="card">
                            <div class="card-Img">
                                <img src="/images/.." class="card-img-top">
                            </div>
                            <div class="card-body justify-content-center align-items-center">
                                <h5 class="card-title">Hi</h5>
                            </div>
                        </div>
                    </div>


                </div>

            </div>

            <div class="row alert alert-info justify-content-center align-items-center">

                    No Reviews

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptAfterContent" runat="server">
</asp:Content>
