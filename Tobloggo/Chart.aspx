<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chart.aspx.cs" Inherits="Tobloggo.Chart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <script src="https://cdn.amcharts.com/lib/4/core.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/material.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
    <div id="trendchartdiv"></div>
    <div id="piechartdiv"></div>
    <div id="dumbbellchartdiv"></div>	

    <form id="form1" runat="server">
        <div>
            <asp:Label ID="fillmeup" runat="server"></asp:Label>
        </div>
    </form>



    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        }

        #trendchartdiv {
            width: 80%;
            height: 500px;
        }

        #piechartdiv {
            width: 100%;
            height: 800px;
        }
        #dumbbellchartdiv {
            width: 80%;
            height: 800px;
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
        series.tooltipText = "open: {openValueY.value} close: {valueY.value}";
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
</body>
</html>
