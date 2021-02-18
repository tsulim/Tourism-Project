using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Routing;   
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Admin
{
    public partial class EditUser : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        User retrievedUser;
        protected void Page_Load(object sender, EventArgs e)    
        {
            
            if (this.RouteData.Values["userId"] == null)
            {
                Response.Redirect("/Admin/ListUsers");
            } else
            {
                retrievedUser = client.GetUserById(RouteData.Values["userId"].ToString());

                if (retrievedUser == null)
                {
                    Response.Redirect("/Admin/ListUsers");
                }
                else
                {
                    if (!IsPostBack)
                    {
                        editAccountName.Text = retrievedUser.Name;
                        editEmail.Text = retrievedUser.Email;
                        editContact.Text = retrievedUser.Contact;
                        editAuthorization.SelectedValue = retrievedUser.Authorization.ToString();
                        editStripeId.Text = retrievedUser.StripeId;
                    }
                }
            }



        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            retrievedUser.Authorization = int.Parse(editAuthorization.SelectedValue);
            client.UpdateUser(retrievedUser);

            Response.Redirect("/Admin/ListUsers");
        }
    }
}