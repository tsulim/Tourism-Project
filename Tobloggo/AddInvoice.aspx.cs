using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo
{
    public partial class AddInvoice : System.Web.UI.Page
    {
        public string bookidselect;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                //Only show bookings 3 months from now that have not been sent.
                List<Booking> BKList = client.DisplayBookingSales(DateTime.Now.AddMonths(-3).Date.ToString(), DateTime.Now.Date.ToString(), "pending").ToList<Booking>();

                if (BKList != null)
                {

                    DropDownList1.DataSource = BKList; // <-- Get your data from somewhere.
                    DropDownList1.DataValueField = "BookId";
                    DropDownList1.DataTextField = "BookId";
                    DropDownList1.DataBind();

                }
                else
                {
                    lbMsg.Text = "There are no recent bookings for you to create an invoice.";
                    lbMsg.ForeColor = Color.Red;
                }

            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Session["BookingId"] = DropDownList1.SelectedValue;
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();

            DateTime createdate = DateTime.Now;
            string status = "False"; //When creating a new invoice, it will not be sent first
            string type = client.GetInvoiceTypeOnCreate(Session["BookingId"].ToString());
            int result = client.CreateInvoice(Session["BookingId"].ToString(), type, createdate, status);
            if (result == 1)
            {
                Session["BookingId"] = DropDownList1.SelectedValue;
                Session["Added"] = "true";
                Response.Redirect("InvoiceForm.aspx");

            }
            else
            {
                lbMsg.Text = "sql error. insert unsuccessful!";
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("InvoiceForm.aspx");
        }
    }
}