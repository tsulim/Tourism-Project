using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public partial class ViewTour : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefreshGridView();
        }

        private void RefreshGridView()
        {
            List<Tour> tList = new List<Tour>();
            Service1Client client = new Service1Client();

            if (client.GetAllTour() != null)
            {
                tList = client.GetAllTour().ToList<Tour>();
            }


            // using gridview to bind to the list of tour objects
            gvTour.Visible = true;
            gvTour.DataSource = tList;
            gvTour.DataBind();
        }

        protected void btnGetTour_Click(object sender, EventArgs e)
        {
            LoadTour();
        }

        protected void LoadTour()
        {
            Service1Client client = new Service1Client();
            Tour tour = client.GetTourByTitle(tbTitle.Text);
            if (tour != null)
            {
                PanelErrorResult.Visible = false;
                PanelCust.Visible = true;

                Lbl_title.Text = tour.Title;
                Image1.ImageUrl = tour.Image;
                Lbl_details.Text = tour.Details;
                Lbl_DT.Text = Convert.ToString(tour.DateTime);
                Lbl_price.Text = Convert.ToString(tour.Price);
                Lbl_iti.Text = Convert.ToString(tour.Itinerary);

                Lbl_err.Text = String.Empty;
            }
            else
            {
                Lbl_err.Text = "Tour record not found!";
                PanelErrorResult.Visible = true;
                PanelCust.Visible = false;
                Lbl_title.Text = String.Empty;
                Image1.ImageUrl = String.Empty;
                Lbl_details.Text = String.Empty;
                Lbl_DT.Text = String.Empty;
                Lbl_price.Text = String.Empty;
            }

        }

        protected void gvTour_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvTour.SelectedRow;
            Session["SSTitle"] = row.Cells[0].Text;
            Image img = row.Cells[1].Controls[0] as Image;
            Session["SSImage"] = img.ImageUrl;
            Session["SSDetails"] = row.Cells[2].Text;
            Session["SSDateTime"] = row.Cells[3].Text;
            Session["SSPrice"] = row.Cells[4].Text;
            Session["SSMinPpl"] = row.Cells[5].Text;
            Session["SSMaxPpl"] = row.Cells[6].Text;
            Session["SSIti"] = row.Cells[7].Text;

            Response.Redirect("ATour.aspx");

        }
    }
}