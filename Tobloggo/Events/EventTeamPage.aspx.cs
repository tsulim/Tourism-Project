using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Events
{
    public partial class EventTeamPage : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        string teamId;

        EventTeam eventTeam;


        public List<Tasks> RetrieveEventTasks { get { return retrievedEventTasks; } }

        private List<Tasks> retrievedEventTasks;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["teamId"] == null)
            {
                Response.Redirect("/Events/EventList");
            }
            else
            {
                teamId = this.RouteData.Values["teamId"].ToString();

                eventTeam = client.GetEventTeamById(teamId);

                if (eventTeam == null)
                {
                    Response.Redirect("/Events/EventList");
                }

                teamName.Text = eventTeam.TeamName;
                teamLeaderId.Text = eventTeam.TeamLeader;
                teamContact.Text = eventTeam.ContactEmail;
                teamStartDate.Value = eventTeam.TStartDate.ToString("yyyy-MM-dd");
                teamEndDate.Value = eventTeam.TEndDate.ToString("yyyy-MM-dd");

                retrievedEventTasks = client.GetAllTaskByEventTeamId(teamId).ToList();
                if (!IsPostBack)
                {


                    teamItemCount.Value = retrievedEventTasks.Count().ToString();
                }

            }
        }

        protected void team_create_btn_submit_Click(object sender, EventArgs e)
        {


            System.Diagnostics.Debug.WriteLine("Death");

            bool valid = true;


            if (String.IsNullOrEmpty(teamName.Text) || String.IsNullOrEmpty(teamLeaderId.Text) || String.IsNullOrEmpty(teamContact.Text) || String.IsNullOrEmpty(teamStartDate.Value) || String.IsNullOrEmpty(teamEndDate.Value))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Some inputs are missing!')", true);
            }
            else
            {

                var itemNum = Convert.ToInt32(teamItemCount.Value);

                var ignoreList = teamDeleteList.Value.Split(',');
                ignoreList = ignoreList.Skip(1).ToArray();



                for (var num = 1; num < itemNum + 1; num++)
                {
                    if (((IList)ignoreList).Contains(num.ToString()))
                    {
                        continue;
                    }

                    System.Diagnostics.Debug.WriteLine(num);

                    var taskNameName = "taskName" + num;
                    var taskDescName = "taskDesc" + num;
                    var taskDiffName = "taskDiff" + num;
                    var taskCompleteName = "taskComplete" + num;

                    var taskName = Request.Form[taskNameName];
                    var taskDesc = Request.Form[taskDescName];
                    var taskDiff = Request.Form[taskDiffName];
                    var taskComplete = Request.Form[taskCompleteName];

                    if (taskComplete == null)
                    {
                        taskComplete = "0";
                    }
                    else { taskComplete = "1"; }

                    if (String.IsNullOrEmpty(taskName) || String.IsNullOrEmpty(taskDesc) || String.IsNullOrEmpty(taskDiff))
                    {
                        valid = false;
                        break;
                    }

                }

                if (valid)
                {
                    string name = teamName.Text;
                    string leaderId = teamLeaderId.Text;
                    string contact = teamContact.Text;
                    DateTime startDate = DateTime.Parse(teamStartDate.Value.ToString());
                    DateTime endDate = DateTime.Parse(teamEndDate.Value.ToString());

                    eventTeam.TeamName = name;
                    eventTeam.TeamLeader = leaderId;
                    eventTeam.ContactEmail = contact;
                    eventTeam.TStartDate = startDate;
                    eventTeam.TEndDate = endDate;

                    client.UpdateEventTeam(eventTeam);


                    //Delete Event Tasks

                    foreach (Tasks task in retrievedEventTasks)
                    {
                        client.DeleteTask(task.Id);
                    }



                    for (var num = 1; num < itemNum + 1; num++)
                    {
                        if (((IList)ignoreList).Contains(num.ToString()))
                        {
                            continue;
                        }

                        var taskNameName = "taskName" + num;
                        var taskDescName = "taskDesc" + num;
                        var taskDiffName = "taskDiff" + num;
                        var taskCompleteName = "taskComplete" + num;

                        var taskName = Request.Form[taskNameName];
                        var taskDesc = Request.Form[taskDescName];
                        var taskDiff = Request.Form[taskDiffName];
                        var taskComplete = Request.Form[taskCompleteName];
                        bool taskComplete2 = false;

                        if (taskComplete != null)
                        {
                            taskComplete2 = true;
                        }

                        client.CreateEventTask(taskName, taskDesc, Double.Parse(taskDiff), taskComplete2, teamId);


                    }

                    Response.RedirectToRoute("EventProgressChartRoute", new { eventId = eventTeam.EventId});
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Some inputs are missing!')", true);
                }






            }







        }
    }
}