<%@ Page Title="Create Location" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="CreateLocation.aspx.cs" Inherits="Tobloggo.Locations.CreateLocation" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/Location.css" rel="stylesheet">
    <script type="text/javascript">

        function FileListItems(files) {
            var b = new ClipboardEvent("").clipboardData || new DataTransfer()
            for (var i = 0, len = files.length; i < len; i++) b.items.add(files[i])
            return b.files
        }

        var counter = 0
        var prevFiles = ""
        var files = ""
        var idList = []

        window.onload = function () {

            //Check File API support
            if (window.File && window.FileList && window.FileReader) {
                var filesInput = document.getElementById("locaImages");
                filesInput.addEventListener("change", function (event) {

                    var fileLbl = document.getElementById("lbl_image");
                    fileLbl.textContent = "";

                    if (files != "") {
                        prevFiles = files
                    }

                    files = event.target.files; //FileList object
                    console.log(files);
                    console.log(prevFiles);

                    var joined = Array.from(files)
                    if (prevFiles != "") {
                        joined = Array.from(prevFiles).concat(Array.from(files));
                        filesInput.files = new FileListItems(joined)
                        console.log(filesInput.files)
                    }

                    if (!arraysMatch(files, prevFiles)) {
                        var output = document.getElementById("imageresult");
                        for (var i = 0; i < files.length; i++) {
                            var file = files[i];
                            //Only pics
                            if (!file.type.match('image'))
                                continue;
                            var picReader = new FileReader();

                            idList.push(counter);

                            console.log(file.name + " here");

                            picReader.addEventListener("load", function (event) {
                                var picFile = event.target;
                                var div = document.createElement("div");
                                //div.innerHTML = "<img class='thumbnail' src='" + picFile.result + "'" +
                                //    "title='" + picFile.name + "'/> " +
                                //    "<input id = 'Button" + counter + "' type = 'button'" + "value = 'Remove' onclick = 'RemoveFileUpload(this)' /> ";

                                div.innerHTML = '<img class="thumbnail" src="' + picFile.result + '"' +
                                    'title="' + file.name + '"/>' +
                                    '<input id="Button' + counter + '" type="button" ' +
                                    'value="Remove" onclick = "RemoveFileUpload(this)" />';
                                output.insertBefore(div, null);
                                counter++;
                            });
                            //Read the image
                            picReader.readAsDataURL(file);
                        }
                    }
                    files = joined;
                });
            } else {
                console.log("Your browser does not support File API");
            }
        }

        function arraysMatch(arr1, arr2) {
            // Check if the arrays are the same length
            if (arr1.length !== arr2.length) return false;

            // Check if all items exist and are in the same order
            for (var i = 0; i < arr1.length; i++) {
                if (arr1[i] !== arr2[i]) return false;
            }

            // Otherwise, return true
            return true;
        }

        function RemoveFileUpload(imgBtn) {
            var imgID = parseInt(imgBtn.id.slice(6));
            var filePos = idList.indexOf(imgID);

            var fileInput = document.getElementById("locaImages");
            var currentFiles = Array.from(fileInput.files);

            currentFiles.splice(filePos, 1);
            idList.splice(filePos, 1);
            
            fileInput.files = new FileListItems(currentFiles);

            files = currentFiles
            prevFiles = ""

            document.getElementById("imageresult").removeChild(imgBtn.parentNode);
        }

        function removeItem(e) {
            var itemTable = document.getElementById("itemTable");

            var trLen = itemTable.getElementsByTagName("tr").length;
            // Check if the table has more than 2 rows (Header + 1 Data Row)
            // If more than 2 rows, delete the selected row
            // Else only clear the contents in the first row
            if (trLen > 2) {
                var td = e.parentNode;

                var reCreateTd = document.createElement("td");
                reCreateTd.innerHTML = td.innerHTML;

                // remove the row
                e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);

                // check if that row has the add function
                // If it has more than 2 button in the td
                // add the add button to the previous tr
                if (reCreateTd.childElementCount == 2) {
                    var secondLastItem = itemTable.getElementsByTagName("tr").item(trLen - 2);
                    var lastCell = secondLastItem.getElementsByTagName("td").item(2);

                    lastCell.innerHTML = '<button type="button" class="btn btn-outline-success" onclick="addItem(this)"><i class="fa fa-plus"></i></button> ' + lastCell.innerHTML;
                }
            } else {
                var lastItem = itemTable.getElementsByTagName("tr").item(trLen - 1);

                var firstCell = lastItem.getElementsByTagName("td").item(0);
                firstCell.getElementsByTagName("input").item(0).value = "";

                var secondCell = lastItem.getElementsByTagName("td").item(1);
                secondCell.getElementsByTagName("input").item(0).value = "";
            }

        }

        var itemCount = 1
        function addItem(e) {
            itemCount ++
            var tr = document.createElement("tr");

            tr.innerHTML = '<td><input type="text" name="multipleItemName' + itemCount + '" id="multipleItemName' + itemCount + '" class="form-control" placeholder="Enter item name"></td><td>' +
                '<input type="text" name="multipleItemPrice' + itemCount + '" id="multipleItemPrice' + itemCount + '" class="form-control" placeholder="$ Input"></td>' +
                '<td><button type="button" class="btn btn-outline-success" onclick="addItem(this)"><i class="fa fa-plus"></i></button> <button type="button" class="btn btn-outline-danger" onclick="removeItem(this)"><i class="fa fa-trash"></i></button></td>';

            var td = document.createElement("td");
            td.innerHTML = '<button type="button" class="btn btn-outline-danger" onclick="removeItem(this)"><i class="fa fa-trash"></i></button>';

            var itemTable = document.getElementById("itemTable");

            var trLen = itemTable.getElementsByTagName("tr").length;
            var lastItem = itemTable.getElementsByTagName("tr").item(trLen - 1);

            var lastCell = lastItem.getElementsByTagName("td").item(2);
            lastCell.innerHTML = '<button type="button" class="btn btn-outline-danger" onclick="removeItem(this)"><i class="fa fa-trash"></i></button></td>';
            
            itemTable.appendChild(tr);

            var hideField = document.getElementById("itemCount");
            hideField.value = itemCount;
        }

        function storeContent() {
            $('#<%= hiddenContentField.ClientID %>').val($('#editor .ql-editor').html());
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ul class="breadcrumb">
        <li><a href="/BPartner">Location</a></li>
        <li>Add New Location</li>
    </ul>
    <div class="page-create-content">
        <div class="form-container">
            <h2><%: Title %></h2>
            <div class="form-row row">
                <h4>Location Details</h4>
                <div class="row">
                    <div class="col-6">
                        <div class="form-group">
                            <label for="locaName">Location Name</label>
                            <asp:TextBox ID="locaName" runat="server" CssClass="form-control" placeholder="Enter Location Name" ClientIDMode="Static"></asp:TextBox>
                            <asp:Label ID="lbl_name" runat="server" ClientIDMode="Static"></asp:Label>

                            <%--                            <input class="form-control" id="locaName" name="locaName" type="text" placeholder="Enter Location Name" />--%>
                        </div>
                        <div class="form-group">
                            <label for="locaAddress">Location Address</label>
                            <asp:TextBox ID="locaAddress" runat="server" CssClass="form-control" placeholder="Enter Location Address" ClientIDMode="Static"></asp:TextBox>
                            <asp:Label ID="lbl_addr" runat="server" ClientIDMode="Static"></asp:Label>
                            <%--                            <input class="form-control" id="locaAddress" name="locaAddress" type="text" placeholder="Enter Location Address" />--%>
                        </div>
                        <div class="form-group">
                            <label for="locaDetails">Location Details</label>
                            <%--<textarea class="form-control" id="locaDetails" name="locaDetails" placeholder="Enter Location Details"></textarea>--%>
                            <!-- Include stylesheet -->

                            <asp:HiddenField ID="hiddenContentField" runat="server" ClientIDMode="Static" />


                            <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

                            <!-- Create the editor container -->
                            <div id="editor" runat="server" ClientIDMode="Static"></div>
                            <asp:Label ID="lbl_detail" runat="server" ClientIDMode="Static"></asp:Label>

                            <!-- Include the Quill library -->
                            <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

                            <!-- Initialize Quill editor -->
                            <script>
                                var quill = new Quill('#editor', {
                                    placeholder: 'Enter Location Details..',
                                    theme: 'snow'
                                });

                                $('#editor .ql-editor').on('keypress keyup keydown', function (e) {
                                    const CHARS_NOT_ALLOWED = /[<>]/;
                                    if (CHARS_NOT_ALLOWED.test(e.key)) {
                                        e.preventDefault();
                                    }

                                    var detailText = $('#editor .ql-editor').text();

                                    if (detailText.search(/(?=.*[<>])/) != -1) {
                                        $('#editor .ql-editor').text(detailText.split("<").join("").split(">").join(""));
                                    } else if (detailText.search("&lt;") != -1) {
                                        $('#editor .ql-editor').text(detailText.split("&lt;").join(""));
                                    } else if (detailText.search("&gt;") != -1) {
                                        $('#editor .ql-editor').text(detailText.split("&gt;").join(""));
                                    }
                                })
                            </script>
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
                            <asp:Label ID="lbl_type" runat="server" ClientIDMode="Static"></asp:Label>
                        </div>
                        <div class="form-group form-images">
                            <label for="locaImages">Location Images</label><br />
                            <p class="uploadInfo">Please upload .jpg or .png files that are under 1MB</p>
                            <asp:FileUpload ID="locaImages" runat="server" AllowMultiple="true" ClientIDMode="Static" />
                            <%--<input type="file" id="locaImages" name="locaImages" multiple/>--%>

                            <output id="imageresult" runat="server" clientidmode="Static" />

                            <asp:Label ID="lbl_image" runat="server" ClientIDMode="Static" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <h4>Item Details</h4>
                <div class="row" id="itemInfo" clientidmode="Static" runat="server">
                    <div id="optionsInfo" clientidmode="Static" runat="server">

                        <asp:HiddenField ID="itemCount" Value="1" runat="server" ClientIDMode="Static" />
                        
                        <table class="auto-style1" id="itemTable" runat="server" ClientIDMode="Static">
                            <tbody>
                                <tr>
                                    <td>Name</td>
                                    <td>
                                        Price
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" name="multipleItemName1" id="multipleItemName1" class="form-control" placeholder="Enter item name">
                                    </td>
                                    <td>
                                        <input type="text" name="multipleItemPrice1" id="multipleItemPrice1" class="form-control" placeholder="$ Input">
                                    </td>
                                    <td>
                                        <button type="button" runat="server" class="btn btn-outline-success" ClientIdMode="Static" onclick="addItem(this)" visible="true"><i class="fa fa-plus"></i></button>
                                        <button type="button" runat="server" class="btn btn-outline-danger" ClientIdMode="Static" onclick="removeItem(this)" visible="true"><i class="fa fa-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div id="bottomLoca">
                <asp:HyperLink ID="cancelBtn" runat="server" Text="Cancel" CssClass="btn btn-outline-danger" NavigateUrl="~/BPartner" ClientIDMode="Static" />
                <asp:Button ID="addBtn" runat="server" Text="Add" CssClass="btn btn-primary" ClientIDMode="Static" OnClick="btnAdd_onClick" OnClientClick="storeContent();" />
            </div>
        </div>
    </div>
</asp:Content>
