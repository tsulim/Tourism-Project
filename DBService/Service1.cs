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
        public int CreateUser(string name, string passwordHash, string passwordSalt, string email, string contact, string iv, string key)
        {
            User user = new User(name, passwordHash, passwordSalt, email, contact, iv, key);
            return user.CreateUser();
        }

        public int CreateOrFindSingleGoogleUser(string googleId, string name, string email)
        {
            User user = new User(googleId, name, email);
            User finding = user.SelectByEmail(user.Email);
            if (finding == null)
            {
                var result = user.CreateGoogleUser();
                return result;
            } else
            {
                return 0;
            }
        }

        public int UpdateUser(User user)
        {
            return user.UpdateUser();
        }

        public User GetUserById(string id)
        {
            User user = new User();
            return user.SelectById(id);
        }
        public User GetUserByEmail(string email)
        {
            User user = new User();
            return user.SelectByEmail(email);
        }

        public List<User> GetAllUsers()
        {
            User user = new User();
            return user.SelectAll();
        }
        // User Codes End

        // Event Codes Start
        public int CreateEvent(string name, string location, string desc, DateTime eStartDate, DateTime eEndDate, string userId)
        {
            Event eventObj = new Event(name, location, desc, eStartDate, eEndDate, userId);
            return eventObj.CreateEvent();
        }

        public int UpdateEvent(Event eventObj)
        {
            return eventObj.UpdateEvent();
        }

        public Event GetEventById(string id)
        {
            Event eventObj = new Event();
            return eventObj.SelectById(id);
        }

        public List<Event> GetAllEvents()
        {
            Event eventObj = new Event();
            return eventObj.SelectAll();
        }

        //EventTeam
        
        public int CreateEventTeam(string teamName, string teamLeader, string contactEmail, DateTime tStartDate, DateTime tEndDate, string eventId)
        {
            EventTeam eventTeamObj = new EventTeam(teamName, teamLeader, contactEmail, tStartDate, tEndDate, eventId);
            return eventTeamObj.CreateEventTeam();
        }
        public int UpdateEventTeam(EventTeam eventTeamObj)
        {
            return eventTeamObj.UpdateEventTeam();
        }
        public int DeleteEventTeam(string teamId)
        {
            EventTeam eventTeamObj = new EventTeam();
            return eventTeamObj.DeleteEventTeam(teamId);
        }
        public EventTeam GetEventTeamById(string id)
        {
            EventTeam eventTeamObj = new EventTeam();
            return eventTeamObj.SelectById(id);
        }
        public List<EventTeam> GetAllEventTeamByEventId(string eventId)
        {
            EventTeam eventTeamObj = new EventTeam();
            return eventTeamObj.SelectAllTeamByEventId(eventId);
        }

        //Tasks

        public int CreateEventTask(string name, string desc, Double difficulty, string teamId)
        {
            Tasks taskObj = new Tasks(name, desc, difficulty, teamId);
            return taskObj.CreateTask();
        }
        public int UpdateTask(Tasks taskObj)
        {
            return taskObj.UpdateTask();
        }
        
        public int DeleteTask(string taskId)
        {
            Tasks taskObj = new Tasks();
            return taskObj.DeleteTask(taskId);
        }
        public List<Tasks> GetAllTaskByEventTeamId(string eventTeamId)
        {
            Tasks taskObj = new Tasks();
            return taskObj.SelectAllTasksByEventTeamId(eventTeamId);
        }



        // Event Codes End

        // Location Codes Start
        public List<Location> GetAllLocations()
        {
            Location loca = new Location();
            return loca.SelectAll();
        }

        public int CreateLocation(string name, string address, string type, string images, int userid)
        {
            Location loca = new Location(name, address, type, images, userid);
            return loca.Insert();
        }

        public Location GetLastLocation(int userid)
        {
            Location loca = new Location();
            return loca.SelectLast(userid);
        }
        // Location Codes End

        // Ticket Codes Start
        public int CreateTicket(string name, double price, int locaid)
        {
            Ticket tic = new Ticket(name, price, locaid);
            return tic.Insert();
        }
        // Ticket Codes End
    }
}
