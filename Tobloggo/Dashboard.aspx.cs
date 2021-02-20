using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;


namespace Tobloggo
{
    public partial class Dashboard : System.Web.UI.Page
    {
        public string serializedTrendChartResult;
        public string serializedSharedChartResult;
        protected void Page_Load(object sender, EventArgs e)
        {
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            List<Booking> TrendChartDataList = client.GetCMProfitChart().ToList();
            List<Tour> SharedDataList = client.DisplayPackageProfit("0", "1000", "0", "10000", "-1000", "0").ToList();

            var serializer = new JavaScriptSerializer();
            serializedTrendChartResult = serializer.Serialize(TrendChartDataList);
            serializedSharedChartResult = serializer.Serialize(SharedDataList);

            Invoice progr = client.GetProgress();
            ////Work Progress should be based on no. of bookings vs no. of invoices created.
            ////Invoices are not intended to stay permanent as their sole purpose is to only send emails.
            ////Therefore we should take into account the entire booking record vs the no. of invoice records.
            ////What we would want to do is match whether an invoice record has been created for a booking that falls within a certain period of 3 months.
            ////This is to ensure that data doesn't pile up unnecessarily in database as these invoice records will typically be irrelevant after a few months unlike 
            ////other things that are  stored into the database.
            
            if (progr != null)
            {
                // sent/created * created/booked * 100 = sent/booked*100
                var percentage = (Double.Parse(progr.Sent) / Double.Parse(progr.Booked)) * 100;
                if (percentage.ToString() == "NaN")
                {
                    //There is no bookings
                    lblProgressPercentage.Text = "100%";
                    lblProgressMessage.Text = "You currently do not need to send out invoices as there are no new bookings.";
                    lblProgressMessage.ForeColor = Color.DeepSkyBlue;
                }
                else
                {
                    lblProgressPercentage.Text = Math.Round(percentage, 1).ToString() + "%";
                    //There are bookings
                    if (percentage < 50)
                    {
                        lblProgressMessage.Text = "Your work is piling up!";
                        lblProgressMessage.ForeColor = Color.Red;
                    }
                    else if (percentage < 75)
                    {
                        lblProgressMessage.Text = "Your work is piling up!";
                        lblProgressMessage.ForeColor = Color.Gold;
                    }
                    else if (percentage < 100)
                    {
                        lblProgressMessage.Text = "Your work is piling up! ";
                        lblProgressMessage.ForeColor = Color.DeepSkyBlue;
                    }
                    else if (percentage == 100)
                    {
                        //All bookings has an invoice and all invoices have been sent
                        lblProgressMessage.Text = "All work done!";
                        lblProgressMessage.ForeColor = Color.DeepSkyBlue;
                    }
                }             

            }
            else
            {
                //SQL did not return any rows. There were no bookings.
                //Could either mean it is the business's first time operating or no bookings were made for the last 3 months.
                lblProgressPercentage.Text = "100%";
                lblProgressMessage.Text = "There are currently no bookings for an invoice to be created.";
                lblProgressMessage.ForeColor = Color.DeepSkyBlue;
            }
        }
    }
}