using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Locations
{
    public partial class Overview : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                var user = client.GetUserByEmail(Session["UserId"].ToString());
                List<Location> locationList = new List<Location>();
                if (user.Authorization == 1)
                {
                    locationList = client.GetAllLocations().ToList();
                    gvLocation.DataSource = locationList;
                    gvLocation.DataBind();
                }
                else if (user.Authorization > 1)
                {
                    locationList = client.GetAllLocationsByUserId(Convert.ToInt32(user.Id)).ToList();
                    gvLocation.DataSource = locationList;
                    gvLocation.DataBind();
                } else
                {
                    Response.Redirect("~/CustomErrors/Error403.html");
                }

                
            }
        }
    }
}