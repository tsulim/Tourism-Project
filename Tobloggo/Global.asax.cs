using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Configuration;
using Stripe;

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
            routes.MapPageRoute(
                "EventProgressChartCreateRoute",
                "Events/ProgressChartCreate/{eventId}",
                "~/Events/CreateEventProgressChartPage.aspx"
            );
            routes.MapPageRoute(
                "EventProgressChartRoute",
                "Events/ProgressChart/{eventId}",
                "~/Events/EventProgressChartPage.aspx"
            );

            routes.MapPageRoute(
                "EventEditProgressChartRoute",
                "Events/ProgressChart/Edit/{eventId}",
                "~/Events/EditEventPage.aspx"
            );

            routes.MapPageRoute(
                "EventCreateTeamRoute",
                "Events/ProgressChart/CreateTeam/{eventId}",
                "~/Events/CreateEventTeam.aspx"
            );


            routes.MapPageRoute(
                "EventTeamPageRoute",
                "Events/ProgressChart/TeamPage/{teamId}",
                "~/Events/EventTeamPage.aspx"
            );

            routes.MapPageRoute(
                "EventTeamDeleteRoute",
                "Events/ProgressChart/DeleteTeam/{teamId}",
                "~/Events/DeleteEventTeamPage.aspx"
            );

            routes.MapPageRoute(
                "ViewLocationRoute",
                "Locations/Viewing/{locaId}",
                "~/Locations/View.aspx"
            );

            routes.MapPageRoute(
                "LocationTypeRoute",
                "Locations/{locaType}",
                "~/Locations/Default.aspx"
            );

            routes.MapPageRoute(
                "BPartnerRoute",
                "BPartner",
                "~/Locations/Overview.aspx"
            );

            routes.MapPageRoute(
                "CreateLocationRoute",
                "BPartner/Locations/Create",
                "~/Locations/CreateLocation.aspx"
            );

            routes.MapPageRoute(
                "EditLocationRoute",
                "BPartner/Locations/Edit/{locaId}",
                "~/Locations/EditLocation.aspx"
            );


            routes.MapPageRoute(
                "PaymentRoute",
                "Payment/Checkout/{paySum}",
                "~/Charge.aspx"
            );

            routes.MapPageRoute(
                "PaymentSuccessRoute",
                "Payment/Success",
                "~/Successful.aspx"
            );
        }
    }
}