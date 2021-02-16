using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DBService.Entity
{
    public class Event
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Location { get; set; }
        public string Status { get; set; }
        public string Desc { get; set; }
        public string Images { get; set; }
        public DateTime EStartDate { get; set; }
        public DateTime EEndDate { get; set; }

        public int ProgCreated { get; set; }
        public DateTime PStartDate { get; set; }
        public DateTime PEndDate { get; set; }
        public string UserId { get; set; }


        //public int TotalProgress { get; set; }

        //public 


        public Event()
        {

        }

        public Event(string name, string location, string desc, DateTime eStartDate, DateTime eEndDate, string userId)
        {
            Id = "0";
            Name = name;
            Location = location;
            Status = "In Preparation";
            Desc = desc;
            Images = String.Empty;
            EStartDate  = eStartDate;
            EEndDate = eEndDate;
            ProgCreated = 0;
            PStartDate = DateTime.Now;
            PEndDate = DateTime.Now;
            UserId = userId;

        }
        public Event(string id, string name, string location, string status, string desc, string images, DateTime eStartDate, DateTime eEndDate, int progCreated, DateTime pStartDate, DateTime pEndDate, string userId)
        {
            Id = id;
            Name = name;
            Location = location;
            Status = status;
            Desc = desc;
            Images = images;
            EStartDate = eStartDate;
            EEndDate = eEndDate;
            ProgCreated = progCreated;
            PStartDate = pStartDate;
            PEndDate = pEndDate;
            UserId = userId;

        }

        public int CreateEvent()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO [Event] (Name, Location, Status, [Desc], Images, EStartDate, EEndDate, ProgCreated, PStartDate, PEndDate, UserId ) " +
                "VALUES (@paraName, @paraLocation, @paraStatus, @paraDesc, @paraImages, @paraEStartDate, @paraEEndDate, @paraProgCreated, @paraPStartDate, @paraPEndDate, @paraUserId)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraLocation", Location);
            sqlCmd.Parameters.AddWithValue("@paraStatus", Status);
            sqlCmd.Parameters.AddWithValue("@paraDesc", Desc);
            sqlCmd.Parameters.AddWithValue("@paraImages", Images);
            sqlCmd.Parameters.AddWithValue("@paraEStartDate", EStartDate);
            sqlCmd.Parameters.AddWithValue("@paraEEndDate", EEndDate);
            sqlCmd.Parameters.AddWithValue("@paraProgCreated", ProgCreated);
            sqlCmd.Parameters.AddWithValue("@paraPStartDate", PStartDate);
            sqlCmd.Parameters.AddWithValue("@paraPEndDate", PEndDate);
            sqlCmd.Parameters.AddWithValue("@paraUserId", UserId);


            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int UpdateEvent()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE [Event] SET Name=@paraName, Location=@paraLocation, Status=@paraStatus, [Desc]=@paraDesc, Images=@paraImages, EStartDate=@paraEStartDate," +
                "EEndDate=@paraEEndDate, ProgCreated=@paraProgCreated, PStartDate=@paraPStartDate, PEndDate=@paraPEndDate, UserId=@paraUserId " +
                "WHERE Id=@paraId;";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraLocation", Location);
            sqlCmd.Parameters.AddWithValue("@paraStatus", Status);
            sqlCmd.Parameters.AddWithValue("@paraDesc", Desc);
            sqlCmd.Parameters.AddWithValue("@paraImages", Images);
            sqlCmd.Parameters.AddWithValue("@paraEStartDate", EStartDate);
            sqlCmd.Parameters.AddWithValue("@paraEEndDate", EEndDate);
            sqlCmd.Parameters.AddWithValue("@paraProgCreated", ProgCreated);
            sqlCmd.Parameters.AddWithValue("@paraPStartDate", PStartDate);
            sqlCmd.Parameters.AddWithValue("@paraPEndDate", PEndDate);
            sqlCmd.Parameters.AddWithValue("@paraUserId", UserId);

            sqlCmd.Parameters.AddWithValue("@paraId", Id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public Event SelectById(string id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [Event] INNER JOIN [User] ON [Event].UserId = [User].Id WHERE [Event].Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            DataSet ds = new DataSet();
            da.Fill(ds);

            Event eventObj = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0]; 
                //string idVal = row["Id"].ToString();
                string name = row["Name"].ToString();
                string location = row["Location"].ToString();
                string status = row["Status"].ToString();
                string desc = row["Desc"].ToString();
                string images = row["Images"].ToString();
                DateTime eStartDate = DateTime.Parse(row["EStartDate"].ToString());
                DateTime eEndDate = DateTime.Parse(row["EEndDate"].ToString());
                int progCreated = int.Parse(row["ProgCreated"].ToString());
                DateTime pStartDate = DateTime.Parse(row["PStartDate"].ToString());
                DateTime pEndDate = DateTime.Parse(row["PEndDate"].ToString());
                string userId = row["UserId"].ToString();




                eventObj = new Event(id, name, location, status, desc, images, eStartDate, eEndDate, progCreated, pStartDate, pEndDate, userId);
            }
            return eventObj;
        }

        public List<Event> SelectAll()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from [Event]";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Event> eventList = new List<Event>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                
                string idVal = row["Id"].ToString();
                string name = row["Name"].ToString();
                string location = row["Location"].ToString();
                string status = row["Status"].ToString();
                string desc = row["Desc"].ToString();
                string images = row["Images"].ToString();
                DateTime eStartDate = DateTime.Parse(row["EStartDate"].ToString());
                DateTime eEndDate = DateTime.Parse(row["EEndDate"].ToString());
                int progCreated = int.Parse(row["ProgCreated"].ToString());
                DateTime pStartDate = DateTime.Parse(row["PStartDate"].ToString());
                DateTime pEndDate = DateTime.Parse(row["PEndDate"].ToString());
                string userId = row["UserId"].ToString();



                Event eventObj = new Event(idVal, name, location, status, desc, images, eStartDate, eEndDate, progCreated, pStartDate, pEndDate, userId);
                eventList.Add(eventObj);
            }
            return eventList;
        }
    }
}
