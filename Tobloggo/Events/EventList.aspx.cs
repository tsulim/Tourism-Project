using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Events
{
    public partial class EventList : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Event> eventList = client.GetAllEvents().ToList();
            eventCounter.InnerText = "There are " + eventList.Count + " Total Events.";

        }
    }
}