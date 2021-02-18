using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;
using System.Web.Configuration;

namespace Tobloggo.Locations
{
    public partial class View : System.Web.UI.Page
    {
        private Location selectedLocation;
        public Location SelectedLocation { get {return selectedLocation;} }
        private List<Ticket> ticketList;
        public List<Ticket> TicketList { get { return ticketList; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["locaId"] == null)
            {
                Response.Redirect("/Locations");
            } else
            {
                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                selectedLocation = client.GetLocationById(Convert.ToInt32(RouteData.Values["locaId"].ToString()));
                ticketList = client.GetTicketByLocaId(selectedLocation.Id).ToList();
                System.Diagnostics.Debug.WriteLine(ticketList.Count);

                for (var i = 0; i < ticketList.Count(); i++)
                {
                    TextBox tb = new TextBox();
                    Label lblName = new Label();
                    Label lblPrice = new Label();

                    Panel rowPanel = new Panel();
                    Panel namePanel = new Panel();
                    Panel pricePanel = new Panel();
                    Panel quantityPanel = new Panel();

                    namePanel.CssClass = "col-6";
                    pricePanel.CssClass = "col-3";
                    quantityPanel.CssClass = "col-3";
                    rowPanel.CssClass = "row";

                    lblName.Text = ticketList[i].Name;
                    lblPrice.Text = "S$" + ticketList[i].Price.ToString();
                    lblPrice.CssClass = "ticketPrice";
                    namePanel.Controls.Add(lblName);
                    pricePanel.Controls.Add(lblPrice);

                    tb.ID = "numTic" + i.ToString();
                    tb.Text = "0";
                    tb.CssClass = "ticketQuantity";
                    tb.TextMode = TextBoxMode.Number;
                    tb.ClientIDMode = ClientIDMode.Static;
                    quantityPanel.Controls.Add(tb);

                    rowPanel.Controls.Add(namePanel);
                    rowPanel.Controls.Add(pricePanel);
                    rowPanel.Controls.Add(quantityPanel);

                    ticketPanel.Controls.Add(rowPanel);
                }
            }
        }

        protected void PayBtn_Click(object sender, EventArgs e)
        {
            for (var i = 0; i < ticketList.Count(); i++)
            {
                var tbId = "numTic" + i.ToString();
                TextBox quantityTB = (TextBox)ticketPanel.FindControl(tbId);

                var ticket = ticketList[i];
                var quantity = Convert.ToInt32(quantityTB.Text);
                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                var userId = Convert.ToInt32(client.GetUserByEmail(Session["UserId"].ToString()).Id);
                int result = client.CreatePurchasedTicket(quantity, ticket.Id, userId);
                if (result == 1)
                {
                    System.Diagnostics.Debug.WriteLine("Successful");
                } else
                {
                    System.Diagnostics.Debug.WriteLine("Unsuccessful creation of purchased ticket");
                }
            }
            var totalSum = bookSum.Text;
            Response.Redirect("/Payment/Checkout/"+totalSum);
        }
    }
}