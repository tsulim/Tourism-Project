using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;


namespace Tobloggo.Locations
{
    public partial class CreateLocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAdd_onClick(object sender, EventArgs e)
        {
            if (ValidateInputs())
            {
                string folderPath = Server.MapPath("~/images/");

                // Check whether Directory exists
                if (!Directory.Exists(folderPath))
                {
                    // If Directory does not exist. Create it
                    Directory.CreateDirectory(folderPath);
                }

                List<String> fileList = new List<String>();
                for (var i = 0; i < locaImages.PostedFiles.Count(); i++)
                {
                    Guid g = Guid.NewGuid();
                    string fileName = Path.GetFileName(locaImages.PostedFiles[i].FileName);
                    string newFileName = g + fileName;
                    locaImages.PostedFiles[i].SaveAs(Server.MapPath("~/images/" + newFileName));
                    fileList.Add(newFileName);
                }

                string name = locaName.Text.ToString();
                string address = locaAddress.Text.ToString();
                string details = hiddenContentField.Value.ToString();
                //string details = locaDetails.Text.ToString();
                string type = locaType.SelectedValue.ToString();
                string images = string.Join(",", fileList);
                int userid = 1;

                MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
                int result = client.CreateLocation(name, address, details, type, images, userid);
                if (result == 1)
                {
                    var itemNum = Convert.ToInt32(itemCount.Value);

                    var locaId = client.GetLastLocation(userid).Id;
                    for (var num = 1; num < itemNum + 1; num++)
                    {
                        var rowNameId = "multipleItemName" + num;
                        var rowPriceId = "multipleItemPrice" + num;

                        var itemName = Request.Form[rowNameId];
                        var itemPrice = Request.Form[rowPriceId];

                        System.Diagnostics.Debug.WriteLine("whatever variable");

                        if (itemName != null && itemPrice != null)
                        {
                            if (itemName != "" && itemPrice != "")
                            {
                                createTickets(itemName, Convert.ToDouble(itemPrice), locaId);
                                System.Diagnostics.Debug.WriteLine(itemName.ToString());
                                System.Diagnostics.Debug.WriteLine(itemPrice.ToString());
                            }
                        }
                    }

                    Response.Redirect("~/Locations");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Error 500: Internal Server Error - Create Location");
                    Response.Redirect("~/CustomErrors/Error500.html");
                }
            }
        }

        protected bool ValidateInputs()
        {
            var result = true;
            if (String.IsNullOrEmpty(locaName.Text))
            {
                lbl_name.Text = "Location name is empty!";
                lbl_name.ForeColor = Color.Red;
                result = false;
            } else
            {
                lbl_name.Text = "";
            }

            if (String.IsNullOrEmpty(locaAddress.Text))
            {
                lbl_addr.Text = "Location address is empty!";
                lbl_addr.ForeColor = Color.Red;
                result = false;
            } else
            {
                lbl_addr.Text = "";
            }

            if (hiddenContentField.Value.Equals("<p><br></p>"))
            {
                lbl_detail.Text = "Location detail is empty!";
                lbl_detail.ForeColor = Color.Red;
                result = false;
            } else
            {
                lbl_detail.Text = "";
            }

            if (locaType.SelectedValue.ToString() == "-1")
            {
                lbl_type.Text = "Location type is empty!";
                lbl_type.ForeColor = Color.Red;
                result = false;
            } else
            {
                lbl_type.Text = "";
            }

            if (locaImages.PostedFiles.Count() == 1 && String.IsNullOrEmpty(locaImages.PostedFile.FileName))
            {
                lbl_image.Text = "No images selected!";
                lbl_image.ForeColor = Color.Red;
                result = false;
            } else
            {
                lbl_image.Text = "";
            }

            return result;

        }
        protected void createTickets(string itemName, double itemPrice, int locationId)
        {
            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            int result = client.CreateTicket(itemName, itemPrice, locationId);
            if (result != 1)
            {
                System.Diagnostics.Debug.WriteLine("Error 500: Internal Server Error - Create Tickets");
                Response.Redirect("~/CustomErrors/Error500.html");
            }
        }
    }
}