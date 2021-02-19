using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo
{
    public partial class UpdateInvoicePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == false)
            {
                if (Session["BookingId"] != null && Session["TourName"] != null && Session["CustName"] != null && Session["InvType"] != null)
                {
                    // Assign session variables for customer id, name and account labels
                    lbBookId.Text = Session["BookingId"].ToString();
                    lbTourName.Text = Session["TourName"].ToString();
                    lbCustName.Text = Session["CustName"].ToString();

                    if (Session["InvType"].ToString() == "BC")
                    {
                        ddlInvType.SelectedIndex = 1;
                    }

                    else if (Session["InvType"].ToString() == "RA")
                    {
                        ddlInvType.SelectedIndex = 2;
                    }

                    // Store the current renew mode to compare with new choice unless it is the default value
                    ViewState["currInvType"] = Session["InvType"].ToString();


                }
                else
                {
                    Response.Redirect("InvoiceForm.aspx");
                }

            }
        }
        //Adeline can only update invoice type only.

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            int updCnt;

            // Retrieve the current renew mode from ViewState
            string currInvType = (string)ViewState["currInvType"];

            if (ddlInvType.SelectedValue == "0")
            {
                lbResult.Text = "Please select an invoice type";
                lbResult.ForeColor = Color.Red;
            }
            else if (ddlInvType.SelectedValue == currInvType)
            {
                lbResult.Text = "No change detected.";
                lbResult.ForeColor = Color.Red;
            }
            else
            {
                string newInvType = ddlInvType.SelectedValue;

                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                updCnt = client.UpdateInvoice(lbBookId.Text, newInvType);

                if (updCnt == 1)
                {
                    Session["Updated"] = "true";
                    Response.Redirect("InvoiceForm.aspx");
                }
                else
                {
                    lbResult.Text = "Unable to update invoice, please inform system administrator!";
                    lbResult.ForeColor = Color.Red;
                }
                btnUpdate.Enabled = false;
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("InvoiceForm.aspx");
        }
    }
}