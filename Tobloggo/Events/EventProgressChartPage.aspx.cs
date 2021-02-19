using System;
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
        public Event RetrievedEvent { get { return retrievedEvent; } }

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
                    eventManager.Text = "Trillium (trilliumtay@gmail.com)"; // fix username and email <---

                    preparationStartDate.Text = retrievedEvent.PStartDate.ToString("dd-MM-yyyy");
                    preparationEndDate.Text = retrievedEvent.PEndDate.ToString("dd-MM-yyyy");
                    eventStartDate.Text = retrievedEvent.EStartDate.ToString();
                    eventEndDate.Text = retrievedEvent.EEndDate.ToString();


                    TimeSpan daysRemainingTimeSpan = retrievedEvent.PEndDate - DateTime.Now;
                    daysRemaining.Text = daysRemainingTimeSpan.Days.ToString();

                    int actualTotal = 0;
                    int expectedTotal = 0;

                    foreach (EventTeam team in retrievedEventTeams)
                    {
                        int actualSum = 0;
                        int expectedSum = 0;


                        TimeSpan timeSpent = DateTime.Now - team.TStartDate;
                        TimeSpan totalTime = team.TEndDate - team.TStartDate;
                        int expectedPercentage;
                        if (totalTime.Days == 0)
                        {
                            expectedPercentage = 0;
                        } else
                        {
                            Double roundedTotal = Math.Round((Double.Parse(timeSpent.Days.ToString()) / Double.Parse(totalTime.Days.ToString()) * 100), 0);
                            expectedPercentage = int.Parse(roundedTotal.ToString());
                        }


                        List<Tasks> taskList = client.GetAllTaskByEventTeamId(team.Id).ToList();
                        foreach (Tasks taskObj in taskList)
                        {
                            if (taskObj.Completed == true)
                            {
                                actualSum += int.Parse(taskObj.Difficulty.ToString());
                                expectedSum += int.Parse(taskObj.Difficulty.ToString());
                            } else
                            {
                                expectedSum += int.Parse(taskObj.Difficulty.ToString());
                            }
                        }

                        int actualPercentage = int.Parse(Math.Round(Double.Parse(actualSum.ToString())/Double.Parse(expectedSum.ToString())*100).ToString());

                        team.ActualPercent = actualPercentage;
                        team.ExpectedPercent = expectedPercentage;


                        actualTotal += actualSum;
                        expectedTotal += expectedSum;
                    }


                    Double percentDiff;
                    if (expectedTotal == 0)
                    {
                        percentDiff = 0;
                    } else
                    {
                        percentDiff = Double.Parse(actualTotal.ToString()) / Double.Parse(expectedTotal.ToString()) * 100;
                    }
                    var roundedDiff = Math.Round(percentDiff, 0).ToString();
                    totalProgress.Text = int.Parse(roundedDiff).ToString() + "%";


                    TeamRepeater.DataSource = retrievedEventTeams;
                    TeamRepeater.DataBind();

                    progressLinkCreateTeam.NavigateUrl = GetRouteUrl("EventCreateTeamRoute", new { eventId = RetrievedEvent.Id });
                    progressLinkEdit.NavigateUrl = GetRouteUrl("EventEditProgressChartRoute", new { eventId = RetrievedEvent.Id });

                }
            }
        }
        
    }
}