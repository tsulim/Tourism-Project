using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Events
{
    public partial class DeleteEventTeamPage : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(this.RouteData.Values["teamId"].ToString());
            EventTeam team = client.GetEventTeamById(this.RouteData.Values["teamId"].ToString());
            client.DeleteEventTeam(this.RouteData.Values["teamId"].ToString());
            Response.RedirectToRoute("EventProgressChartRoute", new { eventId = team.EventId });
        }
    }
}