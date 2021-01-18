using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo
{
    public partial class CreateTour : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefreshGridView();
        }

        private void RefreshGridView()
        {
        }

        private bool ValidateInput()
        {
            bool result;
            lbMsg.Text = String.Empty;
            lbMsg.ForeColor = Color.Red;
            if (String.IsNullOrEmpty(tb_title.Text))
            {
                lbMsg.Text += "Title is required!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_img.Text))
            {
                lbMsg.Text += "Image is required!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_details.Text))
            {
                lbMsg.Text += "Details is required!" + "<br/>";
            }
            DateTime startDT;
            result = DateTime.TryParse(tb_startDT.Text, out startDT);
            if (!result)
            {
                lbMsg.Text += "Start Date Time is invalid!" + "<br/>";
            }
            DateTime endDT;
            result = DateTime.TryParse(tb_endDT.Text, out endDT);
            if (!result)
            {
                lbMsg.Text += "End Date Time is invalid!" + "<br/>";
            }
            double price;
            result = double.TryParse(tb_price.Text, out price);
            if (!result)
            {
                lbMsg.Text += "Price is invalid!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_minPpl.Text))
            {
                lbMsg.Text += "Number of minimum people is required!" + "<br/>";
            }
            if (String.IsNullOrEmpty(tb_maxPpl.Text))
            {
                lbMsg.Text += "Number of maximum people is required!" + "<br/>";
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
            bool validInput = ValidateInput();

            if (validInput)
            {
                DateTime startDT= Convert.ToDateTime(tb_startDT.Text);
                DateTime endDT = Convert.ToDateTime(tb_endDT.Text);
                int minPpl = Convert.ToInt32(tb_minPpl.Text);
                int maxPpl = Convert.ToInt32(tb_maxPpl.Text);
                double price = Convert.ToDouble(tb_price.Text);

                DBServiceReference.Service1Client client = new DBServiceReference.Service1Client();
                int result = client.CreateTour(tb_title.Text, tb_img.Text, tb_details.Text, startDT, endDT, price, minPpl, maxPpl, tb_iti.Text);
                if (result == 1)
                {
                    RefreshGridView();
                    lbMsg.ForeColor = Color.Green;
                    lbMsg.Text = "Employee Record Inserted Successfully!";
                }
                else
                    lbMsg.Text = "SQL Error. Insert Unsuccessful!";
            }
        }
    }
}