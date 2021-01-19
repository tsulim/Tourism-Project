<%@ Page Title="Add New Location" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateLocation.aspx.cs" Inherits="Tobloggo.CreateLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
    <script type="text/javascript">
        window.onload = function () {
            //Check File API support
            if (window.File && window.FileList && window.FileReader) {
                var filesInput = document.getElementById("locaImages");
                filesInput.addEventListener("change", function (event) {
                    var files = event.target.files; //FileList object
                    var output = document.getElementById("image-result");
                    for (var i = 0; i < files.length; i++) {
                        var file = files[i];
                        //Only pics
                        if (!file.type.match('image'))
                            continue;
                        var picReader = new FileReader();
                        picReader.addEventListener("load", function (event) {
                            var picFile = event.target;
                            var div = document.createElement("div");
                            div.innerHTML = "<img class='thumbnail' src='" + picFile.result + "'" +
                                "title='" + picFile.name + "'/>";
                            output.insertBefore(div, null);
                        });
                        //Read the image
                        picReader.readAsDataURL(file);
                    }
                });
            } else {
                console.log("Your browser does not support File API");
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ul class="breadcrumb">
        <li><a href="#">Location</a></li>
        <li>Add New Location</li>
    </ul>
    <div class="page-content">
        <div class="form-container">
            <h2><%: Title %></h2>
            <div class="form-row row">
                <h4>Location Details</h4>
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="locaName">Location Name</label>
                            <asp:TextBox ID="locaName" runat="server" CssClass="form-control" placeholder="Enter Location Name" ClientIDMode="Static"></asp:TextBox>
<%--                            <input class="form-control" id="locaName" name="locaName" type="text" placeholder="Enter Location Name" />--%>
                        </div>
                        <div class="form-group">
                            <label for="locaAddress">Location Address</label>
                            <asp:TextBox ID="locaAddress" runat="server" CssClass="form-control" placeholder="Enter Location Address" ClientIDMode="Static"></asp:TextBox>
<%--                            <input class="form-control" id="locaAddress" name="locaAddress" type="text" placeholder="Enter Location Address" />--%>
                        </div>
                        <div class="form-group">
                            <label for="locaDetails">Location Details</label>
                            <asp:TextBox ID="locaDetails" runat="server" CssClass="form-control" placeholder="Enter Location Details" TextMode="MultiLine" ClientIDMode="Static"></asp:TextBox>
                            <%--<textarea class="form-control" id="locaDetails" name="locaDetails" placeholder="Enter Location Details"></textarea>--%>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="locaType">Location Type</label>
                            <%--<select class="form-control" id="locaType" name="locaType">
                                <option value="">-Select a Type-</option>
                                <option value="food">Food</option>
                                <option value="entertainment">Entertainment</option>
                                <option value="cultural">Cultural</option>
                            </select>--%>
                            <asp:DropDownList ID="locaType" runat="server">
                                <asp:ListItem Value="-1">--Select--</asp:ListItem>
                                <asp:ListItem Value="Food">Food</asp:ListItem>
                                <asp:ListItem Value="Entertainment">Entertainment</asp:ListItem>
                                <asp:ListItem Value="Cultural">Cultural</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group form-images">
                            <label for="locaImages">Location Images</label><br />
                            <p class="uploadInfo">Please upload .jpg or .png files that are under 1MB</p>
                            <asp:FileUpload ID="locaImages" runat="server" AllowMultiple="true" />
                            <%--<input type="file" id="locaImages" name="locaImages" multiple/>--%>
                            <output id="image-result"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <h4>Item Details</h4>
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="itemName">Item Name</label>
                            <asp:TextBox ID="itemName" runat="server" CssClass="form-control" placeholder="Enter item name" ClientIDMode="Static"></asp:TextBox>
                            <%--<input class="form-control" id="itemName" name="itemName" type="text" placeholder="Enter item name" />--%>
                        </div>
                        <div class="form-group">
                            <label for="itemPrice">Price</label>
                            <asp:TextBox ID="itemPrice" runat="server" CssClass="form-control" placeholder="$ Input" ClientIDMode="Static"></asp:TextBox>
<%--                            <input class="form-control" id="itemPrice" name="itemPrice" type="text" placeholder="$ Input" />--%>
                        </div>
                        <div class="form-group">
                            <label for="itemOption">Options</label>
                            <asp:Button ID="enableOption" runat="server" Text="Enable Options" CssClass="btn btn-outline-info" ClientIDMode="Static" />
                            <asp:Button ID="noItem" runat="server" Text="No Item" CssClass="btn btn-danger" ClientIDMode="Static" />
<%--                            <button class="btn btn-outline-info" type="button" id="enableOption">Enable Options</button>
                            <button class="btn btn-danger" type="button" id="noItem">No Item</button>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div id="bottomLoca">
                <asp:HyperLink ID="cancelBtn" runat="server" Text="Cancel" CssClass="btn btn-outline-danger" NavigateUrl="~/WebForm1.aspx" ClientIDMode="Static" />
                <asp:Button ID="addBtn" runat="server" Text="Add" CssClass="btn btn-primary" ClientIDMode="Static" OnClick="btnAdd_onClick" />
<%--                <button class="btn btn-outline-danger" type="button">Cancel</button>
                <button class="btn btn-primary" type="button" onclick="btnAdd_onClick">Add</button>--%>
            </div>
            <div class="form-row row">
                <asp:Label ID="lbl_name" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label ID="lbl_address" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label ID="lbl_type" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label ID="lbl_images" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label ID="lbl_status" runat="server" ClientIDMode="Static"></asp:Label>
                <asp:Label ID="lbl_userid" runat="server" ClientIDMode="Static"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
