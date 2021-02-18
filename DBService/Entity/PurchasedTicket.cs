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
    public class PurchasedTicket
    {
        public int Id { get; set; }
        public int Quantity { get; set; }
        public int Status { get; set; }
        public int TicketId { get; set; }
        public int UserId { get; set; }
        
        public PurchasedTicket() { }

        public PurchasedTicket(int quantity, int ticketId, int userId)
        {
            Id = 0;
            Quantity = quantity;
            Status = 0;
            TicketId = ticketId;
            UserId = userId;
        }

        public PurchasedTicket(int id, int quantity, int status, int ticketId, int userId)
        {
            Id = id;
            Quantity = quantity;
            Status = status;
            TicketId = ticketId;
            UserId = userId;
        }

        public int Insert()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO PurchasedTicket (Quantity, TicketId, Status, UserId)" +
                "VALUES (@paraQuantity, @paraTicketId, @paraStatus, @paraUserId)";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraQuantity", Quantity);
            sqlCmd.Parameters.AddWithValue("@paraStatus", 0);
            sqlCmd.Parameters.AddWithValue("@paraTicketId", TicketId);
            sqlCmd.Parameters.AddWithValue("@paraUserId", UserId);

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }

        public List<PurchasedTicket> SelectAllByUserId(int userId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from PurchasedTicket where UserId = @paraUserId AND Status = @paraStatus";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraUserId", userId);
            da.SelectCommand.Parameters.AddWithValue("@paraStatus", 0);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<PurchasedTicket> pTicList = new List<PurchasedTicket>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                int quantity = Convert.ToInt32(row["Quantity"].ToString());
                int status = Convert.ToInt32(row["Status"].ToString());
                int ticketId = Convert.ToInt32(row["TicketId"].ToString());

                PurchasedTicket pTic = new PurchasedTicket(id, quantity, status, ticketId, userId);
                pTicList.Add(pTic);
            }
            return pTicList;
        }

        public int UpdatePurchasedTicket(int id, int status)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE PurchasedTicket SET Status=@paraStatus WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraId", id);
            sqlCmd.Parameters.AddWithValue("@paraStatus", status);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }
    }
}
