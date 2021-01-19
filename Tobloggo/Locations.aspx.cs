using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefreshGridView();
        }
        private void RefreshGridView()
        {
            List<Location> lList = new List<Location>();
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            lList = client.GetAllLocations()?.ToList<Location>();

            if (lList != null)
            {
                gvLocation.Visible = true;
                gvLocation.DataSource = lList;
                gvLocation.DataBind();
            } else
            {
                gvLocation.Visible = false;
            }
        }
    }
}