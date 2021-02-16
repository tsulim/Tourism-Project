using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stripe;
using Stripe.Checkout;

namespace Tobloggo
{
    public partial class Charge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["paySum"] == null || Session["UserId"] == null)
            {
                Response.Redirect("~/CustomErrors/Error404.html");
            }
            else
            {
                var paySum = Convert.ToDouble(this.RouteData.Values["paySum"].ToString());
                payBtn.Text = "Pay S$" + paySum.ToString();
            }
        }

        protected void payBtn_Click(object sender, EventArgs e)
        {
            ValidatePurchasedTicket();
        }

        protected void ValidatePurchasedTicket()
        {
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            var userId = Convert.ToInt32(client.GetUserByEmail(Session["UserId"].ToString()).Id);

            var pTicList = client.GetPurchasedTicketsByUserId(userId);
            for (var i = 0; i < pTicList.Length; i++)
            {
                var pTic = pTicList[i];
                int result = client.UpdatePurchasedTicket(pTic.Id, 1);
                var currentTic = client.GetTicketById(pTic.TicketId);

                var newSoldAmt = currentTic.SoldAmount + pTic.Quantity;
                int UpdateTicResult = client.UpdateTicketAmt(pTic.TicketId, newSoldAmt);

                if (result == 1)
                {
                    System.Diagnostics.Debug.WriteLine("Successful");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Unsuccessful update of purchased ticket");
                }

                if (UpdateTicResult == 1)
                {
                    System.Diagnostics.Debug.WriteLine("Successful");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Unsuccessful update of ticket sold amount");
                }
            }

            Response.Redirect("/Payment/Success");
        }

        protected void cancelBtn_Click(object sender, EventArgs e)
        {
            InvalidatePurchasedTicket();
        }

        protected void InvalidatePurchasedTicket()
        {
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            var userId = Convert.ToInt32(client.GetUserByEmail(Session["UserId"].ToString()).Id);

            var pTicList = client.GetPurchasedTicketsByUserId(userId);
            for (var i = 0; i < pTicList.Length; i++)
            {
                var pTic = pTicList[i];
                int result = client.UpdatePurchasedTicket(pTic.Id, 2);

                if (result == 1)
                {
                    System.Diagnostics.Debug.WriteLine("Successful");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Unsuccessful update of purchased ticket");
                }
            }
        }

    }
}