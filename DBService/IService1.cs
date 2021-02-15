using DBService.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace DBService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here
        // User Codes Start
        [OperationContract]
        int CreateUser(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key);

        [OperationContract]
        int CreateOrFindSingleGoogleUser(string googleId, string name, string email);

        [OperationContract]
        int UpdateUser(User user);

        [OperationContract]
        User GetUserById(string id);

        [OperationContract]
        User GetUserByEmail(string email);

        [OperationContract]
        List<User> GetAllUsers();
        // User Codes End

        // Location Codes Start
        [OperationContract]
        List<Location> GetAllLocations();
        
        [OperationContract]
        List<Location> GetAllAvailLocations();

        [OperationContract]
        List<Location> GetAllTypeLocations(string type);

        [OperationContract]
        int CreateLocation(string name, string address, string details, string type, string images, int userid);
        
        [OperationContract]
        Location GetLastLocation(int userid);

        [OperationContract]
        Location GetLocationById(int locaid);
        // Location Codes End

        // Ticket Codes Start
        [OperationContract]
        int CreateTicket(string name, double price, int locaid);
        [OperationContract]
        List<Ticket> GetTicketByLocaId(int locaId);
        // Ticket Codes End

    }

    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    // You can add XSD files into the project. After building the project, you can directly use the data types defined there, with the namespace "DBService.ContractType".
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }
}
