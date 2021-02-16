using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tobloggo
{
    public partial class BackendSite : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/CustomErrors/Error404.html");
            } else if (new MyDBServiceReference.Service1Client().GetUserByEmail(Session["UserId"].ToString()).Authorization == 0)
            {
                Response.Redirect("~/CustomErrors/Error404.html");
            }
        }
    }
}