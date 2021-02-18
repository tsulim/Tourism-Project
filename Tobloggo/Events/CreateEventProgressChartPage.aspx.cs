using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Events
{
    public partial class CreateEventProgressChartPage : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        Event retrievedEvent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["eventId"] == null)
            {
                Response.Redirect("/Events/EventList");
            }
            else
            {
                retrievedEvent = client.GetEventById(RouteData.Values["eventId"].ToString());

                if (retrievedEvent == null)
                {
                    Response.Redirect("/Events/EventList");
                }
                else
                {
                }
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            retrievedEvent.PStartDate = DateTime.Parse(preparationStartDate.Value);
            retrievedEvent.PEndDate = DateTime.Parse(preparationEndDate.Value);
            retrievedEvent.ProgCreated = 1;
            client.UpdateEvent(retrievedEvent);

            Response.RedirectToRoute("EventProgressChartRoute", new { eventId = retrievedEvent.Id });
        }
    }
}