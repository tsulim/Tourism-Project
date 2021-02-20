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
    public class Ticket
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public int SoldAmount { get; set; }
        public int LocationId { get; set; }

        public Ticket()
        {

        }

        public Ticket(string name, double price, int locationId)
        {
            Id = 0;
            Name = name;
            Price = price;
            SoldAmount = 0;
            LocationId = locationId;
        }

        public Ticket(int id, string name, double price, int soldAmt, int locationId)
        {
            Id = id;
            Name = name;
            Price = price;
            SoldAmount = soldAmt;
            LocationId = locationId;
        }

        public int Insert()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO Ticket (Name, Price, SoldAmount, LocationId)" +
                "VALUES (@paraName, @paraPrice, @paraSoldAmt, @paraLocationId)";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraPrice", Price);
            sqlCmd.Parameters.AddWithValue("@paraSoldAmt", SoldAmount);
            sqlCmd.Parameters.AddWithValue("@paraLocationId", LocationId);

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }

        public Ticket SelectAllById(int id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Ticket where Id = @paraId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraId", id);

            DataSet ds = new DataSet();

            da.Fill(ds);

            Ticket tic = new Ticket();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];

                string name = row["Name"].ToString();
                double price = Convert.ToDouble(row["Price"].ToString());
                int soldAmt = Convert.ToInt32(row["SoldAmount"].ToString());
                int locaId = Convert.ToInt32(row["LocationId"].ToString());

                tic = new Ticket(id, name, price, soldAmt, locaId);
            }
            return tic;
        }

        public List<Ticket> SelectAllByLocaId(int locaId)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Ticket where LocationId = @paraLocationId";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);
            da.SelectCommand.Parameters.AddWithValue("@paraLocationId", locaId);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Ticket> ticList = new List<Ticket>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                int id = Convert.ToInt32(row["Id"]);
                string name = row["Name"].ToString();
                double price = Convert.ToDouble(row["Price"].ToString());
                int soldAmt = Convert.ToInt32(row["SoldAmount"].ToString());

                Ticket tic = new Ticket(id, name, price, soldAmt, locaId);
                ticList.Add(tic);
            }
            return ticList;
        }

        public int UpdateTicketAmt(int id, int soldAmt)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE PurchasedTicket SET SoldAmount=@paraSoldAmount WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraId", id);
            sqlCmd.Parameters.AddWithValue("@paraSoldAmount", soldAmt);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;
        }

        public int UpdateTicketInfo(int id, string name, double price)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "UPDATE Ticket SET Name=@paraName, Price=@paraPrice WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraId", id);
            sqlCmd.Parameters.AddWithValue("@paraName", name);
            sqlCmd.Parameters.AddWithValue("@paraPrice", price);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;

        }
        public int DeleteTicket(int id)
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "DELETE FROM Ticket WHERE Id=@paraId;";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);
            sqlCmd.Parameters.AddWithValue("@paraId", id);

            myConn.Open();
            int result = sqlCmd.ExecuteNonQuery();
            myConn.Close();

            return result;

        }
    }
}
