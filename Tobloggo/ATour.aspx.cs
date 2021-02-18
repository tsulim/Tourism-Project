using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo
{
    public partial class ATour : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                if (Session["SSTitle"] != null)
                {
                    //Assign session variables 
                    Lbl_title.Text = Session["SSTitle"].ToString();
                    Image1.ImageUrl = Session["SSImage"].ToString();
                    Lbl_details.Text = Session["SSDetails"].ToString();
                    Lbl_DT.Text = Session["SSDateTime"].ToString();
                    Lbl_price.Text = Session["SSPrice"].ToString();
                    Lbl_iti.Text = Session["SSIti"].ToString();

                    ////Retrieve Tour by Title 
                    //Service1Client client = new Service1Client(); 
                    //Tour tour = client.GetTourByTitle(lbl_title1.Text); 

                    //tb_details.Text = tour.Details; 
                    //ViewState["currDetails"] = tour.Details; 
                    //ViewState["currDateTime"] = tour.DateTime; 
                    //ViewState["currPrice"] = tour.Price.ToString(); 
                    //ViewState["currMinPpl"] = tour.MinPeople.ToString(); 
                    //ViewState["currMaxPpl"] = tour.MaxPeople.ToString(); 
                    //ViewState["currIti"] = tour.Itinerary; 

                }
                else
                {
                    Response.Redirect("TourOverview.aspx");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewTour.aspx");
        }
    }
}