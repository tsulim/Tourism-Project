using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Tobloggo
{
    public partial class CreateLocation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAdd_onClick(object sender, EventArgs e)
        {
            List<String> fileList = new List<String>();
            for (var i = 0; i < locaImages.PostedFiles.Count(); i++)
            {
                Guid g = Guid.NewGuid();
                string fileName = Path.GetFileName(locaImages.PostedFiles[i].FileName);
                locaImages.SaveAs(Server.MapPath("~/images/" + g + fileName));
                fileList.Add(fileName);
            }
            
            string name = locaName.Text.ToString();
            string address = locaAddress.Text.ToString();
            string type = locaType.SelectedValue.ToString();
            string images = string.Join(",", fileList);
            bool status = true;
            int userid = 1;

            MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
            int result = client.CreateLocation(name, address, type, images, status, userid);
            if (result == 1)
            {
                Response.Redirect("~/Locations.aspx");
            } else
            {
                lbl_name.Text = "Error";
            }
            //var reqImages = Request.Form["locaImages"].ToString().Split(',').ToList<String>();

            //lbl_name.Text = name;
            //lbl_address.Text = address;
            //lbl_type.Text = type;
            //lbl_images.Text = string.Join(",", fileList);
            //lbl_status.Text = status.ToString();
            //lbl_userid.Text = userid.ToString();

            //Response.Redirect("~/WebForm1.aspx");
        }
    }
}