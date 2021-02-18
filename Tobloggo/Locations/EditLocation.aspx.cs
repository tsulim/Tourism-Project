using System;
using System.Collections.Generic;
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
                        Image img = new Image();

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

        protected void addBtn_Click(object sender, EventArgs e)
        {

        }
    }
}