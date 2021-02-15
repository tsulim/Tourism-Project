﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Events
{
    public partial class EventProgressChartPage : System.Web.UI.Page
    {

        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        private Event retrievedEvent;
        private List<EventTeam> retrievedEventTeams;

        public List<EventTeam> RetrievedEventTeams { get { return retrievedEventTeams; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["eventId"] == null)
            {
                Response.Redirect("/Events/EventList");
            }
            else
            {
                retrievedEvent = client.GetEventById(RouteData.Values["eventId"].ToString());
                retrievedEventTeams = client.GetAllEventTeamByEventId(retrievedEvent.Id).ToList();
                

                if (retrievedEvent == null)
                {
                    Response.Redirect("/Events/EventList");
                }
                else
                {
                    eventTitle.Text = retrievedEvent.Name;
                    eventLocation.Text = retrievedEvent.Location;
                    eventStatus.Text = retrievedEvent.Status;
                    eventManager.Text = "Meow";

                    TeamRepeater.DataSource = retrievedEventTeams;
                    TeamRepeater.DataBind();

                }
            }
        }
    }
}