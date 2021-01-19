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

        // User Codes Start
        public User GetUserById(string id)
        {
            User user = new User();
            return user.SelectById(id);
        }
        // User Codes End

        // Location Codes Start
        public List<Location> GetAllLocations()
        {
            Location loca = new Location();
            return loca.SelectAll();
        }

        public int CreateLocation(string name, string address, string type, string images, bool status, int userid)
        {
            Location loca = new Location(name, address, type, images, status, userid);
            return loca.Insert();
        }
        // Location Codes End
    }
}
