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
    public partial class ViewReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Define the name and type of the client scripts on the page.
            //String csname1 = "PopupScript";
            //Type cstype = this.GetType();
            //// Get a ClientScriptManager reference from the Page class.
            //ClientScriptManager cs = Page.ClientScript;
            //// Check to see if the startup script is already registered.
            //if (!cs.IsStartupScriptRegistered(cstype, csname1))
            //{
            //    StringBuilder cstext1 = new StringBuilder();
            //    cstext1.Append("<script type=text/javascript>");
            //    cstext1.Append("</script>");
            //    cs.RegisterStartupScript(cstype, csname1, cstext1.ToString());
            //}

            //if (Session["reportType"] != null)
            //{
            //    RefreshGridView(Session["ReportType"].ToString());
            //} else
            //{
            //    PanelSharedView.Visible = false;
            //    btnExport.Enabled = false;
            //}
        }

        private void RefreshGridView(string reporttype)
        {
            if (reporttype == "BKSales")
            {
                List<Booking> BKList = new List<Booking>();
                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                //TODO: ADD date range filter feature. Dont hardcode. Date must be in the correct format.
                BKList = client.DisplayBookingSales("", "", "").ToList<Booking>();

                // using gridview to bind to the list of employee objects
                gvBKSales.Visible = true;
                gvBKSales.DataSource = BKList;
                gvBKSales.DataBind();

                for (int i = 0; i < gvBKSales.Rows.Count; i++)
                {
                    GridViewRow row = gvBKSales.Rows[i];

                    row.Cells[1].Style.Add("font-weight", "bold");
                    row.Cells[5].Style.Add("font-weight", "bold");
                    if (row.Cells[1].Text == "cancelled")
                    {
                        row.Cells[1].Style.Add("color", "#FF0000");
                    }
                }

                if (!BKList.Any())
                {
                    //No results found
                    lblMsgResults.Text = "No records found.";
                    //disable export to excel
                    btnExport.Enabled = false;
                }
                else
                {
                    lblMsgResults.Text = BKList.Count().ToString() + " records(s) found.";
                    //enable export to excel
                    btnExport.Enabled = true;
                }
            }
            else
            {
                List<Tour> TourList = new List<Tour>();
                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                //TODO: ADD range filter feature. Dont hardcode
                TourList = client.DisplayPackageProfit("0", "1000", "0", "1000", "-1000", "0").ToList<Tour>();

                // using gridview to bind to the list of employee objects
                gvTourProfit.Visible = true;
                gvTourProfit.DataSource = TourList;
                gvTourProfit.DataBind();

                for (int i = 0; i < gvTourProfit.Rows.Count; i++)
                {
                    GridViewRow row = gvTourProfit.Rows[i];

                    row.Cells[0].Style.Add("font-weight", "bold");
                    row.Cells[6].Style.Add("font-weight", "bold");
                    row.Cells[7].Style.Add("font-weight", "bold");
                    if (row.Cells[7].Text != "0")
                    {
                        row.Cells[7].Style.Add("color", "#1E8449");
                    }

                }

                if (!TourList.Any())
                {
                    //No results found
                    lblMsgResults.Text = "No records found.";
                    //disable export to excel
                    btnExport.Enabled = false;
                }
                else
                {
                    lblMsgResults.Text = TourList.Count().ToString() + " records(s) found.";
                    //enable export to excel
                    btnExport.Enabled = true;
                }
            }


        }

        protected void gvBKSales_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBKSales.PageIndex = e.NewPageIndex;
            RefreshGridView(Session["ReportType"].ToString());
        }

        protected void gvTourProfit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvTourProfit.PageIndex = e.NewPageIndex;
            RefreshGridView(Session["ReportType"].ToString());
        }

        protected void ViewBKSalesGV_Click(object sender, EventArgs e)
        {
            Session["ReportType"] = "BKSales";
            PanelSharedView.Visible = true;
            ReportTitle.Text = "Booking Sales";
            PanelViewTourProfit.Visible = false;
            PanelViewBKSales.Visible = true;
            RefreshGridView(Session["ReportType"].ToString());
        }

        protected void ViewTourProfitGV_Click(object sender, EventArgs e)
        {
            Session["ReportType"] = "TourProfit";
            PanelSharedView.Visible = true;
            ReportTitle.Text = "Tour Packages Profit";
            PanelViewBKSales.Visible = false;
            PanelViewTourProfit.Visible = true;
            RefreshGridView(Session["ReportType"].ToString());
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.ClearContent();
            Response.AppendHeader("content-disposition", "attachment;filename=Invoice.xls");
            Response.ContentType = "application/excel";

            StringWriter stringWriter = new StringWriter();
            HtmlTextWriter htmlTextWriter = new HtmlTextWriter(stringWriter);

            gvTourProfit.AllowPaging = false;
            RefreshGridView(Session["ReportType"].ToString());

            for (int i = 0; i < gvTourProfit.Rows.Count; i++)
            {
                GridViewRow row = gvTourProfit.Rows[i];

                //add style for alternate row
                if (i % 2 != 0)
                {
                    row.Cells[0].Style.Add("background-color", "#F0F0F0");
                    row.Cells[1].Style.Add("background-color", "#F0F0F0");
                    row.Cells[2].Style.Add("background-color", "#F0F0F0");
                    row.Cells[3].Style.Add("background-color", "#F0F0F0");
                    row.Cells[4].Style.Add("background-color", "#F0F0F0");
                    row.Cells[5].Style.Add("background-color", "#F0F0F0");
                    row.Cells[6].Style.Add("background-color", "#F0F0F0");
                    row.Cells[7].Style.Add("background-color", "#F0F0F0");
                }
            }

            //change the style
            gvTourProfit.HeaderRow.Style.Add("background-color", "#FFFFFF");
            gvTourProfit.HeaderRow.Style.Add("color", "#000000");

            gvTourProfit.RenderControl(htmlTextWriter);
            Response.Write(stringWriter.ToString());
            Response.End();

            gvTourProfit.AllowPaging = true;
            RefreshGridView(Session["ReportType"].ToString());
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}