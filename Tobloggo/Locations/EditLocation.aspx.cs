using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo.Locations
{
    public partial class EditLocation : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        private string locaHTMLDetails;
        public string LocaHTMLDetails { get { return locaHTMLDetails; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.RouteData.Values["locaId"] == null || Session["UserId"] == null)
            {
                Response.Redirect("~/CustomErrors/Error404.html");
            }
            else
            {
                var user = client.GetUserByEmail(Session["UserId"].ToString());
                if (user.Authorization == 1 || user.Authorization == 3)
                {
                    var locaId = Convert.ToInt32(this.RouteData.Values["locaId"].ToString());
                    var selectedLoca = client.GetLocationById(locaId);

                    locaName.Text = selectedLoca.Name;
                    locaAddress.Text = selectedLoca.Address;
                    locaHTMLDetails = selectedLoca.Details;
                    locaType.SelectedValue = selectedLoca.Type;
                    var imgList = selectedLoca.Images.Split(',').ToList();

                    for (var i = 0; i < imgList.Count; i++)
                    {
                        Panel div = new Panel();
                        System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();

                        img.CssClass = "thumbnail";
                        img.ImageUrl = "/images/" + imgList[i];
                        img.AlternateText = imgList[i];

                        div.Controls.Add(img);

                        imageresult.Controls.Add(div);
                    }

                    imgCount.Value = imgList.Count.ToString();

                    var itemList = client.GetTicketByLocaId(selectedLoca.Id);
                    var itemListLen = itemList.Length;

                    Repeater1.DataSource = itemList;
                    Repeater1.DataBind();

                    itemCount.Value = itemListLen.ToString();


                } else {
                    Response.Redirect("~/CustomErrors/Error503.html");
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
            }
            else
            {
                lbl_name.Text = "";
            }

            if (String.IsNullOrEmpty(locaAddress.Text))
            {
                lbl_addr.Text = "Location address is empty!";
                lbl_addr.ForeColor = Color.Red;
                result = false;
            }
            else
            {
                lbl_addr.Text = "";
            }

            if (hiddenContentField.Value.Equals("<p><br></p>"))
            {
                lbl_detail.Text = "Location detail is empty!";
                lbl_detail.ForeColor = Color.Red;
                result = false;
            }
            else
            {
                lbl_detail.Text = "";
            }

            if (locaType.SelectedValue.ToString() == "-1")
            {
                lbl_type.Text = "Location type is empty!";
                lbl_type.ForeColor = Color.Red;
                result = false;
            }
            else
            {
                lbl_type.Text = "";
            }

            //if (locaImages.PostedFiles.Count() == 1 && String.IsNullOrEmpty(locaImages.PostedFile.FileName))
            //{
            //    lbl_image.Text = "No images selected!";
            //    lbl_image.ForeColor = Color.Red;
            //    result = false;
            //}
            //else
            //{
            //    lbl_image.Text = "";
            //}

            return result;

        }

        protected void addBtn_Click(object sender, EventArgs e)
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

                int id = Convert.ToInt32(this.RouteData.Values["locaId"].ToString());
                var loca = client.GetLocationById(id);
                string name = locaName.Text.ToString();
                string address = locaAddress.Text.ToString();
                string details = hiddenContentField.Value.ToString();
                //string details = locaDetails.Text.ToString();
                string type = locaType.SelectedValue.ToString();
                string images = string.Join(",", fileList);

                if (fileList.Count != 0 || fileList != null)
                {
                    images = loca.Images + "," + images;
                } else
                {
                    images = loca.Images;
                }

                int userid = 1;

                int result = client.UpdateLocation(id, name, address, details, type, images, userid);
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

                    var itemList = client.GetTicketByLocaId(id);

                    for (var setNum = 1; setNum < itemList.Length + 1; setNum++)
                    {
                        var rowNameId = "multipleItemNamex" + setNum;
                        var rowPriceId = "multipleItemPricex" + setNum;

                        var itemName = Request.Form[rowNameId];
                        var itemPrice = Request.Form[rowPriceId];

                        System.Diagnostics.Debug.WriteLine("whatever variable");

                        if (itemName != null && itemPrice != null)
                        {
                            if (itemName != "" && itemPrice != "")
                            {
                                client.UpdateTicketInfo(setNum, itemName, Convert.ToDouble(itemPrice));
                                System.Diagnostics.Debug.WriteLine(itemName.ToString());
                                System.Diagnostics.Debug.WriteLine(itemPrice.ToString());
                            } else
                            {
                                client.DeleteTicket(setNum);
                                System.Diagnostics.Debug.WriteLine("deteledTicket");
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