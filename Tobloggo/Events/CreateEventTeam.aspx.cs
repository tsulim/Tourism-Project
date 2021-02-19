using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using System.Windows.Forms;
using Tobloggo.MyDBServiceReference;

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

        protected void team_create_btn_submit_Click(object sender, EventArgs e)
        {


            System.Diagnostics.Debug.WriteLine("Death");

            bool valid = true;


            if (String.IsNullOrEmpty(teamName.Text) || String.IsNullOrEmpty(teamLeaderId.Text) || String.IsNullOrEmpty(teamContact.Text) || String.IsNullOrEmpty(teamStartDate.Value) || String.IsNullOrEmpty(teamEndDate.Value))
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Some inputs are missing!')", true);
            } else
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

                    EventTeam team = client.CreateEventTeam(name, leaderId, contact, startDate, endDate, eventId);

                   

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

                        client.CreateEventTask(taskName, taskDesc, Double.Parse(taskDiff), taskComplete2, team.Id);


                    }

                    Response.RedirectToRoute("EventProgressChartRoute", new { eventId = eventId });
                } else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Some inputs are missing!')", true);
                }






            }







        }
    }
}