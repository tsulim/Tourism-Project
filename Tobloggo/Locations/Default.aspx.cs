using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Locations
{
    public partial class _Default : System.Web.UI.Page
    {
        private string selectedLoca = "all";
        public string SelectedLoca { get { return selectedLoca; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["locaType"] != null)
            {
                if (this.RouteData.Values["locaType"].ToString() == "Food" || this.RouteData.Values["locaType"].ToString() == "Entertainment" || this.RouteData.Values["locaType"].ToString() == "Cultural")
                {
                    selectedLoca = RouteData.Values["locaType"].ToString();
                } else
                {
                    Response.Redirect("/Locations");
                }
            }
        }
    }
}