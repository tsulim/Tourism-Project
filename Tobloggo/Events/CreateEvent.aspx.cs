using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo.Events
{
    public partial class CreateEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("/Default.aspx");
            }
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {

            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            


            int cnt = client.CreateEvent(
                eventName.Text,
                eventLocation.Text,
                eventDescription.Text,
                DateTime.Parse(eventStartDate.Value),
                DateTime.Parse(eventEndDate.Value),
                client.GetUserByEmail(Session["UserID"].ToString()).Id);
        }
    }
}