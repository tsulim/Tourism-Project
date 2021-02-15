using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo.Events
{
    public partial class CreateEventTeam : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        string eventId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["eventId"] == null)
            {
                Response.Redirect("/Events/EventList");
            }
            else
            {
                eventId = this.RouteData.Values["eventId"].ToString();
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            int cnt = client.CreateEventTeam(teamName.Text, teamLeaderId.Text, teamContact.Text, DateTime.Parse(teamStartDate.Value), DateTime.Parse(teamEndDate.Value), eventId);
            Response.RedirectToRoute("EventProgressChartRoute", new { eventId = eventId });

        }
    }
}