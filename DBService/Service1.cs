using DBService.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace DBService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in both code and config file together.
    public class Service1 : IService1
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        public User GetUserById(string id)
        {
            User user = new User();
            return user.SelectById(id);
        }
        public List<Tour> GetAllTour()
        {
            Tour tour = new Tour();
            return tour.SelectAll();
        }
        public Tour GetTourByTitle(string title)
        {
            Tour tour = new Tour();
            return tour.SelectByTitle(title);
        }
        public int CreateTour(string title, string image, string details, DateTime startDateTime, DateTime endDateTime, double price, int minPpl, int maxPpl, string iti)
        {
            Tour tour = new Tour(title, image, details, startDateTime, endDateTime, price, minPpl, maxPpl, iti);
            return tour.Insert();
        }
    }
}
