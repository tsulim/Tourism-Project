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
    }
}
