using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public string serializedTrendChartResult;
    public string serializedSharedChartResult;

    //public bool hasBeenAWeek;
    //public bool hasNodeOnDay1;
    //public bool hasNodeOnDay7;

    //public bool hasBeen4Weeks;
    //public bool hasNodeOnDay22;
    //public bool hasNodeOnLastDay;

    //public int lastDayOfMonth;

    protected void Page_Load(object sender, EventArgs e)
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        List<Booking> TrendChartDataList = client.GetCMProfitChart().ToList();
        List<Tour> SharedDataList = client.DisplayPackageProfit("0", "1000", "0", "10000", "-1000", "0").ToList();

        var serializer = new JavaScriptSerializer();
        serializedTrendChartResult = serializer.Serialize(TrendChartDataList);
        serializedSharedChartResult = serializer.Serialize(SharedDataList);


        //var currentDate = DateTime.Now;
        //var lastDateOfMonth = new DateTime(currentDate.Year, currentDate.Month, 1).AddMonths(1).AddDays(-1);
        //lastDayOfMonth = lastDateOfMonth.Day;

        ////For Single Digits, Need to omit 0. Replace with " instead to avoid matching numbers above 9
        //hasNodeOnDay1 = serializedResult.Contains("\"1/" + currentDate.Month.ToString() + "/" + currentDate.Year.ToString());
        //hasNodeOnDay7 = serializedResult.Contains("\"7/" + currentDate.Month.ToString() + "/" + currentDate.Year.ToString());
        //hasNodeOnDay22 = serializedResult.Contains("22/" + currentDate.Month.ToString() + "/" + currentDate.Year.ToString());
        //hasNodeOnLastDay = serializedResult.Contains(lastDateOfMonth.Date.ToString());

    }
}