using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Tobloggo.Locations
{
    public partial class CreateLocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAdd_onClick(object sender, EventArgs e)
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
                locaImages.SaveAs(Server.MapPath("~/images/" + newFileName));
                fileList.Add(newFileName);
            }

            //string name = locaName.Text.ToString();
            //string address = locaAddress.Text.ToString();
            //string type = locaType.SelectedValue.ToString();
            //string images = string.Join(",", fileList);
            //bool status = true;
            //int userid = 1;

            //MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            //int result = client.CreateLocation(name, address, type, images, status, userid);
            int result = 1;
            if (result == 1)
            {
                var itemNum = Convert.ToInt32(itemCount.Value);
                
                for (var num = 1; num < itemNum; num++)
                {
                    var rowNameId = "multipleItemName" + num;
                    var rowPriceId = "multipleItemPrice" + num;
                    var c = new Control();
                    var nameContr = c.FindControl(rowNameId);
                    var priceContr = c.FindControl(rowPriceId);
                    
                    if (nameContr != null && priceContr != null)
                    {
                        var itemName = nameContr;
                    }
                }


                //Response.Redirect("~/Locations.aspx");

                //createTickets();

            }
            else
            {
                //lbl_name.Text = "Error";
            }
        }

        protected void createTickets()
        {

        }
    }
}