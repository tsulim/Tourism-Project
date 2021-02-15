using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.DBServiceReference;

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
            tList = client.GetAllTour().ToList<Tour>();

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
            DBServiceReference.Service1Client client = new DBServiceReference.Service1Client();
            Tour tour = client.GetTourByTitle(tbTitle.Text);
            if (tour != null)
            {
                PanelErrorResult.Visible = false;
                PanelCust.Visible = true;

                Lbl_title.Text = tour.Title;
                Image1.ImageUrl = "Images\\" + tour.Image;
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
    }
}