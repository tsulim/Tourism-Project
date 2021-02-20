<%@ Page Title="" Language="C#" MasterPageFile="~/BackendSite.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Tobloggo.Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.amcharts.com/lib/4/core.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/material.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

    <main>
        <section class="personalmsg">
            <div class="msg">
                <h2 class="card-title darkPurple">Welcome Back!</h2>    
                <h4 class="card-text"><asp:Label runat="server" ID="lblpersonalmsg">There are currently no updates available.</asp:Label></h4>
            </div>

            <div class="card reminders">
                <div class="card-body">
                    <h4 class="card-title adminPurple">Existing Reminders&nbsp;&nbsp;&nbsp;<i class="glyphicon glyphicon-bell bell"></i></h4>
                    <p class="card-text">There are currently no reminders </p>
                    <div style="position:relative;">
                        <!--FIXME: Bring to error page. Feature not implemented yet-->
                        <a style="position:absolute;right:20px;bottom:-70px;" id="addreminders" href="/Dashboard" class="btn">Add <i class="glyphicon glyphicon-bell"></i></a>
                    </div>
                    
                </div>
            </div>


            <object id="svg" data="SVG/character-10.svg" width="280" height="180"></object>
        </section>
        <div class="flex-container">
            <section class="dumbbells">
                    <h3>Targeted Profit VS Actual Profit By Individual Tour Packages&nbsp;&nbsp;&nbsp;
                        <span class="glyphicon glyphicon-question-sign"
                        data-toggle="popover" title="How do I intepret this?" data-placement="bottom" 
                            data-content="This chart helps you identify the more lucrative tour packages. The shorter the lines, the closer we are towards eventually earning maximum profit from that particular tour package."></span>
                    </h3>
                    <div id="dumbbellchartdiv"></div>
            </section>

            <div>
                <!-- Invoice Management -->
                <section class="invoicem">
                    <h3>Invoice Management</h3>
                    <p>
                        Work Progress: <asp:Label ID="lblProgressPercentage" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblProgressMessage" runat="server"></asp:Label>      
                    </p>
                    <a href="/InvoiceForm" class="btn toInv">Go to Invoice System</a>
                </section>

                <!-- Shortcuts -->
                <section class="shortcuts">
                    <a href="/AddInvoice" class="btn shortcut1">Add&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-plus" aria-hidden="true"></span><br />
                        Invoice</a>
                    <a href="/ViewReport" class="btn shortcut2">View&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span><br />
                        Report</a>
                    <a href="/Dashboard" class="btn shortcut3">Print&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-print" aria-hidden="true"></span><br />
                        Report</a>
                </section>

                <section class="chart">
                <h3>Profits Earned By Day For This Month&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-question-sign" 
                    data-toggle="popover" title="How do I intepret this?" data-placement="right" data-content="This chart helps you identify trends in booking activity. The more the nodes across the days, the higher the booking activity during those period of days."></span>
                </h3>
                    <div id="trendchartdiv"></div>

            </section>
                
            </div>
        </div>

        <section class="chart">
            <h3>Segmentation of Profits Earned from Tour Packages&nbsp;&nbsp;&nbsp;
                <span class="glyphicon glyphicon-question-sign" data-toggle="popover" title="How do I intepret this?" data-placement="right" 
                    data-content="This chart helps you identify the more popular tour packages based on their number of bookings all time (since the date of their creation)."></span>
            </h3>
            <div id="piechartdiv"></div>
        </section>
    </main>

    <style>
        body{
            background-color:#f0e6ff;
        }

        main, section {
            margin: 0;
            padding: 20px;
            margin-top: 30px;
        }

        section {
            padding-top: 1px;
            padding-left: 20px;
        }

        @media screen and (min-width: 640px) {
            .flex-container {
                display: flex;
            }

            .dumbbells {
                margin-right: 20px;
            }

            .reminders {
                width: 400px;
            }
            .shortcut2{
                margin-left: 10px;
                margin-right: 10px;
            }


        }

        @media only screen and (max-width: 995px) {
            .msg {
                display: none;
            }

            .reminders {
                right: 0;
                left: 0;
                width: 550px;
            }
        }

        @media only screen and (max-width: 640px) {
            .reminders {
                width: 100%;
            }
        }

        @media only screen and (max-width: 570px) {
            #svg {
                display: none;
            }
        }

        .chart {
            flex: 1;
            background-color: #ffffff;
            border-radius: 12px;
        }

        .dumbbells {
            background-color: #ffffff;
            border-radius: 12px;
            flex: 0 1 1000px;
        }

        .invoicem {
            border-radius: 12px;
            flex: 1;
            background-color: #ffffff;
            height: 170px;
        }

        .personalmsg {
            height: 140px;
            overflow: visible;
            background-color: #fcffc2;
            border-radius: 12px;
            position: relative;
            flex: 0 1 1000px;
        }

        .btn {
            border-radius: 8px;
            color: white;
            transition: all .2s ease-in-out;
            text-align: left;
        }

            .btn:hover {
                transform: scale(1.1);
                color: white;
            }

        span {
            transform: scale(1.5);
        }

        #addreminders {
            background-color: #9477fe;
        }

        #svg {
            position: absolute;
            right: -40px;
            bottom: 0;
        }

        .reminders {
            padding: 20px;
            position: absolute;
            right: 250px;
            height: 180px;
            bottom: 0px;
            background: linear-gradient(180deg, #ffcd1a 0%, hsl(49, 100%, 84%) 100%);
            border-radius: 12px;
        }

        a {
            text-decoration: none;
        }


        .adminPurple {
            color: #581FF4;
        }

        .darkPurple {
            color: #6B34CB;
        }

        .toInv {
            background-color: #6B34CB;
        }

        .shortcuts {
            padding: 0;
            display: flex;
            justify-content: space-around;
            height: 60px;
        }

        .shortcut1 {
            padding: 10px;
            width: 140px;
            background-color: #BB66CC;
            flex: 1;
        }

        .shortcut2 {
            padding: 10px;
            width: 140px;
            background-color: #9477fe;
            flex: 1;
        }

        .shortcut3 {
            padding: 10px;
            width: 140px;
            background-color: #22CCDD;
            flex: 1;
        }

        #trendchartdiv {
            padding: 20px;
            width: 100%;
            height: 500px;
        }

        #piechartdiv {
            padding: 30px;
            width: 100%;
            height: 1100px;
        }
        
        #dumbbellchartdiv {
            padding: 20px;
            width: 100%;
            height: 700px;
        }

        .bell {
            width: 25px;
            height: 25px;
            font-size: 25px;
            color: #581FF4;
            -webkit-animation: ring 3s .7s ease-in-out infinite;
            -webkit-transform-origin: 40% 4px;
            -moz-animation: ring 3s .7s ease-in-out infinite;
            -moz-transform-origin: 40% 4px;
            animation: ring 3s .7s ease-in-out infinite;
            transform-origin: 40% 4px;
        }
        .glyphicon-question-sign{
            width:15px;
            height:15px;
            font-size: 15px;
        }

    @-webkit-keyframes ring {
      0% { -webkit-transform: rotateZ(0); }
      1% { -webkit-transform: rotateZ(30deg); }
      3% { -webkit-transform: rotateZ(-28deg); }
      5% { -webkit-transform: rotateZ(34deg); }
      7% { -webkit-transform: rotateZ(-32deg); }
      9% { -webkit-transform: rotateZ(30deg); }
      11% { -webkit-transform: rotateZ(-28deg); }
      13% { -webkit-transform: rotateZ(26deg); }
      15% { -webkit-transform: rotateZ(-24deg); }
      17% { -webkit-transform: rotateZ(22deg); }
      19% { -webkit-transform: rotateZ(-20deg); }
      21% { -webkit-transform: rotateZ(18deg); }
      23% { -webkit-transform: rotateZ(-16deg); }
      25% { -webkit-transform: rotateZ(14deg); }
      27% { -webkit-transform: rotateZ(-12deg); }
      29% { -webkit-transform: rotateZ(10deg); }
      31% { -webkit-transform: rotateZ(-8deg); }
      33% { -webkit-transform: rotateZ(6deg); }
      35% { -webkit-transform: rotateZ(-4deg); }
      37% { -webkit-transform: rotateZ(2deg); }
      39% { -webkit-transform: rotateZ(-1deg); }
      41% { -webkit-transform: rotateZ(1deg); }

      43% { -webkit-transform: rotateZ(0); }
      100% { -webkit-transform: rotateZ(0); }
    }

    @-moz-keyframes ring {
      0% { -moz-transform: rotate(0); }
      1% { -moz-transform: rotate(30deg); }
      3% { -moz-transform: rotate(-28deg); }
      5% { -moz-transform: rotate(34deg); }
      7% { -moz-transform: rotate(-32deg); }
      9% { -moz-transform: rotate(30deg); }
      11% { -moz-transform: rotate(-28deg); }
      13% { -moz-transform: rotate(26deg); }
      15% { -moz-transform: rotate(-24deg); }
      17% { -moz-transform: rotate(22deg); }
      19% { -moz-transform: rotate(-20deg); }
      21% { -moz-transform: rotate(18deg); }
      23% { -moz-transform: rotate(-16deg); }
      25% { -moz-transform: rotate(14deg); }
      27% { -moz-transform: rotate(-12deg); }
      29% { -moz-transform: rotate(10deg); }
      31% { -moz-transform: rotate(-8deg); }
      33% { -moz-transform: rotate(6deg); }
      35% { -moz-transform: rotate(-4deg); }
      37% { -moz-transform: rotate(2deg); }
      39% { -moz-transform: rotate(-1deg); }
      41% { -moz-transform: rotate(1deg); }

      43% { -moz-transform: rotate(0); }
      100% { -moz-transform: rotate(0); }
    }

    @keyframes ring {
      0% { transform: rotate(0); }
      1% { transform: rotate(30deg); }
      3% { transform: rotate(-28deg); }
      5% { transform: rotate(34deg); }
      7% { transform: rotate(-32deg); }
      9% { transform: rotate(30deg); }
      11% { transform: rotate(-28deg); }
      13% { transform: rotate(26deg); }
      15% { transform: rotate(-24deg); }
      17% { transform: rotate(22deg); }
      19% { transform: rotate(-20deg); }
      21% { transform: rotate(18deg); }
      23% { transform: rotate(-16deg); }
      25% { transform: rotate(14deg); }
      27% { transform: rotate(-12deg); }
      29% { transform: rotate(10deg); }
      31% { transform: rotate(-8deg); }
      33% { transform: rotate(6deg); }
      35% { transform: rotate(-4deg); }
      37% { transform: rotate(2deg); }
      39% { transform: rotate(-1deg); }
      41% { transform: rotate(1deg); }

      43% { transform: rotate(0); }
      100% { transform: rotate(0); }
}
    </style>

    <script>
        /**
         * ---------------------------------------
         * This demo was created using amCharts 4.
         * 
         * For more information visit:
         * https://www.amcharts.com/
         * 
         * Documentation is available at:
         * https://www.amcharts.com/docs/v4/
         * ---------------------------------------
         */

        // Themes begin
        am4core.useTheme(am4themes_material);
        am4core.useTheme(am4themes_animated);
        // Themes end

        // Create chart instance
        var trendchart = am4core.create("trendchartdiv", am4charts.XYChart);

        // Enable chart cursor
        trendchart.cursor = new am4charts.XYCursor();
        trendchart.cursor.lineX.disabled = true;
        trendchart.cursor.lineY.disabled = true;

        // Enable scrollbar
        trendchart.scrollbarX = new am4core.Scrollbar();

        var json = JSON.parse('<%=serializedTrendChartResult%>');
        for (var key in json) {
            if (json.hasOwnProperty(key)) {
                delete json[key].BookId;
                delete json[key].CreateDate;
                delete json[key].Status;
                delete json[key].TourName;
                delete json[key].NumAttendees;
                delete json[key].TourPrice;
                delete json[key].TotalAmt;
                delete json[key].ChartYear;
                delete json[key].ChartMonth;
                delete json[key].ChartMonthTotal;
                json[key].date = json[key].ChartCMDate;
                json[key].date = json[key].date.split(" ")[0].split("/")[2] + "-" + json[key].date.split(" ")[0].split("/")[1] + "-" + json[key].date.split(" ")[0].split("/")[0];
                var day = json[key].date.split("-")[2];
                if (day < 10) {
                    json[key].date = json[key].date.split("-")[0] + "-" + json[key].date.split("-")[1] + "-" + 0 + json[key].date.split("-")[2]
                }
                delete json[key].ChartCMDate;
                json[key].value = json[key].ChartCMDayProfit;
                delete json[key].ChartCMDayProfit;
            }
        }

        trendchart.data = json;

        // Create axes
        var dateAxis = trendchart.xAxes.push(new am4charts.DateAxis());
        dateAxis.renderer.grid.template.location = 0.5;
        dateAxis.dateFormatter.inputDateFormat = "yyyy-MM-dd";
        dateAxis.renderer.minGridDistance = 40;
        dateAxis.tooltipDateFormat = "MMM dd, yyyy";
        dateAxis.dateFormats.setKey("day", "dd");

        var valueAxis = trendchart.yAxes.push(new am4charts.ValueAxis());

        // Create series
        var series = trendchart.series.push(new am4charts.LineSeries());
        series.tooltipText = "{date}\n[bold font-size: 17px]profit: ${valueY}[/]";
        series.dataFields.valueY = "value";
        series.dataFields.dateX = "date";
        series.strokeDasharray = 3;
        series.strokeWidth = 2
        series.strokeOpacity = 0.3;
        series.strokeDasharray = "3,3"

        var bullet = series.bullets.push(new am4charts.CircleBullet());
        bullet.strokeWidth = 2;
        bullet.stroke = am4core.color("#fff");
        bullet.setStateOnChildren = true;
        bullet.propertyFields.fillOpacity = "opacity";
        bullet.propertyFields.strokeOpacity = "opacity";

        var hoverState = bullet.states.create("hover");
        hoverState.properties.scale = 1.7;

        function createTrendLine(data) {
            var trend = trendchart.series.push(new am4charts.LineSeries());
            trend.dataFields.valueY = "value";
            trend.dataFields.dateX = "date";
            trend.strokeWidth = 2
            trend.stroke = trend.fill = am4core.color("#c00");
            trend.data = data;

            var bullet = trend.bullets.push(new am4charts.CircleBullet());
            bullet.tooltipText = "there is an increasing profit";
            bullet.strokeWidth = 2;
            bullet.stroke = am4core.color("#fff")
            bullet.circle.fill = trend.stroke;

            var hoverState = bullet.states.create("hover");
            hoverState.properties.scale = 1.7;

            return trend;
        }


        createTrendLine([
            { "date": "2021-02-04", "value": 164 },
            { "date": "2021-02-08", "value": 380 }
        ]);
    </script>

    <script>
        // Themes begin
        am4core.useTheme(am4themes_animated);
        // Themes end

        var piechart = am4core.create("piechartdiv", am4charts.PieChart3D);
        piechart.hiddenState.properties.opacity = 0; // this creates initial fade-in

        piechart.legend = new am4charts.Legend();

        var json = JSON.parse('<%=serializedSharedChartResult%>');
        for (var key in json) {
            if (json.hasOwnProperty(key)) {
                delete json[key].TourId;
                delete json[key].BKConfirmed;
                delete json[key].BKRefunded;
                delete json[key].AvailSlots;
                delete json[key].TourPrice;
                delete json[key].MaxPpl;
                delete json[key].RefundLoss;
                delete json[key].PeakProfit;

                json[key].tour = json[key].TourName;
                delete json[key].TourName;
                json[key].profit = json[key].ActualProfit;
                delete json[key].ActualProfit;

            }
        }

        piechart.data = json;

        var series = piechart.series.push(new am4charts.PieSeries3D());
        series.dataFields.value = "profit";
        series.dataFields.category = "tour";
    </script>

    <script>
        // Themes begin
        am4core.useTheme(am4themes_animated);
        // Themes end

        var dumbbellchart = am4core.create("dumbbellchartdiv", am4charts.XYChart);

        var data = [];
        var names = [];

        var json = JSON.parse('<%=serializedSharedChartResult%>');
        for (var key in json) {
            if (json.hasOwnProperty(key)) {
                delete json[key].TourId;
                delete json[key].BKConfirmed;
                delete json[key].BKRefunded;
                delete json[key].AvailSlots;
                delete json[key].TourPrice;
                delete json[key].MaxPpl;
                delete json[key].RefundLoss;
                names.push(json[key].TourName);
                json[key].category = json[key].TourName;
                delete json[key].TourName;
                json[key].open = json[key].ActualProfit;
                delete json[key].ActualProfit;
                json[key].close = json[key].PeakProfit;
                delete json[key].PeakProfit;
            }
        }


        dumbbellchart.data = json;
        var categoryAxis = dumbbellchart.xAxes.push(new am4charts.CategoryAxis());
        categoryAxis.renderer.grid.template.location = 0;
        categoryAxis.dataFields.category = "category";
        categoryAxis.renderer.minGridDistance = 15;
        categoryAxis.renderer.grid.template.location = 0.5;
        categoryAxis.renderer.grid.template.strokeDasharray = "1,3";
        categoryAxis.renderer.labels.template.rotation = -90;
        categoryAxis.renderer.labels.template.horizontalCenter = "left";
        categoryAxis.renderer.labels.template.location = 0.5;
        categoryAxis.renderer.inside = true;

        categoryAxis.renderer.labels.template.adapter.add("dx", function (dx, target) {
            return -target.maxRight / 2;
        })

        var valueAxis = dumbbellchart.yAxes.push(new am4charts.ValueAxis());
        valueAxis.tooltip.disabled = true;
        valueAxis.renderer.ticks.template.disabled = true;
        valueAxis.renderer.axisFills.template.disabled = true;

        var series = dumbbellchart.series.push(new am4charts.ColumnSeries());
        series.dataFields.categoryX = "category";
        series.dataFields.openValueY = "open";
        series.dataFields.valueY = "close";
        series.tooltipText = "actual: {openValueY.value} targeted: {valueY.value}";
        series.sequencedInterpolation = true;
        series.fillOpacity = 0;
        series.strokeOpacity = 1;
        series.columns.template.width = 0.01;
        series.tooltip.pointerOrientation = "horizontal";

        var openBullet = series.bullets.create(am4charts.CircleBullet);
        openBullet.locationY = 1;

        var closeBullet = series.bullets.create(am4charts.CircleBullet);

        closeBullet.fill = dumbbellchart.colors.getIndex(4);
        closeBullet.stroke = closeBullet.fill;

        dumbbellchart.cursor = new am4charts.XYCursor();

        dumbbellchart.scrollbarX = new am4core.Scrollbar();
        dumbbellchart.scrollbarY = new am4core.Scrollbar();
    </script>

    <script>
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover();
        });
    </script>
</asp:Content>
