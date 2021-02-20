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
        public string Id { get; set; }
        public string Title { get; set; }
        public string Image { get; set; }
        public string Details { get; set; }
        public string DateTime{ get; set; }
        public string BKConfirmed { get; set; }
        public string BKRefunded { get; set; }
        public string AvailSlots { get; set; }
        public double Price { get; set; }
        public int MinPeople { get; set; }
        public int MaxPeople { get; set; }
        public string Itinerary { get; set; }
        public string PeakProfit { get; set; }
        public string ActualProfit { get; set; }
        public string RefundLoss { get; set; }

        //public int AvailableSlots { get; set; }

        public Tour()
        {
        }

        //Define a constructor to initialize all the properties
        public Tour(string title, string img, string details, string dateTime, double price, int minPpl, int maxPpl, string iti)
        {
            Title = title;
            Image = img;
            Details = details;
            DateTime = dateTime;
            Price = price;
            MinPeople = minPpl;
            MaxPeople = maxPpl;
            Itinerary = iti;
            //AvailableSlot = CalculateAvailSlots();
        }

        // Nazrie's Constructor
        public Tour(string id, string title, string confirmedbk, string refundedbk, string tavailslots, double price, int mp, string pprofit, string aprofit, string refloss)
        {
            Id = id;
            Title = title;
            BKConfirmed = confirmedbk;
            BKRefunded = refundedbk;
            AvailSlots = tavailslots;
            Price = price;
            MaxPeople = mp;
            PeakProfit = pprofit;
            ActualProfit = aprofit;
            RefundLoss = refloss;
        }
        

        public int Insert()
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            // Step 2 - Create a SqlCommand object to add record with INSERT statement
            string sqlStmt = "INSERT INTO Tour (title, image, details, DateTime, price, minPpl, maxPpl, iti) " + "VALUES (@paraTitle, @paraImage, @paraDetails, @paraDateTime, @paraPrice, @paraMinPpl, @paraMaxPpl, @paraIti)";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            // Step 3 : Add each parameterised variable with value
            sqlCmd.Parameters.AddWithValue("@paraTitle", Title);
            sqlCmd.Parameters.AddWithValue("@paraImage", Image);
            sqlCmd.Parameters.AddWithValue("@paraDetails", Details);
            sqlCmd.Parameters.AddWithValue("@paraDateTime", DateTime);
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
            da.SelectCommand.Parameters.AddWithValue("@paraTitle", title);

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
                string title1 = row["title"].ToString();
                string image = "Images\\" + row["image"].ToString();
                string details = row["details"].ToString();
                string dateTime = row["dateTime"].ToString();;
                string p = row["price"].ToString();
                double price = Convert.ToDouble(p);
                int minPpl = Convert.ToInt32(row["minPpl"].ToString());
                int maxPpl = Convert.ToInt32(row["maxPpl"].ToString());
                string iti = row["iti"].ToString();
                tour = new Tour(title1, image, details, dateTime, price, minPpl, maxPpl, iti);
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
            if (rec_cnt == 0)
            {
                tourList = null;
            }
            else
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string title = row["title"].ToString();
                    string image = "Images\\" + row["image"].ToString();
                    string details = row["details"].ToString();
                    string dateTime = row["dateTime"].ToString();
                    string p = row["price"].ToString();
                    double price = Convert.ToDouble(p);
                    int minPpl = Convert.ToInt32(row["minPpl"].ToString());
                    int maxPpl = Convert.ToInt32(row["maxPpl"].ToString());
                    string iti = row["iti"].ToString();
                    Tour tour = new Tour(title, image, details, dateTime, price, minPpl, maxPpl, iti);
                    tourList.Add(tour);
                }
            }
            return tourList;
        }

        public int UpdateTour(string title, string image, string details, string dateTime, double price, int minPpl, int maxPpl, string iti)
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            // Step 2 - Create a SqlCommand object to add record with UPDATE statement
            string sqlStmt = "UPDATE Tour SET image = @paraImage, details = @paraDetails, dateTime = @paraDateTime , price = @paraPrice, minPpl = @paraMinPpl, maxPpl = @paraMaxPpl, iti = @paraIti where title = @paraTitle";
            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            // Step 3 : Add each parameterised variable with value
            sqlCmd.Parameters.AddWithValue("@paraTitle", title);
            sqlCmd.Parameters.AddWithValue("@paraImage", image);
            sqlCmd.Parameters.AddWithValue("@paraDetails", details);
            sqlCmd.Parameters.AddWithValue("@paraDateTime", dateTime);
            sqlCmd.Parameters.AddWithValue("@paraPrice", price);
            sqlCmd.Parameters.AddWithValue("@paraMinPpl", minPpl);
            sqlCmd.Parameters.AddWithValue("@paraMaxPpl", maxPpl);
            sqlCmd.Parameters.AddWithValue("@paraIti", iti);

            // Step 4 Open connection the execute NonQuery of sql command   
            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();

            // Step 5 :Close connection
            myConn.Close();

            return result;
        }

        // Nazrie's Method
        //Call this method to display Tour Package Profit Report
        public List<Tour> DisplayPackageProfit(string startPrice, string endPrice, string startProfit, string endProfit, string startLoss, string endLoss)
        {
            //Set Aliases for each column
            string TourIdColName = "Id";
            string TourNameColName = "Title";
            string ConfirmedBKColName = "Confirmed";
            string RefundedBKColName = "Refunded";
            string AvailSlotsColName = "Available_Slots_Left";
            string TourPriceColName = "price";
            string MaxPplColName = "maxPpl";
            string PeakProfitColName = "Peak_Profit";
            string ActualProfitColName = "Actual_Profit";
            string RefundLossColName = "Loss_from_Refunds";
            string TableName = "Tour";

            //Set range filter sql statements
            string priceRangeSqlStmt = $"{TourPriceColName} BETWEEN {startPrice} AND {endPrice} ";
            string actProfitRangeSqlStmt = $"{ActualProfitColName} BETWEEN {startProfit} AND {endProfit} ";
            string refundLossRangeSqlStmt = $"{RefundLossColName} BETWEEN {startLoss} AND {endLoss} ";

            //Set DB Connection
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Wrap original select query statement in another select query statement.
            //This will allow us to use the Aliases found the subqueried table in where clause.
            //TODO: Remove tour id column and loss from refund column. change base price to unit price. Change Peak Profit to ???
            string sqlStmt = $"SELECT * FROM (SELECT x.id AS {TourIdColName}, x.Title AS {TourNameColName}, " +
                "(CASE WHEN EXISTS(Select count(Booking.id) FROM Booking INNER JOIN[Tour] ON [Tour].id = [Booking].tourId where STATUS = 1 AND Tour.id = x.id GROUP BY TourId) " +
                $"THEN(Select count(Booking.id) FROM Booking INNER JOIN[Tour] ON[Tour].id = [Booking].tourId where STATUS = 1 AND Tour.id = x.id GROUP BY TourId) ELSE '0' END) AS {ConfirmedBKColName}, " +
                "(CASE WHEN EXISTS((Select count(Booking.id) FROM Booking INNER JOIN[Tour] ON[Tour].id = [Booking].tourId where STATUS = 0 AND Tour.id = x.id GROUP BY TourId)) " +
                $"THEN(Select count(Booking.id) FROM Booking INNER JOIN[Tour] ON[Tour].id = [Booking].tourId where STATUS = 0 AND Tour.id = x.id GROUP BY TourId) ELSE '0' END) AS {RefundedBKColName}, " +
                $"x.AvailSlots AS {AvailSlotsColName}, x.Price AS {TourPriceColName}, x.MaxPpl AS {MaxPplColName}, " +
                "(0.35 * x.Price * x.MaxPpl * (x.AvailSlots + " +
                "(CASE WHEN EXISTS(select count(booking.id) from booking inner join[tour] on [tour].id = [booking].tourid where status = 1 AND tourid = x.id group by tourid, title) " +
                $"THEN(select count(booking.id) from booking inner join [tour] on [tour].id = [booking].tourid where status = 1 AND tourid = x.id group by tourid, title) ELSE '0' END))) AS {PeakProfitColName}, " +
                $"(0.35 * sum(CASE WHEN[Booking].status = 1 THEN(x.price * [Booking].amtPpl) ELSE '0' END)) AS {ActualProfitColName}, " +
                $"(0.35 * sum(CASE WHEN[Booking].status = 0 THEN(x.price * [Booking].amtPpl * -1) ELSE '0' END)) AS {RefundLossColName} " +
                "FROM Booking RIGHT JOIN Tour x ON x.id = Booking.TourId GROUP BY Booking.TourId, x.id, x.Title, x.AvailSlots, x.Price, x.MaxPpl) " +
                $"AS {TableName} ORDER BY Id";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Tour> bkList = new List<Tour>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time
                Tour obj = new Tour(
                    row[TourIdColName].ToString(),
                    row[TourNameColName].ToString(),
                    row[ConfirmedBKColName].ToString(),
                    row[RefundedBKColName].ToString(),
                    row[AvailSlotsColName].ToString(),
                    Convert.ToDouble(row[TourPriceColName].ToString()),
                    Convert.ToInt32(row[MaxPplColName].ToString()),
                    row[PeakProfitColName].ToString(),
                    row[ActualProfitColName].ToString(),
                    row[RefundLossColName].ToString()
                    );
                bkList.Add(obj);
            }
            return bkList;
        }
    }
}

