using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Tobloggo
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {

            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);


            // Add Routes.
            RegisterCustomRoutes(RouteTable.Routes);

        }

        void RegisterCustomRoutes(RouteCollection routes)
        {

            routes.MapPageRoute(
                "EditUserRoute",
                "Admin/EditUserDetail/{userId}",
                "~/Admin/EditUser.aspx"
            );
        }
    }
}