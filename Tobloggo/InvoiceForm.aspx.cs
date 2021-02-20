using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public partial class InvoiceForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RefreshGridView();
            if (Session["BookingId"] != null)
            {
                if (Session["Added"] != null)
                {
                    string result = Session["Added"].ToString();
                    if (result == "true")
                    {
                        string bookid = Session["BookingId"].ToString();
                        Lbl_Msg.Text = "Invoice for Booking No. " + bookid + " sucessfully created!";
                        PanelMsgResult.CssClass = "alert alert-dismissable alert-success";
                        PanelMsgResult.Visible = true;
                    }

                    Session["Added"] = null;
                }
                else if (Session["Updated"] != null)
                {
                    string result = Session["Updated"].ToString();
                    if (result == "true")
                    {
                        string bookid = Session["BookingId"].ToString();
                        Lbl_Msg.Text = "Invoice for Booking No. " + bookid + " sucessfully updated!";
                        PanelMsgResult.CssClass = "alert alert-dismissable alert-info";
                        PanelMsgResult.Visible = true;
                    }

                    Session["Updated"] = null;
                }

            }
        }
        private void RefreshGridView()
        {
            //set the default filter and sort values
            if (Session["Filter"] == null)
            {
                Session["Filter"] = "";
            }
            if (Session["Sort"] == null)
            {
                Session["Sort"] = "dateDesc";
            }

            Service1Client client = new Service1Client();
            List<Invoice> invList = client.GetAllInvoice(Session["Filter"].ToString(), Session["Sort"].ToString(), searchBar.Text).ToList<Invoice>();

            // using gridview to bind to the list of employee objects
            gvInvoice.Visible = true;
            gvInvoice.DataSource = invList;
            gvInvoice.DataBind();

            if (!invList.Any())
            {
                //No results found
                lblMsgResults.Text = "No Results found.";
                //disable export to excel
                btnExport.Enabled = false;
            }
            else
            {
                lblMsgResults.Text = invList.Count().ToString() + " Invoice(s) found.";
                //enable export to excel
                btnExport.Enabled = true;
            }

            if (Session["Filter"].ToString() == "")
            {
                lblFilterMsg.Text = "";
            }
            else
            {
                string val = Session["Filter"].ToString();
                switch (val)
                {
                    case "BC":
                        val = "BC Invoice Only";
                        break;
                    case "RA":
                        val = "RA Invoice Only";
                        break;
                    case "Pending":
                        val = "Pending Only";
                        break;
                    case "Sent":
                        val = "Sent Only";
                        break;
                }
                lblFilterMsg.Text = "Filtering applied. Showing results for " + val + ".";
            }

            if (Session["Sort"].ToString() == "dateDesc")
            {
                lblSortMsg.Text = "";
            }
            else
            {
                string val = Session["Sort"].ToString();
                switch (val)
                {
                    case "dateAsc":
                        val = "Last Updated (Oldest to Latest)";
                        break;
                    case "idDesc":
                        val = "Booking ID (Highest to Lowest)";
                        break;
                    case "idAsc":
                        val = "Booking ID (Lowest to Highest)";
                        break;
                }
                lblSortMsg.Text = "Sorting applied. Showing results sorted by " + val + ".";
            }
        }

        protected void gvInvoice_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            // If multiple buttons are used in a GridView control, use the
            // CommandName property to determine which button was clicked.
            if (e.CommandName == "Update")
            {
                // Convert the row index stored in the CommandArgument
                // property to an Integer.
                int index = Convert.ToInt32(e.CommandArgument);
                // Retrieve the row that contains the button clicked 
                // by the user from the Rows collection.
                GridViewRow row = gvInvoice.Rows[index];

                Session["BookingId"] = row.Cells[1].Text;
                Session["TourName"] = row.Cells[2].Text;
                Session["CustName"] = row.Cells[3].Text;
                Session["InvType"] = row.Cells[4].Text;
                Response.Redirect("UpdateInvoicePage.aspx");
            }
            else if (e.CommandName == "Send")
            {
                Service1Client client = new Service1Client();
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvInvoice.Rows[index];
                string status = row.Cells[6].Text;
                //FIXME: Should I allow user to keep sending invoice? what if customer deletes from email inbox and requests for a new one. Mayb create a modal asking to confirm send again.
                if (status == "sent")
                {
                    Lbl_Msg.Text = "Customer already recieved this invoice.";

                    PanelMsgResult.CssClass = "alert alert-dismissable alert-danger";
                    PanelMsgResult.Visible = true;
                }
                else
                {
                    string bookid = row.Cells[1].Text;

                    int result = client.SendInvoice(bookid);
                    if (result == 1)
                    {
                        //Database updated
                        RefreshGridView();
                        Lbl_Msg.Text = "Invoice for Booking No. " + bookid + " sucessfully sent!";
                        PanelMsgResult.CssClass = "alert alert-dismissable alert-success";
                        PanelMsgResult.Visible = true;
                    }
                    else
                    {
                        Lbl_Msg.Text = "Invoice for Booking No. " + Session["BookingId"].ToString() + " was not successful! There were some errors with the system. Please try again later.";
                        PanelMsgResult.CssClass = "alert alert-dismissable alert-danger";
                        PanelMsgResult.Visible = true;
                    }
                }


            }
        }

        protected void btnAddInvoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddInvoice.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RefreshGridView();
            //Clear search Bar text
            searchBar.Text = "";
        }

        protected void gvInvoice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInvoice.PageIndex = e.NewPageIndex;
            RefreshGridView();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.ClearContent();
            Response.AppendHeader("content-disposition", "attachment;filename=Invoice.xls");
            Response.ContentType = "application/excel";

            StringWriter stringWriter = new StringWriter();
            HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);

            gvInvoice.AllowPaging = false;
            RefreshGridView();

            //hides unwanted headers
            gvInvoice.HeaderRow.Cells[0].Visible = false;
            gvInvoice.HeaderRow.Cells[7].Visible = false;
            gvInvoice.HeaderRow.Cells[8].Visible = false;

            for (int i = 0; i < gvInvoice.Rows.Count; i++)
            {
                GridViewRow row = gvInvoice.Rows[i];
                row.Cells[0].Visible = false; //hides the checkbox column row by row
                row.Cells[7].Visible = false; //hides the update action column row by row
                row.Cells[8].Visible = false; //hides the send action column row by row

                //add style for alternate row
                if (i % 2 != 0)
                {
                    row.Cells[1].Style.Add("background-color", "#F0F0F0");
                    row.Cells[2].Style.Add("background-color", "#F0F0F0");
                    row.Cells[3].Style.Add("background-color", "#F0F0F0");
                    row.Cells[4].Style.Add("background-color", "#F0F0F0");
                    row.Cells[5].Style.Add("background-color", "#F0F0F0");
                    row.Cells[6].Style.Add("background-color", "#F0F0F0");
                }
            }

            //change the style of gvInvoice
            gvInvoice.HeaderRow.Style.Add("background-color", "#FFFFFF");
            gvInvoice.HeaderRow.Style.Add("color", "#000000");

            gvInvoice.RenderControl(htmlTextWriter);
            Response.Write(stringWriter.ToString());
            Response.End();

            gvInvoice.AllowPaging = true;
            RefreshGridView();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            //only store final sort value if btn was clicked
            Session["Sort"] = ddlSort.SelectedValue;
            RefreshGridView();
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            //only store the final filter value if btn was clicked
            Session["Filter"] = ddlFilter.SelectedValue;
            RefreshGridView();
        }

    }
}