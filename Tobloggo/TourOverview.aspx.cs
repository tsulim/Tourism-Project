using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.DBServiceReference;

namespace Tobloggo
{
    public partial class TourOverview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefreshGridView();
        }

        private void RefreshGridView()
        {
            List<Tour> tList = new List<Tour>();
            Service1Client client = new Service1Client();
            tList = client.GetAllTour().ToList<Tour>();

            // using gridview to bind to the list of tour objects
            gvTour.Visible = true;
            gvTour.DataSource = tList;
            gvTour.DataBind();

        }

        protected void gvTour_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTour.SelectedRow;
            Session["SSTitle"] = row.Cells[0].Text;
            Session["SSImage"] = row.Cells[1].Text;
            Session["SSDetails"] = row.Cells[2].Text;
            Session["SSDateTime"] = row.Cells[3].Text;
            Session["SSPrice"] = row.Cells[4].Text;
            Session["SSMinPpl"] = row.Cells[5].Text;
            Session["SSMaxPpl"] = row.Cells[6].Text;
            Session["SSIti"] = row.Cells[7].Text;

            Response.Redirect("EditTour.aspx");

        }
    }
}