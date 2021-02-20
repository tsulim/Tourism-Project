using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tobloggo.MyDBServiceReference;

namespace Tobloggo.Admin
{
    public partial class ListUsers : System.Web.UI.Page
    {
        MyDBServiceReference.Service1Client client = new MyDBServiceReference.Service1Client();
        protected void Page_Load(object sender, EventArgs e)
        {
            List<User> userList = client.GetAllUsers().ToList();
            ListView1.DataSource = userList;
            ListView1.DataBind();
        }
    }
}