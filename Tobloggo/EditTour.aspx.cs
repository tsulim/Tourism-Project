using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.DBServiceReference;

namespace Tobloggo
{
    public partial class EditTour : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                if (Session["SSTitle"] != null)
                {
                    //Assign session variables
                    lbl_title1.Text = Session["SSTitle"].ToString();
                    tb_details.Text = Session["SSDetails"].ToString();
                    calendar.Text = Session["SSDateTime"].ToString();
                    tb_price.Text = Session["SSPrice"].ToString();
                    ddlMinPpl.Text = Session["SSMinPpl"].ToString();
                    ddlMaxPpl.Text = Session["SSMaxPpl"].ToString();
                    tb_iti.Text = Session["SSIti"].ToString();

                    //Retrieve Tour by Title
                    Service1Client client = new Service1Client();
                    Tour tour = client.GetTourByTitle(lbl_title1.Text);

                    tb_details.Text = tour.Details;
                    ViewState["currDetails"] = tour.Details;
                    ViewState["currDateTime"] = tour.DateTime;
                    ViewState["currPrice"] = tour.Price.ToString();
                    ViewState["currMinPpl"] = tour.MinPeople.ToString();
                    ViewState["currMaxPpl"] = tour.MaxPeople.ToString();
                    ViewState["currIti"] = tour.Itinerary;

                }
                else
                {
                    Response.Redirect("TourOverview.aspx");
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string image = "";
            if (FileUpload.HasFile == true)
            {
                image = "Images\\" + FileUpload.FileName;
            }

            bool validInput = ValidateInput();

            if (validInput)
            {

                ////Retrieve the current value from ViewState
                string currDetails = (string)ViewState["currDetails"];
                string currDateTime = (string)ViewState["currDateTime"];
                string currPrice = (string)ViewState["currPrice"];
                string currMinPpl = (string)ViewState["currMinPpl"];
                string currMaxPpl = (string)ViewState["currMaxPpl"];
                string currIti = (string)ViewState["currIti"];

                string newImage = FileUpload.FileName;
                string newDetails = tb_details.Text;
                string newDateTime = calendar.Text;
                string newPrice = tb_price.Text;
                string newMinPpl = ddlMinPpl.Text;
                string newMaxPpl = ddlMaxPpl.Text;
                string newIti = tb_iti.Text;

                int minPpl = Convert.ToInt32(newMinPpl);
                int maxPpl = Convert.ToInt32(newMaxPpl);
                double price = Convert.ToDouble(newPrice);

                Service1Client client = new Service1Client();
                int updCnt = client.UpdateTour(lbl_title1.Text, newImage, newDetails, newDateTime, price, minPpl, maxPpl, newIti);

                if (updCnt == 1)
                {
                    lbMsg.Text = "Details Updated!";
                    lbMsg.ForeColor = Color.Green;
                }
                else
                {
                    lbMsg.Text = "Unable to update, please inform system administrator!";

                    btnUpdate.Enabled = false;
                }
                btnUpdate.Enabled = false;
            }

        }

        private bool ValidateInput()
        {
            bool result; lbMsg.Text = String.Empty;
            lbMsg.ForeColor = Color.Red;
            if (String.IsNullOrEmpty(FileUpload.FileName))
            {
                lbMsg.Text += "Image is required!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_details.Text))
            {
                lbMsg.Text += "Details is required!" + "<br/>";
            }
            double price;
            result = double.TryParse(tb_price.Text, out price);
            if (String.IsNullOrEmpty(tb_price.Text))
            {
                lbMsg.Text += "Price is required!" + "<br/>";
            }
            else if (!result)
            {
                lbMsg.Text += "Price is invalid!" + "<br/>";
            }
            if (ddlMinPpl.SelectedIndex == 0)
            {
                lbMsg.Text += "Minimum number of people is required!" + "<br/>";
            }
            if (ddlMaxPpl.SelectedIndex == 0)
            {
                lbMsg.Text += "Maximum number of people is required!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_iti.Text))
            {
                lbMsg.Text += "Itinerary is required!" + "<br/>";
            }

            if (String.IsNullOrEmpty(lbMsg.Text))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("TourOverview.aspx");
        }
    }
}