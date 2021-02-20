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
    public class Booking
    {
        public string BookId { get; set; }
        public DateTime CreateDate { get; set; }
        public string Status { get; set; }
        public string TourName { get; set; }
        public string NumAttendees { get; set; }
        public string TourPrice { get; set; }
        public string TotalAmt { get; set; }
        public string ChartYear { get; set; }
        public string ChartMonth { get; set; }
        public string ChartMonthTotal { get; set; }
        public string ChartCMDate { get; set; }
        public double ChartCMDayProfit { get; set; }

        //Primary Construct
        //TODO: Tell Hui en need to add createDate
        public Booking()
        {

        }
        //Secondary Constructs Starts Here - Need to inform Hui En to add these to her entity class.

        //1 Parameter; Used for SelectBookingById. FIXME: Read Comments in method.
        public Booking(string bookid)
        {
            BookId = bookid;
        }
        //2 Parameters; Used for Current Month Profit By Days Chart
        public Booking(string cmdate, string cmdayprofit)
        {

            ChartCMDate = cmdate;
            if (cmdayprofit == "")
            {
                ChartCMDayProfit = 0;
            }
            else
            {
                ChartCMDayProfit = double.Parse(cmdayprofit);
            }
        }
        //3 Parameters; Used for experimentation only. Will delete later. FIXME
        public Booking(string year, string month, string total)
        {
            ChartYear = year;
            ChartMonth = month;
            ChartMonthTotal = total;
        }
        //7 Parameters; Used for Booking Sales Report
        public Booking(string bookid, DateTime cDate, string numA, string stat, string tname, string tprice, string total)
        {
            BookId = bookid;
            CreateDate = cDate;
            Status = stat;
            TourName = tname;
            NumAttendees = numA;
            TourPrice = tprice;
            TotalAmt = total;
        }



        public List<Booking> RetrieveChartData()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "SELECT YEAR(Booking.CreateDate) AS Year, MONTH(Booking.CreateDate) AS Month, SUM(Tour.price * Booking.amtPpl) AS Total " +
                "FROM Booking INNER JOIN Tour ON Tour.id = Booking.tourId " +
                "WHERE DATEDIFF(month, Booking.CreateDate, GETDATE()) <= 4 AND Booking.Status = 1 " +
                "GROUP BY MONTH(Booking.CreateDate), YEAR(Booking.CreateDate)" +
                "ORDER BY YEAR(Booking.CreateDate) ASC";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Booking> bkList = new List<Booking>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time
                string year = row["year"].ToString();
                string month = row["month"].ToString();
                string total = row["total"].ToString();

                Booking obj = new Booking(year, month, total);
                bkList.Add(obj);
            }
            return bkList;
        }

        public List<Booking> RetrieveCMDayAndProfit()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);
            string sqlStmt = "SELECT CAST(Booking.createDate AS DATE) AS Date, SUM(Tour.price * Booking.amtPpl) AS Total " +
                "FROM Booking INNER JOIN Tour ON Tour.id = Booking.tourId " +
                "WHERE Booking.Status = 1 AND YEAR(Booking.createDate) = YEAR(GETDATE()) AND MONTH(Booking.createDate) = MONTH(GETDATE()) " +
                "GROUP BY DAY(Booking.createDate), Booking.CreateDate";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Booking> cmDPList = new List<Booking>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time
                string date = row["date"].ToString();
                string total = row["total"].ToString();

                Booking obj = new Booking(date, total);
                cmDPList.Add(obj);
            }
            return cmDPList;
        }


        public List<Booking> DisplayBookingSales(string startdate, string enddate, string filter)
        {
            string datefilterSqlStmt = "";
            if (startdate != "" && enddate != "")
            {
                datefilterSqlStmt = $"WHERE [Booking].createDate BETWEEN \'{startdate}\' AND \'{enddate}\'";
            }


            //if custom was chosen, regardless of whether it is still 30 days but not from the date today, we will use date is btwn ...
            // and since last 7 days and 30 days is making use of date between, no need to check whether date is custom anot.
            //if date is not custom, before it is passed here, convert to startdate and endddate format

            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "SELECT [Booking].id, [Booking].createDate, [Booking].status, [Tour].Title, [Tour].price, [Booking].amtPpl, " +
                "(CASE WHEN[Booking].status = 1 THEN([Tour].price * [Booking].amtPpl) " +
                "ELSE ([Tour].price * [Booking].amtPpl * -1) END) AS Total " +
                "FROM [Booking] INNER JOIN[Tour] ON[Tour].id = [Booking].tourId " + datefilterSqlStmt + "ORDER BY [Booking].id DESC";

            if (filter == "pending")
            {
                //overwrite sql statement
                sqlStmt = "SELECT [Booking].id, [Booking].createDate, [Booking].status, [Tour].Title, [Tour].price, [Booking].amtPpl, " +
                    "(CASE WHEN[Booking].status = 1 THEN([Tour].price * [Booking].amtPpl) " +
                    "ELSE([Tour].price * [Booking].amtPpl * -1) END) AS Total " +
                    "FROM[Booking] INNER JOIN[Tour] ON[Tour].id = [Booking].tourId " +
                    "LEFT JOIN[Invoice] ON[Invoice].BookingId = [Booking].Id " +
                    "WHERE DATEDIFF(month, [Booking].CreateDate, GETDATE()) <= 2 AND[Invoice].BookingId IS NULL";
            }

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            List<Booking> bkList = new List<Booking>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time
                string bookid = row["id"].ToString();
                DateTime cDate = Convert.ToDateTime(row["createdate"].ToString());
                string stat = row["status"].ToString();
                string tname = row["name"].ToString();
                string tprice = row["price"].ToString();
                string numA = row["amtPpl"].ToString();
                string total = row["total"].ToString();

                if (stat == "True")
                {
                    stat = "confirmed";
                }
                else
                {
                    stat = "cancelled";
                }

                Booking obj = new Booking(bookid, cDate, numA, stat, tname, tprice, total);
                bkList.Add(obj);
            }
            return bkList;
        }

        public Booking SelectBookingByBookingId(string id)
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter to retrieve data from the database table
            string sqlStmt = "Select * from Booking where Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet.
            Booking bk = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string bid = row["Id"].ToString();
                bk = new Booking(bid);

                //for add invoice, this method is called to check whether tht invoice aldy exist. 
                //is it necessesary to retrieve all columns? or just the id will do?
                //the thing about retrieving only one thing is that i will need to have a new constructor only to take in one object.
                //UPDATE: NO NEED. but still need to check with hui en what she will be retrieving. if same, then dont need to create new constructor.
                //for now i do like this.
            }
            return bk;
        }

        public string DetermineInvoiceTypeByBookStatus(string id)
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter to retrieve data from the database table
            string sqlStmt = "Select * from Booking where Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet.
            string type = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string status = row["status"].ToString();
                if (status == "True")
                {
                    type = "BC";
                }
                else if (status == "False")
                {
                    type = "RA";
                }
            }
            return type;
        }
    }
}
