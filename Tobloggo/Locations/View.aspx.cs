using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Locations
{
    public partial class View : System.Web.UI.Page
    {
        private Location selectedLocation;
        public Location SelectedLocation { get {return selectedLocation;} }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["locaId"] == null)
            {
                Response.Redirect("/Locations");
            } else
            {
                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                selectedLocation = client.GetLocationById(Convert.ToInt32(RouteData.Values["locaId"].ToString()));
            }
        }
    }
}