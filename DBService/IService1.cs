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

        // Event Codes Start
        [OperationContract]
        int CreateEvent(string name, string location, string desc, DateTime eStartDate, DateTime eEndDate, string userId);

        [OperationContract]
        int UpdateEvent(Event eventObj);

        [OperationContract]
        Event GetEventById(string id);

        [OperationContract]
        List<Event> GetAllEvents();

        //EventTeam
        [OperationContract]
        int CreateEventTeam(string teamName, string teamLeader, string contactEmail, DateTime tStartDate, DateTime tEndDate, string eventId);

        [OperationContract]
        int UpdateEventTeam(EventTeam eventTeamObj);
        [OperationContract]
        int DeleteEventTeam(string teamId);

        [OperationContract]
        EventTeam GetEventTeamById(string id);

        [OperationContract]
        List<EventTeam> GetAllEventTeamByEventId(string eventId);

        //Tasks

        [OperationContract]
        int CreateEventTask(string name, string desc, Double difficulty, string teamId);

        [OperationContract]
        int UpdateTask(Tasks taskObj);

        [OperationContract]
        int DeleteTask(string taskId);

        [OperationContract]
        List<Tasks> GetAllTaskByEventTeamId(string eventTeamId);


        // Event Codes End

        // Location Codes Start
        [OperationContract]
        List<Location> GetAllLocations();
        [OperationContract]
        int CreateLocation(string name, string address, string type, string images, int userid);
        [OperationContract]
        Location GetLastLocation(int userid);
        // Location Codes End

        // Ticket Codes Start
        [OperationContract]
        int CreateTicket(string name, double price, int locaid);
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
