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
        public string Type { get; set; }
        public float Price { get; set; }
        public int TotalAmount { get; set; }
        public int SoldAmount { get; set; }
        public int LocationId { get; set; }

        public Ticket(string type, float price, int totalAmt, int soldAmt, int locationId)
        {
            Type = type;
            Price = price;
            TotalAmount = totalAmt;
            SoldAmount = soldAmt;
            LocationId = locationId;
        }

        public int Insert()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO Location (Type, Price, TotalAmount, SoldAmount, LocationId)" +
                "VALUES (@paraType, @paraPrice, @paraTotalAmt, @paraSoldAmt, @paraLocationId)";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraType", Type);
            sqlCmd.Parameters.AddWithValue("@paraPrice", Price);
            sqlCmd.Parameters.AddWithValue("@paraTotalAmt", TotalAmount);
            sqlCmd.Parameters.AddWithValue("@paraSoldAmt", SoldAmount);
            sqlCmd.Parameters.AddWithValue("@paraLocationId", LocationId);

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }
    }
}
