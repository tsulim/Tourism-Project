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
    public class Location
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Type { get; set; }
        public string Images { get; set; }
        public bool Status { get; set; }
        public int UserId { get; set; }

        public Location()
        {
        }

        public Location(string name, string address, string type, string images, bool status, int userid)
        {
            Name = name;
            Address = address;
            Type = type;
            Images = images;
            Status = status;
            UserId = userid;
        }
        public int Insert()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "INSERT INTO Location (Name, Address, Type, Images, Status, UserId) " +
                "VALUES (@paraName, @paraAddress, @paraType, @paraImages, @paraStatus, @paraUserId)";

            SqlCommand sqlCmd = new SqlCommand(sqlStmt, myConn);

            sqlCmd.Parameters.AddWithValue("@paraName", Name);
            sqlCmd.Parameters.AddWithValue("@paraAddress", Address);
            sqlCmd.Parameters.AddWithValue("@paraType", Type);
            sqlCmd.Parameters.AddWithValue("@paraImages", Images);
            sqlCmd.Parameters.AddWithValue("@paraStatus", Status);
            sqlCmd.Parameters.AddWithValue("@paraUserId", UserId);

            myConn.Open();

            int result = sqlCmd.ExecuteNonQuery();

            myConn.Close();

            return result;
        }
        public List<Location> SelectAll()
        {
            string DBConnect = ConfigurationManager.ConnectionStrings["TobloggoDB"].ConnectionString;
            SqlConnection myConn = new SqlConnection(DBConnect);

            string sqlStmt = "Select * from Location";
            SqlDataAdapter da = new SqlDataAdapter(sqlStmt, myConn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            List<Location> locaList = new List<Location>();
            int rec_cnt = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rec_cnt; i++)
            {
                DataRow row = ds.Tables[0].Rows[i];
                string name = row["Name"].ToString();
                string address = row["Address"].ToString();
                string type = row["Type"].ToString();
                string images = row["Images"].ToString();
                bool status = Convert.ToBoolean(row["Status"]);
                int userId = Convert.ToInt32(row["UserId"]);

                Location loca = new Location(name, address, type, images, status, userId);
                locaList.Add(loca);
            }
            return locaList;
        }
    }
}
