<%@ Page Title="Add New Location" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateLocation.aspx.cs" Inherits="Tobloggo.CreateLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
    <script type="text/javascript">
        //function readURL(input) {
        //    if (input.files && input.files.length > 0) {
        //        for (var i = 0; i < input.files.length; i++) {
        //            var reader = new FileReader();
        //            $('#image-result').empty();
        //            reader.onload = function (e) {
        //                $('#image-result').attr('src', e.target.result);
        //                ${ '#image-result' }.append($("<img class='thumbnail' src='" + e.target.result + "' title = '" + e.target.name + "'/>"))
        //            }
        //            reader.readAsDataURL(input.files[i]);
        //        }
        //    }
        //}
        //$("#locaImages").change(function () {
        //    readURL(this);
        //})
        var counter = 0;
        window.onload = function () {
            //Check File API support
            if (window.File && window.FileList && window.FileReader) {
                var filesInput = document.getElementById("locaImages");
                filesInput.addEventListener("change", function (event) {
                    var files = event.target.files; //FileList object
                    var output = document.getElementById("imageresult");

                    output.innerHTML = "";
                    for (var i = 0; i < files.length; i++) {
                        var file = files[i];
                        //Only pics
                        if (!file.type.match('image'))
                            continue;
                        var picReader = new FileReader();

                        picReader.addEventListener("load", function (event) {
                            var picFile = event.target;
                            var div = document.createElement("div");
                            //div.innerHTML = "<img class='thumbnail' src='" + picFile.result + "'" +
                            //    "title='" + picFile.name + "'/> " +
                            //    "<input id = 'Button" + counter + "' type = 'button'" + "value = 'Remove' onclick = 'RemoveFileUpload(this)' /> ";

                            div.innerHTML = '<img class="thumbnail" src="' + picFile.result + '"' +
                                'title="' + picFile.name + '"/>' +
                                '<input id = "file' + counter + '" name = "file' + counter +
                                '" type="file" hidden="true" value="' + picFile.result + '" />' +
                                '<input id="Button' + counter + '" type="button" ' +
                                'value="Remove" onclick = "RemoveFileUpload(this)" />';
                            output.insertBefore(div, null);
                        });
                        //Read the image
                        picReader.readAsDataURL(file);
                        counter++;
                    }
                });
            } else {
                console.log("Your browser does not support File API");
            }
        }

        //window.onload = function () {
        //    if (window.File && window.FileList && window.FileReader) {
        //        for (var i = 1; i < 6; i++) {
        //            var imageInput = document.getElementById("locaImage" + i);
        //            imageInput.addEventListener("change", function (event) {
        //                var file = event.target.files[0];
        //                var output = document.getElementById("displayImage" + i);

        //                var picReader = new FileReader();

        //                picReader.addEventListener("load", function (event) {
        //                    var picFile = event.target;

        //                    output.src = event.target.result;
        //                    //var img = document.createElement("img");
        //                    //img.classList.add("thumbnail");
        //                    //img.src = picFile.result;

        //                    //imageInput.insertBefore(img, null);
        //                })
        //                picReader.readAsDataURL(file);
        //            });
        //        }
        //    } else {
        //        console.log("Your browser does not support File API");
        //    }
        //}

        function RemoveFileUpload(div) {
            document.getElementById("imageresult").removeChild(div.parentNode);
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
                            <asp:FileUpload ID="locaImages" runat="server" AllowMultiple="true" ClientIDMode="Static" />
                            <%--<input type="file" id="locaImages" name="locaImages" multiple/>--%>

                            <output id="imageresult" runat="server" clientidmode="Static" />

                            <asp:Label ID="test" runat="server" ClientIDMode="Static" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <h4>Item Details</h4>
                <div class="row" id="itemInfo" clientidmode="Static" runat="server">
                    <div class="col-6" id="optionsInfo" clientidmode="Static" runat="server">
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
                            <asp:Button ID="enableOption" runat="server" Text="Enable Options" CssClass="btn btn-outline-info" ClientIDMode="Static" OnClick="enableOptions" />
                            <asp:Button ID="noItem" runat="server" Text="No Item" CssClass="btn btn-danger" ClientIDMode="Static" OnClick="noItemBtn" />
                            <%--                            <button class="btn btn-outline-info" type="button" id="enableOption">Enable Options</button>
                            <button class="btn btn-danger" type="button" id="noItem">No Item</button>--%>
                        </div>
                    </div>
                    <div id="noItemOptions" clientid="Static" runat="server" visible="false">
                        <asp:Button ID="Button1" runat="server" Text="Enable Options" CssClass="btn btn-outline-info" ClientIDMode="Static" OnClick="enableOptions" />
                    </div>
                    <div id="moreOptions" clientidmode="Static" runat="server" visible="false">
                        <h2>test</h2>
                    </div>
                </div>
            </div>
            <div id="bottomLoca">
                <asp:HyperLink ID="cancelBtn" runat="server" Text="Cancel" CssClass="btn btn-outline-danger" NavigateUrl="~/WebForm1.aspx" ClientIDMode="Static" />
                <asp:Button ID="addBtn" runat="server" Text="Add" CssClass="btn btn-primary" ClientIDMode="Static" OnClick="btnAdd_onClick" />
                <%--                <button class="btn btn-outline-danger" type="button">Cancel</button>
                <button class="btn btn-primary" type="button" onclick="btnAdd_onClick">Add</button>--%>
            </div>
        </div>
    </div>
</asp:Content>
