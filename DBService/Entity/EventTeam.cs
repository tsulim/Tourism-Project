using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBService.Entity
{
    public class EventTeam
    {
        public string Id { get; set; }
        public string TeamName { get; set; }
        public string TeamLeader { get; set; } //User Id
        public string ContactEmail { get; set; }
        public DateTime TStartDate { get; set; }
        public DateTime TEndDate { get; set; }


        public string EventId { get; set; } //Event Id

        public EventTeam()
        {

        }

        public EventTeam(string teamName, string teamLeader, string contactEmail, DateTime tStartDate, DateTime tEndDate, string eventId)
        {
            TeamName = teamName;
            TeamLeader = teamLeader;
            ContactEmail = contactEmail;
            TStartDate = tStartDate;
            TEndDate = tEndDate;

            EventId = eventId;
        }

        public EventTeam(string id, string teamName, string teamLeader, string contactEmail, DateTime tStartDate, DateTime tEndDate, string eventId)
        {
            Id = id;
            TeamName = teamName;
            TeamLeader = teamLeader;
            ContactEmail = contactEmail;
            TStartDate = tStartDate;
            TEndDate = tEndDate;

            EventId = eventId;
        }

        public int CreateEventTeam()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO [EventTeam] (TeamName, TeamLeader, ContactEmail, TStartDate, TEndDate, EventId) " +
                "VALUES (@paraTeamName, @paraTeamLeader, @paraContactEmail, @paraTStartDate, @paraTEndDate, @paraEventId)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraTeamName", TeamName);
            sqlCmd.Parameters.AddWithValue("@paraTeamLeader", TeamLeader);
            sqlCmd.Parameters.AddWithValue("@paraContactEmail", ContactEmail);
            sqlCmd.Parameters.AddWithValue("@paraTStartDate", TStartDate);
            sqlCmd.Parameters.AddWithValue("@paraTEndDate", TEndDate);
            sqlCmd.Parameters.AddWithValue("@paraEventId", EventId);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int UpdateEventTeam()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE [EventTeam] SET TeamName=@paraTeamName, TeamLeader=@paraTeamLeader, ContactEmail=@paraContactEmail, TStartDate=@paraTStartDate, TEndDate=@paraTEndDate, EventId " +
                "WHERE Id=@paraId;";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd.Parameters.AddWithValue("@paraTeamName", TeamName);
            sqlCmd.Parameters.AddWithValue("@paraTeamLeader", TeamLeader);
            sqlCmd.Parameters.AddWithValue("@paraContactEmail", ContactEmail);
            sqlCmd.Parameters.AddWithValue("@paraTStartDate", TStartDate);
            sqlCmd.Parameters.AddWithValue("@paraTEndDate", TEndDate);
            sqlCmd.Parameters.AddWithValue("@paraEventId", EventId);

            sqlCmd.Parameters.AddWithValue("@paraId", Id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }
        public int DeleteEventTeam(string teamId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "DELETE FROM [EventTeam] WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd.Parameters.AddWithValue("@paraId", teamId);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;

        }

        public List<EventTeam> SelectAllTeamByEventId(string eventId) 
        {

            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [EventTeam] WHERE EventId=@paraEventId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraEventId", eventId);

            DataSet ds = new DataSet();
            da.Fill(ds);

            List<EventTeam> eventTeamList = new List<EventTeam>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];

                string idVal = row["Id"].ToString();
                string teamName = row["TeamName"].ToString();
                string teamLeader = row["TeamLeader"].ToString();
                string contactEmail = row["ContactEmail"].ToString();
                DateTime tStartDate = DateTime.Parse(row["TStartDate"].ToString());
                DateTime tEndDate = DateTime.Parse(row["TEndDate"].ToString());



                EventTeam eventTeamObj = new EventTeam(idVal, teamName, teamLeader, contactEmail, tStartDate, tEndDate, eventId);
                eventTeamList.Add(eventTeamObj);
            }
            return eventTeamList;
        }

        public EventTeam SelectById(string id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [EventTeam] WHERE Id=@paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            EventTeam eventTeamObj = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];

                string teamName = row["TeamName"].ToString();
                string teamLeader = row["TeamLeader"].ToString();
                string contactEmail = row["ContactEmail"].ToString();
                DateTime tStartDate = DateTime.Parse(row["TStartDate"].ToString());
                DateTime tEndDate = DateTime.Parse(row["TEndDate"].ToString());
                string eventId = row["EventId"].ToString();



                eventTeamObj = new EventTeam(id, teamName, teamLeader, contactEmail, tStartDate, tEndDate, eventId);
            }
            return eventTeamObj;
        }

    }
}
