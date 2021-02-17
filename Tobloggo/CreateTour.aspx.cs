using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web.UI;
using Tobloggo.DBServiceReference;

namespace Tobloggo
{
    public partial class CreateTour : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool ValidateInput()
        {
            bool result;lbMsg.Text = String.Empty;
            lbMsg.ForeColor = Color.Red;
            if (String.IsNullOrEmpty(tb_title.Text))
            {
                lbMsg.Text += "Title is required!" + "<br/>";
            }
            Service1Client client = new Service1Client();
            Tour tour = client.GetTourByTitle(tb_title.Text);
            if (tour != null)
            {
                lbMsg.Text += "Title already exists!" + "<br/>";
            }
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
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string image = "";
            if (FileUpload.HasFile == true)
            {
                image = "Images\\" + FileUpload.FileName;
            }

            bool validInput = ValidateInput();

            if (validInput)
            {
                int minPpl = Convert.ToInt32(ddlMinPpl.Text);
                int maxPpl = Convert.ToInt32(ddlMaxPpl.Text);
                double price = Convert.ToDouble(tb_price.Text);

                var reqDateTime = calendar.Text;

                Service1Client client = new Service1Client();
                int result = client.CreateTour(tb_title.Text, FileUpload.FileName, tb_details.Text, reqDateTime, price, minPpl, maxPpl, tb_iti.Text);
                if (result == 1)
                {
                    string saveimg = Server.MapPath(" ") + "\\" + image;
                    FileUpload.SaveAs(saveimg);
                    lbMsg.ForeColor = Color.Green;
                    lbMsg.Text = "Tour Record Inserted Successfully!";
                }
                else
                    lbMsg.Text = "SQL Error. Insert Unsuccessful!";
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("TourOverview.aspx");
        }
    }
}