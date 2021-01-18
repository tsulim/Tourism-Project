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
    public class Tour
    {
        //Define class properties
        public string Title { get; set; }
        public string Image { get; set; }
        public string Details { get; set; }
        public DateTime StartDateTime { get; set; }
        public DateTime EndDateTime { get; set; }
        public double Price { get; set; }
        public int MinPeople { get; set; }
        public int MaxPeople { get; set; }
        public string Itinerary { get; set; }

        //public int AvailableSlots { get; set; }

        public Tour()
        {
        }

        //Define a constructor to initialize all the properties
        public Tour(string title, string img, string details, DateTime sDateTime, DateTime eDateTime, double price, int minPpl, int maxPpl, string itin)
        {
            Title = title;
            Image = img;
            Details = details;
            StartDateTime = sDateTime;
            EndDateTime = eDateTime;
            Price = price;
            MinPeople = minPpl;
            MaxPeople = maxPpl;
            Itinerary = itin;
            //AvailableSlot = CalculateAvailSlots();
        }

        public int Insert()
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            // Step 2 - Create a SqlCommand object to add record with INSERT statement
            string sqlStmt = "INSERT INTO Tour (title, image, details, startDT, endDT, price, minPpl, maxPpl, iti) " + "VALUES (@paraTitle, @paraImage, @paraDetails, @paraStartDT, @paraEndDT, @paraPrice, @paraMinPpl, @paraMaxPpl, @paraIti)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            // Step 3 : Add each parameterised variable with value
            sqlCmd.Parameters.AddWithValue("@paraTitle", Title);
            sqlCmd.Parameters.AddWithValue("@paraImage", Image);
            sqlCmd.Parameters.AddWithValue("@paraDetails", Details);
            sqlCmd.Parameters.AddWithValue("@paraStartDT", StartDateTime.ToShortDateString());
            sqlCmd.Parameters.AddWithValue("@paraEndDT", EndDateTime.ToShortDateString());
            sqlCmd.Parameters.AddWithValue("@paraPrice", Price);
            sqlCmd.Parameters.AddWithValue("@paraMinPpl", MinPeople);
            sqlCmd.Parameters.AddWithValue("@paraMaxPpl", MaxPeople);
            sqlCmd.Parameters.AddWithValue("@paraIti", Itinerary);

            // Step 4 Open connection the execute NonQuery of sql command   
            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();

            // Step 5 :Close connection
            myConn.Close();

            return result;
        }
        public Tour SelectByTitle(string title)
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter to retrieve data from the database table
            string sqlStmt = "Select * from Tour where title = @paraTitle";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraTitle",Title );

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet.
            Tour tour = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string image = row["image"].ToString();
                string details = row["details"].ToString();
                DateTime startDT = Convert.ToDateTime(row["startDateTime"].ToString());
                DateTime endDT = Convert.ToDateTime(row["endDateTime"].ToString());
                string p = row["price"].ToString();
                double price = Convert.ToDouble(p);
                int minPpl = Convert.ToInt32(row["minPeople"].ToString());
                int maxPpl = Convert.ToInt32(row["maxPeople"].ToString());
                string iti = row["itinerary"].ToString();
                tour = new Tour(title,image, details, startDT, endDT, price, minPpl, maxPpl, iti);
            }
            return tour;
        }

        public List<Tour> SelectAll()
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter object to retrieve data from the database table
            string sqlStmt = "Select * from Tour";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet to List
            List<Tour> tourList = new List<Tour>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string title = row["title"].ToString();
                string image = row["image"].ToString();
                string details = row["details"].ToString();
                DateTime startDT = Convert.ToDateTime(row["startDateTime"].ToString());
                DateTime endDT = Convert.ToDateTime(row["endDateTime"].ToString());
                string p = row["price"].ToString();
                double price = Convert.ToDouble(p);
                int minPpl = Convert.ToInt32(row["minPeople"].ToString());
                int maxPpl = Convert.ToInt32(row["maxPeople"].ToString());
                string iti = row["itinerary"].ToString();
                Tour tour = new Tour(title, image, details, startDT, endDT, price, minPpl, maxPpl, iti);
                tourList.Add(tour);
            }
            return tourList;
        }
    }
}

