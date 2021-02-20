using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace DBService.Entity
{
    public class Invoice
    {
        //Define properties
        public string BookingId { get; set; }
        public string TourName { get; set; }
        public string CustName { get; set; }
        public string Type { get; set; }
        public DateTime CreateDate { get; set; }
        public string Status { get; set; }
        public string Sent { get; set; }
        public string Created { get; set; }
        public string Booked { get; set; }

        //Define constructor
        //1. Base Construct - to create an empty instance of Invoice class object
        public Invoice()
        {
        }
        //2. Primary Construct - used for creating/updating invoices + checking if invoice alrdy exists
        public Invoice(string bookingId, string type, DateTime createDate, string status)
        {
            BookingId = bookingId;
            Type = type;
            CreateDate = createDate;
            Status = status;

        }
        //3. Secondary Construct - used for retrieving invoices (to support inner join)
        public Invoice(string bookingId, string tourname, string custname, string type, DateTime createDate, string status)
        {
            BookingId = bookingId;
            TourName = tourname;
            CustName = custname;
            Type = type;
            CreateDate = createDate;
            Status = status;

        }
        //4.Secondary Construct - used for parsing work progress information
        public Invoice(string sent, string created, string booked)
        {
            Sent = sent;
            Created = created;
            Booked = booked;
        }

        public int Insert()
        {
            //Step 1 -  Define a connection to the database by getting the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            // Step 2 - Create a SqlCommand object to add record with INSERT statement
            string sqlStmt = "INSERT INTO Invoice (BookingId, Type, CreateDate, Status) VALUES ((SELECT Id FROM Booking WHERE Id=@paraBookId), @paraType, @paraCreateDate, @paraStatus) ";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            // Step 3 : Add each parameterised variable with value
            sqlCmd.Parameters.AddWithValue("@paraBookId", BookingId);
            sqlCmd.Parameters.AddWithValue("@paraType", Type);
            sqlCmd.Parameters.AddWithValue("@paraCreateDate", CreateDate);
            sqlCmd.Parameters.AddWithValue("@paraStatus", Status);

            // Step 4 Open connection the execute NonQuery of sql command   
            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();

            // Step 5 :Close connection
            myConn.Close();

            return result;
        }

        public List<Invoice> SelectAll(string filter, string sort, string search)
        {
            //TODO: Implement filter feature here. SelectAll will take in a filter parameter. just change the "order by" accordingly. Same for selectById
            //For search bar text field, can do backend onkeyup database search instead of frontend client side jquery?
            string filterSqlStmt = ""; // Default: Filter by None
            string sortSqlStmt = "ORDER BY 5 DESC"; //Default: Sort by dateDesc
            string searchSqlStmt = ""; //Default: No search

            if (filter == "BC")
            {
                filterSqlStmt = "[Invoice].Type = 'BC'";
            }
            else if (filter == "RA")
            {
                filterSqlStmt = "[Invoice].Type = 'RA' ";
            }
            else if (filter == "Pending")
            {
                filterSqlStmt = "[Invoice].Status = 'false' ";
            }
            else if (filter == "Sent")
            {
                filterSqlStmt = "[Invoice].Status = 'true' ";
            }
            if (sort == "dateDesc")
            {
                sortSqlStmt = "ORDER BY 5 DESC";
            }
            else if (sort == "dateAsc")
            {
                sortSqlStmt = "ORDER BY 5 ASC";
            }
            else if (sort == "idDesc")
            {
                sortSqlStmt = "ORDER BY 1 DESC";
            }
            else if (sort == "idAsc")
            {
                sortSqlStmt = "ORDER BY 1 ASC";
            }

            if (search != "")
            {
                searchSqlStmt =
                $"([Invoice].BookingId LIKE '%{search}%' OR " +
                $"[User].Name LIKE '%{search}%' OR " +
                $"[Tour].Title LIKE '%{search}%') ";
            }

            //Correct the syntax. Should allow search within filtered results.
            string whereClause = "";
            string andClause = "";
            if (searchSqlStmt != "" || filterSqlStmt != "")
            {
                whereClause = "WHERE ";
            }
            if (searchSqlStmt != "" && filterSqlStmt != "")
            {
                andClause = "AND ";
            }

            //Step 1 -  Define a connection to the database by getting the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter object to retrieve data from the database table


            string sqlStmt =
                "SELECT [Invoice].BookingId, [Tour].Title As TourName, [User].name AS CustomerName, [Invoice].Type, [Invoice].CreateDate, [Invoice].Status " +
                "FROM [Invoice] INNER JOIN [Booking] ON [Booking].id = [Invoice].bookingid " +
                "INNER JOIN [Tour] ON [Tour].id = [Booking].tourid " +
                "INNER JOIN [User] ON [User].id = [Booking].userid " +
                whereClause +
                searchSqlStmt +
                andClause +
                filterSqlStmt +
                sortSqlStmt;

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet to List
            List<Invoice> InvList = new List<Invoice>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time
                string bookId = row["bookingid"].ToString();
                string tourname = row["tourname"].ToString();
                string custname = row["customername"].ToString();
                string type = row["type"].ToString();
                DateTime createDate = Convert.ToDateTime(row["createdate"].ToString());
                string status = row["status"].ToString();
                if (status == "True")
                {
                    status = "sent";
                }
                else
                {
                    status = "pending";
                }

                Invoice obj = new Invoice(bookId, tourname, custname, type, createDate, status);
                InvList.Add(obj);
            }
            return InvList;
        }

        public Invoice SelectInvoiceByBookingId(string id)
        {
            //Step 1 -  Define a connection to the database by getting
            //          the connection string from App.config
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //Step 2 -  Create a DataAdapter to retrieve data from the database table
            string sqlStmt =
                "SELECT * FROM Invoice WHERE BookingId = @paraId";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet.
            Invoice inv = null;
            int rec_cnt = ds.Tables[0].Rows.Count;
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string bookingId = row["bookingId"].ToString();
                string type = row["type"].ToString();
                DateTime createDate = Convert.ToDateTime(row["createDate"].ToString());
                string status = row["status"].ToString();
                if (status == "True")
                {
                    status = "sent";
                }
                else
                {
                    status = "pending";
                }

                inv = new Invoice(bookingId, type, createDate, status);
            }
            return inv;
        }

        public int UpdateByBookingId(string id, string invtype)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE Invoice SET type = @paraType, createDate = @paraCreateDate, status = @paraStatus where BookingId =  @paraId";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraType", invtype);
            // TODO: Change name to last updated. In database and entity too.
            sqlCmd.Parameters.AddWithValue("@paraCreateDate", DateTime.Now);
            sqlCmd.Parameters.AddWithValue("@paraStatus", "false");
            sqlCmd.Parameters.AddWithValue("@paraId", id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }

        public int SendInvoice(string id)
        {
            //TODO: Implement email smtp here
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "SELECT[Invoice].BookingId, [Booking].CreateDate, [Tour].Title As Tour, [User].name AS Customer, [User].[Email] AS Email, [Invoice].Type, [Invoice].Status " +
                "FROM[Invoice] INNER JOIN[Booking] ON[Booking].id = [Invoice].bookingid " +
                "INNER JOIN[Tour] ON[Tour].id = [Booking].tourid " +
                "INNER JOIN[User] ON[User].id = [Booking].userid " +
                "WHERE[Booking].id = @paraId";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);
            //Step 3 -  Create a DataSet to store the data to be retrieved
            DataSet ds = new DataSet();

            //Step 4 -  Use the DataAdapter to fill the DataSet with data retrieved
            da.Fill(ds);

            //Step 5 -  Read data from DataSet to List
            List<Invoice> InvList = new List<Invoice>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];  // Sql command returns only one record at a time

                string bookId = row["bookingid"].ToString();
                DateTime DateofBooking = Convert.ToDateTime(row["createdate"].ToString());
                string tourname = row["tour"].ToString();
                string custname = row["customer"].ToString();
                string recipient = row["email"].ToString();
                string itype = row["type"].ToString();

                if (recipient != null || recipient != "")
                {
                    try
                    {
                        string msg = "";
                        if (itype == "BC")
                        {
                            itype = "Booking Confirmation";
                            msg = "successfuly confirmed. Happy touring! :)";
                        }
                        else
                        {
                            itype = "Refund Approval";
                            msg = "successfully refunded. Please note that it may take up 2-3 business days for the payment refund to be reflected in your bank account.";
                        }


                        string strEmail = ConfigurationManager.AppSettings["Email"];
                        string strPassword = ConfigurationManager.AppSettings["EmailPassword"];
                        using (MailMessage mail = new MailMessage())
                        {
                            mail.From = new MailAddress(strEmail);
                            mail.To.Add(recipient);
                            mail.Subject = $"Tobloggo - {itype} (#000000{bookId})";
                            mail.Body = "<p style=\"color:#000000;margin:10px 0;padding:0;font-family:Helvetica;font-size:16px;line-height:150%;text-align:left\">" +
                                $"Dear {custname},<br/><br/>Your booking for the \'{tourname}\' Tour, made on {DateofBooking.Date} has been {msg}</p>" +
                                "<p><br/><br/>This is a system generated email. Please do not reply to this email.<br>If you have any enquiries, please email us at Tobloggo@gmail.com</p>";
                            mail.IsBodyHtml = true;

                            using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
                            {
                                smtp.Credentials = new NetworkCredential(strEmail, strPassword);
                                smtp.EnableSsl = true;
                                smtp.Send(mail);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }

            sqlStmt = "UPDATE Invoice SET status = @paraStatus where BookingId =  @paraId";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd.Parameters.AddWithValue("@paraStatus", "true");
            sqlCmd.Parameters.AddWithValue("@paraId", id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public Invoice calculateProgressPercent()
        {
            Invoice inv = null;
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            //FOR TESTING WE SET IT TO CURRENT MONTH ONLY --> 0
            //Only count invoices for Bookings that are less than 4 months old. (I.e. Bookings made in last 3 months only; current month inclusive) --> 2
            string sqlStmt = "SELECT (SELECT count(Invoice.Status) As Sent_Invoice FROM Booking INNER JOIN Invoice ON Invoice.BookingId = Booking.Id " +
                "WHERE DATEDIFF(month, Booking.CreateDate, GETDATE()) <= 2 AND Invoice.Status = 1) AS Sent_Inv, " +
                "count(x.BookingId) AS Total_Inv_Created, (SELECT count(y.Id) FROM Booking y WHERE DATEDIFF(month, y.CreateDate, GETDATE()) <= 2) AS Total_Book " +
                "FROM Invoice x";

            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            int rec_cnt = ds.Tables[0].Rows.Count;
            //Will return a single row of No of Sent Invoices, No. of Created Invoices, and No. of Bookings made in the last 3 mths.
            if (rec_cnt == 1)
            {
                DataRow row = ds.Tables[0].Rows[0];  // Sql command returns only one record
                string sent = row["Sent_Inv"].ToString();
                string created = row["Total_Inv_Created"].ToString();
                string booked = row["Total_Book"].ToString();

                inv = new Invoice(sent, created, booked);

            }
            return inv;
        }
    }
}
