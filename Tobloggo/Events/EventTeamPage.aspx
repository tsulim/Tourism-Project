<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="EventTeamPage.aspx.cs" Inherits="Tobloggo.Events.EventTeamPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">        
    <script>

        function addItem(e) {
            itemCount++

            var parent = document.getElementById("taskContainer")

            var div = document.createElement("div")
            div.setAttribute("id", "taskRow" + itemCount)

            div.innerHTML = '<div class="d-flex flex-row my-2" >' + 
                '<input class = "col-2 mx-1" name="taskName' + itemCount + '"   ></input >' +
                '<input class="col-5 mx-1" name="taskDesc' + itemCount + '" ></input>' +
                '<input CssClass="col-3 mx-1" name="taskDiff' + itemCount + '"  ></input>' +
                '<div class="col-1 d-flex align-items-center justify-content-center" >' +
                '<input class="h-100 w-100" name="taskComplete' + itemCount + '" type="checkbox" id="flexCheckDefault"  value="0">' +
                '</div>' +

                '<input id="delete' + itemCount + '" name="' + itemCount + '" class="col-1" type="button" onclick="deleteItem(this.id)" value="Delete"></input>' +

                '</div>'

            parent.appendChild(div)


            var hideField = document.getElementById("teamItemCount");
            hideField.value = itemCount;
            console.log(document.getElementById("teamDeleteList").value);

        }

        function deleteItem(id) {
            
            var previousIgnoreList = $.makeArray(document.getElementById("teamDeleteList").value.split(","))
            previousIgnoreList.push(id.slice(6))
            document.getElementById("teamDeleteList").value = previousIgnoreList.join();

            document.getElementById("taskRow" + id.slice(6)).remove();
        }
    </script>

    <div class="container" style="margin-top: 10px;">
        
        <asp:HiddenField ID="teamItemCount" runat="server" ClientIDMode="Static" value=""/>
        <script>
            var itemCount = document.getElementById("teamItemCount").value;
        </script>
        <asp:HiddenField ID="teamDeleteList" runat="server" ClientIDMode="Static" value=""/>

        <div>
            <br />
            <asp:Label ID="editUserTitle" runat="server" Font-Size="Larger" Text="Create Event Team: "></asp:Label>
            <br />
            <br />
            <table id="editUserTable">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Team Name: " Width="272px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="teamName" runat="server" name="teamName"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Team Leader: " Width="272px"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="teamLeaderId" runat="server" name="teamLeader"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Contact Email: "></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="teamContact" runat="server" name="teamContact"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Start Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="date" id="teamStartDate" runat="server" name="teamStart">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="End Date: "></asp:Label>
                    </td>
                    <td>
                        <input type="date" id="teamEndDate" runat="server" name="teamEnd">
                    </td>
                </tr>
            </table>
        </div>


        <div class="d-flex flex-row mt-4">
            <asp:Label class="flex-grow-1" ID="Label14" runat="server" Font-Size="15pt">Tasks</asp:Label>
            <asp:Label ID="Label6" runat="server" Font-Size="15pt">(1 Unit ≈ 1 day)</asp:Label>
        </div>
        <hr />


        

<%--        <div class="d-flex flex-row align-items-center">
            <div class="d-flex justify-content-end col-sm-2" >
                <asp:Label ID="Label13" runat="server" Font-Size="12pt">Actual Work Done:</asp:Label>
            </div>
            <div class="progress mx-3" style="height: 12px; flex-grow: 100;">
                <div ID="actualBarWidth" runat="server" class="progress-bar" role="progressbar" aria-valuenow="50"
                aria-valuemin="0" aria-valuemax="100" style="background-color:#4DFF6D; width:50%"></div>
            </div>  
            <asp:Label ID="actualBarPercentage" runat="server" Font-Size="12pt">0%</asp:Label>
        </div>

            
        <div class="d-flex flex-row align-items-center">
            <div class="d-flex justify-content-end col-sm-2" >
                <asp:Label ID="Label7" runat="server" Font-Size="12pt">Expected Work Done:</asp:Label>
            </div>
            <div class="progress mx-3" style="height: 12px; flex-grow: 100;">
                <div ID="expectedBarWidth" runat="server" class="progress-bar" role="progressbar" aria-valuenow="50"
                aria-valuemin="0" aria-valuemax="100" style="background-color:#FFD666; width:0%"></div>
            </div>
            <asp:Label ID="expectedBarPercentage" runat="server" Font-Size="12pt">0%</asp:Label>
        </div>

        <hr />--%>

        <div class="d-flex flex-row align-items-center">
            <asp:Label CssClass="col-2" ID="Label8" runat="server" Font-Size="14pt">Task Name</asp:Label>
            <asp:Label CssClass="col-5" ID="Label9" runat="server" Font-Size="14pt">Task Description</asp:Label>


            
            <div class="justify-content-end col-3">
                <asp:Label ID="Label10" runat="server" Font-Size="14pt">Task Difficulty (In Units)</asp:Label>
            </div>

            <div class="justify-content-end col-1">
                <asp:Label ID="Label11" runat="server" Font-Size="14pt">Completed</asp:Label>
            </div>
        </div>

        <hr />

        <div id="taskContainer">

<%--       <div class="d-flex flex-row my-2">
                <asp:TextBox CssClass="col-2 mx-1 taskName" ID="TextBox1" runat="server"></asp:TextBox>
                <asp:TextBox CssClass="col-5 mx-1 taskDesc" ID="TextBox2" runat="server"></asp:TextBox>
                <asp:TextBox CssClass="col-3 mx-1 taskDiff" ID="TextBox3" runat="server"></asp:TextBox>

                <div class="col-1 d-flex align-items-center justify-content-center">
                    <input class="h-100 w-100 taskComplete" type="checkbox" id="flexCheckDefault" runat="server" value="0">
                </div>
                
                <input id="delete1" class="col-1" type="button" onclick="deleteItem(this)" value="Delete"></input>

            </div>--%>
            <asp:ListView ID="ListView1" runat="server" DataSourceID="EventTeamPageListView">
                <LayoutTemplate>
                    
                    <div id="itemPlaceholder" runat="server">
                    </div>
                </LayoutTemplate>
                <ItemTemplate>
                    
                    <div id="taskContainer" runat="server">
                        <div id="taskRow<%#Container.DataItemIndex+1 %>">
                            <div class="d-flex flex-row my-2" > 
                                <input class = "col-2 mx-1" name="taskName<%#Container.DataItemIndex+1 %>" value="<%# Eval("Name") %>" ></input > 
                                <input class="col-5 mx-1" name="taskDesc<%#Container.DataItemIndex+1 %>" value="<%# Eval("Description") %>"></input> 
                                <input CssClass="col-3 mx-1" name="taskDiff<%#Container.DataItemIndex+1 %>" value="<%# Eval("Difficulty") %>" ></input> 
                                <div class="col-1 d-flex align-items-center justify-content-center" > 

                                <input class="h-100 w-100" name="taskComplete<%#Container.DataItemIndex+1 %>" type="checkbox" id="flexCheckDefault" <%#((bool)Eval("Completed") == true) ? "checked" : "" %> value="<%# ((bool)Eval("Completed") == true) ? "1" : "0" %>"> 

                                </div> 

                                <input id="delete<%#Container.DataItemIndex+1 %>" name="<%#Container.DataItemIndex+1 %>" class="col-1" type="button" onclick="deleteItem(this.id)" value="Delete"></input> 
                            </div>
                        </div>
                    </div>


                </ItemTemplate>
            </asp:ListView>

            <asp:SqlDataSource ID="EventTeamPageListView" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\TobloggoDB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [Name], [Description], [Difficulty], [Completed] FROM [EventTask] WHERE ([TeamId] = @TeamId)">
                <SelectParameters>
                    <asp:RouteParameter Name="TeamId" RouteKey="teamId" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>


        <div class="d-flex justify-content-center mt-2">
            <input runat="server" id="createTask" type="button" value="+ Add New Task" onclick="addItem(this)"></input>
        </div>

        <hr />


        <div class="d-flex justify-content-end">
            <asp:Button ID="team_create_btn_submit" runat="server" Text="Submit" OnClick="team_create_btn_submit_Click" />
        </div>




    </div>
</asp:Content>
